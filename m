From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 28 Oct 2007 11:49:43 +0000
Subject: [PATCH] blktrace: Make sure BLKTRACETEARDOWN does the full cleanup.
Message-Id: <1193572155-11126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

if blktrace program segfault it will not be able
to call BLKTRACETEARDOWN. Now if we run the blktrace
again that would result in a failure to create the
block/<device> debugfs directory.This will result
in blk_remove_root() to be called which will set
blk_tree_root to NULL. But the  debugfs block dir
still exist because it contain subdirectory.

Now if we try to fix it using BLKTRACETEARDOWN
it won't work because blk_tree_root is NULL.

Fix the same.

Tested as below

root@qemu-image:/home/kvaneesh/blktrace# ./blktrace  -d /dev/hdc
Segmentation fault
root@qemu-image:/home/kvaneesh/blktrace# ./blktrace  -d /dev/hdc
BLKTRACESETUP: No such file or directory
Failed to start trace on /dev/hdc
root@qemu-image:/home/kvaneesh/blktrace# ./blktrace  -k /dev/hdc
root@qemu-image:/home/kvaneesh/blktrace# ./blktrace  -d /dev/hdc

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 block/blktrace.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blktrace.c b/block/blktrace.c
index d00ac39..498a0a5 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -202,6 +202,7 @@ static void blk_remove_tree(struct dentry *dir)
 static struct dentry *blk_create_tree(const char *blk_name)
 {
 	struct dentry *dir = NULL;
+	int created = 0;
 
 	mutex_lock(&blk_tree_mutex);
 
@@ -209,13 +210,17 @@ static struct dentry *blk_create_tree(const char *blk_name)
 		blk_tree_root = debugfs_create_dir("block", NULL);
 		if (!blk_tree_root)
 			goto err;
+		created = 1;
 	}
 
 	dir = debugfs_create_dir(blk_name, blk_tree_root);
 	if (dir)
 		root_users++;
-	else
-		blk_remove_root();
+	else {
+		/* Delete root only if we created it */
+		if (created)
+			blk_remove_root();
+	}
 
 err:
 	mutex_unlock(&blk_tree_mutex);
-- 
1.5.3.4.383.gd90a7-dirty

