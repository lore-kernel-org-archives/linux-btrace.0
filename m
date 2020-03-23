From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Mon, 23 Mar 2020 16:29:47 +0000
Subject: [RFC PATCH 04/39] blktrace: introduce new ioctls
Message-Id: <20200323163022.30688-5-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Add new IOCTLs definitions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..c360e1a98e66 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -184,6 +184,10 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKTRACESETUP_EXT _IOWR(0x12,128,struct blk_user_trace_setup_ext)
+#define BLKTRACESTART_EXT _IO(0x12,129)
+#define BLKTRACESTOP_EXT _IO(0x12,130)
+#define BLKTRACETEARDOWN_EXT _IO(0x12,131)
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.22.0
