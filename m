From: Stefan Raspl <raspl@linux.vnet.ibm.com>
Date: Tue, 19 May 2009 07:59:08 +0000
Subject: [Patch updated] blktrace: remove debugfs entries on bad path
Message-Id: <4A1266CC.5040801@linux.vnet.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@redhat.com, Li Zefan <lizf@cn.fujitsu.com>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-btrace@vger.kernel.org, linux-kernel@vger.kernel.org

debugfs directory entries for devices are not removed on some
of the failure pathes in do_blk_trace_setup().
One way to reproduce is to start blktrace on multiple devices
with insufficient Vmalloc space: Devices will fail with
a message like this:

	BLKTRACESETUP(2) /dev/sdu failed: 5/Input/output error

If so, the respective entries in debugfs
(e.g. /sys/kernel/debug/block/sdu) will remain and subsequent
attempts to start blktrace on the respective devices will not
succeed due to existing directories.



Acked-by: Li Zefan <lizf@cn.fujitsu.com>
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
