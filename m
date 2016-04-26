From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 26 Apr 2016 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20160426120002.91AEA2C18E7@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 80c4041b2e7a7d5afb75df563bf51bb27773c095:

  blktrace: Use number of online CPUs (2016-02-09 08:17:50 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to cbd4bc0a3f6386cd000cb842b9f1f6325e301623:

  btreplay: remove timestamps (2016-04-25 08:54:34 -0600)

----------------------------------------------------------------
Olaf Hering (1):
      btreplay: remove timestamps

Roman Pen (3):
      btreplay: fix memory corruption caused by CPU_ZERO_S
      btreplay: fix sched_{set|get}affinity
      btreplay: make Ctrl-C work

 btreplay/btrecord.c |  3 ---
 btreplay/btreplay.c | 15 ++++++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

---

Diff of recent changes:

diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index 3646257..a07ca07 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -18,8 +18,6 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-static char build_date[] = __DATE__ " at "__TIME__;
-
 #include <assert.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -449,7 +447,6 @@ void handle_args(int argc, char *argv[])
 		case 'V':
 			fprintf(stderr, "btrecord -- version %s\n", 
 				my_btversion);
-			fprintf(stderr, "            Built on %s\n", build_date);
 			exit(0);
 			/*NOTREACHED*/
 
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 6d19564..edaf81f 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -18,8 +18,6 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-static char build_date[] = __DATE__ " at "__TIME__;
-
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -275,7 +273,7 @@ static inline int is_send_done(struct thr_info *tip)
  */
 static inline int is_reap_done(struct thr_info *tip)
 {
-	return tip->send_done && tip->naios_out = 0;
+	return signal_done || (tip->send_done && tip->naios_out = 0);
 }
 
 /**
@@ -513,7 +511,7 @@ realloc:
 	size = CPU_ALLOC_SIZE(nrcpus);
 	CPU_ZERO_S(size, cpus);
 
-	if (sched_getaffinity(getpid(), size, cpus)) {
+	if (sched_getaffinity(0, size, cpus)) {
 		if( errno = EINVAL && nrcpus < (4096<<4) ) {
 			CPU_FREE(cpus);
 			nrcpus <<= 1;
@@ -550,18 +548,19 @@ static void pin_to_cpu(struct thr_info *tip)
 
 	assert(0 <= tip->cpu && tip->cpu < ncpus);
 
-	CPU_ZERO_S(ncpus, cpus);
+	CPU_ZERO_S(size, cpus);
 	CPU_SET_S(tip->cpu, size, cpus);
-	if (sched_setaffinity(getpid(), size, cpus)) {
+	if (sched_setaffinity(0, size, cpus)) {
 		fatal("sched_setaffinity", ERR_SYSCALL, "Failed to pin CPU\n");
 		/*NOTREACHED*/
 	}
+	assert(tip->cpu = sched_getcpu());
 
 	if (verbose > 1) {
 		int i;
 		cpu_set_t *now = CPU_ALLOC(ncpus);
 
-		(void)sched_getaffinity(getpid(), size, now);
+		(void)sched_getaffinity(0, size, now);
 		fprintf(tip->vfp, "Pinned to CPU %02d ", tip->cpu);
 		for (i = 0; i < ncpus; i++)
 			fprintf(tip->vfp, "%1d", CPU_ISSET_S(i, size, now));
@@ -1558,8 +1557,6 @@ static void handle_args(int argc, char *argv[])
 		case 'V':
 			fprintf(stderr, "btreplay -- version %s\n", 
 				my_btversion);
-			fprintf(stderr, "            Built on %s\n", 
-				build_date);
 			exit(0);
 			/*NOTREACHED*/
 
