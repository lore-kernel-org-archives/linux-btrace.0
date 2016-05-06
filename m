From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 06 May 2016 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20160506120002.8973B2C00D9@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit d1422556dbff03e982aeb2faf5893b4363621bee:

  btt/unplug_hist: fix bad memset (2016-05-03 08:34:50 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 7644909627859a9d9d837df8b2ecf21a169f0ff0:

  Fixup graph name in help text (2016-05-05 09:20:18 -0600)

----------------------------------------------------------------
Jan Kara (9):
      Better max estimate for line graphs
      Use maximum over all traces for queue depth
      Process notify events outside of given interval
      iowatcher: Use queue events if issue not available
      btt: Replace overlapping IO
      Zero sectors are strange
      Don't prepend blktrace destination dir if we didn't run blktrace
      Separate prefix in legend with space
      Fixup graph name in help text

 btt/dip_rb.c         |  6 ++++--
 iowatcher/blkparse.c | 16 ++++++++++++--
 iowatcher/main.c     | 59 +++++++++++++++++++++++++++++++++-------------------
 iowatcher/plot.c     | 28 +++++++++++++++++++++----
 iowatcher/plot.h     |  1 +
 5 files changed, 81 insertions(+), 29 deletions(-)

---

Diff of recent changes:

diff --git a/btt/dip_rb.c b/btt/dip_rb.c
index 867a97b..2aa7ffc 100644
--- a/btt/dip_rb.c
+++ b/btt/dip_rb.c
@@ -37,8 +37,10 @@ int rb_insert(struct rb_root *root, struct io *iop)
 			p = &(*p)->rb_left;
 		else if (s > __s)
 			p = &(*p)->rb_right;
-		else
-			return 0;
+		else {
+			rb_replace_node(parent, &iop->rb_node, root);
+			return 1;
+		}
 	}
 
 	rb_link_node(&iop->rb_node, parent, p);
diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index ef33d5b..c7d1d65 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -1097,8 +1097,19 @@ void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 		return;
 
 	if (action = __BLK_TA_QUEUE) {
-		if (trace->found_issue || trace->found_completion)
-			hash_queued_io(trace->io);
+		if (io->sector = 0)
+			return;
+		if (trace->found_issue || trace->found_completion) {
+			pio = hash_queued_io(trace->io);
+			/*
+			 * When there are no ISSUE events count depth and
+			 * latency at least from queue events
+			 */
+			if (pio && !trace->found_issue) {
+				pio->dispatch_time = io->time;
+				goto account_io;
+			}
+		}
 		return;
 	}
 	if (action = __BLK_TA_REQUEUE) {
@@ -1118,6 +1129,7 @@ void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 		free(pio);
 	}
 
+account_io:
 	ios_in_flight++;
 
 	seconds = SECONDS(io->time);
