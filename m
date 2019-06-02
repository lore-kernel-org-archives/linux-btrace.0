From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:58:09 +0000
Subject: [blktrace-tools RFC PATCH 4/5] blktrace: add support for trace extension
Message-Id: <20190602165810.14817-5-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Update blktrace tool to support the trace extensions. The new option
'-E' will allow blktrace to configure trace with newly introduced
IOCTLs for trace extensions. '-Y' and '-y' options are similar to
'-a' and '-A' but can now use the mask for additional operations
which are supported for trace-extension. For tracking the priority we
add '-P' along with the '-X' and '-x' to specify priority value and
mask.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blktrace.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 315 insertions(+), 27 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index d0d271f..b8b36c2 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -112,7 +112,7 @@ struct devpath {
 	struct cl_host *ch;
 	u32 cl_id;
 	time_t cl_connect_time;
-	int setup_done;	/* ioctl BLKTRACESETUP done */
+	int setup_done;	/* ioctl BLKTRACESETUP or BLKTRACESETUP_EXT done */
 	struct io_info *ios;
 };
 
@@ -274,12 +274,16 @@ static char blktrace_version[] = "2.0.0";
  */
 int data_is_native = -1;
 
+static bool use_ext = false;
 static int ndevs;
 static int max_cpus;
 static int ncpus;
 static cpu_set_t *online_cpus;
 static int pagesize;
 static int act_mask = ~0U;
+static uint64_t act_mask_ext = -1ULL;
+static uint32_t blktrace_prio_mask = 0;
+bool blktrace_track_prio = false;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
@@ -329,7 +333,7 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
-#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:Px:X:y:Y:E"
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -355,6 +359,24 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'A'
 	},
+	{
+		.name = "act-mask-ext",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'y'
+	},
+	{
+		.name = "set-mask-ext",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'Y'
+	},
+	{
+		.name = "use-extensions",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'E'
+	},
 	{
 		.name = "relay",
 		.has_arg = required_argument,
@@ -427,6 +449,24 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'p'
 	},
