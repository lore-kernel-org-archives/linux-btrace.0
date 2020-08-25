From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:10:08 +0000
Subject: [RFC PATCH 38/39] blktrace: update blk_fill_rwbs() with new requests
Message-Id: <20200825221009.6457-39-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3cf1b2bbae79..e571c599bdf8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -3305,6 +3305,35 @@ void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)
 	case REQ_OP_READ:
 		rwbs[i++] = 'R';
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+		break;
+	case REQ_OP_ZONE_RESET:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_APPEND:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_OPEN:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+		break;
+	case REQ_OP_ZONE_FINISH:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+		break;
 	default:
 		rwbs[i++] = 'N';
 	}
-- 
2.22.1
