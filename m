From: Namhyung Kim <namhyung@gmail.com>
Date: Mon, 27 Jun 2011 17:26:14 +0000
Subject: [PATCH] blkparse: fix wrong suffix in size_cnv()
Message-Id: <1309195574-19981-1-git-send-email-namhyung@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The next suffix to Giga(G) is Tera(T) not Peta(P).

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 blkparse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 7ee9f9d..1abbd0b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1630,7 +1630,7 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
  */
 static char *size_cnv(char *dst, unsigned long long num, int in_kb)
 {
-	char suff[] = { '\0', 'K', 'M', 'G', 'P' };
+	char suff[] = { '\0', 'K', 'M', 'G', 'T' };
 	unsigned int i = 0;
 
 	if (in_kb)
-- 
1.7.6

