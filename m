From: Vasily Tarasov <sectorsize512@gmail.com>
Date: Fri, 09 Sep 2011 23:02:16 +0000
Subject: [PATCH][BLKPARSE/BLKTRACE] too small arrays for file names
Message-Id: <20110909230216.GA11154@white>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In our experiments blktrace/blkparse file names encode a lot of infomation about
the particular experiment.  We noticed that for long enough file names blkparse
does not work.

The reason is that per_cpu_info->fname[] is of 128 bytes. As a result, in
setup_file() function only part of the file name gets to ->fname[]. Then stat()
fails and we exit the function. Notice, that no error is printed in this case.

In the following patch ->fname[] size is increased to POSXI defined PATH_MAX.

Signed-off-by: Vasily Tarasov <tarasov@vasily.name>

--huq684BweRXVnRxX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="blkparse-to-short-file-name.diff"

diff --git a/blkparse.c b/blkparse.c
index 169d491..6db7307 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2836,7 +2836,7 @@ int main(int argc, char *argv[])
 			ofp = fdopen(STDOUT_FILENO, "w");
 			mode = _IOLBF;
 		} else {
-			char ofname[128];
+			char ofname[PATH_MAX];
 
 			snprintf(ofname, sizeof(ofname) - 1, "%s", output_name);
 			ofp = fopen(ofname, "w");
diff --git a/blktrace.h b/blktrace.h
index 8b3e031..5da6dbc 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -2,6 +2,7 @@
 #define BLKTRACE_H
 
 #include <stdio.h>
+#include <limits.h>
 #include <byteswap.h>
 #include <endian.h>
 
@@ -44,7 +45,7 @@ struct per_cpu_info {
 
 	int fd;
 	int fdblock;
-	char fname[128];
+	char fname[PATH_MAX];
 
 	struct io_stats io_stats;
 

--huq684BweRXVnRxX--
