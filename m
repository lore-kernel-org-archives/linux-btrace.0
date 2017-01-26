From: Jan Kara <jack@suse.cz>
Date: Thu, 26 Jan 2017 10:23:53 +0000
Subject: [PATCH 1/3] blktrace: Add support for sparse CPU numbers
Message-Id: <20170126102355.19802-1-jack@suse.cz>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On some machines CPU numbers do not form a contiguous interval. In such
cases blktrace will fail to start threads for missing CPUs and exit
effectively rendering itself unusable.

Add support into blktrace to handle systems with sparse CPU numbers.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 blktrace.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 99 insertions(+), 16 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index b445524b1f0b..f7d35dd1a62e 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -274,7 +274,9 @@ static char blktrace_version[] = "2.0.0";
 int data_is_native = -1;
 
 static int ndevs;
+static int max_cpus;
 static int ncpus;
+static cpu_set_t *online_cpus;
 static int pagesize;
 static int act_mask = ~0U;
 static int kill_running_trace;
@@ -623,8 +625,9 @@ static int lock_on_cpu(int cpu)
 {
 	cpu_set_t * cpu_mask;
 	size_t size;
-	cpu_mask = CPU_ALLOC(ncpus);
-	size = CPU_ALLOC_SIZE(ncpus);
+
+	cpu_mask = CPU_ALLOC(max_cpus);
+	size = CPU_ALLOC_SIZE(max_cpus);
 
 	CPU_ZERO_S(size, cpu_mask);
 	CPU_SET_S(cpu, size, cpu_mask);
@@ -882,7 +885,7 @@ static int net_send_header(int fd, int cpu, char *buts_name, int len)
 	strncpy(hdr.buts_name, buts_name, sizeof(hdr.buts_name));
 	hdr.buts_name[sizeof(hdr.buts_name) - 1] = '\0';
 	hdr.cpu = cpu;
-	hdr.max_cpus = ncpus;
+	hdr.max_cpus = max_cpus;
 	hdr.len = len;
 	hdr.cl_id = getpid();
 	hdr.buf_size = buf_size;
@@ -1026,9 +1029,12 @@ static int net_setup_client(void)
 static int open_client_connections(void)
 {
 	int cpu;
+	size_t alloc_size = CPU_ALLOC_SIZE(max_cpus);
 
 	cl_fds = calloc(ncpus, sizeof(*cl_fds));
-	for (cpu = 0; cpu < ncpus; cpu++) {
+	for (cpu = 0; cpu < max_cpus; cpu++) {
+		if (!CPU_ISSET_S(cpu, alloc_size, online_cpus))
+			continue;
 		cl_fds[cpu] = net_setup_client();
 		if (cl_fds[cpu] < 0)
 			goto err;
@@ -1046,8 +1052,11 @@ static void close_client_connections(void)
 {
 	if (cl_fds) {
 		int cpu, *fdp;
+		size_t alloc_size = CPU_ALLOC_SIZE(max_cpus);
 
-		for (cpu = 0, fdp = cl_fds; cpu < ncpus; cpu++, fdp++) {
+		for (cpu = 0, fdp = cl_fds; cpu < max_cpus; cpu++, fdp++) {
+			if (!CPU_ISSET_S(cpu, alloc_size, online_cpus))
+				continue;
 			if (*fdp >= 0) {
 				net_send_drops(*fdp);
 				net_close_connection(fdp);
@@ -1071,7 +1080,7 @@ static void setup_buts(void)
 		buts.act_mask = act_mask;
 
 		if (ioctl(dpp->fd, BLKTRACESETUP, &buts) >= 0) {
-			dpp->ncpus = ncpus;
+			dpp->ncpus = max_cpus;
 			dpp->buts_name = strdup(buts.name);
 			if (dpp->stats)
 				free(dpp->stats);
@@ -1155,7 +1164,7 @@ static void free_tracer_heads(struct devpath *dpp)
 	int cpu;
 	struct tracer_devpath_head *hd;
 
-	for (cpu = 0, hd = dpp->heads; cpu < ncpus; cpu++, hd++) {
+	for (cpu = 0, hd = dpp->heads; cpu < max_cpus; cpu++, hd++) {
 		if (hd->prev)
 			free(hd->prev);
 
@@ -1177,8 +1186,8 @@ static int setup_tracer_devpaths(void)
 		struct tracer_devpath_head *hd;
 		struct devpath *dpp = list_entry(p, struct devpath, head);
 
-		dpp->heads = calloc(ncpus, sizeof(struct tracer_devpath_head));
-		for (cpu = 0, hd = dpp->heads; cpu < ncpus; cpu++, hd++) {
+		dpp->heads = calloc(max_cpus, sizeof(struct tracer_devpath_head));
+		for (cpu = 0, hd = dpp->heads; cpu < max_cpus; cpu++, hd++) {
 			INIT_LIST_HEAD(&hd->head);
 			pthread_mutex_init(&hd->mutex, NULL);
 			hd->prev = NULL;
@@ -1426,7 +1435,7 @@ static void __process_trace_bufs(void)
 		struct devpath *dpp = list_entry(p, struct devpath, head);
 		struct tracer_devpath_head *hd = dpp->heads;
 
-		for (cpu = 0; cpu < ncpus; cpu++, hd++) {
+		for (cpu = 0; cpu < max_cpus; cpu++, hd++) {
 			pthread_mutex_lock(&hd->mutex);
 			if (list_empty(&hd->head)) {
 				pthread_mutex_unlock(&hd->mutex);
@@ -1876,14 +1885,19 @@ static int start_tracer(int cpu)
 
 static void start_tracers(void)
 {
-	int cpu;
+	int cpu, started = 0;
 	struct list_head *p;
+	size_t alloc_size = CPU_ALLOC_SIZE(max_cpus);
 
-	for (cpu = 0; cpu < ncpus; cpu++)
+	for (cpu = 0; cpu < max_cpus; cpu++) {
+		if (!CPU_ISSET_S(cpu, alloc_size, online_cpus))
+			continue;
 		if (start_tracer(cpu))
 			break;
+		started++;
+	}
 
-	wait_tracers_ready(cpu);
+	wait_tracers_ready(started);
 
 	__list_for_each(p, &tracers) {
 		struct tracer *tp = list_entry(p, struct tracer, head);
@@ -2657,15 +2671,83 @@ static int run_tracers(void)
 	return 0;
 }
 
+static cpu_set_t *get_online_cpus(void)
+{
+	FILE *cpus;
+	cpu_set_t *set;
+	size_t alloc_size;
+	int cpuid, prevcpuid = -1;
+	char nextch;
+	int n, ncpu, curcpu = 0;
+	int *cpu_nums;
+
+	ncpu = sysconf(_SC_NPROCESSORS_CONF);
+	if (ncpu < 0)
+		return NULL;
+
+	cpu_nums = malloc(sizeof(int)*ncpu);
+	if (!cpu_nums) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	/*
+	 * There is no way to easily get maximum CPU number. So we have to
+	 * parse the file first to find it out and then create appropriate
+	 * cpuset
+	 */
+	cpus = my_fopen("/sys/devices/system/cpu/online", "r");
+	for (;;) {
+		n = fscanf(cpus, "%d%c", &cpuid, &nextch);
+		if (n <= 0)
+			break;
+		if (n = 2 && nextch = '-') {
+			prevcpuid = cpuid;
+			continue;
+		}
+		if (prevcpuid = -1)
+			prevcpuid = cpuid;
+		while (prevcpuid <= cpuid) {
+			/* More CPUs listed than configured? */
+			if (curcpu >= ncpu) {
+				errno = EINVAL;
+				return NULL;
+			}
+			cpu_nums[curcpu++] = prevcpuid++;
+		}
+		prevcpuid = -1;
+	}
+	fclose(cpus);
+
+	ncpu = curcpu;
+	max_cpus = cpu_nums[ncpu - 1] + 1;
+
+	/* Now that we have maximum cpu number, create a cpuset */
+	set = CPU_ALLOC(max_cpus);
+	if (!set) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	alloc_size = CPU_ALLOC_SIZE(max_cpus);
+	CPU_ZERO_S(alloc_size, set);
+
+	for (curcpu = 0; curcpu < ncpu; curcpu++)
+		CPU_SET_S(cpu_nums[curcpu], alloc_size, set);
+
+	free(cpu_nums);
+
+	return set;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
 
 	setlocale(LC_NUMERIC, "en_US");
 	pagesize = getpagesize();
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
-	if (ncpus < 0) {
-		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed %d/%s\n",
+	online_cpus = get_online_cpus();
+	if (!online_cpus) {
+		fprintf(stderr, "cannot get online cpus %d/%s\n",
 			errno, strerror(errno));
 		ret = 1;
 		goto out;
@@ -2674,6 +2756,7 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	ncpus = CPU_COUNT_S(CPU_ALLOC_SIZE(max_cpus), online_cpus);
 	if (ndevs > 1 && output_name && strcmp(output_name, "-") != 0) {
 		fprintf(stderr, "-o not supported with multiple devices\n");
 		ret = 1;
-- 
2.10.2