+	{
+		.name = "track-priority",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'P'
+	},
+	{
+		.name = "prio-mask",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'x'
+	},
+	{
+		.name = "prio-set-mask",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'X'
+	},
 	{
 		.name = "no-sendfile",
 		.has_arg = no_argument,
@@ -439,23 +479,30 @@ static struct option l_opts[] = {
 };
 
 static char usage_str[] = "\n\n" \
-	"-d <dev>             | --dev=<dev>\n" \
-        "[ -r <debugfs path>  | --relay=<debugfs path> ]\n" \
-        "[ -o <file>          | --output=<file>]\n" \
-        "[ -D <dir>           | --output-dir=<dir>\n" \
-        "[ -w <time>          | --stopwatch=<time>]\n" \
-        "[ -a <action field>  | --act-mask=<action field>]\n" \
-        "[ -A <action mask>   | --set-mask=<action mask>]\n" \
-        "[ -b <size>          | --buffer-size]\n" \
-        "[ -n <number>        | --num-sub-buffers=<number>]\n" \
-        "[ -l                 | --listen]\n" \
-        "[ -h <hostname>      | --host=<hostname>]\n" \
-        "[ -p <port number>   | --port=<port number>]\n" \
-        "[ -s                 | --no-sendfile]\n" \
-        "[ -I <devs file>     | --input-devs=<devs file>]\n" \
-        "[ -v <version>       | --version]\n" \
-        "[ -V <version>       | --version]\n" \
-
+	"-d <dev>                | --dev=<dev>\n" \
+	"[ -E                    | --use-extensions ]\n" \
+	"[ -r <debugfs path>     | --relay=<debugfs path> ]\n" \
+	"[ -o <file>             | --output=<file>]\n" \
+	"[ -D <dir>              | --output-dir=<dir>\n" \
+	"[ -w <time>             | --stopwatch=<time>]\n" \
+	"[ -a <action field>     | --act-mask=<action field>]\n" \
+	"[ -A <action mask>      | --set-mask-ext=<action mask ext>]\n" \
+	"[ -y <action field ext> | --act-mask-ext=<action field ext>]\n" \
+	"[ -Y <action mask ext>  | --set-mask=<action mask>]\n" \
+	"[ -b <size>             | --buffer-size]\n" \
+	"[ -n <number>           | --num-sub-buffers=<number>]\n" \
+	"[ -l                    | --listen]\n" \
+	"[ -h <hostname>         | --host=<hostname>]\n" \
+	"[ -p <port number>      | --port=<port number>]\n" \
+	"[ -s                    | --no-sendfile]\n" \
+	"[ -I <devs file>        | --input-devs=<devs file>]\n" \
+	"[ -P                    | --track-priority ]\n" \
+	"[ -x <ioprio field>     | --prio-mask=<ioprio field> ]\n" \
+	"[ -X <ioprio mask>      | --set-mask=<ioprio mask> ]\n" \
+	"[ -v <version>          | --version]\n" \
+	"[ -V <version>          | --version]\n" \
+
+	"\t-E Use Blocktrace Extensions\n" \
 	"\t-d Use specified device. May also be given last after options\n" \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
 	"\t-o File(s) to send output to\n" \
@@ -470,6 +517,11 @@ static char usage_str[] = "\n\n" \
 	"\t-p Network port to use (default 8462)\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
+	"\t-P Enable tracking priorites.\n" \
+	"\t-y Only trace specified actions ext.\n" \
+	"\t-Y Give trace mask as a single value ext.\n" \
+	"\t-x Only priority specified actions.\n" \
+	"\t-X Give priority mask as a single value.\n" \
 	"\t-v Print program version info\n" \
 	"\t-V Print program version info\n\n";
 
@@ -784,7 +836,7 @@ static int setup_mmap(int fd, unsigned int maxlen,
 	return 0;
 }
 
-static int __stop_trace(int fd)
+static int __stop_tear_trace(int fd)
 {
 	/*
 	 * Should be stopped, don't complain if it isn't
@@ -793,6 +845,20 @@ static int __stop_trace(int fd)
 	return ioctl(fd, BLKTRACETEARDOWN);
 }
 
+static int __stop_tear_trace_ext(int fd)
+{
+	/*
+	 * Should be stopped, don't complain if it isn't
+	 */
+	ioctl(fd, BLKTRACESTOP_EXT);
+	return ioctl(fd, BLKTRACETEARDOWN_EXT);
+}
+
+static int __stop_trace(int fd)
+{
+	return use_ext ? __stop_tear_trace_ext(fd) : __stop_tear_trace(fd);
+}
+
 static int write_data(char *buf, int len)
 {
 	int ret;
@@ -1067,7 +1133,7 @@ static void close_client_connections(void)
 	}
 }
 
-static int setup_buts(void)
+static int __setup_buts(void)
 {
 	struct list_head *p;
 	int ret = 0;
@@ -1099,7 +1165,45 @@ static int setup_buts(void)
 	return ret;
 }
 
-static void start_buts(void)
+static int __setup_buts_ext(void)
+{
+	struct list_head *p;
+	int ret = 0;
+
+	__list_for_each(p, &devpaths) {
+		struct blk_user_trace_setup_ext buts;
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		memset(&buts, 0, sizeof(buts));
+		buts.buf_size = buf_size;
+		buts.buf_nr = buf_nr;
+		buts.act_mask = act_mask_ext;
+		buts.prio_mask = blktrace_prio_mask;
+
+		if (ioctl(dpp->fd, BLKTRACESETUP_EXT, &buts) >= 0) {
+			dpp->ncpus = max_cpus;
+			dpp->buts_name = strdup(buts.name);
+			dpp->setup_done = 1;
+			if (dpp->stats)
+				free(dpp->stats);
+			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
+			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
+		} else {
+			fprintf(stderr, "BLKTRACESETUP_EXT(2) %s failed: %d/%s\n",
+				dpp->path, errno, strerror(errno));
+			ret++;
+		}
+	}
+
+	return ret;
+}
+
+static int setup_buts(void)
+{
+	return use_ext ? __setup_buts_ext() : __setup_buts();
+}
+
+static void __start_buts(void)
 {
 	struct list_head *p;
 
@@ -1113,6 +1217,25 @@ static void start_buts(void)
 	}
 }
 
