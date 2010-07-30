From: Edward Shishkin <edward@redhat.com>
Date: Fri, 30 Jul 2010 14:04:53 +0000
Subject: [patch 4/6] blktrace: blktrace documentation update
Message-Id: <4C52DC05.1090201@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030108020509080409020405"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108020509080409020405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Edward O. Shishkin
Principal Software Engineer
Red Hat Czech


--------------030108020509080409020405
Content-Type: text/plain;
 name="11-blktrace-fix-595620.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="11-blktrace-fix-595620.patch"

Fixup for 595620.

Document undocumented blktrace options.
Update the man pages.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
--- blktrace-1.0.1.orig/blktrace.c
+++ blktrace-1.0.1/blktrace.c
@@ -435,9 +435,24 @@
 	}
 };
 
-static char usage_str[] = \
-	"-d <dev> [ -r debugfs path ] [ -o <output> ] [-k ] [ -w time ]\n" \
-	"[ -a action ] [ -A action mask ] [ -I  <devs file> ] [ -v ]\n\n" \
+static char usage_str[] = "\n\n" \
+	"-d <dev>             | --dev=<dev>\n" \
+        "[ -r <debugfs path>  | --relay=<debugfs path> ]\n" \
+        "[ -o <file>          | --output=<file>]\n" \
+        "[ -D <dir>           | --output-dir=<dir>\n" \
+        "[ -w <time>          | --stopwatch=<time>]\n" \
+        "[ -a <action field>  | --act-mask=<action field>]\n" \
+        "[ -A <action mask>   | --set-mask=<action mask>]\n" \
+        "[ -b <size>          | --buffer-size]\n" \
+        "[ -n <number>        | --num-sub-buffers=<number>]\n" \
+        "[ -l                 | --listen]\n" \
+        "[ -h <hostname>      | --host=<hostname>]\n" \
+        "[ -p <port number>   | --port=<port number>]\n" \
+        "[ -s                 | --no-sendfile]\n" \
+        "[ -I <devs file>     | --input-devs=<devs file>]\n" \
+        "[ -v <version>       | --version]\n" \
+        "[ -V <version>       | --version]\n" \
+
 	"\t-d Use specified device. May also be given last after options\n" \
 	"\t-r Path to mounted debugfs, defaults to /sys/kernel/debug\n" \
 	"\t-o File(s) to send output to\n" \
@@ -452,6 +467,7 @@
 	"\t-p Network port to use (default 8462)\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
+	"\t-v Print program version info\n" \
 	"\t-V Print program version info\n\n";
 
 static void clear_events(struct pollfd *pfd)
--- blktrace-1.0.1.orig/doc/blktrace.8
+++ blktrace-1.0.1/doc/blktrace.8
@@ -105,23 +105,59 @@
 
 \-I \fIfile\fR
 .br
-\-\-input-devs=\fIfile\fR 
+\-\-input\-devs=\fIfile\fR
 .RS
 Adds the devices found in \fIfile\fR as devices to trace
 .RE
 
 \-n \fInum\-sub\fR 
 .br
-\-\-num\-sub=\fInum-sub\fR    
+\-\-num\-sub\-buffers=\fInum-sub\fR
 .RS
 Specifies number of buffers to use. blktrace defaults to 4 sub buffers.
 .RE
 
-\-o \fIfile\fR 
+\-l
 .br
-\-\-output=\fIfile\fR        
+\-\-listen
 .RS
-Prepend \fIfile\fR to output file name(s)  
+Run in network listen mode (blktrace server)
+.RE
+
+\-h \fIhostname\fR
+.br
+\-\-host=\fIhostname\fR
+.RS
+Run in network client mode, connecting to the given host
+.RE
+
+\-p \fInumber\fR
+.br
+\-\-port=\fInumber\fR
+.RS
+Network port to use (default 8462)
+.RE
+
+\-s
+.br
+\-\-no\-sendfile
+.RS
+Make the network client NOT use sendfile() to transfer data
+.RE
+
+\-o \fIbasename\fR
+.br
+\-\-output=\fIbasename\fR
+.RS
+Specifies base name for input files. Default is device.blktrace.cpu.
+Specifying -o - runs in live mode with blkparse (writing data to standard out).
+.RE
+
+\-D \fIdir\fR
+.br
+\-\-output\-dir=\fIdir\fR
+.RS
+Prepend \fIfile\fR to output file name(s)
 .RE
 
 \-r \fIrel-path\fR
@@ -131,9 +167,17 @@
 Specifies debugfs mount point  
 .RE
 
+\-v
+.br
+\-\-version
+.RS
+Outputs version
+.RE
+
 \-V               
 .br
-\-\-version                  
+\-\-version
+.RS
 Outputs version  
 .RE
 

--------------030108020509080409020405--
