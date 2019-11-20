From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:25:00 +0000
Subject: [RFC PATCH 30/39] blktrace: add blk_log_xxx helpers()
Message-Id: <20191120042509.12835-31-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 165 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index b981b35842f3..712ecf6dc6db 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1769,6 +1769,23 @@ static void blk_log_action_classic(struct trace_iterator *iter, const char *act,
 			 secs, nsec_rem, iter->ent->pid, act, rwbs);
 }
 
+static void blk_log_action_classic_ext(struct trace_iterator *iter, const char *act,
+	bool has_cg)
+{
+	char rwbs[RWBS_LEN];
+	unsigned long long ts  = iter->ts;
+	unsigned long nsec_rem = do_div(ts, NSEC_PER_SEC);
+	unsigned secs	       = (unsigned long)ts;
+	const struct blk_io_trace_ext *t = te_blk_io_trace_ext(iter->ent);
+
+	fill_rwbs_ext(rwbs, t);
+
+	trace_seq_printf(&iter->seq,
+			 "%3d,%-3d %2d %5d.%09lu %5u %2s %3s ",
+			 MAJOR(t->device), MINOR(t->device), iter->cpu,
+			 secs, nsec_rem, iter->ent->pid, act, rwbs);
+}
+
 static void blk_log_action(struct trace_iterator *iter, const char *act,
 	bool has_cg)
 {
@@ -1797,6 +1814,34 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 				 MAJOR(t->device), MINOR(t->device), act, rwbs);
 }
 
+static void blk_log_action_ext(struct trace_iterator *iter, const char *act,
+	bool has_cg)
+{
+	char rwbs[RWBS_LEN];
+	const struct blk_io_trace_ext *t = te_blk_io_trace_ext(iter->ent);
+
+	fill_rwbs_ext(rwbs, t);
+	if (has_cg) {
+		const union kernfs_node_id *id = cgid_start(iter->ent);
+
+		if (blk_tracer_flags.val & TRACE_BLK_OPT_CGNAME) {
+			char blkcg_name_buf[NAME_MAX + 1] = "<...>";
+
+			cgroup_path_from_kernfs_id(id, blkcg_name_buf,
+				sizeof(blkcg_name_buf));
+			trace_seq_printf(&iter->seq, "%3d,%-3d %s %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device),
+				 blkcg_name_buf, act, rwbs);
+		} else
+			trace_seq_printf(&iter->seq,
+				 "%3d,%-3d %x,%-x %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device),
+				 id->ino, id->generation, act, rwbs);
+	} else
+		trace_seq_printf(&iter->seq, "%3d,%-3d %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device), act, rwbs);
+}
+
 static void blk_log_dump_pdu(struct trace_seq *s,
 	const struct trace_entry *ent, bool has_cg)
 {
@@ -1836,6 +1881,45 @@ static void blk_log_dump_pdu(struct trace_seq *s,
 	trace_seq_puts(s, ") ");
 }
 
+static void blk_log_dump_pdu_ext(struct trace_seq *s,
+	const struct trace_entry *ent, bool has_cg)
+{
+	const unsigned char *pdu_buf;
+	int pdu_len;
+	int i, end;
+
+	pdu_buf = pdu_start_ext(ent, has_cg);
+	pdu_len = pdu_real_len_ext(ent, has_cg);
+
+	if (!pdu_len)
+		return;
+
+	/* find the last zero that needs to be printed */
+	for (end = pdu_len - 1; end >= 0; end--)
+		if (pdu_buf[end])
+			break;
+	end++;
+
+	trace_seq_putc(s, '(');
+
+	for (i = 0; i < pdu_len; i++) {
+
+		trace_seq_printf(s, "%s%02x",
+				 i = 0 ? "" : " ", pdu_buf[i]);
+
+		/*
+		 * stop when the rest is just zeroes and indicate so
+		 * with a ".." appended
+		 */
+		if (i = end && end != pdu_len - 1) {
+			trace_seq_puts(s, " ..) ");
+			return;
+		}
+	}
+
+	trace_seq_puts(s, ") ");
+}
+
 static void blk_log_generic(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -1855,6 +1939,28 @@ static void blk_log_generic(struct trace_seq *s, const struct trace_entry *ent,
 	}
 }
 
+static void blk_log_generic_ext(struct trace_seq *s,
+				const struct trace_entry *ent,
+				bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	if (t_action(ent) & BLK_TC_ACT_EXT(BLK_TC_PC)) {
+		trace_seq_printf(s, "%u ", t_bytes_ext(ent));
+		blk_log_dump_pdu_ext(s, ent, has_cg);
+		trace_seq_printf(s, "[%s]\n", cmd);
+	} else {
+		if (t_sec_ext(ent))
+			trace_seq_printf(s, "%llu + %u [%s]\n",
+						t_sector_ext(ent),
+						t_sec_ext(ent), cmd);
+		else
+			trace_seq_printf(s, "[%s]\n", cmd);
+	}
+}
+
 static void blk_log_with_error(struct trace_seq *s,
 			      const struct trace_entry *ent, bool has_cg)
 {
@@ -1872,6 +1978,23 @@ static void blk_log_with_error(struct trace_seq *s,
 	}
 }
 
+static void blk_log_with_error_ext(struct trace_seq *s,
+			      const struct trace_entry *ent, bool has_cg)
+{
+	if (t_action_ext(ent) & BLK_TC_ACT_EXT(BLK_TC_PC)) {
+		blk_log_dump_pdu_ext(s, ent, has_cg);
+		trace_seq_printf(s, "[%d]\n", t_error_ext(ent));
+	} else {
+		if (t_sec_ext(ent))
+			trace_seq_printf(s, "%llu + %u [%d]\n",
+					 t_sector_ext(ent),
+					 t_sec_ext(ent), t_error_ext(ent));
+		else
+			trace_seq_printf(s, "%llu [%d]\n",
+					 t_sector_ext(ent), t_error_ext(ent));
+	}
+}
+
 static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	struct blk_io_trace_remap r = { .device_from = 0, };
@@ -1883,6 +2006,18 @@ static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bo
 			 (unsigned long long)r.sector_from);
 }
 
