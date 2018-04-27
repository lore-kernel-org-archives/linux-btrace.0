From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:31 +0000
Subject: [PATCH 24/31] verify_blkparse: inform on bad line, report line no
Message-Id: <20180427130738.102806-25-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 verify_blkparse.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/verify_blkparse.c b/verify_blkparse.c
index 3f3e92a563c9..97dbc2970dee 100644
--- a/verify_blkparse.c
+++ b/verify_blkparse.c
@@ -48,12 +48,18 @@ int main(int argc, char *argv[])
 	alias = nr = 0;
 	total_entries = 0;
 	while ((p = fgets(line, sizeof(line), f)) != NULL) {
-		if (sscanf(p, "%3d,%3d %5d %8d %lf", &major, &minor, &cpu, &seq, &this_time) != 5)
+		if (sscanf(p, "%3d,%3d %5d %8d %lf",
+			   &major, &minor, &cpu, &seq, &this_time) != 5) {
+			fprintf(stdout, "unrecognized line, aborting\n");
+			fprintf(stdout, "this (line no %llu): %s",
+				total_entries + 1, p);
 			break;
+		}
 
 		if (this_time < last_time) {
 			fprintf(stdout, "last: %s", last_line);
-			fprintf(stdout, "this: %s", p);
+			fprintf(stdout, "this (line no %llu): %s",
+				total_entries + 1, p);
 			nr++;
 		}
 
@@ -66,6 +72,8 @@ int main(int argc, char *argv[])
 
 		if (last_seq[cpu] = seq) {
 			fprintf(stdout, "alias on sequence %u\n", seq);
+			fprintf(stdout, "this (line no %llu): %s",
+				total_entries + 1, p);
 			alias++;
 		}
 
-- 
2.14.2

