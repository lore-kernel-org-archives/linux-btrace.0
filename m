From: Jens Axboe <jaxboe@fusionio.com>
Date: Tue, 28 Feb 2012 05:00:03 +0000
Subject: Recent changes
Message-Id: <20120228050003.7E1D6484005@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit f6d38abde41a7b18808dcdab393f05d6300d16c3:

  Fix compiler warnings (2012-02-01 13:17:57 +0100)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Jens Axboe (1):
      blktrace 1.0.5

Vasily Tarasov (1):
      Too small arrays for file names

 blkparse.c |    4 ++--
 blktrace.h |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index b0b88c3..a7ff0f7 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -36,7 +36,7 @@
 #include "rbtree.h"
 #include "jhash.h"
 
-static char blkparse_version[] = "1.0.4";
+static char blkparse_version[] = "1.0.5";
 
 struct skip_info {
 	unsigned long start, end;
@@ -2839,7 +2839,7 @@ int main(int argc, char *argv[])
 			ofp = fdopen(STDOUT_FILENO, "w");
 			mode = _IOLBF;
 		} else {
-			char ofname[128];
+			char ofname[PATH_MAX];
 
 			snprintf(ofname, sizeof(ofname) - 1, "%s", output_name);
 			ofp = fopen(ofname, "w");
diff --git a/blktrace.h b/blktrace.h
index 8b3e031..5da6dbc 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -2,6 +2,7 @@
 #define BLKTRACE_H
 
 #include <stdio.h>
+#include <limits.h>
 #include <byteswap.h>
 #include <endian.h>
 
@@ -44,7 +45,7 @@ struct per_cpu_info {
 
 	int fd;
 	int fdblock;
-	char fname[128];
+	char fname[PATH_MAX];
 
 	struct io_stats io_stats;
 
