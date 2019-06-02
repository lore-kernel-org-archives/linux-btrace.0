From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:50:11 +0000
Subject: [RFC PATCH 02/46] blktrace_api: add new trace definition
Message-Id: <20190602165055.14424-3-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds new structure similar to struct blk_trace to support
block trace extensions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blktrace_api.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 7bb2d8de9f30..83103c1194fb 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -29,6 +29,24 @@ struct blk_trace {
 	atomic_t dropped;
 };
 
+struct blk_trace_ext {
+	int trace_state;
+	struct rchan *rchan;
+	unsigned long __percpu *sequence;
+	unsigned char __percpu *msg_data;
+	u64 act_mask;
+	u32 prio_mask;
+	u64 start_lba;
+	u64 end_lba;
+	u32 pid;
+	u32 dev;
+	struct dentry *dir;
+	struct dentry *dropped_file;
+	struct dentry *msg_file;
+	struct list_head running_ext_list;
+	atomic_t dropped;
+};
+
 struct blkcg;
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
-- 
2.19.1
