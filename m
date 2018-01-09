From: Hou Tao <houtao1@huawei.com>
Date: Tue, 09 Jan 2018 06:56:25 +0000
Subject: [PATCH 2/3] blkparse: add option g/group to output cgroup info
Message-Id: <20180109065626.5459-3-houtao1@huawei.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When blk_cgroup option is enabled in trace_options file, the trace
got by blktrace will include the io cgroup info for trace action or
trace message. The io cgroup info is a file handle exported by kernfs
(union kernfs_node_id), so we use open_by_handle_at() and procfs to
get the path of the corresponding io cgroup and output the cgroup path
before the pid. Maybe we also need to add a cache for the translation
from kernfs (ino, gen) tuple to cgroup path.

The following lines are snippet from output with cgroup info:
253,0    3      664     0.528123310 /t1    0  C   R 790832 + 8 [0]
253,0    3      665     0.528208698  1521  A   R 452720 + 8 <- (253,1) 450672
253,0    3      666     0.528211593 /t1 1521  Q   R 452720 + 8 [fio]
253,0    3      667     0.528215253 /t1 1521  G   R 452720 + 8 [fio]
253,0    3      668     0.528219125  1521  P   N [fio]
253,0    3      669     0.528221590  1521 UT   N [fio] 1
253,0    3      670     0.528223067 /t1 1521  I   R 452720 + 8 [fio]
253,0    3      671     0.528226553 /t1 1521  D   R 452720 + 8 [fio]
253,0    5      608     0.533095375 /    0  C   R 3868224 + 8 [0]
253,0    5      609     0.533164175  1523  A   R 4641296 + 8 <- (253,1) 4639248
253,0    5      610     0.533166445 / 1523  Q   R 4641296 + 8 [fio]
253,0    5      611     0.533169825 / 1523  G   R 4641296 + 8 [fio]

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 blkparse.c     | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 blkparse_fmt.c |  10 ++++--
 blktrace.h     |   2 ++
 doc/blkparse.1 |   9 ++++-
 4 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index fa2f520..35958d2 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -148,6 +148,12 @@ static struct option l_opts[] = {
 		.val = 'F'
 	},
 	{
+		.name = "cgroup",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'g',
+	},
+	{
 		.name = "hash-by-name",
 		.has_arg = no_argument,
 		.flag = NULL,
@@ -292,6 +298,15 @@ static char *pipename;
 
 static int text_output = 1;
 
+int show_cgroup = 0;
+static const char *unknown_cg = "<...>";
+static const char *root_cg = "/";
+static int cg_mount_fd;
+static struct file_handle *cg_handle;
+static int cg_path_skip;
+static char cg_path[NAME_MAX + 1];
+
+
 #define is_done()	(*(volatile int *)(&done))
 static volatile int done;
 
@@ -572,6 +587,45 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
 	return ppm;
 }
 
+void get_cg_path(struct blk_io_trace *bit, const char **path)
+{
+#define FILEID_INO32_GEN 1
+	int fd = -1;
+	union kernfs_node_id *id;
+	char fd_path[NAME_MAX + 1];
+	ssize_t cnt;
+
+	cg_handle->handle_bytes = sizeof(*id);
+	cg_handle->handle_type = FILEID_INO32_GEN;
+	id = (void *)&cg_handle[1];
+
+	memcpy(id, (void *)&bit[1], sizeof(*id));
+
+	fd = open_by_handle_at(cg_mount_fd, cg_handle, 0);
+	if (fd < 0)
+		goto err_out;
+
+	snprintf(fd_path, sizeof(fd_path), "/proc/%d/fd/%d", getpid(), fd);
+	cnt = readlink(fd_path, cg_path, sizeof(cg_path) - 1);
+	if (cnt < 0)
+		goto err_out;
+
+	close(fd);
+
+	cg_path[cnt] = '\0';
+	if (cg_path_skip < cnt)
+		*path = cg_path + cg_path_skip;
+	else
+		*path = root_cg;
+
+	return;
+
+err_out:
+	if (fd >= 0)
+		close(fd);
+	*path = unknown_cg;
+}
+
 static void handle_notify(struct blk_io_trace *bit)
 {
 	void	*payload;
@@ -607,16 +661,22 @@ static void handle_notify(struct blk_io_trace *bit)
 	case BLK_TN_MESSAGE:
 		if (pdu_len > 0) {
 			char msg[pdu_len+1];
+			const char *cg_path;
 
 			memcpy(msg, (char *)payload, pdu_len);
 			msg[pdu_len] = '\0';
 
+			if (show_cgroup && (bit->action & __BLK_TA_CGROUP))
+				get_cg_path(bit, &cg_path);
+			else
+				cg_path = "";
+
 			fprintf(ofp,
-				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+				"%3d,%-3d %2d %8s %5d.%09lu %s%5u %2s %3s %s\n",
 				MAJOR(bit->device), MINOR(bit->device),
 				bit->cpu, "0", (int) SECONDS(bit->time),
 				(unsigned long) NANO_SECONDS(bit->time),
-				0, "m", "N", msg);
+				cg_path, 0, "m", "N", msg);
 		}
 		break;
 
