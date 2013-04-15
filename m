From: Nathan Zimmer <nzimmer@sgi.com>
Date: Mon, 15 Apr 2013 14:53:36 +0000
Subject: [PATCH 5/5] blktrace blkreplay: convert to use a dynamic cpu_set_t
Message-Id: <1366037616-20159-6-git-send-email-nzimmer@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Some distros have changed CPU_SETSIZE in glibc to 4096 since that matches
the NR_CPUS in the linux kernel config file.  Some distros have decided to
leave CPU_SETSIZE at 1024. This is a problem if you want to run that distro
on a very large machine.

CPU_SETSIZE is use by the struct cpu_set_t.  This means you to deal with cpus
greater the 1024 you must use the dynamic cpu sets, which involves converting
from things like CPU_SET to CPU_SET_S.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
---
 blktrace.c          | 16 +++++++++++-----
 btreplay/btreplay.c | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 63125ab..7e64c94 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -621,13 +621,19 @@ static void dpp_free(struct devpath *dpp)
 
 static int lock_on_cpu(int cpu)
 {
-	cpu_set_t cpu_mask;
-
-	CPU_ZERO(&cpu_mask);
-	CPU_SET(cpu, &cpu_mask);
-	if (sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask) < 0)
+	cpu_set_t * cpu_mask;
+	size_t size;
+	cpu_mask = CPU_ALLOC(ncpus);
+	size = CPU_ALLOC_SIZE(ncpus);
+
+	CPU_ZERO_S(size, cpu_mask);
+	CPU_SET_S(cpu, size, cpu_mask);
+	if (sched_setaffinity(0, size, cpu_mask) < 0) {
+		CPU_FREE(cpu_mask);		
 		return errno;
+	}
 
+	CPU_FREE(cpu_mask);		
 	return 0;
 }
 
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index fe6cd80..783b208 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -505,10 +505,20 @@ static void get_ncpus(void)
 #ifdef _SC_NPROCESSORS_CONF
 	ncpus = sysconf(_SC_NPROCESSORS_CONF);
 #else
-	long last_cpu;
-	cpu_set_t cpus;
-
-	if (sched_getaffinity(getpid(), sizeof(cpus), &cpus)) {
+	int nrcpus = 4096;
+	cpu_set_t * cpus;
+	
+realloc:
+	cpus = CPU_ALLOC(nrcpus);
+	size = CPU_ALLOC_SIZE(nrcpus);
+	CPU_ZERO_S(size, cpus);
+
+	if (sched_getaffinity(getpid(), size, cpus)) {
+		if( errno = EINVAL && nrcpus < (4096<<4) ) {
+			CPU_FREE(cpus);
+			nrcpus <= 1;
+			goto realloc;
+		}
 		fatal("sched_getaffinity", ERR_SYSCALL, "Can't get CPU info\n");
 		/*NOTREACHED*/
 	}
@@ -518,6 +528,7 @@ static void get_ncpus(void)
 		if (CPU_ISSET( last_cpu, &cpus) ) 
 			ncpus = last_cpu;
 	ncpus++;
+	CPU_FREE(cpus);
 #endif
 	if (ncpus = 0) {
 		fatal(NULL, ERR_SYSCALL, "Insufficient number of CPUs\n");
@@ -531,25 +542,29 @@ static void get_ncpus(void)
  */
 static void pin_to_cpu(struct thr_info *tip)
 {
-	cpu_set_t cpus;
+	cpu_set_t * cpus;
+	size_t size;
+
+	cpus = CPU_ALLOC(ncpus);
+	size = CPU_ALLOC_SIZE(ncpus);	
 
 	assert(0 <= tip->cpu && tip->cpu < ncpus);
 
-	CPU_ZERO(&cpus);
-	CPU_SET(tip->cpu, &cpus);
-	if (sched_setaffinity(getpid(), sizeof(cpus), &cpus)) {
+	CPU_ZERO_S(ncpus, &cpus);
+	CPU_SET_S(tip->cpu, size, &cpus);
+	if (sched_setaffinity(getpid(), size, cpus)) {
 		fatal("sched_setaffinity", ERR_SYSCALL, "Failed to pin CPU\n");
 		/*NOTREACHED*/
 	}
 
 	if (verbose > 1) {
 		int i;
-		cpu_set_t now;
+		cpu_set_t * now = CPU_ALLOC(ncpus);
 
-		(void)sched_getaffinity(getpid(), sizeof(now), &now);
+		(void)sched_getaffinity(getpid(), size, now);
 		fprintf(tip->vfp, "Pinned to CPU %02d ", tip->cpu);
 		for (i = 0; i < ncpus; i++)
-			fprintf(tip->vfp, "%1d", CPU_ISSET(i, &now));
+			fprintf(tip->vfp, "%1d", CPU_ISSET_S(i, size, now));
 		fprintf(tip->vfp, "\n");
 	}
 }
-- 
1.8.1.2

