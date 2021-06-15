From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 15 Jun 2021 11:59:59 +0000
Subject: Recent changes (master)
Message-Id: <20210615120001.737021BC0144@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit dc24c67dfbbd11a3221034557548061e7d2c602f:

  blkparse: Print time when trace was started (2021-04-19 11:55:04 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 366d30b9cdb20345c5d064af850d686da79b89eb:

  blktrace 1.3.0 (2021-06-14 08:55:52 -0600)

----------------------------------------------------------------
Jens Axboe (1):
      blktrace 1.3.0

 blkparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 1d7ae95..f88204a 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -38,7 +38,7 @@
 #include "rbtree.h"
 #include "jhash.h"
 
-static char blkparse_version[] = "1.2.0";
+static char blkparse_version[] = "1.3.0";
 
 struct skip_info {
 	unsigned long start, end;