@@ -2743,7 +2803,36 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
+static int init_cg_res(void)
+{
+	const char *path;
+
+	cg_handle = malloc(sizeof(*cg_handle) + sizeof(union kernfs_node_id));
+	if (!cg_handle) {
+		perror("malloc");
+		return -1;
+	}
+
+	path = "/sys/fs/cgroup/blkio";
+	cg_mount_fd = open(path, O_RDONLY);
+	if (cg_mount_fd < 0) {
+		if (errno = ENOENT) {
+			path = "/sys/fs/cgroup/unified";
+			cg_mount_fd = open(path, O_RDONLY);
+		}
+
+		if (cg_mount_fd < 0) {
+			perror("open io cgroup");
+			return -1;
+		}
+	}
+
+	cg_path_skip = strlen(path);
+
+	return 0;
+}
+
+#define S_OPTS  "a:A:b:D:d:f:F:ghi:o:Oqstw:vVM"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -2753,6 +2842,7 @@ static char usage_str[] =    "\n\n" \
 	"[ -D <dir>          | --input-directory=<dir> ]\n" \
 	"[ -f <format>       | --format=<format> ]\n" \
 	"[ -F <spec>         | --format-spec=<spec> ]\n" \
+	"[ -g                | --cgroup\n" \
 	"[ -h                | --hash-by-name ]\n" \
 	"[ -o <file>         | --output=<file> ]\n" \
 	"[ -O                | --no-text-output ]\n" \
@@ -2771,6 +2861,7 @@ static char usage_str[] =    "\n\n" \
 	"\t-f Output format. Customize the output format. The format field\n" \
 	"\t   identifies can be found in the documentation\n" \
 	"\t-F Format specification. Can be found in the documentation\n" \
+	"\t-g Show the io cgroup of trace action or trace message\n" \
 	"\t-h Hash processes by name, not pid\n" \
 	"\t-i Input file containing trace data, or '-' for stdin\n" \
 	"\t-o Output file. If not given, output is stdout\n" \
@@ -2840,6 +2931,9 @@ int main(int argc, char *argv[])
 			if (rb_batch <= 0)
 				rb_batch = RB_BATCH_DEFAULT;
 			break;
+		case 'g':
+			show_cgroup = 1;
+			break;
 		case 's':
 			per_process_stats = 1;
 			break;
@@ -2898,6 +2992,9 @@ int main(int argc, char *argv[])
 	if (act_mask_tmp != 0)
 		act_mask = act_mask_tmp;
 
+	if (show_cgroup && init_cg_res())
+		return 1;
+
 	memset(&rb_sort_root, 0, sizeof(rb_sort_root));
 
 	signal(SIGINT, handle_sigint);
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 8dc20ca..58c2721 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -312,6 +312,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 	struct blk_io_trace_remap r = { .device_from = 0, };
 	char rwbs[8];
 	char *name;
+	const char *cg_path;
 
 	fill_rwbs(rwbs, t);
 
@@ -324,13 +325,18 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		 t->device = r.device_to;
 	 }
 
+	if (show_cgroup && (t->action & __BLK_TA_CGROUP))
+		get_cg_path(t, &cg_path);
+	else
+		cg_path = "";
+
 	/*
 	 * The header is always the same
 	 */
-	fprintf(ofp, "%3d,%-3d %2d %8d %5d.%09lu %5u %2s %3s ",
+	fprintf(ofp, "%3d,%-3d %2d %8d %5d.%09lu %s%5u %2s %3s ",
 		MAJOR(t->device), MINOR(t->device), pci->cpu, t->sequence,
 		(int) SECONDS(t->time), (unsigned long) NANO_SECONDS(t->time),
-		t->pid, act, rwbs);
+		cg_path, t->pid, act, rwbs);
 
 	name = find_process_name(t->pid);
 
diff --git a/blktrace.h b/blktrace.h
index c5ed618..6874edb 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -68,6 +68,7 @@ struct per_cpu_info {
 extern FILE *ofp;
 extern int data_is_native;
 extern struct timespec abs_start_time;
+extern int show_cgroup;
 
 #define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) = BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
@@ -152,5 +153,6 @@ extern char *find_process_name(pid_t);
 
 extern void pdu_start_len(struct blk_io_trace *bit,
 			void **pdu, __u16 *pdu_len);
+extern void get_cg_path(struct blk_io_trace *bit, const char **path);
 
 #endif
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index be9b34b..de2f9cd 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -114,11 +114,18 @@ event type. The single\-character \fItyp\fR field is one of the
 action specifiers described in ACTION IDENTIFIERS.
 .RE
 
+\-g
+.br
+\-\-cgroup
+.RS
+Show the io cgroup of trace action or trace message
+.RE
+
 \-M
 .br
 \-\-no-msgs
 .RS
-When \-d is specified, this will stop messages from being output to the
+When \-M is specified, this will stop messages from being output to the
 file. (Can seriously reduce the size of the resultant file when using
 the CFQ I/O scheduler.)
 .RE
-- 
2.9.5

