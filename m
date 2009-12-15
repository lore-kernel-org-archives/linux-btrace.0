From: Edward Shishkin <edward@redhat.com>
Date: Tue, 15 Dec 2009 17:48:06 +0000
Subject: [patch 4/5] blktrace: disable kill option
Message-Id: <4B27CBD6.6060807@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090207030309000302050001"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090207030309000302050001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090207030309000302050001
Content-Type: text/plain;
 name="blktrace-fix-513950.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blktrace-fix-513950.patch"

Fixup for 513950.

Problem:
'blktrace -d <device> -k' does not kill a running
backgound trace. Executing 'blktrace -d <device> -k'
for the second time results in "BLKTRACETEARDOWN:
Invalid argument" message and then each run of
blktrace on that machine prints the following output:
BLKTRACESETUP: No such file or directory.

The bug:
The option -k results in clobbering information
about running trace by kernel (blk_trace_remove),
while resources (files open in debugfs by the running
background blktrace) are not released.

Solution:
. Disable non-working "kill" option;
. Update documentation, advise to send SIGINT signal
  via kill(1) to the running background blktrace for
  its correct termination.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
 blktrace.c     |   14 +++++++++++++-
 doc/blktrace.8 |   24 ++++--------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

--- blktrace.orig/blktrace.c
+++ blktrace/blktrace.c
@@ -64,6 +64,7 @@
 
 #define DEBUGFS_TYPE		(0x64626720)
 #define TRACE_NET_PORT		(8462)
+#define KILL_OPT_ENABLED        (0)
 
 enum {
 	Net_none = 0,
@@ -326,7 +327,12 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
+#if KILL_OPT_ENABLED
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+#else
+#define S_OPTS	"d:a:A:r:o:w:vVb:n:D:lh:p:sI:"
+#endif /* KILL_OPT_ENABLED */
+
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -364,12 +370,14 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'o'
 	},
+#if KILL_OPT_ENABLED
 	{
 		.name = "kill",
 		.has_arg = no_argument,
 		.flag = NULL,
 		.val = 'k'
 	},
+#endif /* KILL_OPT_ENABLED */
 	{
 		.name = "stopwatch",
 		.has_arg = required_argument,
@@ -442,7 +450,9 @@ static char usage_str[] = \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
 	"\t-o File(s) to send output to\n" \
 	"\t-D Directory to prepend to output file names\n" \
-	"\t-k Kill a running trace\n" \
+#if KILL_OPT_ENABLED
+        "\t-k Kill a running trace\n" \
+#endif /* KILL_OPT_ENABLED */
 	"\t-w Stop after defined time, in seconds\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
@@ -2065,9 +2075,11 @@ static int handle_args(int argc, char *a
 		case 'o':
 			output_name = optarg;
 			break;
+#if KILL_OPT_ENABLED
 		case 'k':
 			kill_running_trace = 1;
 			break;
+#endif /* KILL_OPT_ENABLED */
 		case 'w':
 			stop_watch = atoi(optarg);
 			if (stop_watch <= 0) {
--- blktrace.orig/doc/blktrace.8
+++ blktrace/doc/blktrace.8
@@ -66,19 +66,10 @@ blktrace may also be run concurrently wi
 .TP 2
 \- 
 The default behaviour for blktrace is to run forever until explicitly
-killed by the user (via a control-C, or kill utility invocation).
-There are two ways to modify this:
-
-.TP 5
-  1. 
-You may utilise the blktrace utility itself to kill
-a running trace -- via the \fB\-k\fR option.
-
-.TP 5
-  2.
-You can specify a run-time duration for blktrace via the
-\fB\-w\fR option -- then blktrace will run for the specified number
-of seconds, and then halt.
+killed by the user (via a control-C, or sending SIGINT signal to the
+process via invocation the kill (1) utility). Also you can specify a
+run-time duration for blktrace via the \fB\-w\fR option -- then
+blktrace will run for the specified number of seconds, and then halt.
 
 
 .SH OPTIONS
@@ -119,13 +110,6 @@ Adds \fIdev\fR as a device to trace  
 Adds the devices found in \fIfile\fR as devices to trace
 .RE
 
-\-k 
-.br
-\-\-kill 
-.RS
-Kill on-going trace  
-.RE
-
 \-n \fInum\-sub\fR 
 .br
 \-\-num\-sub=\fInum-sub\fR    

--------------090207030309000302050001--
