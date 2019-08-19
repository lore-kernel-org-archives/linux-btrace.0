From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 19 Aug 2019 04:40:59 +0000
Subject: [RFC PATCH 28/38] blktrace: add a new formatting routine
Message-Id: <20190819044109.3405-29-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c0ebb78e200b..31ab1f4fc32b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1579,6 +1579,46 @@ static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
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
-- 
2.17.0
