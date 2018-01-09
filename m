From: Hou Tao <houtao1@huawei.com>
Date: Tue, 09 Jan 2018 06:56:24 +0000
Subject: [PATCH 1/3] blktrace: support trace with cgroup info
Message-Id: <20180109065626.5459-2-houtao1@huawei.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Now the trace action and notify of blktrace may include cgroup info
in them. If __BLK_TA_CGROUP & blk_io_trace::action is true, the cgroup
info will be stored after the blk_io_trace struct (namely the header),
and the PDU will be appended after the cgroup info.

To support trace with cgroup info, we define macro BLK_AUX_TA and
function pdu_start_len(). BLK_AUX_TA is used to strip __BLK_TA_CGROUP
from blk_io_trace::action and pdu_start_len() is used to get the start
address and the length of PDU.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 blkparse.c     | 49 +++++++++++++++++++++++++++++++------------------
 blkparse_fmt.c | 22 +++++++++++++++++++++-
 blktrace.h     |  5 +++++
 blktrace_api.h | 10 ++++++++++
 4 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 227cc44..fa2f520 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -574,16 +574,20 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
 
 static void handle_notify(struct blk_io_trace *bit)
 {
-	void	*payload = (caddr_t) bit + sizeof(*bit);
+	void	*payload;
+	__u16	pdu_len;
 	__u32	two32[2];
+	__u32	act = bit->action & ~BLK_AUX_TA;
 
-	switch (bit->action) {
+	pdu_start_len(bit, &payload, &pdu_len);
+
+	switch (act) {
 	case BLK_TN_PROCESS:
 		add_ppm_hash(bit->pid, payload);
 		break;
 
 	case BLK_TN_TIMESTAMP:
-		if (bit->pdu_len != sizeof(two32))
+		if (pdu_len != sizeof(two32))
 			return;
 		memcpy(two32, payload, sizeof(two32));
 		if (!data_is_native) {
@@ -601,11 +605,11 @@ static void handle_notify(struct blk_io_trace *bit)
 		break;
 
 	case BLK_TN_MESSAGE:
-		if (bit->pdu_len > 0) {
-			char msg[bit->pdu_len+1];
+		if (pdu_len > 0) {
+			char msg[pdu_len+1];
 
-			memcpy(msg, (char *)payload, bit->pdu_len);
-			msg[bit->pdu_len] = '\0';
+			memcpy(msg, (char *)payload, pdu_len);
+			msg[pdu_len] = '\0';
 
 			fprintf(ofp,
 				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
@@ -1491,7 +1495,7 @@ static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int act = (t->action & 0xffff) & ~BLK_AUX_TA;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1540,7 +1544,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int act = (t->action & 0xffff) & ~BLK_AUX_TA;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1622,10 +1626,12 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
+	__u32 act = t->action & ~BLK_AUX_TA;
+
 	if (text_output) {
-		if (t->action = BLK_TN_MESSAGE)
+		if (act = BLK_TN_MESSAGE)
 			handle_notify(t);
-		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
+		else if (act & BLK_TC_ACT(BLK_TC_PC))
 			dump_trace_pc(t, pdi, pci);
 		else
 			dump_trace_fs(t, pdi, pci);
@@ -1637,8 +1643,8 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 	pdi->events++;
 
 	if (bin_output_msgs ||
-			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
-			      t->action = BLK_TN_MESSAGE))
+			    !(act & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			      act = BLK_TN_MESSAGE))
 		output_binary(t, sizeof(*t) + t->pdu_len);
 }
 
@@ -2107,6 +2113,8 @@ static void show_entries_rb(int force)
 	struct trace *t;
 
 	while ((n = rb_first(&rb_sort_root)) != NULL) {
+		__u32 act;
+
 		if (is_done() && !force && !pipeline)
 			break;
 
@@ -2127,7 +2135,8 @@ static void show_entries_rb(int force)
 			break;
 		}
 
-		if (!(bit->action = BLK_TN_MESSAGE) &&
+		act = bit->action & ~BLK_AUX_TA;
+		if (!(act = BLK_TN_MESSAGE) &&
 		    check_sequence(pdi, t, force))
 			break;
 
@@ -2139,12 +2148,12 @@ static void show_entries_rb(int force)
 		if (!pci || pci->cpu != bit->cpu)
 			pci = get_cpu_info(pdi, bit->cpu);
 
-		if (!(bit->action = BLK_TN_MESSAGE))
+		if (!(act = BLK_TN_MESSAGE))
 			pci->last_sequence = bit->sequence;
 
 		pci->nelems++;
 
-		if (bit->action & (act_mask << BLK_TC_SHIFT))
+		if (act & (act_mask << BLK_TC_SHIFT))
 			dump_trace(bit, pci, pdi);
 
 		put_trace(pdi, t);
@@ -2225,6 +2234,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		struct trace *t;
 		int pdu_len, should_block, ret;
 		__u32 magic;
+		__u32 act;
 
 		bit = bit_alloc();
 
@@ -2273,7 +2283,8 @@ static int read_events(int fd, int always_block, int *fdblock)
 		/*
 		 * not a real trace, so grab and handle it here
 		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
+		act = bit->action & ~BLK_AUX_TA;
+		if (act & BLK_TC_ACT(BLK_TC_NOTIFY) && act != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			continue;
@@ -2375,6 +2386,7 @@ static void ms_sort(struct ms_stream *msp)
 static int ms_prime(struct ms_stream *msp)
 {
 	__u32 magic;
+	__u32 act;
 	unsigned int i;
 	struct trace *t;
 	struct per_dev_info *pdi = msp->pdi;
@@ -2422,7 +2434,8 @@ static int ms_prime(struct ms_stream *msp)
 			continue;
 		}
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
+		act = bit->action & ~BLK_AUX_TA;
+		if (act & BLK_TC_ACT(BLK_TC_NOTIFY) && act != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c42e6d7..8dc20ca 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -145,7 +145,27 @@ static char *dump_pdu(unsigned char *pdu_buf, int pdu_len)
 	return p;
 }
 
-#define pdu_start(t)	(((void *) (t) + sizeof(struct blk_io_trace)))
+void pdu_start_len(struct blk_io_trace *bit, void **pdu, __u16 *pdu_len)
+{
+	__u16	extra = 0;
+
+	if (bit->action & __BLK_TA_CGROUP) {
+		extra += sizeof(union kernfs_node_id);
+	}
+
+	*pdu = (caddr_t)bit + sizeof(*bit) + extra;
+	if (pdu_len)
+		*pdu_len = bit->pdu_len - extra;
+}
+
+static void *pdu_start(struct blk_io_trace *t)
+{
+	void *pdu;
+
+	pdu_start_len(t, &pdu, NULL);
+
+	return pdu;
+}
 
 static unsigned int get_pdu_int(struct blk_io_trace *t)
 {
diff --git a/blktrace.h b/blktrace.h
index 944fc08..c5ed618 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -26,6 +26,8 @@
 #define t_kb(t)		((t)->bytes >> 10)
 #define t_b(t)		((t)->bytes & 1023)
 
+#define BLK_AUX_TA (__BLK_TA_CGROUP)
+
 typedef __u32 u32;
 typedef __u8 u8;
 
@@ -148,4 +150,7 @@ extern int valid_act_opt(int);
 extern int find_mask_map(char *);
 extern char *find_process_name(pid_t);
 
+extern void pdu_start_len(struct blk_io_trace *bit,
+			void **pdu, __u16 *pdu_len);
+
 #endif
diff --git a/blktrace_api.h b/blktrace_api.h
index b222218..a78a862 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -51,6 +51,7 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_CGROUP = 1 << 8,
 };
 
 /*
@@ -60,6 +61,7 @@ enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
 	__BLK_TN_MESSAGE,               /* Character string message */
+	__BLK_TN_CGROUP = __BLK_TA_CGROUP,
 };
 
 /*
@@ -90,6 +92,14 @@ enum blktrace_notify {
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
 
+union kernfs_node_id {
+	struct {
+		__u32 ino;
+		__u32 generation;
+	};
+	__u64 id;
+};
+
 /*
  * The trace itself
  */
-- 
2.9.5

