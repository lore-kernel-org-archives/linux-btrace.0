From: Stefan Raspl <raspl@linux.vnet.ibm.com>
Date: Mon, 18 May 2009 12:59:17 +0000
Subject: [Patch] Remove debugfs entries on bad path
Message-Id: <4A115BA5.6090905@linux.vnet.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

debugfs directory entries for devices are not removed on bad path.
If so, subsequent attempts to start blktrace on the respective
devices will not succeed due to existing directories.

Signed-off-by: Stefan Raspl <stefan.raspl@linux.vnet.ibm.com>

---
 kernel/trace/blktrace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -262,6 +262,7 @@ static void blk_trace_free(struct blk_tr
 {
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
+	debugfs_remove(bt->dir);
 	relay_close(bt->rchan);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);

