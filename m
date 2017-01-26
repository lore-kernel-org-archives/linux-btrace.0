From: Jan Kara <jack@suse.cz>
Date: Thu, 26 Jan 2017 10:23:54 +0000
Subject: [PATCH 2/3] blktrace: Reorganize creation of output file name
Message-Id: <20170126102355.19802-2-jack@suse.cz>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

We would like to generate output file name without having corresponding
iop structure. Reorganize the function to allow that. Also fix couple of
overflows possible when generating the file name when we are modifying
the code anyway.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 blktrace.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index f7d35dd1a62e..3a25338cc9ad 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1502,30 +1502,25 @@ static inline int net_sendfile_data(struct tracer *tp, struct io_info *iop)
 	return net_sendfile(iop);
 }
 
-static int fill_ofname(struct io_info *iop, int cpu)
+static int fill_ofname(char *dst, int dstlen, char *subdir, char *buts_name,
+		       int cpu)
 {
 	int len;
 	struct stat sb;
-	char *dst = iop->ofn;
 
 	if (output_dir)
-		len = snprintf(iop->ofn, sizeof(iop->ofn), "%s/", output_dir);
+		len = snprintf(dst, dstlen, "%s/", output_dir);
 	else
-		len = snprintf(iop->ofn, sizeof(iop->ofn), "./");
+		len = snprintf(dst, dstlen, "./");
 
-	if (net_mode = Net_server) {
-		struct cl_conn *nc = iop->nc;
-
-		len += sprintf(dst + len, "%s-", nc->ch->hostname);
-		len += strftime(dst + len, 64, "%F-%T/",
-				gmtime(&iop->dpp->cl_connect_time));
-	}
+	if (subdir)
+		len += snprintf(dst + len, dstlen - len, "%s", subdir);
 
-	if (stat(iop->ofn, &sb) < 0) {
+	if (stat(dst, &sb) < 0) {
 		if (errno != ENOENT) {
 			fprintf(stderr,
 				"Destination dir %s stat failed: %d/%s\n",
-				iop->ofn, errno, strerror(errno));
+				dst, errno, strerror(errno));
 			return 1;
 		}
 		/*
@@ -1533,20 +1528,20 @@ static int fill_ofname(struct io_info *iop, int cpu)
 		 * trying to create the directory at once.  It's harmless
 		 * to let them try, so just detect the problem and move on.
 		 */
-		if (mkdir(iop->ofn, 0755) < 0 && errno != EEXIST) {
+		if (mkdir(dst, 0755) < 0 && errno != EEXIST) {
 			fprintf(stderr,
 				"Destination dir %s can't be made: %d/%s\n",
-				iop->ofn, errno, strerror(errno));
+				dst, errno, strerror(errno));
 			return 1;
 		}
 	}
 
 	if (output_name)
-		snprintf(iop->ofn + len, sizeof(iop->ofn), "%s.blktrace.%d",
+		snprintf(dst + len, dstlen - len, "%s.blktrace.%d",
 			 output_name, cpu);
 	else
-		snprintf(iop->ofn + len, sizeof(iop->ofn), "%s.blktrace.%d",
-			 iop->dpp->buts_name, cpu);
+		snprintf(dst + len, dstlen - len, "%s.blktrace.%d",
+			 buts_name, cpu);
 
 	return 0;
 }
@@ -1567,8 +1562,23 @@ static int set_vbuf(struct io_info *iop, int mode, size_t size)
 
 static int iop_open(struct io_info *iop, int cpu)
 {
+	char hostdir[MAXPATHLEN + 64];
+
 	iop->ofd = -1;
-	if (fill_ofname(iop, cpu))
+	if (net_mode = Net_server) {
+		struct cl_conn *nc = iop->nc;
+		int len;
+
+		len = snprintf(hostdir, sizeof(hostdir), "%s-",
+			       nc->ch->hostname);
+		len += strftime(hostdir + len, sizeof(hostdir) - len, "%F-%T/",
+				gmtime(&iop->dpp->cl_connect_time));
+	} else {
+		hostdir[0] = 0;
+	}
+
+	if (fill_ofname(iop->ofn, sizeof(iop->ofn), hostdir,
+			iop->dpp->buts_name, cpu))
 		return 1;
 
 	iop->ofp = my_fopen(iop->ofn, "w+");
-- 
2.10.2

