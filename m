From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:10:01 +0000
Subject: [RFC PATCH 31/39] blktrace: add trace event print helper
Message-Id: <20200825221009.6457-32-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index cbaf4e816959..6bd158d5454b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2447,12 +2447,51 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 	return trace_handle_return(s);
 }
 
+static enum print_line_t print_one_line_ext(struct trace_iterator *iter,
+					bool classic)
+{
+	struct trace_array *tr = iter->tr;
+	struct trace_seq *s = &iter->seq;
+	const struct blk_io_trace_ext *t;
+	u32 what;
+	bool long_act;
+	blk_log_action_t *log_action;
+	bool has_cg;
+
+	t	   = te_blk_io_trace_ext(iter->ent);
+	what	   = (t->action & ((1ULL << BLK_TC_SHIFT_EXT) - 1)) & ~__BLK_TA_CGROUP;
+	long_act   = !!(tr->trace_flags & TRACE_ITER_VERBOSE);
+	log_action = classic ? &blk_log_action_classic_ext : &blk_log_action_ext;
+	has_cg	   = t->action & __BLK_TA_CGROUP;
+
+	if ((t->action & ~__BLK_TN_CGROUP) = BLK_TN_MESSAGE_EXT) {
+		log_action(iter, long_act ? "message" : "m", has_cg);
+		blk_log_msg_ext(s, iter->ent, has_cg);
+		return trace_handle_return(s);
+	}
+
+	if (unlikely(what = 0 || what >= ARRAY_SIZE(what2act_ext)))
+		trace_seq_printf(s, "Unknown action %x\n", what);
+	else {
+		log_action(iter, what2act_ext[what].act[long_act], has_cg);
+		what2act_ext[what].print(s, iter->ent, has_cg);
+	}
+
+	return trace_handle_return(s);
+}
+
 static enum print_line_t blk_trace_event_print(struct trace_iterator *iter,
 					       int flags, struct trace_event *event)
 {
 	return print_one_line(iter, false);
 }
 
+static enum print_line_t blk_trace_event_print_ext(struct trace_iterator *iter,
+					       int flags, struct trace_event *event)
+{
+	return print_one_line_ext(iter, false);
+}
+
 static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
-- 
2.22.1