+static void __start_buts_ext(void)
+{
+	struct list_head *p;
+
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		if (ioctl(dpp->fd, BLKTRACESTART_EXT) < 0) {
+			fprintf(stderr, "BLKTRACESTART_EXT %s failed: %d/%s\n",
+				dpp->path, errno, strerror(errno));
+		}
+	}
+}
+
+static void start_buts(void)
+{
+	use_ext ? __start_buts_ext() : __start_buts();
+}
+
 static int get_drops(struct devpath *dpp)
 {
 	int fd, drops = 0;
@@ -1432,6 +1555,72 @@ static int handle_list_file(struct tracer_devpath_head *hd,
 	return entries_handled;
 }
 
+static int handle_list_file_ext(struct tracer_devpath_head *hd,
+			    struct list_head *list)
+{
+	int off, t_len, nevents;
+	struct blk_io_trace_ext *t;
+	struct list_head *p, *q;
+	int entries_handled = 0;
+	struct trace_buf *tbp, *prev;
+
+	prev = hd->prev;
+
+	list_for_each_safe(p, q, list) {
+		tbp = list_entry(p, struct trace_buf, head);
+		list_del(&tbp->head);
+		entries_handled++;
+
+		/*
+		 * If there was some leftover before, tack this new
+		 * entry onto the tail of the previous one.
+		 */
+		if (prev)
+			tbp = tb_combine(prev, tbp);
+
+		/*
+		 * See how many whole traces there are - send them
+		 * all out in one go.
+		 */
+		off = 0;
+		nevents = 0;
+		while (off + (int)sizeof(*t) <= tbp->len) {
+			t = (struct blk_io_trace_ext *)(tbp->buf + off);
+			t_len = sizeof(*t) + t->pdu_len;
+			if (off + t_len > tbp->len)
+				break;
+
+			off += t_len;
+			nevents++;
+		}
+		if (nevents)
+			pdc_nev_update(tbp->dpp, tbp->cpu, nevents);
+
+		/*
+		 * Write any full set of traces, any remaining data is kept
+		 * for the next pass.
+		 */
+		if (off) {
+			if (write_data(tbp->buf, off) || off = tbp->len) {
+				free(tbp);
+				prev = NULL;
+			}
+			else {
+				/*
+				 * Move valid data to beginning of buffer
+				 */
+				tbp->len -= off;
+				memmove(tbp->buf, tbp->buf + off, tbp->len);
+				prev = tbp;
+			}
+		} else
+			prev = tbp;
+	}
+	hd->prev = prev;
+
+	return entries_handled;
+}
+
 static void __process_trace_bufs(void)
 {
 	int cpu;
@@ -1954,7 +2143,7 @@ static void start_tracers(void)
 	}
 }
 
-static void stop_tracers(void)
+static void __stop_tracers(void)
 {
 	struct list_head *p;
 
@@ -1976,6 +2165,34 @@ static void stop_tracers(void)
 	pthread_cond_broadcast(&mt_cond);
 }
 