+static void blk_log_remap_ext(struct trace_seq *s, const struct trace_entry *ent,
+		bool has_cg)
+{
+	struct blk_io_trace_remap r = { .device_from = 0, };
+
+	get_pdu_remap_ext(ent, &r, has_cg);
+	trace_seq_printf(s, "%llu + %u <- (%d,%d) %llu\n",
+			 t_sector_ext(ent), t_sec_ext(ent),
+			 MAJOR(r.device_from), MINOR(r.device_from),
+			 (unsigned long long)r.sector_from);
+}
+
 static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -1892,6 +2027,7 @@ static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, boo
 	trace_seq_printf(s, "[%s]\n", cmd);
 }
 
+
 static void blk_log_unplug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -1901,6 +2037,16 @@ static void blk_log_unplug(struct trace_seq *s, const struct trace_entry *ent, b
 	trace_seq_printf(s, "[%s] %llu\n", cmd, get_pdu_int(ent, has_cg));
 }
 
+static void blk_log_unplug_ext(struct trace_seq *s, const struct trace_entry *ent,
+		bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	trace_seq_printf(s, "[%s] %llu\n", cmd, get_pdu_int_ext(ent, has_cg));
+}
+
 static void blk_log_split(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -1911,6 +2057,16 @@ static void blk_log_split(struct trace_seq *s, const struct trace_entry *ent, bo
 			 get_pdu_int(ent, has_cg), cmd);
 }
 
+static void blk_log_split_ext(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	trace_seq_printf(s, "%llu / %llu [%s]\n", t_sector_ext(ent),
+			 get_pdu_int_ext(ent, has_cg), cmd);
+}
+
 static void blk_log_msg(struct trace_seq *s, const struct trace_entry *ent,
 			bool has_cg)
 {
@@ -1920,6 +2076,15 @@ static void blk_log_msg(struct trace_seq *s, const struct trace_entry *ent,
 	trace_seq_putc(s, '\n');
 }
 
+static void blk_log_msg_ext(struct trace_seq *s, const struct trace_entry *ent,
+			bool has_cg)
+{
+
+	trace_seq_putmem(s, pdu_start_ext(ent, has_cg),
+		pdu_real_len_ext(ent, has_cg));
+	trace_seq_putc(s, '\n');
+}
+
 /*
  * struct tracer operations
  */
-- 
2.22.1
