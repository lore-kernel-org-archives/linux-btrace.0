From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:30:22 +0000
Subject: [RFC PATCH 39/39] blktrace: add support for zone-mgmt ops
Message-Id: <20200323163022.30688-40-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 3 +++
 kernel/trace/blktrace.c           | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index d82bd470bfb2..6c3b9fe6febf 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -28,6 +28,9 @@ enum blktrace_cat {
 	BLK_TC_WRITE_ZEROES	= 1 << 16,	/* write-zeores */
 	BLK_TC_ZONE_RESET	= 1 << 17,	/* zone-reset */
 	BLK_TC_ZONE_RESET_ALL	= 1 << 18,	/* zone-reset-all */
+	BLK_TC_ZONE_OPEN	= 1 << 19,	/* zone-open */
+	BLK_TC_ZONE_CLOSE	= 1 << 20,	/* zone-close */
+	BLK_TC_ZONE_FINISH	= 1 << 21,	/* zone-finish */
 
 	BLK_TC_END		= 1 << 15,	/* we've run out of bits! */
 	BLK_TC_END_EXT		= 1 << 31,	/* we've run out of bits! */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 77d28fcedfa8..4c94adfaf79d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -529,6 +529,12 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET);
 	if (unlikely(op = REQ_OP_ZONE_RESET_ALL))
 		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET_ALL);
+	if (unlikely(op = REQ_OP_ZONE_OPEN))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_OPEN);
+	if (unlikely(op = REQ_OP_ZONE_CLOSE))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_CLOSE);
+	if (unlikely(op = REQ_OP_ZONE_FINISH))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_FINISH);
 
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
-- 
2.22.0
