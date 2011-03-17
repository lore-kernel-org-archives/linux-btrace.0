From: Jens Axboe <jaxboe@fusionio.com>
Date: Thu, 17 Mar 2011 05:00:04 +0000
Subject: Recent changes
Message-Id: <20110317050004.6DFBF37A324@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 8fe5cc8d646d2fccbf82d0021d3c323ef6738a28:

  gitignore: add blkiomon to .gitignore. (2011-02-09 10:22:39 +0100)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Jens Axboe (1):
      blktrace 1.0.2

Justin TerAvest (1):
      blktrace: Document default values for -b and -n

 blkparse.c |    2 +-
 blktrace.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index c911185..7ee9f9d 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -36,7 +36,7 @@
 #include "rbtree.h"
 #include "jhash.h"
 
-static char blkparse_version[] = "1.0.1";
+static char blkparse_version[] = "1.0.2";
 
 struct skip_info {
 	unsigned long start, end;
diff --git a/blktrace.c b/blktrace.c
index 18c5157..72866e2 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -460,8 +460,8 @@ static char usage_str[] = "\n\n" \
 	"\t-w Stop after defined time, in seconds\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
-	"\t-b Sub buffer size in KiB\n" \
-	"\t-n Number of sub buffers\n" \
+	"\t-b Sub buffer size in KiB (default 512)\n" \
+	"\t-n Number of sub buffers (default 4)\n" \
 	"\t-l Run in network listen mode (blktrace server)\n" \
 	"\t-h Run in network client mode, connecting to the given host\n" \
 	"\t-p Network port to use (default 8462)\n" \
