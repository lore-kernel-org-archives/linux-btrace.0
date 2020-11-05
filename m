From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Thu, 05 Nov 2020 02:40:33 +0000
Subject: [RFC PATCH 34/39] blktrace: add blkext tracer
Message-Id: <20201105024038.5831-35-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 47 ++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.h    |  1 +
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index b5e925952a0d..35182090bd6c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2581,18 +2581,42 @@ static struct tracer blk_tracer __read_mostly = {
 	.set_flag	= blk_tracer_set_flag,
 };
 
+static struct tracer blk_tracer_ext __read_mostly = {
+	.name		= "blkext",
+	.init		= blk_tracer_init,
+	.reset		= blk_tracer_reset,
+	.start		= blk_tracer_start,
+	.stop		= blk_tracer_stop,
+	.print_header	= blk_tracer_print_header,
+	.print_line	= blk_tracer_print_line_ext,
+	.flags		= &blk_tracer_flags,
+	.set_flag	= blk_tracer_set_flag,
+};
+
 static struct trace_event_functions trace_blk_event_funcs = {
 	.trace		= blk_trace_event_print,
 	.binary		= blk_trace_event_print_binary,
 };
 
+static struct trace_event_functions trace_blk_event_funcs_ext = {
+	.trace		= blk_trace_event_print_ext,
+	.binary		= blk_trace_event_print_binary_ext,
+};
+
 static struct trace_event trace_blk_event = {
 	.type		= TRACE_BLK,
 	.funcs		= &trace_blk_event_funcs,
 };
 
+static struct trace_event trace_blk_event_ext = {
+	.type		= TRACE_BLK_EXT,
+	.funcs		= &trace_blk_event_funcs_ext,
+};
+
 static int __init init_blk_tracer(void)
 {
+	int ret = 0;
+
 	if (!register_trace_event(&trace_blk_event)) {
 		pr_warn("Warning: could not register block events\n");
 		return 1;
@@ -2600,11 +2624,28 @@ static int __init init_blk_tracer(void)
 
 	if (register_tracer(&blk_tracer) != 0) {
 		pr_warn("Warning: could not register the block tracer\n");
-		unregister_trace_event(&trace_blk_event);
-		return 1;
+		goto unregister_trace_event;
 	}
 
-	return 0;
+	if (!register_trace_event(&trace_blk_event_ext)) {
+		pr_warn("Warning: could not register block events\n");
+		/* unregister blk_tracer */
+		goto unregister_trace_event;
+	}
+
+	if (register_tracer(&blk_tracer_ext) != 0) {
+		pr_warn("Warning: could not register the block tracer\n");
+		goto unregister_trace_event_ext;
+	}
+out:
+	return ret;
+
+unregister_trace_event_ext:
+	unregister_trace_event(&trace_blk_event_ext);
+unregister_trace_event:
+	unregister_trace_event(&trace_blk_event);
+	ret = 1;
+	goto out;
 }
 
 device_initcall(init_blk_tracer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f3f5e77123ad..fd2630dcd180 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -42,6 +42,7 @@ enum trace_type {
 	TRACE_GRAPH_ENT,
 	TRACE_USER_STACK,
 	TRACE_BLK,
+	TRACE_BLK_EXT,
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_RAW_DATA,
-- 
2.22.1
