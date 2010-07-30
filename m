From: Edward Shishkin <edward@redhat.com>
Date: Fri, 30 Jul 2010 14:05:04 +0000
Subject: [patch 5/6] blktrace: btreplay man pages update
Message-Id: <4C52DC10.7060003@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020500070700010409090001"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------020500070700010409090001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------020500070700010409090001
Content-Type: text/plain;
 name="12-blktrace-fix-595623.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="12-blktrace-fix-595623.patch"

Fixup for 595623
Document btreplay option -x (--acc-factor)

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
--- blktrace-1.0.1.orig/doc/btreplay.8
+++ blktrace-1.0.1/doc/btreplay.8
@@ -168,6 +168,13 @@
 ignored. IOs will be replayed without inter-bunch delays.
 .RE
 
+\-x <\fIfactor\fR>
+.br
+\-\-acc\-factor=<\fIfactor\fR>
+.RS
+Specify acceleration factor. Default value is 1 (no acceleration).
+.RE
+
 \-v
 .br
 \-\-verbose

--------------020500070700010409090001--
