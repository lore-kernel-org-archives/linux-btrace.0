From: Tao Ma <tm@tao.ma>
Date: Wed, 25 May 2011 15:49:12 +0000
Subject: [PATCH v2] blkparse: Avoid segfault for wrong cpu number.
Message-Id: <1306338552-11529-1-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Tao Ma <boyu.mt@taobao.com>

Currently we only check the magic number to see whether
a blktrace is valid or not, but Bill Broadley did meet
with a case that the cpu info is wrong with a number
of 1725552676. So in resize_cpu_info, we meet with a
overflow when calculating
size = new_count * sizeof(struct per_cpu_info);
And the program will be either segfault or has the error
of out of memory. Although this is more likely a kernel
problem, the blkparse shoudn't segfault for it.

So this patch just check whether the cpu stored in the
trace is the same as the file, if not, just warn it out
and skip it.

Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Bill Broadley <bill@broadley.org>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 blkparse.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 7ee9f9d..817cb31 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2354,6 +2354,12 @@ static int ms_prime(struct ms_stream *msp)
 		if (verify_trace(bit))
 			goto err;
 
+		if (bit->cpu != pci->cpu) {
+			fprintf(stderr, "cpu %d trace info has error cpu %d\n",
+				pci->cpu, bit->cpu);
+			continue;
+		}
+
 		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-- 
1.7.1

