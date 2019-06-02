From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Sun, 02 Jun 2019 16:58:08 +0000
Subject: [blktrace-tools RFC PATCH 3/5] act_mask: add support for trace extension
Message-Id: <20190602165810.14817-4-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds helper functions to validate the action mask and
priority mask for blktrace-extension. We also add new mask map to hold
newly supported actions along with the priority mask.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 act_mask.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/act_mask.c b/act_mask.c
index 8f1b8d7..88abbaf 100644
--- a/act_mask.c
+++ b/act_mask.c
@@ -1,6 +1,9 @@
 #include <strings.h>
+#include <stdint.h>
 #include "blktrace.h"
 
+#define DECLARE_PRIO_CLASS_MASK_MAP(mask) \
+	{ (1 << IOPRIO_CLASS_##mask), #mask, "IOPRIO_CLASS_"#mask }
 #define DECLARE_MASK_MAP(mask)          { BLK_TC_##mask, #mask, "BLK_TC_"#mask }
 #define COMPARE_MASK_MAP(mmp, str)                                      \
         (!strcasecmp((mmp)->short_form, (str)) ||                      \
@@ -31,6 +34,67 @@ static struct mask_map mask_maps[] = {
 	DECLARE_MASK_MAP(FUA),
 };
 
+/**
+ * Map mask with extentions.
+ */
+static struct mask_map mask_maps_ext[] = {
+	DECLARE_MASK_MAP(READ),
+	DECLARE_MASK_MAP(WRITE),
+	DECLARE_MASK_MAP(FLUSH),
+	DECLARE_MASK_MAP(SYNC),
+	DECLARE_MASK_MAP(QUEUE),
+	DECLARE_MASK_MAP(REQUEUE),
+	DECLARE_MASK_MAP(ISSUE),
+	DECLARE_MASK_MAP(COMPLETE),
+	DECLARE_MASK_MAP(FS),
+	DECLARE_MASK_MAP(PC),
+	DECLARE_MASK_MAP(NOTIFY),
+	DECLARE_MASK_MAP(AHEAD),
+	DECLARE_MASK_MAP(META),
+	DECLARE_MASK_MAP(DISCARD),
+	DECLARE_MASK_MAP(DRV_DATA),
+	DECLARE_MASK_MAP(FUA),
+	DECLARE_MASK_MAP(WRITE_ZEROES),
+	DECLARE_MASK_MAP(ZONE_RESET),
+};
+
+/**
+ * I/O Priority Map mask based on ${KERNEL_SRC_DIR}/include/linux/ioprio.h.
+ */
+static struct mask_map prio_map[] = {
+	DECLARE_PRIO_CLASS_MASK_MAP(NONE),
+	DECLARE_PRIO_CLASS_MASK_MAP(RT),
+	DECLARE_PRIO_CLASS_MASK_MAP(BE),
+	DECLARE_PRIO_CLASS_MASK_MAP(IDLE),
+};
+
+/**
+ * I/O Priority Map mask search for valid ioprio string value.
+ */
+int find_prio_mask_map(char *string)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(prio_map)/sizeof(prio_map[0]); i++)
+		if (COMPARE_MASK_MAP(&prio_map[i], string))
+			return prio_map[i].mask;
+
+	return -1;
+}
+
+/**
+ * I/O Priority Map mask search for valid ioprio mask.
+ */
+bool valid_prio_opt(uint32_t x)
+{
+	return (x & 0xFFFFFFF0) ? false : true;
+}
+
+uint64_t valid_act_opt_ext(uint64_t x)
+{
+	return (1 <= x) && (x < (1ULL << BLK_TC_SHIFT));
+}
+
 int find_mask_map(char *string)
 {
 	unsigned int i;
@@ -46,3 +110,14 @@ int valid_act_opt(int x)
 {
 	return (1 <= x) && (x < (1 << BLK_TC_SHIFT));
 }
+
+int find_mask_map_ext(char *string)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(mask_maps_ext)/sizeof(mask_maps_ext[0]); i++)
+		if (COMPARE_MASK_MAP(&mask_maps_ext[i], string))
+			return mask_maps_ext[i].mask;
+
+	return -1;
+}
-- 
2.19.1
