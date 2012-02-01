From: Jens Axboe <jaxboe@fusionio.com>
Date: Wed, 01 Feb 2012 05:00:02 +0000
Subject: Recent changes
Message-Id: <20120201050002.CEC32484007@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 0abccbcb5d1a538028ffcb3869d646d29bf5812b:

  blktrace 1.0.3 (2011-08-11 12:49:08 +0200)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Jens Axboe (2):
      Merge branch 'master' of ssh://brick.kernel.dk/data/git/blktrace
      blktrace 1.0.4

Mikulas Patocka (1):
      Fix for realloc bug and wrong error logging

 blkparse.c |    2 +-
 blktrace.c |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 169d491..0f8d135 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -36,7 +36,7 @@
 #include "rbtree.h"
 #include "jhash.h"
 
-static char blkparse_version[] = "1.0.3";
+static char blkparse_version[] = "1.0.4";
 
 struct skip_info {
 	unsigned long start, end;
diff --git a/blktrace.c b/blktrace.c
index 72866e2..b14daf2 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1330,7 +1330,7 @@ static struct trace_buf *tb_combine(struct trace_buf *prev,
 		 * the whole structures, as the other fields
 		 * are "static".
 		 */
-		prev = realloc(prev->buf, sizeof(*prev) + tot_len);
+		prev = realloc(prev, sizeof(*prev) + tot_len);
 		prev->buf = (void *)(prev + 1);
 	}
 
@@ -2155,12 +2155,17 @@ static int handle_args(int argc, char *argv[])
 		return 1;
 	}
 
-	if (statfs(debugfs_path, &st) < 0 || st.f_type != (long)DEBUGFS_TYPE) {
+	if (statfs(debugfs_path, &st) < 0) {
 		fprintf(stderr, "Invalid debug path %s: %d/%s\n",
 			debugfs_path, errno, strerror(errno));
 		return 1;
 	}
 
+	if (st.f_type != (long)DEBUGFS_TYPE) {
+		fprintf(stderr, "Debugfs is not mounted at %s\n", debugfs_path);
+		return 1;
+	}
+
 	if (act_mask_tmp != 0)
 		act_mask = act_mask_tmp;
 
