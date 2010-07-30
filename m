From: Edward Shishkin <edward@redhat.com>
Date: Fri, 30 Jul 2010 14:05:15 +0000
Subject: [patch 6/6] blktrace: btt documentation update
Message-Id: <4C52DC1B.5030809@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070600080309080704000604"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600080309080704000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------070600080309080704000604
Content-Type: text/plain;
 name="13-blktrace-fix-595628.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="13-blktrace-fix-595628.patch"

Fixup for 595628.

Document btt options:
-m (--seeks-per-second);
-X (--easy-parse-avgs).

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
--- blktrace-1.0.1.orig/doc/btt.1
+++ blktrace-1.0.1/doc/btt.1
@@ -30,6 +30,8 @@
 .br
 [ \-L <\fIfreq\fR>        | \-\-periodic\-latencies=<\fIfreq\fR> ]
 .br
+[ \-m <\fIoutput name\fR> | \-\-seeks\-per\-second=<\fIoutput name\fR> ]
+.br
 [ \-M <\fIdev map\fR>     | \-\-dev\-maps=<\fIdev map\fR>
 .br
 [ \-o <\fIoutput name\fR> | \-\-output\-file=<\fIoutput name\fR> ]
@@ -58,6 +60,8 @@
 .br
 [ \-V               | \-\-version ]
 .br
+[ \-X               | \-\-easy\-parse\-avgs ]
+.br
 [ \-z <\fIoutput name\fR> | \-\-q2d\-latencies=<\fIoutput name\fR> ]
 
 
@@ -199,6 +203,15 @@
 an average latency is output -- a floating point value expressing seconds.
 .RE
 
+.B \-m <\fIoutput name\fR>
+.br
+.B \-\-seeks\-per\-second=<\fIoutput name\fR>
+.RS 4
+Trigger btt to output seeks-per-second information. The first column will
+contain a time value (seconds), and the second column  will indicate the
+number of seeks per second at that point.
+.RE
+
 .B \-M <\fIdev map\fR>
 .br
 .B \-\-dev\-maps=<\fIdev map\fR>
@@ -330,6 +343,14 @@
 Requests a more verbose output.
 .RE
 
+.B \-X
+.br
+.B \-\-easy\-parse\-avgs
+.RS 4
+Provide data in an easy-to-parse form and write it to a file
+with .avg exentsion
+.RE
+
 .B \-z <\fIoutput name\fR>
 .br
 .B \-\-q2d\-latencies=<\fIoutput name\fR>

--------------070600080309080704000604--
