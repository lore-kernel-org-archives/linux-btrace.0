From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:42 +0000
Subject: [RFC PATCH 33/46] blktrace: add trace_synthesize helper
Message-Id: <20190602165055.14424-34-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 71fc15ded5c6..cd6110bb5fcd 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2260,6 +2260,21 @@ static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 			 sizeof(old) - offset + t->pdu_len);
 }
 
+static void blk_trace_synthesize_old_trace_ext(struct trace_iterator *iter)
+{
+	struct trace_seq *s = &iter->seq;
+	struct blk_io_trace_ext *t = (struct blk_io_trace_ext *)iter->ent;
+	const int offset = offsetof(struct blk_io_trace_ext, sector);
+	struct blk_io_trace_ext old = {
+		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT,
+		.time     = iter->ts,
+	};
+
+	trace_seq_putmem(s, &old, offset);
+	trace_seq_putmem(s, &t->sector,
+			 sizeof(old) - offset + t->pdu_len);
+}
+
 static enum print_line_t
 blk_trace_event_print_binary(struct trace_iterator *iter, int flags,
 			     struct trace_event *event)
-- 
2.19.1
