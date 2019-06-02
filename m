From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:16 +0000
Subject: [RFC PATCH 07/46] blktrace: add act and prio check helpers
Message-Id: <20190602165055.14424-8-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e6b0a914cb85..0ed4ce410ed8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -310,6 +310,43 @@ static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 	return 0;
 }
 
+static inline bool prio_log_check(struct blk_trace_ext *bt, u32 ioprio)
+{
+	bool ret;
+
+	switch (IOPRIO_PRIO_CLASS(ioprio)) {
+	case IOPRIO_CLASS_NONE:
+		ret = (bt->prio_mask & 0x01) ? true : false;
+		break;
+	case IOPRIO_CLASS_RT:
+		ret = (bt->prio_mask & 0x02) ? true : false;
+		break;
+	case IOPRIO_CLASS_BE:
+		ret = (bt->prio_mask & 0x04) ? true : false;
+		break;
+	case IOPRIO_CLASS_IDLE:
+		ret = (bt->prio_mask & 0x08) ? true : false;
+		break;
+	default:
+		/*XXX: print rate limit warn here */
+		ret = false;
+	}
+	return ret;
+}
+
+static inline int act_log_check_ext(struct blk_trace_ext *bt, u64 what,
+			     sector_t sector, pid_t pid)
+{
+	if (((bt->act_mask << BLK_TC_SHIFT_EXT) & what) = 0)
+		return 1;
+	if (sector && (sector < bt->start_lba || sector > bt->end_lba))
+		return 1;
+	if (bt->pid && pid != bt->pid)
+		return 1;
+
+	return 0;
+}
+
 /*
  * Data direction bit lookup
  */
-- 
2.19.1
