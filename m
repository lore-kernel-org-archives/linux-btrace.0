From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 17 Feb 2009 14:04:05 +0000
Subject: [PATCH] Removed empty data files
Message-Id: <499AC3D5.8050008@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010201090407090106080509"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201090407090106080509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Does anybody rely upon _all_ of the blktrace.X files being generated
(even if they are 0-lengthed)?


--------------010201090407090106080509
Content-Type: text/x-diff;
 name="0001-Removed-empty-data-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Removed-empty-data-files.patch"

From 1da4effb9b61928b6475ac0cba05a1f32468185e Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Tue, 17 Feb 2009 09:01:04 -0500
Subject: [PATCH] Removed empty data files

It's not unusual to have lots of empty blktrace files, this unlinks
files at the end of the run that are empty.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 26b3afd..2695a33 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1509,6 +1509,17 @@ static int set_vbuf(struct io_info *iop, int mode, size_t size)
 	return 0;
 }
 
+static void iop_close(struct io_info *iop)
+{
+	if (iop) {
+		struct stat buf;
+
+		fclose(iop->ofp);
+		if (!stat(iop->ofn, &buf) && (buf.st_size == 0))
+			unlink(iop->ofn);
+	}
+}
+
 static int iop_open(struct io_info *iop, int cpu)
 {
 	iop->ofd = -1;
@@ -1525,7 +1536,7 @@ static int iop_open(struct io_info *iop, int cpu)
 	if (set_vbuf(iop, _IOLBF, FILE_VBUF_SIZE)) {
 		fprintf(stderr, "set_vbuf for file %s failed: %d/%s\n",
 			iop->ofn, errno, strerror(errno));
-		fclose(iop->ofp);
+		iop_close(iop);
 		return 1;
 	}
 
@@ -1548,8 +1559,7 @@ static void close_iop(struct io_info *iop)
 		}
 	}
 
-	if (iop->ofp)
-		fclose(iop->ofp);
+	iop_close(iop);
 	if (iop->obuf)
 		free(iop->obuf);
 }
-- 
1.5.6.3


--------------010201090407090106080509--
