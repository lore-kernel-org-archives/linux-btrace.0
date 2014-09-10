From: Robert Schiele <rschiele@gmail.com>
Date: Wed, 10 Sep 2014 05:42:22 +0000
Subject: [PATCH] handle offline CPUs
Message-Id: <20140910054222.GA25814@ulegcprs1.emea.nsn-net.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

So far the code had trouble dealing with the situation of offline
CPUs.  In such a scenario the lock_on_cpu failed and thus the whole
tracing was shut down since an error was detected there and thus
nthreads_running != ncpus.

This change introduces a new thread_status Th_offline, which is kind
of an acceptable error status that is set on the thread when it could
not be started due to the CPU being offline.

To achieve that we read /proc/stat on startup and record all online
CPUs in a CPU set, such that we later in the thread can determine
whether the relevant CPU is online or leave early with thread_status
Th_offline otherwise.  For getting the application up Th_offline is
counted towards success, such that the overall application does not
fail due to offline CPUs.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---

Some more comments on this code:

It would be great if someone with deeper understanding of the state
machine could review the code, especially under the aspect of
introducing the new thread_status value Th_offline.

Additionally I was looking for a method to determine the set of
online CPUs without parsing test files from the proc file system
but couldn't find one.  Thus if someone is aware of a smarter way
to collect this information I would like to hear about it.

Robert

 blktrace.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 3c8fb4c..f8a54d0 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -73,6 +73,7 @@ enum {
 
 enum thread_status {
 	Th_running,
+	Th_offline,
 	Th_leaving,
 	Th_error
 };
@@ -275,6 +276,8 @@ int data_is_native = -1;
 
 static int ndevs;
 static int ncpus;
+static cpu_set_t * cpu_online_mask;
+static size_t cpu_online_mask_size;
 static int pagesize;
 static int act_mask = ~0U;
 static int kill_running_trace;
@@ -309,6 +312,7 @@ static volatile int dp_entries;
 static pthread_cond_t mt_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t mt_mutex = PTHREAD_MUTEX_INITIALIZER;
 static volatile int nthreads_running;
+static volatile int nthreads_offline;
 static volatile int nthreads_leaving;
 static volatile int nthreads_error;
 static volatile int tracers_run;
@@ -567,6 +571,8 @@ static void tracer_signal_ready(struct tracer *tp,
 
 	if (th_status = Th_running)
 		nthreads_running++;
+	else if (th_status = Th_offline)
+		nthreads_offline++;
 	else if (th_status = Th_error)
 		nthreads_error++;
 	else
@@ -579,7 +585,7 @@ static void tracer_signal_ready(struct tracer *tp,
 static void wait_tracers_ready(int ncpus_started)
 {
 	pthread_mutex_lock(&mt_mutex);
-	while ((nthreads_running + nthreads_error) < ncpus_started)
+	while ((nthreads_running + nthreads_offline + nthreads_error) < ncpus_started)
 		t_pthread_cond_wait(&mt_cond, &mt_mutex);
 	pthread_mutex_unlock(&mt_mutex);
 }
@@ -1806,11 +1812,21 @@ static int handle_pfds_entries(struct tracer *tp, int nevs, int force_read)
 	return nentries;
 }
 
+static int cpu_online(int cpu) {
+	return CPU_ISSET_S(cpu, cpu_online_mask_size, cpu_online_mask);
+}
+
 static void *thread_main(void *arg)
 {
 	int ret, ndone, to_val;
 	struct tracer *tp = arg;
 
+	if (! cpu_online(tp->cpu)) {
+		fprintf(stderr, "skip offline CPU %d\n", tp->cpu);
+		tracer_signal_ready(tp, Th_offline, 0);
+		return NULL;
+	}
+
 	ret = lock_on_cpu(tp->cpu);
 	if (ret)
 		goto err;
@@ -2637,7 +2653,7 @@ static int run_tracers(void)
 	}
 
 	start_tracers();
-	if (nthreads_running = ncpus) {
+	if (nthreads_running + nthreads_offline = ncpus) {
 		unblock_tracers();
 		start_buts();
 		if (net_mode = Net_client)
@@ -2648,7 +2664,7 @@ static int run_tracers(void)
 		stop_tracers();
 
 	wait_tracers();
-	if (nthreads_running = ncpus)
+	if (nthreads_running + nthreads_offline = ncpus)
 		show_stats(&devpaths);
 	if (net_client_use_send())
 		close_client_connections();
@@ -2657,6 +2673,42 @@ static int run_tracers(void)
 	return 0;
 }
 
+static int read_online_cpus() {
+	cpu_online_mask = CPU_ALLOC(ncpus);
+	cpu_online_mask_size = CPU_ALLOC_SIZE(ncpus);
+
+	CPU_ZERO_S(cpu_online_mask_size, cpu_online_mask);
+
+	if (ncpus > 1) {
+		FILE *fp;
+		char line[4096];
+
+		fp = my_fopen("/proc/stat", "r");
+		if (fp = NULL) {
+			CPU_FREE(cpu_online_mask);
+			fprintf(stderr, "opening /proc/stat failed %d/%s\n",
+				errno, strerror(errno));
+			return 1;
+		}
+
+		while (fgets(line, 4096, fp)) {
+			if ((! memcmp(line, "cpu", 3)) && line[3] != ' ') {
+				int cpu;
+				if (sscanf(line + 3, "%d ", &cpu) = 1)
+					CPU_SET_S(cpu, cpu_online_mask_size, cpu_online_mask);
+				else {
+					CPU_FREE(cpu_online_mask);
+					fprintf(stderr, "parsing /proc/stat failed\n");
+					return 1;
+				}
+			}
+		}
+	} else
+		CPU_SET_S(0, cpu_online_mask_size, cpu_online_mask);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
@@ -2673,6 +2725,10 @@ int main(int argc, char *argv[])
 		ret = 1;
 		goto out;
 	}
+	if (read_online_cpus()) {
+		ret = 1;
+		goto out;
+	}
 
 	if (ndevs > 1 && output_name && strcmp(output_name, "-") != 0) {
 		fprintf(stderr, "-o not supported with multiple devices\n");
@@ -2707,6 +2763,8 @@ int main(int argc, char *argv[])
 	} else
 		ret = run_tracers();
 
+	CPU_FREE(cpu_online_mask);
+
 out:
 	if (pfp)
 		fclose(pfp);
-- 
1.8.4.5
