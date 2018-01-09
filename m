From: Hou Tao <houtao1@huawei.com>
Date: Tue, 09 Jan 2018 06:56:26 +0000
Subject: [PATCH 3/3] blktrace: add option g/group to save cgroup info
Message-Id: <20180109065626.5459-4-houtao1@huawei.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Now blk tracer could output cgroup info for trace actions and
trace messages, but there is no per-device API for it and it
can only be turned on globally by writing trace_options file
under /sys/kernel/debug/tracing.

Add option g/group to save cgroup info in trace file. Implement it
by writing "blk_cgroup" to trace_options file before tracing starts,
and writing "noblk_cgroup" to trace_options file after tracing stops.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 blktrace.c     | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/blktrace.8 |   9 +++-
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index e048f68..56aa9c9 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -282,6 +282,7 @@ static int act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
+static int save_cgroup_info;
 
 static char *debugfs_path = "/sys/kernel/debug";
 static char *output_name;
@@ -328,7 +329,7 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
-#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:g"
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -433,6 +434,12 @@ static struct option l_opts[] = {
 		.val = 's'
 	},
 	{
+		.name = "cgroup",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'g',
+	},
+	{
 		.name = NULL,
 	}
 };
@@ -446,6 +453,7 @@ static char usage_str[] = "\n\n" \
         "[ -a <action field>  | --act-mask=<action field>]\n" \
         "[ -A <action mask>   | --set-mask=<action mask>]\n" \
         "[ -b <size>          | --buffer-size]\n" \
+        "[ -g                 | --cgroup]\n" \
         "[ -n <number>        | --num-sub-buffers=<number>]\n" \
         "[ -l                 | --listen]\n" \
         "[ -h <hostname>      | --host=<hostname>]\n" \
@@ -463,6 +471,7 @@ static char usage_str[] = "\n\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b Sub buffer size in KiB (default 512)\n" \
+	"\t-g Save io cgroup info in trace\n" \
 	"\t-n Number of sub buffers (default 4)\n" \
 	"\t-l Run in network listen mode (blktrace server)\n" \
 	"\t-h Run in network client mode, connecting to the given host\n" \
@@ -2010,6 +2019,125 @@ static void wait_tracers(void)
 	get_all_drops();
 }
 
+static int read_oneline_tfile(const char *name, char *buf, size_t len)
+{
+	char fn[MAXPATHLEN];
+	int fd;
+	ssize_t rcnt;
+
+	snprintf(fn, sizeof(fn), "%s/tracing/%s", debugfs_path, name);
+	fd = my_open(fn, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Could not open %s: %d/%s\n",
+				fn, errno, strerror(errno));
+		return -1;
+	}
+
+	/* -1 for the trailing \0 */
+	rcnt = read(fd, buf, len - 1);
+	if (rcnt >= 0) {
+		if (rcnt > 0 && buf[rcnt - 1] = '\n')
+			rcnt--;
+		buf[rcnt] = '\0';
+	} else {
+		fprintf(stderr, "Could not read %s: %d/%s\n",
+				fn, errno, strerror(errno));
+	}
+
+	close(fd);
+
+	return rcnt >= 0 ? 0 : -1;
+}
+
+static int write_tfile(const char *name, const char *str)
+{
+	char fn[MAXPATHLEN];
+	int fd;
+	size_t len;
+	ssize_t wcnt;
+
+	snprintf(fn, sizeof(fn), "%s/tracing/%s", debugfs_path, name);
+	fd = my_open(fn, O_WRONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Could not open %s for write: %d/%s\n",
+				fn, errno, strerror(errno));
+		return -1;
+	}
+
+	len = strlen(str);
+	wcnt = write(fd, str, len);
+	if (wcnt < 0)
+		fprintf(stderr, "Could not write %s to %s: %d/%s\n",
+				str, fn, errno, strerror(errno));
+	else if ((size_t)wcnt != len)
+		fprintf(stderr, "Incomplete write (%zu/%zu) to %s: %d/%s\n",
+				(size_t)wcnt, len, fn, errno, strerror(errno));
+
+	close(fd);
+
+	return ((size_t)wcnt = len) ? 0 : -1;
+}
+
+static void restore_tracer(const char *tracer, int tracing_on)
+{
+	write_tfile("current_tracer", tracer);
+	if (tracing_on)
+		write_tfile("tracing_on", "1");
+}
+
+static int switch_tracer(const char *tracer, int *old_tracing_on)
+{
+	int err;
+	char buf[4];
+	int tracing_on;
+
+	err = read_oneline_tfile("tracing_on", buf, sizeof(buf));
+	if (err)
+		goto out;
+
+	tracing_on = atoi(buf);
+	if (tracing_on) {
+		err = write_tfile("tracing_on", "0");
+		if (err)
+			goto out;
+	}
+
+	err = write_tfile("current_tracer", tracer);
+	if (err)
+		goto restore_out;
+
+	*old_tracing_on = tracing_on;
+
+	return 0;
+
+restore_out:
+	if (tracing_on)
+		write_tfile("tracing_on", "1");
+out:
+	return -1;
+}
+
+static int set_blk_tracer_opt(const char *opt)
+{
+	int err;
+	char tracer[32];
+	int tracing_on = 0;
+
+	err = read_oneline_tfile("current_tracer", tracer, sizeof(tracer));
+	if (err)
+		return -1;
+
+	if (strcmp(tracer, "blk") && switch_tracer("blk", &tracing_on))
+		return -1;
+
+	err = write_tfile("trace_options", opt);
+
+	if (strcmp(tracer, "blk"))
+		restore_tracer(tracer, tracing_on);
+
+	return !err ? 0 : -1;
+}
+
 static void exit_tracing(void)
 {
 	signal(SIGINT, SIG_IGN);
@@ -2021,6 +2149,10 @@ static void exit_tracing(void)
 	wait_tracers();
 	del_tracers();
 	rel_devpaths();
+
+	if (save_cgroup_info) {
+		set_blk_tracer_opt("noblk_cgroup");
+	}
 }
 
 static void handle_sigint(__attribute__((__unused__)) int sig)
@@ -2131,6 +2263,10 @@ static int handle_args(int argc, char *argv[])
 				return 1;
 			break;
 
+		case 'g':
+			save_cgroup_info = 1;
+			break;
+
 		case 'I': {
 			char dev_line[256];
 			FILE *ifp = my_fopen(optarg, "r");
@@ -2681,6 +2817,12 @@ static int run_tracers(void)
 	if (net_mode = Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
+	if (save_cgroup_info && set_blk_tracer_opt("blk_cgroup")) {
+		/* No need to disable opt "blk_cgroup" */
+		save_cgroup_info = 0;
+		return 1;
+	}
+
 	if (setup_buts())
 		return 1;
 
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 820b03a..861c54a 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -6,7 +6,7 @@ blktrace \- generate traces of the i/o traffic on block devices
 
 
 .SH SYNOPSIS
-.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
+.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-g ] [ \-v ]
 .br
 
 
@@ -103,6 +103,13 @@ buffer size is 512KiB.
 Adds \fIdev\fR as a device to trace  
 .RE
 
+\-g
+.br
+\-\-cgroup
+.RS
+Save io cgroup info in trace
+.RE
+
 \-I \fIfile\fR
 .br
 \-\-input\-devs=\fIfile\fR
-- 
2.9.5

