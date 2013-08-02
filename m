From: Jens Axboe <jaxboe@fusionio.com>
Date: Fri, 02 Aug 2013 04:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20130802040002.167ED20ADA@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit cd0ae0f6bc3d72e89d0b258aa2040437b75d4ef2:

  More accurate calculation of the total read/write values (2013-03-19 08:16:27 -0600)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Nathan Zimmer (5):
      verify_blkparse: Change max_cpus to deal with systems larger the 512
      btreplay: Machines are now large enough that holes need to be dealt with
      btreplay: use sysconf to get the number of configured cpus
      blktrace: use number of configured cpus instead of online cpus
      blktrace blkreplay: convert to use a dynamic cpu_set_t

 blktrace.c          |   20 +++++++++++++-------
 btreplay/btreplay.c |   51 +++++++++++++++++++++++++++++++++++----------------
 verify_blkparse.c   |   23 +++++++++++++++++++----
 3 files changed, 67 insertions(+), 27 deletions(-)

---

Diff of recent changes:

diff --git a/blktrace.c b/blktrace.c
index 89aaaac..7e64c94 100644
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
 
@@ -2656,9 +2662,9 @@ int main(int argc, char *argv[])
 
 	setlocale(LC_NUMERIC, "en_US");
 	pagesize = getpagesize();
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	ncpus = sysconf(_SC_NPROCESSORS_CONF);
 	if (ncpus < 0) {
-		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed %d/%s\n",
+		fprintf(stderr, "sysconf(_SC_NPROCESSORS_CONF) failed %d/%s\n",
 			errno, strerror(errno));
 		ret = 1;
 		goto out;
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 20494e0..5444010 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -502,19 +502,34 @@ static inline void start_iter(void)
  */
 static void get_ncpus(void)
 {
-	cpu_set_t cpus;
-
-	if (sched_getaffinity(getpid(), sizeof(cpus), &cpus)) {
+#ifdef _SC_NPROCESSORS_CONF
+	ncpus = sysconf(_SC_NPROCESSORS_CONF);
+#else
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
 
-	/*
-	 * XXX This assumes (perhaps wrongly) that there are no /holes/ 
-	 * XXX in the mask.
-	 */
-	for (ncpus = 0; ncpus < CPU_SETSIZE && CPU_ISSET(ncpus, &cpus); ncpus++)
-		;
+	ncpus = -1;
+	for (last_cpu = 0; last_cpu < CPU_SETSIZE && CPU_ISSET(last_cpu, &cpus); last_cpu++)
+		if (CPU_ISSET( last_cpu, &cpus) ) 
+			ncpus = last_cpu;
+	ncpus++;
+	CPU_FREE(cpus);
+#endif
 	if (ncpus = 0) {
 		fatal(NULL, ERR_SYSCALL, "Insufficient number of CPUs\n");
 		/*NOTREACHED*/
@@ -527,25 +542,29 @@ static void get_ncpus(void)
  */
 static void pin_to_cpu(struct thr_info *tip)
 {
-	cpu_set_t cpus;
+	cpu_set_t *cpus;
+	size_t size;
+
+	cpus = CPU_ALLOC(ncpus);
+	size = CPU_ALLOC_SIZE(ncpus);	
 
 	assert(0 <= tip->cpu && tip->cpu < ncpus);
 
-	CPU_ZERO(&cpus);
-	CPU_SET(tip->cpu, &cpus);
-	if (sched_setaffinity(getpid(), sizeof(cpus), &cpus)) {
+	CPU_ZERO_S(ncpus, cpus);
+	CPU_SET_S(tip->cpu, size, cpus);
+	if (sched_setaffinity(getpid(), size, cpus)) {
 		fatal("sched_setaffinity", ERR_SYSCALL, "Failed to pin CPU\n");
 		/*NOTREACHED*/
 	}
 
 	if (verbose > 1) {
 		int i;
-		cpu_set_t now;
+		cpu_set_t *now = CPU_ALLOC(ncpus);
 
-		(void)sched_getaffinity(getpid(), sizeof(now), &now);
+		(void)sched_getaffinity(getpid(), size, now);
 		fprintf(tip->vfp, "Pinned to CPU %02d ", tip->cpu);
 		for (i = 0; i < ncpus; i++)
-			fprintf(tip->vfp, "%1d", CPU_ISSET(i, &now));
+			fprintf(tip->vfp, "%1d", CPU_ISSET_S(i, size, now));
 		fprintf(tip->vfp, "\n");
 	}
 }
diff --git a/verify_blkparse.c b/verify_blkparse.c
index aae8d7c..5689f43 100644
--- a/verify_blkparse.c
+++ b/verify_blkparse.c
@@ -3,18 +3,33 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
-
-#define MAX_CPUS	(512)
+#include <errno.h>
 
 int main(int argc, char *argv[])
 {
 	double this_time, last_time;
 	char line[256], last_line[256], *p;
 	int major, minor, cpu, nr, alias;
+	long  MAX_CPUS;
 	unsigned long long total_entries;
-	unsigned int last_seq[MAX_CPUS], seq;
+	unsigned int *last_seq;
+	unsigned int seq;
 	FILE *f;
 
+#ifdef _SC_NPROCESSORS_CONF
+	MAX_CPUS = sysconf(_SC_NPROCESSORS_CONF);
+	if (MAX_CPUS < 1)
+	{
+		fprintf(stderr, "Could not determine number of CPUs online:\n%s\n", 
+			strerror (errno));
+		fprintf(stderr, "Assuming 1024\n");
+		MAX_CPUS = 1024;
+  	}
+#else
+	MAX_CPUS = CPU_SETSIZE;
+#endif 
+	
+	last_seq = malloc( sizeof(unsigned int) * MAX_CPUS );
 	for (nr = 0; nr < MAX_CPUS; nr++)
 		last_seq[nr] = -1;
 
@@ -33,7 +48,7 @@ int main(int argc, char *argv[])
 	alias = nr = 0;
 	total_entries = 0;
 	while ((p = fgets(line, sizeof(line), f)) != NULL) {
-		if (sscanf(p, "%3d,%3d %2d %8d %lf", &major, &minor, &cpu, &seq, &this_time) != 5)
+		if (sscanf(p, "%3d,%3d %5d %8d %lf", &major, &minor, &cpu, &seq, &this_time) != 5)
 			break;
 
 		if (this_time < last_time) {
