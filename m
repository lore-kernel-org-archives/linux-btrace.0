From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 19 Aug 2019 04:41:05 +0000
Subject: [RFC PATCH 34/38] blktrace: add trace print helpers
Message-Id: <20190819044109.3405-35-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5712321d4a53..05498ddb26c4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2280,6 +2280,15 @@ blk_trace_event_print_binary(struct trace_iterator *iter, int flags,
 	return trace_handle_return(&iter->seq);
 }
 
+static enum print_line_t
+blk_trace_event_print_binary_ext(struct trace_iterator *iter, int flags,
+			     struct trace_event *event)
+{
+	blk_trace_synthesize_old_trace_ext(iter);
+
+	return trace_handle_return(&iter->seq);
+}
+
 static enum print_line_t blk_tracer_print_line(struct trace_iterator *iter)
 {
 	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CLASSIC))
@@ -2288,6 +2297,14 @@ static enum print_line_t blk_tracer_print_line(struct trace_iterator *iter)
 	return print_one_line(iter, true);
 }
 
+static enum print_line_t blk_tracer_print_line_ext(struct trace_iterator *iter)
+{
+	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CLASSIC))
+		return TRACE_TYPE_UNHANDLED;
+
+	return print_one_line_ext(iter, true);
+}
+
 static int
 blk_tracer_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-- 
2.17.0
