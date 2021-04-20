From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 20 Apr 2021 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20210420120001.6F5E51BC0159@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 2ec0bb0b725305025dcc3e3f195894040e2dab90:

  blktrace: inclusive terminology (2021-02-19 09:42:41 -0700)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to dc24c67dfbbd11a3221034557548061e7d2c602f:

  blkparse: Print time when trace was started (2021-04-19 11:55:04 -0600)

----------------------------------------------------------------
Jan Kara (1):
      blkparse: Print time when trace was started

 blkparse.c | 2 ++
 1 file changed, 2 insertions(+)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 33dd023..1d7ae95 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -32,6 +32,7 @@
 #include <signal.h>
 #include <locale.h>
 #include <libgen.h>
+#include <time.h>
 
 #include "blktrace.h"
 #include "rbtree.h"
@@ -2888,6 +2889,7 @@ static void show_stats(void)
 
 	if (per_device_and_cpu_stats)
 		show_device_and_cpu_stats();
+	fprintf(ofp, "Trace started at %s\n", ctime(&abs_start_time.tv_sec));
 
 	fflush(ofp);
 }