+static void __stop_tracers_ext(void)
+{
+	struct list_head *p;
+
+	/*
+	 * Stop the tracing - makes the tracer threads clean up quicker.
+	 */
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		(void)ioctl(dpp->fd, BLKTRACESTOP_EXT);
+	}
+
+	/*
+	 * Tell each tracer to quit
+	 */
+	__list_for_each(p, &tracers) {
+		struct tracer *tp = list_entry(p, struct tracer, head);
+		tp->is_done = 1;
+	}
+	pthread_cond_broadcast(&mt_cond);
+}
+
+static void stop_tracers(void)
+{
+	use_ext ? __stop_tracers_ext() : __stop_tracers();
+}
+
 static void del_tracers(void)
 {
 	struct list_head *p, *q;
@@ -2063,7 +2280,11 @@ static void show_stats(struct list_head *devpaths)
 			 * Estimate events if not known...
 			 */
 			if (sp->nevents = 0) {
-				sp->nevents = sp->data_read /
+				if (use_ext)
+					sp->nevents = sp->data_read /
+						sizeof(struct blk_io_trace_ext);
+				else
+					sp->nevents = sp->data_read /
 						sizeof(struct blk_io_trace);
 			}
 
@@ -2105,6 +2326,7 @@ static int handle_args(int argc, char *argv[])
 	int c, i;
 	struct statfs st;
 	int act_mask_tmp = 0;
+	uint64_t act_mask_tmp_ext = 0;
 
 	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) >= 0) {
 		switch (c) {
@@ -2129,11 +2351,35 @@ static int handle_args(int argc, char *argv[])
 			act_mask_tmp = i;
 			break;
 
+		case 'y':
+			i = find_mask_map_ext(optarg);
+			if (i < 0) {
+				fprintf(stderr, "Invalid action mask %s\n",
+					optarg);
+				return 1;
+			}
+			act_mask_tmp_ext |= i;
+			break;
+
+		case 'Y':
+			if ((sscanf(optarg, "%x", &i) != 1) ||
+							!valid_act_opt_ext(i)) {
+				fprintf(stderr,
+					"Invalid set action mask %s/0x%x\n",
+					optarg, i);
+				return 1;
+			}
+			act_mask_tmp_ext = i;
+			break;
+
 		case 'd':
 			if (add_devpath(optarg) != 0)
 				return 1;
 			break;
 
+		case 'E': /* use blktrace extensions */
+			use_ext = true;
+			break;
 		case 'I': {
 			char dev_line[256];
 			FILE *ifp = my_fopen(optarg, "r");
@@ -2211,6 +2457,27 @@ static int handle_args(int argc, char *argv[])
 		case 'p':
 			net_port = atoi(optarg);
 			break;
+		case 'P': /* enable priority tracking */
+			blktrace_track_prio = true;
+			break;
+		case 'x': /* priority mask values in string */
+			i = find_prio_mask_map(optarg);
+			if (i < 0) {
+				fprintf(stderr,"Invalid prio mask %s\n",
+						optarg);
+				return 1;
+			}
+			blktrace_prio_mask |= i;
+			break;
+		case 'X': /* priority mask values in hex */
+			if ((sscanf(optarg, "%x", &i) != 1) ||
+					!valid_prio_opt(i)) {
+				fprintf(stderr, "Invalid prio mask %s/0x%x\n",
+						optarg, i);
+				return 1;
+			}
+			blktrace_prio_mask = i;
+			break;
 		case 's':
 			net_use_sendfile = 0;
 			break;
@@ -2241,8 +2508,28 @@ static int handle_args(int argc, char *argv[])
 		return 1;
 	}
 
-	if (act_mask_tmp != 0)
-		act_mask = act_mask_tmp;
+	if (use_ext) {
+		if (act_mask_tmp) {
+			fprintf(stderr, "please use y or Y with -E\n");
+			return 1;
+		}
+		if (act_mask_tmp_ext != 0)
+			act_mask_ext = act_mask_tmp_ext;
+		/*
+		 * When track-priority is on and user didn't specify prio_mask then
+		 * trace all the classes.
+		 */
+		if (blktrace_track_prio && !blktrace_prio_mask)
+			blktrace_prio_mask = TRACE_ALL_IOPRIO;
+	} else {
+		if (act_mask_tmp != 0)
+			act_mask = act_mask_tmp;
+	}
+
+	if (!use_ext && (blktrace_track_prio || blktrace_prio_mask)) {
+		fprintf(stderr,"please specify -E with -P or -X or -x\n");
+		return 1;
+	}
 
 	if (net_mode = Net_client && net_setup_addr())
 		return 1;
@@ -2692,7 +2979,8 @@ static int run_tracers(void)
 			return 1;
 
 		if (piped_output)
-			handle_list = handle_list_file;
+			handle_list = use_ext ? handle_list_file_ext :
+				handle_list_file;
 		else
 			handle_list = handle_list_net;
 	}
-- 
2.19.1
