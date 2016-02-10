From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 10 Feb 2016 13:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20160210130002.548032C2158@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 8a1209713563b4dedea962909c18b941fb09d01a:

  Add the "-a discard" filter option to the blktrace.8 man page (2016-01-08 11:46:03 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 80c4041b2e7a7d5afb75df563bf51bb27773c095:

  blktrace: Use number of online CPUs (2016-02-09 08:17:50 -0700)

----------------------------------------------------------------
Abutalib Aghayev (1):
      blktrace: Use number of online CPUs

 blktrace.c          | 4 ++--
 btreplay/btreplay.c | 4 ++--
 verify_blkparse.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

---

Diff of recent changes:

diff --git a/blktrace.c b/blktrace.c
index 3c8fb4c..b445524 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2663,9 +2663,9 @@ int main(int argc, char *argv[])
 
 	setlocale(LC_NUMERIC, "en_US");
 	pagesize = getpagesize();
-	ncpus = sysconf(_SC_NPROCESSORS_CONF);
+	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
 	if (ncpus < 0) {
-		fprintf(stderr, "sysconf(_SC_NPROCESSORS_CONF) failed %d/%s\n",
+		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed %d/%s\n",
 			errno, strerror(errno));
 		ret = 1;
 		goto out;
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 2a1e1cc..6d19564 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -502,8 +502,8 @@ static inline void start_iter(void)
  */
 static void get_ncpus(void)
 {
-#ifdef _SC_NPROCESSORS_CONF
-	ncpus = sysconf(_SC_NPROCESSORS_CONF);
+#ifdef _SC_NPROCESSORS_ONLN
+	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
 #else
 	int nrcpus = 4096;
 	cpu_set_t * cpus;
diff --git a/verify_blkparse.c b/verify_blkparse.c
index 5689f43..3f3e92a 100644
--- a/verify_blkparse.c
+++ b/verify_blkparse.c
@@ -16,8 +16,8 @@ int main(int argc, char *argv[])
 	unsigned int seq;
 	FILE *f;
 
-#ifdef _SC_NPROCESSORS_CONF
-	MAX_CPUS = sysconf(_SC_NPROCESSORS_CONF);
+#ifdef _SC_NPROCESSORS_ONLN
+	MAX_CPUS = sysconf(_SC_NPROCESSORS_ONLN);
 	if (MAX_CPUS < 1)
 	{
 		fprintf(stderr, "Could not determine number of CPUs online:\n%s\n", 
