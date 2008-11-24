From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 24 Nov 2008 16:07:31 +0000
Subject: [Patch] fix blktrace API (missing commit)
Message-Id: <1227542851.9636.27.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

The git commit 11914a53d2ec2974a565311af327b8983d8c820d added __BLK_TA_ABORT
to blktrace_api.h. A corresponding addition to the blktrace tools repository
has been missing, breaking the API. Blkparse complained:
"Bad fs action 40010011"

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blktrace_api.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -48,6 +48,7 @@ enum {
 	__BLK_TA_SPLIT,			/* bio was split */
 	__BLK_TA_BOUNCE,		/* bio was bounced */
 	__BLK_TA_REMAP,			/* bio was remapped */
+	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
 };
 
@@ -78,6 +79,7 @@ enum blktrace_notify {
 #define BLK_TA_SPLIT		(__BLK_TA_SPLIT)
 #define BLK_TA_BOUNCE		(__BLK_TA_BOUNCE)
 #define BLK_TA_REMAP		(__BLK_TA_REMAP | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))


