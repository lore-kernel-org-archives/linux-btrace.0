From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 03 May 2018 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20180503120002.4C9322C00EF@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 93d9e5b5082258f3570dbc56202276284575fc11:

  blkparse: add documetation for 'R' requeue request (2018-04-09 08:36:43 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to d61ff409cb4dda31386373d706ea0cfb1aaac5b7:

  btt: make device/devno use PATH_MAX to avoid overflow (2018-05-02 10:24:17 -0600)

----------------------------------------------------------------
Jens Axboe (1):
      btt: make device/devno use PATH_MAX to avoid overflow

 btt/devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/btt/devmap.c b/btt/devmap.c
index 0553a9e..5fc1cb2 100644
--- a/btt/devmap.c
+++ b/btt/devmap.c
@@ -23,7 +23,7 @@
 
 struct devmap {
 	struct list_head head;
-	char device[32], devno[32];
+	char device[PATH_MAX], devno[PATH_MAX];
 };
 
 LIST_HEAD(all_devmaps);
