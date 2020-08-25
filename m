From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:58 +0000
Subject: [RFC PATCH 28/39] blktrace: add a new formatting routine
Message-Id: <20200825221009.6457-29-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3801809a77d5..49ae01d4e4d6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1813,6 +1813,62 @@ static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
 	rwbs[i] = '\0';
 }
 
+static void fill_rwbs_ext(char *rwbs, const struct blk_io_trace_ext *t)
+{
+	int i = 0;
+	int tc = t->action >> BLK_TC_SHIFT_EXT;
+
+	if ((t->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE_EXT) {
+		rwbs[i++] = 'N';
+		goto out;
+	}
+
+	if (tc & BLK_TC_FLUSH)
+		rwbs[i++] = 'F';
+
+	if (tc & BLK_TC_DISCARD)
+		rwbs[i++] = 'D';
+	else if ((tc & BLK_TC_WRITE_ZEROES)) {
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+	} else if ((tc & BLK_TC_ZONE_RESET)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	} else if ((tc & BLK_TC_ZONE_RESET_ALL)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+	} else if ((tc & BLK_TC_ZONE_APPEND)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+	} else if ((tc & BLK_TC_ZONE_OPEN)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+	} else if ((tc & BLK_TC_ZONE_CLOSE)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+	} else if ((tc & BLK_TC_ZONE_FINISH)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+	} else if (tc & BLK_TC_WRITE)
+		rwbs[i++] = 'W';
+	else if (t->bytes)
+		rwbs[i++] = 'R';
+	else
+		rwbs[i++] = 'N';
+
+	if (tc & BLK_TC_FUA)
+		rwbs[i++] = 'F';
+	if (tc & BLK_TC_AHEAD)
+		rwbs[i++] = 'A';
+	if (tc & BLK_TC_SYNC)
+		rwbs[i++] = 'S';
+	if (tc & BLK_TC_META)
+		rwbs[i++] = 'M';
+out:
+	rwbs[i] = '\0';
+}
+
 static inline
 const struct blk_io_trace *te_blk_io_trace(const struct trace_entry *ent)
 {
@@ -2627,5 +2683,6 @@ void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)
 }
 EXPORT_SYMBOL_GPL(blk_fill_rwbs);
 
+
 #endif /* CONFIG_EVENT_TRACING */
 
-- 
2.22.1
