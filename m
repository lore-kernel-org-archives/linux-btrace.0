From: Tao Ma <tm@tao.ma>
Date: Tue, 11 Jan 2011 06:48:06 +0000
Subject: [PATCH] blkparse: Fix blktrace output pipe broken in the new kernel.
Message-Id: <1294728486-5608-1-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Tao Ma <boyu.mt@taobao.com>

With the newest kernel(say 2.6.37, some older one should also have the
similar problem), some cfq messages are added to blktrace, so it makes
the old blkparse broken.

See a simple example:
1. blktrace /dev/sdb -o -|blkparse -i -
2. Run the following command(/dev/sdb1 is mounted at /mnt/test_dir):
dd if=/mnt/test_dir/test of=/dev/null bs=4k count=1 iflag=direct

There are only 2 lines of output there:
  8,16   0        1     0.000000000 13183  A   R 114759 + 8 <- (8,17) 114696
  8,16   0        2     0.000000491 13183  Q   R 114759 + 8 [dd]

And even we run a command line like:
for((i=0;i<100;i++))do dd if=/mnt/ocfs2/test of=/dev/null bs=4k count=1 iflag=direct;done
We are only given the same 2 lines of output.

While the really one should look like:
  8,16   0        1     0.000000000 13319  A   R 114759 + 8 <- (8,17) 114696
  8,16   0        2     0.000000376 13319  Q   R 114759 + 8 [dd]
  8,16   0        0     0.000005931     0  m   N cfq13319 alloced
  8,16   0        3     0.000006259 13319  G   R 114759 + 8 [dd]
  8,16   0        4     0.000007143 13319  P   N [dd]
  8,16   0        5     0.000007817 13319  I   R 114759 + 8 [dd]
  8,16   0        0     0.000008491     0  m   N cfq13319 insert_request
  8,16   0        0     0.000009029     0  m   N cfq13319 add_to_rr
...

The main reason is that in show_entries_rb, we test sequences every time,
but actually with some messages like cfq, the sequence number is always
0 which makes the old sequence check refuses all the logs after it.
So only check/store sequence number if it isn't a message.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 blkparse.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index da34c14..c911185 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2065,7 +2065,8 @@ static void show_entries_rb(int force)
 			break;
 		}
 
-		if (check_sequence(pdi, t, force))
+		if (!(bit->action = BLK_TN_MESSAGE) &&
+		    check_sequence(pdi, t, force))
 			break;
 
 		if (!force && bit->time > last_allowed_time)
@@ -2076,7 +2077,8 @@ static void show_entries_rb(int force)
 		if (!pci || pci->cpu != bit->cpu)
 			pci = get_cpu_info(pdi, bit->cpu);
 
-		pci->last_sequence = bit->sequence;
+		if (!(bit->action = BLK_TN_MESSAGE))
+			pci->last_sequence = bit->sequence;
 
 		pci->nelems++;
 
-- 
1.6.3.GIT