diff --git a/iowatcher/main.c b/iowatcher/main.c
index 2797afb..54325fb 100644
--- a/iowatcher/main.c
+++ b/iowatcher/main.c
@@ -328,7 +328,10 @@ static void read_traces(void)
 	char *path = NULL;
 
 	list_for_each_entry(tf, &all_traces, list) {
-		path = join_path(blktrace_dest_dir, tf->filename);
+		if (num_blktrace_devices)
+			path = join_path(blktrace_dest_dir, tf->filename);
+		else
+			path = strdup(tf->filename);
 
 		trace = open_trace(path);
 		if (!trace)
@@ -429,9 +432,9 @@ static void read_trace_events(void)
 
 		first_record(trace);
 		do {
+			check_record(trace);
 			if (SECONDS(get_record_time(trace)) > tf->max_seconds)
 				continue;
-			check_record(trace);
 			add_tput(trace, tf->tput_writes_gld, tf->tput_reads_gld);
 			add_iop(trace, tf->iop_gld);
 			add_io(trace, tf);
@@ -774,7 +777,7 @@ static void plot_tput(struct plot *plot, unsigned int min_seconds,
 	struct trace_file *tf;
 	char *units;
 	char line[128];
-	u64 max = 0;
+	u64 max = 0, val;
 
 	if (active_graphs[TPUT_GRAPH_INDEX] = 0)
 		return;
@@ -783,10 +786,12 @@ static void plot_tput(struct plot *plot, unsigned int min_seconds,
 		svg_alloc_legend(plot, num_traces * 2);
 
 	list_for_each_entry(tf, &all_traces, list) {
-		if (tf->tput_writes_gld->max > max)
-			max = tf->tput_writes_gld->max;
-		if (tf->tput_reads_gld->max > max)
-			max = tf->tput_reads_gld->max;
+		val = line_graph_roll_avg_max(tf->tput_writes_gld);
+		if (val > max)
+			max = val;
+		val = line_graph_roll_avg_max(tf->tput_reads_gld);
+		if (val > max)
+			max = val;
 	}
 	list_for_each_entry(tf, &all_traces, list) {
 		if (tf->tput_writes_gld->max > 0)
@@ -810,12 +815,12 @@ static void plot_tput(struct plot *plot, unsigned int min_seconds,
 		if (tf->tput_writes_gld->max > 0) {
 			svg_line_graph(plot, tf->tput_writes_gld, tf->writes_color, 0, 0);
 			if (with_legend)
-				svg_add_legend(plot, tf->label, "Writes", tf->writes_color);
+				svg_add_legend(plot, tf->label, " Writes", tf->writes_color);
 		}
 		if (tf->tput_reads_gld->max > 0) {
 			svg_line_graph(plot, tf->tput_reads_gld, tf->reads_color, 0, 0);
 			if (with_legend)
-				svg_add_legend(plot, tf->label, "Reads", tf->reads_color);
+				svg_add_legend(plot, tf->label, " Reads", tf->reads_color);
 		}
 	}
 
@@ -835,7 +840,7 @@ static void plot_fio_tput(struct plot *plot,
 	struct trace_file *tf;
 	char *units;
 	char line[128];
-	u64 max = 0;
+	u64 max = 0, val;
 
 	if (num_fio_traces = 0 || active_graphs[FIO_GRAPH_INDEX] = 0)
 		return;
@@ -844,8 +849,9 @@ static void plot_fio_tput(struct plot *plot,
 		svg_alloc_legend(plot, num_fio_traces);
 
 	list_for_each_entry(tf, &fio_traces, list) {
-		if (tf->fio_gld->max > max)
-			max = tf->fio_gld->max;
+		val = line_graph_roll_avg_max(tf->fio_gld);
+		if (val > max)
+			max = val;
 	}
 
 	list_for_each_entry(tf, &fio_traces, list) {
@@ -988,6 +994,7 @@ static void plot_queue_depth(struct plot *plot, unsigned int min_seconds,
 			     unsigned int max_seconds)
 {
 	struct trace_file *tf;
+	u64 max = 0, val;
 
 	if (active_graphs[QUEUE_DEPTH_GRAPH_INDEX] = 0)
 		return;
@@ -997,9 +1004,17 @@ static void plot_queue_depth(struct plot *plot, unsigned int min_seconds,
 	if (num_traces > 1)
 		svg_alloc_legend(plot, num_traces);
 
-	tf = list_entry(all_traces.next, struct trace_file, list);
+	list_for_each_entry(tf, &all_traces, list) {
+		val = line_graph_roll_avg_max(tf->queue_depth_gld);
+		if (val > max)
+			max = val;
+	}
+
+	list_for_each_entry(tf, &all_traces, list)
+		tf->queue_depth_gld->max = max;
+
 	set_ylabel(plot, "Pending IO");
-	set_yticks(plot, num_yticks, 0, tf->queue_depth_gld->max, "");
+	set_yticks(plot, num_yticks, 0, max, "");
 	set_xticks(plot, num_xticks, min_seconds, max_seconds);
 
 	list_for_each_entry(tf, &all_traces, list) {
@@ -1190,7 +1205,7 @@ static void plot_latency(struct plot *plot, unsigned int min_seconds,
 	struct trace_file *tf;
 	char *units;
 	char line[128];
-	u64 max = 0;
+	u64 max = 0, val;
 
 	if (active_graphs[LATENCY_GRAPH_INDEX] = 0)
 		return;
@@ -1199,8 +1214,9 @@ static void plot_latency(struct plot *plot, unsigned int min_seconds,
 		svg_alloc_legend(plot, num_traces);
 
 	list_for_each_entry(tf, &all_traces, list) {
-		if (tf->latency_gld->max > max)
-			max = tf->latency_gld->max;
+		val = line_graph_roll_avg_max(tf->latency_gld);
+		if (val > max)
+			max = val;
 	}
 
 	list_for_each_entry(tf, &all_traces, list)
@@ -1236,14 +1252,15 @@ static void plot_iops(struct plot *plot, unsigned int min_seconds,
 {
 	struct trace_file *tf;
 	char *units;
-	u64 max = 0;
+	u64 max = 0, val;
 
 	if (active_graphs[IOPS_GRAPH_INDEX] = 0)
 		return;
 
 	list_for_each_entry(tf, &all_traces, list) {
-		if (tf->iop_gld->max > max)
-			max = tf->iop_gld->max;
+		val = line_graph_roll_avg_max(tf->iop_gld);
+		if (val > max)
+			max = val;
 	}
 
 	list_for_each_entry(tf, &all_traces, list)
@@ -1345,7 +1362,7 @@ static void print_usage(void)
 		"\t-C (--codec): ffmpeg codec. Use ffmpeg -codecs to list\n"
 		"\t-r (--rolling): number of seconds in the rolling averge\n"
 		"\t-T (--title): graph title\n"
-		"\t-N (--no-graph): skip a single graph (io, tput, latency, queue_depth, \n"
+		"\t-N (--no-graph): skip a single graph (io, tput, latency, queue-depth, \n"
 		"\t\t\tiops, cpu-sys, cpu-io, cpu-irq cpu-soft cpu-user)\n"
 		"\t-O (--only-graph): add a single graph to the output\n"
 		"\t-h (--height): set the height of each graph\n"
diff --git a/iowatcher/plot.c b/iowatcher/plot.c
index 012d4f9..372406b 100644
--- a/iowatcher/plot.c
+++ b/iowatcher/plot.c
@@ -759,6 +759,29 @@ void scale_line_graph_time(u64 *max, char **units)
 	*max /= div;
 }
 
+static int rolling_span(struct graph_line_data *gld)
+{
+	if (rolling_avg_secs)
+		return rolling_avg_secs;
+	return (gld->stop_seconds - gld->min_seconds) / 25;
+}
+
+
+double line_graph_roll_avg_max(struct graph_line_data *gld)
+{
+	unsigned int i;
+	int rolling;
+	double avg, max = 0;
+
+	rolling = rolling_span(gld);
+	for (i = gld->min_seconds; i < gld->stop_seconds; i++) {
+		avg = rolling_avg(gld->data, i, rolling);
+		if (avg > max)
+			max = avg;
+	}
+	return max;
+}
+
 int svg_line_graph(struct plot *plot, struct graph_line_data *gld, char *color, int thresh1, int thresh2)
 {
 	unsigned int i;
@@ -776,10 +799,8 @@ int svg_line_graph(struct plot *plot, struct graph_line_data *gld, char *color,
 
 	if (thresh1 && thresh2)
 		rolling = 0;
-	else if (rolling_avg_secs)
-		rolling = rolling_avg_secs;
 	else
-		rolling = (gld->stop_seconds - gld->min_seconds) / 25;
+		rolling = rolling_span(gld);
 
 	for (i = gld->min_seconds; i < gld->stop_seconds; i++) {
 		avg = rolling_avg(gld->data, i, rolling);
@@ -795,7 +816,6 @@ int svg_line_graph(struct plot *plot, struct graph_line_data *gld, char *color,
 
 		x = (double)(i - gld->min_seconds) / xscale;
 		if (!thresh1 && !thresh2) {
-
 			if (!printed_header) {
 				write_check(fd, start, strlen(start));
 				printed_header = 1;
diff --git a/iowatcher/plot.h b/iowatcher/plot.h
index 7e87b1d..d65bbcf 100644
--- a/iowatcher/plot.h
+++ b/iowatcher/plot.h
@@ -137,6 +137,7 @@ char *pick_fio_color(void);
 char *pick_cpu_color(void);
 void reset_cpu_color(void);
 int svg_io_graph(struct plot *plot, struct graph_dot_data *gdd);
+double line_graph_roll_avg_max(struct graph_line_data *gld);
 int svg_line_graph(struct plot *plot, struct graph_line_data *gld, char *color, int thresh1, int thresh2);
 struct graph_line_data *alloc_line_data(unsigned int min_seconds, unsigned int max_seconds, unsigned int stop_seconds);
 struct graph_dot_data *alloc_dot_data(unsigned int min_seconds, unsigned int max_seconds, u64 min_offset, u64 max_offset, unsigned int stop_seconds, char *color, char *label);
