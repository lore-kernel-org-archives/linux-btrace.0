From: Nathan Zimmer <nzimmer@sgi.com>
Date: Mon, 15 Apr 2013 14:53:32 +0000
Subject: [PATCH 1/5] verify_blkparse: Change max_cpus to deal with systems larger the 512
Message-Id: <1366037616-20159-2-git-send-email-nzimmer@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

verify_blkpars has troubles with systems larger then 512.
Also there is issue in the scanning code causing the cpu number to be
truncated to the first two digits. i.e cpu 542 would be read as 54.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
---
 verify_blkparse.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/verify_blkparse.c b/verify_blkparse.c
index aae8d7c..5689f43 100644
--- a/verify_blkparse.c
+++ b/verify_blkparse.c
@@ -3,18 +3,33 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
-
-#define MAX_CPUS	(512)
+#include <errno.h>
 
 int main(int argc, char *argv[])
 {
 	double this_time, last_time;
 	char line[256], last_line[256], *p;
 	int major, minor, cpu, nr, alias;
+	long  MAX_CPUS;
 	unsigned long long total_entries;
-	unsigned int last_seq[MAX_CPUS], seq;
+	unsigned int *last_seq;
+	unsigned int seq;
 	FILE *f;
 
+#ifdef _SC_NPROCESSORS_CONF
+	MAX_CPUS = sysconf(_SC_NPROCESSORS_CONF);
+	if (MAX_CPUS < 1)
+	{
+		fprintf(stderr, "Could not determine number of CPUs online:\n%s\n", 
+			strerror (errno));
+		fprintf(stderr, "Assuming 1024\n");
+		MAX_CPUS = 1024;
+  	}
+#else
+	MAX_CPUS = CPU_SETSIZE;
+#endif 
+	
+	last_seq = malloc( sizeof(unsigned int) * MAX_CPUS );
 	for (nr = 0; nr < MAX_CPUS; nr++)
 		last_seq[nr] = -1;
 
@@ -33,7 +48,7 @@ int main(int argc, char *argv[])
 	alias = nr = 0;
 	total_entries = 0;
 	while ((p = fgets(line, sizeof(line), f)) != NULL) {
-		if (sscanf(p, "%3d,%3d %2d %8d %lf", &major, &minor, &cpu, &seq, &this_time) != 5)
+		if (sscanf(p, "%3d,%3d %5d %8d %lf", &major, &minor, &cpu, &seq, &this_time) != 5)
 			break;
 
 		if (this_time < last_time) {
-- 
1.8.1.2

