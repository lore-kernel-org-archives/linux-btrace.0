From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:33 +0000
Subject: [PATCH 26/31] blkparse: treat sector as %llu for custom format like elsewhere in code
Message-Id: <20180427130738.102806-27-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

blk_io_trace.sector is __u64.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 blkparse_fmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c110dad10b0b..818208808198 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -230,7 +230,8 @@ static void print_field(char *act, struct per_cpu_info *pci,
 		fprintf(ofp, strcat(format, "ld"), t->sequence);
 		break;
 	case 'S':
-		fprintf(ofp, strcat(format, "lu"), t->sector);
+		fprintf(ofp, strcat(format, "llu"),
+			(unsigned long long)t->sector);
 		break;
 	case 't':
 		sprintf(format, "%%0%dlu", has_w ? width : 9);
-- 
2.14.2

