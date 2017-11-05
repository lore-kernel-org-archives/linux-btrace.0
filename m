From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 05 Nov 2017 13:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20171105130001.6F6C22C02AF@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 8772bc4fb049bdd879de5952d6f291a34112fae0:

  blktrace: Create empty output files for non-existent cpus (2017-01-26 10:06:05 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to cca113f2fe0759b91fd6a0e10fdcda2c28f18a7e:

  Blktrace 1.2.0 (2017-11-04 22:13:06 -0600)

----------------------------------------------------------------
Jens Axboe (2):
      blktrace: abort if device ioctl setup fails
      Blktrace 1.2.0

 blkparse.c |  2 +-
 blktrace.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index ab5edc2..227cc44 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -36,7 +36,7 @@
 #include "rbtree.h"
 #include "jhash.h"
 
-static char blkparse_version[] = "1.1.0";
+static char blkparse_version[] = "1.2.0";
 
 struct skip_info {
 	unsigned long start, end;
diff --git a/blktrace.c b/blktrace.c
index e8f2f87..e048f68 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1066,9 +1066,10 @@ static void close_client_connections(void)
 	}
 }
 
-static void setup_buts(void)
+static int setup_buts(void)
 {
 	struct list_head *p;
+	int ret = 0;
 
 	__list_for_each(p, &devpaths) {
 		struct blk_user_trace_setup buts;
@@ -1086,10 +1087,14 @@ static void setup_buts(void)
 				free(dpp->stats);
 			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
 			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
-		} else
+		} else {
 			fprintf(stderr, "BLKTRACESETUP(2) %s failed: %d/%s\n",
 				dpp->path, errno, strerror(errno));
+			ret++;
+		}
 	}
+
+	return ret;
 }
 
 static void start_buts(void)
@@ -2676,7 +2681,8 @@ static int run_tracers(void)
 	if (net_mode = Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	setup_buts();
+	if (setup_buts())
+		return 1;
 
 	if (use_tracer_devpaths()) {
 		if (setup_tracer_devpaths())
