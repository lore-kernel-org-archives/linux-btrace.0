From: Edward Shishkin <edward@redhat.com>
Date: Fri, 30 Jul 2010 14:04:36 +0000
Subject: [patch 3/6] blktrace: blkparse documentation update
Message-Id: <4C52DBF4.4080506@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070604070401080002070305"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604070401080002070305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------070604070401080002070305
Content-Type: text/plain;
 name="10-blktrace-fix-595615.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10-blktrace-fix-595615.patch"

Fixup for 595615.

Document blkparse options:
-A, --set-mask,
-a, --act-mask,
-D. --input-directory

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
--- blktrace-1.0.1.orig/blkparse.c
+++ blktrace-1.0.1/blkparse.c
@@ -2680,6 +2680,8 @@
 	"[ -M                | --no-msgs\n" \
 	"[ -v                | --verbose ]\n" \
 	"[ -V                | --version ]\n\n" \
+	"\t-a Only trace specified actions. See documentation\n" \
+	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b stdin read batching\n" \
 	"\t-d Output file. If specified, binary data is written to file\n" \
 	"\t-D Directory to prepend to input file names\n" \
--- blktrace-1.0.1.orig/doc/blkparse.1
+++ blktrace-1.0.1/doc/blkparse.1
@@ -58,6 +58,26 @@
 
 
 .SH OPTIONS
+\-A \fIhex-mask\fR
+.br
+\-\-set-mask=\fIhex-mask\fR
+.RS
+Set filter mask to \fIhex-mask\fR, see blktrace (8) for masks
+.RE
+
+\-a \fImask\fR
+.br
+\-\-act-mask=\fImask\fR
+.RS
+Add \fImask\fR to current filter, see blktrace (8) for masks
+.RE
+
+\-D \fIdir\fR
+.br
+\-\-input-directory=\fIdir\fR
+.RS
+Prepend \fIdir\fR to input file names
+.RE
 
 \-b \fIbatch\fR
 .br

--------------070604070401080002070305--
