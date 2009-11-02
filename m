From: dhsharp@google.com
Date: Mon, 02 Nov 2009 22:39:29 +0000
Subject: [PATCH] blktrace: triggered output: with '-t' option, trigger output on SIGUSR1
Message-Id: <1257201569-8551-2-git-send-email-dhsharp@google.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1257201569-8551-1-git-send-email-dhsharp@google.com>
In-Reply-To: <1257201569-8551-1-git-send-email-dhsharp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: David Sharp <dhsharp@google.com>

Allow the kernel ring buffer to accumulate and drop events. Use wait conditions
to block the reader threads just before poll().  In SIGUSR1 handler, signal the
wait conditions to unblock the threads.  Each tracer thread has its own wait
condition and trigger count.  Don't warn about the (intentionally) dropped
events.
---
 blktrace.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index b4c919d..531e924 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -167,6 +167,13 @@ struct tracer {
 	pthread_t thread;
 	int cpu, nios;
 	volatile int status, is_done;
+
+	/*
+	 * Wait condition to trigger reading on signal for triggered output.
+	 */
+	pthread_mutex_t trig_mutex;
+	pthread_cond_t trig_cond;
+	int trig_count;
 };
 
 /*
@@ -280,6 +287,7 @@ static int act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
+static int triggered_output;
 
 static char *debugfs_path = "/sys/kernel/debug";
 static char *output_name;
@@ -326,7 +334,7 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
-#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:t"
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -431,13 +439,20 @@ static struct option l_opts[] = {
 		.val = 's'
 	},
 	{
+		.name = "triggered-output",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 't'
+	},
+	{
 		.name = NULL,
 	}
 };
 
 static char usage_str[] = \
 	"-d <dev> [ -r debugfs path ] [ -o <output> ] [-k ] [ -w time ]\n" \
-	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -v ]\n\n" \
+	"[ -a action ] [ -A action mask ] [ -I  <devs file> ]\n" \
+	"[ -t ] [ -v ]\n\n" \
 	"\t-d Use specified device. May also be given last after options\n" \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
 	"\t-o File(s) to send output to\n" \
@@ -453,7 +468,9 @@ static char usage_str[] = \
 	"\t-p Network port to use (default 8462)\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
-	"\t-V Print program version info\n\n";
+	"\t-V Print program version info\n" \
+	"\t-t Trigger reading on SIGUSR1, allowing kernel ring buffers to " \
+        "overflow.\n\n";
 
 static void clear_events(struct pollfd *pfd)
 {
@@ -577,6 +594,30 @@ static void wait_tracers_leaving(void)
 	pthread_mutex_unlock(&mt_mutex);
 }
 
+static void trigger_tracers(int trigger) {
+	struct list_head *p;
+	__list_for_each(p, &tracers) {
+		struct tracer *tp = list_entry(p, struct tracer, head);
+		pthread_mutex_lock(&tp->trig_mutex);
+		if (trigger)
+			tp->trig_count++;
+		pthread_cond_signal(&tp->trig_cond);
+		pthread_mutex_unlock(&tp->trig_mutex);
+	}
+}
+
+static int trigger_wait(struct tracer *tp) {
+	int ret;
+	pthread_mutex_lock(&tp->trig_mutex);
+	while(tp->trig_count = 0 && !tp->is_done)
+		pthread_cond_wait(&tp->trig_cond, &tp->trig_mutex);
+	ret = tp->trig_count;
+	if (tp->trig_count > 0)
+		tp->trig_count--;
+	pthread_mutex_unlock(&tp->trig_mutex);
+	return ret;
+}
+
 static void init_mmap_info(struct mmap_info *mip)
 {
 	mip->buf_size = buf_size;
@@ -1778,7 +1819,9 @@ static void *thread_main(void *arg)
 	if (ret)
 		goto err;
 
-	if (piped_output)
+	if (triggered_output)
+		to_val = 0;		/* Don't wait after a trigger */
+	else if (piped_output)
 		to_val = 50;		/* Frequent partial handles */
 	else
 		to_val = 500;		/* 1/2 second intervals */
@@ -1788,6 +1831,10 @@ static void *thread_main(void *arg)
 	tracer_wait_unblock(tp);
 
 	while (!tp->is_done) {
+		if (triggered_output) {
+			if (!trigger_wait(tp) && tp->is_done)
+				break;
+		}
 		ndone = poll(tp->pfds, ndevs, to_val);
 		if (ndone || piped_output)
 			(void)handle_pfds(tp, ndone, piped_output);
@@ -1799,8 +1846,9 @@ static void *thread_main(void *arg)
 	/*
 	 * Trace is stopped, pull data until we get a short read
 	 */
-	while (handle_pfds(tp, ndevs, 1) > 0)
-		;
+	if (!triggered_output)
+		while (handle_pfds(tp, ndevs, 1) > 0)
+			;
 
 	close_ios(tp);
 	tracer_signal_ready(tp, Th_leaving, 0);
@@ -1822,6 +1870,10 @@ static int start_tracer(int cpu)
 	tp->status = 0;
 	tp->cpu = cpu;
 
+	pthread_mutex_init(&tp->trig_mutex, NULL);
+	pthread_cond_init(&tp->trig_cond, NULL);
+	tp->trig_count = 0;
+
 	if (pthread_create(&tp->thread, NULL, thread_main, tp)) {
 		fprintf(stderr, "FAILED to start thread on CPU %d: %d/%s\n",
 			cpu, errno, strerror(errno));
@@ -1872,6 +1924,13 @@ static void stop_tracers(void)
 		struct tracer *tp = list_entry(p, struct tracer, head);
 		tp->is_done = 1;
 	}
+
+	/*
+	 * Wake up the tracers if they're waiting for a trigger.
+	 */
+	if (triggered_output) {
+		trigger_tracers(0);
+	}
 }
 
 static void del_tracers(void)
@@ -1930,6 +1989,11 @@ static void handle_sigint(__attribute__((__unused__)) int sig)
 	stop_tracers();
 }
 
+static void handle_sigusr1(__attribute__((__unused__)) int sig)
+{
+	trigger_tracers(1);
+}
+
 static void show_stats(struct list_head *devpaths)
 {
 	FILE *ofp;
@@ -1985,7 +2049,7 @@ static void show_stats(struct list_head *devpaths)
 	if (piped_output)
 		fclose(ofp);
 
-	if (total_drops) {
+	if (!triggered_output && total_drops) {
 		double drops_ratio = 1.0;
 
 		if (total_events)
@@ -2106,6 +2170,9 @@ static int handle_args(int argc, char *argv[])
 		case 's':
 			net_use_sendfile = 0;
 			break;
+		case 't':
+			triggered_output = 1;
+			break;
 		default:
 			show_usage(argv[0]);
 			exit(1);
@@ -2580,6 +2647,10 @@ static int run_tracers(void)
 			handle_list = handle_list_net;
 	}
 
+	if (triggered_output) {
+		signal(SIGUSR1, handle_sigusr1);
+	}
+
 	start_tracers();
 	if (nthreads_running = ncpus) {
 		unblock_tracers();
-- 
1.6.5.2.5.g7c3ba.dirty

