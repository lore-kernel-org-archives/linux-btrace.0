From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:25:03 +0000
Subject: [RFC PATCH 33/39] blktrace: add trace_synthesize helper
Message-Id: <20191120042509.12835-34-chaitanya.kulkarni@wdc.com>
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
index 747fd8caf10f..5712321d4a53 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2256,6 +2256,21 @@ static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
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
2.22.1
