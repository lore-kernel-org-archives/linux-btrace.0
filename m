From: Edward Shishkin <edward@redhat.com>
Date: Fri, 30 Jul 2010 14:04:24 +0000
Subject: [patch 2/6] blktrace: blkiomon documentation update
Message-Id: <4C52DBE8.4020206@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070208000206090401040608"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------070208000206090401040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------070208000206090401040608
Content-Type: text/plain;
 name="9-blktrace-fix-595419.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="9-blktrace-fix-595419.patch"

Fixup for 595419.

Document blkiomon option -d (--dump-lldd).
Add drv_data mask description to blktrace man page.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---

--- blktrace-1.0.1.orig/blkiomon.c
+++ blktrace-1.0.1/blkiomon.c
@@ -599,6 +599,7 @@
 	"-I <interval>       | --interval=<interval>\n" \
 	"[ -h <file>         | --human-readable=<file> ]\n" \
 	"[ -b <file>         | --binary=<file> ]\n" \
+	"[ -d <file>         | --dump-lldd=<file> ]\n" \
 	"[ -D <file>         | --debug=<file> ]\n" \
 	"[ -Q <path name>    | --msg-queue=<path name>]\n" \
 	"[ -q <msg queue id> | --msg-queue-id=<msg queue id>]\n" \
--- blktrace-1.0.1.orig/doc/blkiomon.8
+++ blktrace-1.0.1/doc/blkiomon.8
@@ -7,7 +7,7 @@
 
 .SH SYNOPSIS
 .B blkiomon \-I \fIinterval\fR [ \-h \fIfile\fR ] [ \-b \fIfile\fR ]
-[ \-D \fIfile\fR ] [ \-Q \fIpath_name\fR
+[ \-d \fIfile\fR ] [ \-D \fIfile\fR ] [ \-Q \fIpath_name\fR
 \-q \fImsg_queue_id\fR \-m \fImsg_id\fR ] [ \-V ]
 .br
 
@@ -50,6 +50,13 @@
 Binary output file. Use '\-' for stdout.
 .RE
 
+\-d \fIfile\fR
+.br
+\-\-dump-lldd=\fIfile\fR
+.RS
+Output file for data emitted by low level device driver.
+.RE
+
 \-D \fIfile\fR
 .br
 \-\-debug=\fIfile\fR
--- blktrace-1.0.1.orig/doc/blktrace.8
+++ blktrace-1.0.1/doc/blktrace.8
@@ -172,6 +172,8 @@
 \fIwrite\fR: write traces
 .br
 \fInotify\fR: trace messages
+.br
+\fIdrv_data\fR: additional driver specific trace
 .RE
 
 

--------------070208000206090401040608--
