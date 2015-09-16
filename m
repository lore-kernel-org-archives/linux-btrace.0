From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 16 Sep 2015 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20150916120001.D14872C225F@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 2564a6029e55d6a0507ebb28a5a01f5dffb0bd56:

  btreplay: Fix typo in scaling up the dynamic cpu set size. (2015-08-20 08:58:08 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to dd093eb1c48e0d86b835758b96a9886fb7773aa4:

  Fix warnings on newer gcc (2015-09-15 08:48:06 -0600)

----------------------------------------------------------------
Jens Axboe (1):
      Fix warnings on newer gcc

Khem Raj (1):
      include sys/types.h for dev_t definition

 blkiomon.c          | 2 +-
 blktrace.h          | 1 +
 btreplay/btreplay.c | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/blkiomon.c b/blkiomon.c
index a895f65..f8b0c9d 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -198,7 +198,7 @@ static struct dstat *blkiomon_find_dstat(struct rb_search *search, __u32 device)
 static struct dstat *blkiomon_get_dstat(__u32 device)
 {
 	struct dstat *dstat;
-	struct rb_search search;
+	struct rb_search search = { 0, };
 
 	pthread_mutex_lock(&dstat_mutex);
 
diff --git a/blktrace.h b/blktrace.h
index 380aec7..944fc08 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -5,6 +5,7 @@
 #include <limits.h>
 #include <byteswap.h>
 #include <endian.h>
+#include <sys/types.h>
 
 #include "blktrace_api.h"
 #include "rbtree.h"
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index f762279..2a1e1cc 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -646,7 +646,7 @@ static void find_input_devs(char *idir)
 static void read_map_devs(char *file_name)
 {
 	FILE *fp;
-	char *from_dev, *to_dev;
+	char from_dev[256], to_dev[256];
 
 	fp = fopen(file_name, "r");
 	if (!fp) {
@@ -654,7 +654,7 @@ static void read_map_devs(char *file_name)
 		/*NOTREACHED*/
 	}
 
-	while (fscanf(fp, "%as %as", &from_dev, &to_dev) = 2) {
+	while (fscanf(fp, "%s %s", from_dev, to_dev) = 2) {
 		struct map_dev *mdp = malloc(sizeof(*mdp));
 
 		mdp->from_dev = from_dev;
