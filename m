From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:26 +0000
Subject: [RFC PATCH 29/38] blktrace: add trace entry & pdu helpers
Message-Id: <20190717212435.2990-30-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 359562073d01..f0ae1bdadfc9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1629,54 +1629,108 @@ const struct blk_io_trace *te_blk_io_trace(const struct trace_entry *ent)
 	return (const struct blk_io_trace *)ent;
 }
 
+static inline
+const struct blk_io_trace_ext *te_blk_io_trace_ext(const struct trace_entry *ent)
+{
+	return (const struct blk_io_trace_ext *)ent;
+}
+
 static inline const void *pdu_start(const struct trace_entry *ent, bool has_cg)
 {
 	return (void *)(te_blk_io_trace(ent) + 1) +
 		(has_cg ? sizeof(union kernfs_node_id) : 0);
 }
 
+static inline const void *pdu_start_ext(const struct trace_entry *ent, bool has_cg)
+{
+	return (void *)(te_blk_io_trace_ext(ent) + 1) +
+		(has_cg ? sizeof(union kernfs_node_id) : 0);
+}
+
 static inline const void *cgid_start(const struct trace_entry *ent)
 {
 	return (void *)(te_blk_io_trace(ent) + 1);
 }
 
+static inline const void *cgid_start_ext(const struct trace_entry *ent)
+{
+	return (void *)(te_blk_io_trace_ext(ent) + 1);
+}
+
 static inline int pdu_real_len(const struct trace_entry *ent, bool has_cg)
 {
 	return te_blk_io_trace(ent)->pdu_len -
 			(has_cg ? sizeof(union kernfs_node_id) : 0);
 }
 
+static inline int pdu_real_len_ext(const struct trace_entry *ent, bool has_cg)
+{
+	return te_blk_io_trace_ext(ent)->pdu_len -
+			(has_cg ? sizeof(union kernfs_node_id) : 0);
+}
+
 static inline u32 t_action(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->action;
 }
 
+static inline u64 t_action_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->action;
+}
+
 static inline u32 t_bytes(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->bytes;
 }
 
+static inline u32 t_bytes_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->bytes;
+}
+
 static inline u32 t_sec(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->bytes >> 9;
 }
 
+static inline u32 t_sec_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->bytes >> 9;
+}
+
 static inline unsigned long long t_sector(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->sector;
 }
 
+static inline unsigned long long t_sector_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->sector;
+}
+
 static inline __u16 t_error(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->error;
 }
 
+static inline __u16 t_error_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->error;
+}
+
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
 	const __u64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
+static __u64 get_pdu_int_ext(const struct trace_entry *ent, bool has_cg)
+{
+	const __u64 *val = pdu_start_ext(ent, has_cg);
+	return be64_to_cpu(*val);
+}
+
 static void get_pdu_remap(const struct trace_entry *ent,
 			  struct blk_io_trace_remap *r, bool has_cg)
 {
@@ -1688,6 +1742,17 @@ static void get_pdu_remap(const struct trace_entry *ent,
 	r->sector_from = be64_to_cpu(sector_from);
 }
 
+static void get_pdu_remap_ext(const struct trace_entry *ent,
+			  struct blk_io_trace_remap *r, bool has_cg)
+{
+	const struct blk_io_trace_remap *__r = pdu_start_ext(ent, has_cg);
+	__u64 sector_from = __r->sector_from;
+
+	r->device_from = be32_to_cpu(__r->device_from);
+	r->device_to   = be32_to_cpu(__r->device_to);
+	r->sector_from = be64_to_cpu(sector_from);
+}
+
 typedef void (blk_log_action_t) (struct trace_iterator *iter, const char *act,
 	bool has_cg);
 
-- 
2.17.0
