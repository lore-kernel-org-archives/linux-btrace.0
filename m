From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 23 May 2008 20:43:50 +0000
Subject: [RFC: blkparse Patch] Implement simple message in blktrace stream
Message-Id: <48372C86.1050500@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060300000601090700000903"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300000601090700000903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060300000601090700000903
Content-Type: text/x-diff;
 name="0001-Added-in-handling-of-MESSAGE-notes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Added-in-handling-of-MESSAGE-notes.patch"

From b03cc9f9a75da479d2b37b03fc4554553b8ee6b6 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Fri, 23 May 2008 16:25:46 -0400
Subject: [PATCH] Added in handling of MESSAGE notes

Output stream would look like:

  8,16   1   813055    20.259000000  4692  I   R 3088320 + 8 [dd]
  8,16   1   813056    20.259000000  4692  Q   R 3088328 + 8 [dd]
  8,16   1             20.259000000     0  m   N elv switch: deadline
  8,16   1   813057    20.259000000  4692  G   R 3088328 + 8 [dd]
  8,16   1   813058    20.259000000  4692  I   R 3088328 + 8 [dd]

Needs some cleaning up (documentation).

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blkparse.c     |   17 +++++++++++++++++
 blktrace_api.h |    2 ++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 517dde5..09a77f6 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -590,6 +590,23 @@ static void handle_notify(struct blk_io_trace *bit)
 
 		break;
 
+	case BLK_TN_MESSAGE:
+		if (bit->pdu_len > 0) {
+			char msg[bit->pdu_len+1];
+
+			memcpy(msg, (char *)payload, bit->pdu_len);
+			msg[bit->pdu_len] = '\0';
+
+			bit->time -= genesis_time;
+			fprintf(ofp,
+				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+				MAJOR(bit->device), MINOR(bit->device),
+				bit->cpu, "", (int) SECONDS(bit->time),
+				(unsigned long) NANO_SECONDS(bit->time),
+				0, "m", "N", msg);
+		}
+		break;
+
 	default:
 		/* Ignore unknown notify events */
 		;
diff --git a/blktrace_api.h b/blktrace_api.h
index 61b405a..67720de 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -54,6 +54,7 @@ enum {
 enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
+	__BLK_TN_MESSAGE,               /* Character string message */
 };
 
 /*
@@ -77,6 +78,7 @@ enum blktrace_notify {
 
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
+#define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
 #define BLK_IO_TRACE_VERSION	0x07
-- 
1.5.4.3


--------------060300000601090700000903--
