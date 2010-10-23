From: Jens Axboe <jaxboe@fusionio.com>
Date: Sat, 23 Oct 2010 04:00:03 +0000
Subject: Recent changes
Message-Id: <20101023040003.A308237A290@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit ce2151ebdca6f2741dbd903aa3845c56adcba8f4:

  blktrace: disallow -o when using multiple devices (2010-09-16 09:26:22 -0400)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Edward Shishkin (6):
      blktrace: btrecord man pages fixup
      blktrace: blkiomon documentation update
      blktrace: blkparse documentation update
      blktrace: blktrace documentation update
      blktrace: btreplay man pages update
      blktrace: btt documentation update

 blkiomon.c     |    1 +
 blkparse.c     |    2 +
 blktrace.c     |   22 ++++++++++++++++++--
 doc/blkiomon.8 |    9 +++++++-
 doc/blkparse.1 |   20 +++++++++++++++++++
 doc/blktrace.8 |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 doc/btrecord.8 |    2 +-
 doc/btreplay.8 |    7 ++++++
 doc/btt.1      |   21 ++++++++++++++++++++
 9 files changed, 131 insertions(+), 11 deletions(-)

---

Diff of recent changes:

diff --git a/blkiomon.c b/blkiomon.c
index 9fc4d75..a895f65 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -599,6 +599,7 @@ static char usage_str[] = "\n\nblkiomon " \
 	"-I <interval>       | --interval=<interval>\n" \
 	"[ -h <file>         | --human-readable=<file> ]\n" \
 	"[ -b <file>         | --binary=<file> ]\n" \
+	"[ -d <file>         | --dump-lldd=<file> ]\n" \
 	"[ -D <file>         | --debug=<file> ]\n" \
 	"[ -Q <path name>    | --msg-queue=<path name>]\n" \
 	"[ -q <msg queue id> | --msg-queue-id=<msg queue id>]\n" \
diff --git a/blkparse.c b/blkparse.c
index ffad9b6..da34c14 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2680,6 +2680,8 @@ static char usage_str[] =    "\n\n" \
 	"[ -M                | --no-msgs\n" \
 	"[ -v                | --verbose ]\n" \
 	"[ -V                | --version ]\n\n" \
+	"\t-a Only trace specified actions. See documentation\n" \
+	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b stdin read batching\n" \
 	"\t-d Output file. If specified, binary data is written to file\n" \
 	"\t-D Directory to prepend to input file names\n" \
diff --git a/blktrace.c b/blktrace.c
index 4671a04..4cccb7c 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -435,9 +435,24 @@ static struct option l_opts[] = {
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
@@ -452,6 +467,7 @@ static char usage_str[] = \
 	"\t-p Network port to use (default 8462)\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
+	"\t-v Print program version info\n" \
 	"\t-V Print program version info\n\n";
 
 static void clear_events(struct pollfd *pfd)
diff --git a/doc/blkiomon.8 b/doc/blkiomon.8
index aa5ece2..34fbba8 100644
--- a/doc/blkiomon.8
+++ b/doc/blkiomon.8
@@ -7,7 +7,7 @@ blkiomon \- monitor block device I/O based o blktrace data
 
 .SH SYNOPSIS
 .B blkiomon \-I \fIinterval\fR [ \-h \fIfile\fR ] [ \-b \fIfile\fR ]
-[ \-D \fIfile\fR ] [ \-Q \fIpath_name\fR
+[ \-d \fIfile\fR ] [ \-D \fIfile\fR ] [ \-Q \fIpath_name\fR
 \-q \fImsg_queue_id\fR \-m \fImsg_id\fR ] [ \-V ]
 .br
 
@@ -50,6 +50,13 @@ Human-readable output file. Use '\-' for stdout.
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
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 11dab65..9193dbe 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -58,6 +58,26 @@ option.
 
 
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
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 50b3a62..b5e69b7 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -105,23 +105,59 @@ Adds \fIdev\fR as a device to trace
 
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
 
 This only works when supplying a single device, or when piping the output
 via "-o -" with multiple devices.
@@ -134,9 +170,17 @@ via "-o -" with multiple devices.
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
 
@@ -175,6 +219,8 @@ line options.
 \fIwrite\fR: write traces
 .br
 \fInotify\fR: trace messages
+.br
+\fIdrv_data\fR: additional driver specific trace
 .RE
 
 
diff --git a/doc/btrecord.8 b/doc/btrecord.8
index c0655ab..dd92396 100644
--- a/doc/btrecord.8
+++ b/doc/btrecord.8
@@ -107,7 +107,7 @@ Show version number and exit.
 
 \-m <\fInanoseconds\fR>
 .br
-\-\-input\-base=<\fInanoseconds\fR>
+\-\-max\-bunch\-time=<\fInanoseconds\fR>
 .RS
 The \fI\-m\fR option requires a single parameter which specifies an
 amount of time (in nanoseconds) to include in any one bunch of IOs that
diff --git a/doc/btreplay.8 b/doc/btreplay.8
index 1efcd0d..118dc10 100644
--- a/doc/btreplay.8
+++ b/doc/btreplay.8
@@ -168,6 +168,13 @@ When specified on the command line, all pre-bunch stall indicators will be
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
diff --git a/doc/btt.1 b/doc/btt.1
index 60d28ac..28cf912 100644
--- a/doc/btt.1
+++ b/doc/btt.1
@@ -30,6 +30,8 @@ btt \- analyse block i/o traces produces by blktrace
 .br
 [ \-L <\fIfreq\fR>        | \-\-periodic\-latencies=<\fIfreq\fR> ]
 .br
+[ \-m <\fIoutput name\fR> | \-\-seeks\-per\-second=<\fIoutput name\fR> ]
+.br
 [ \-M <\fIdev map\fR>     | \-\-dev\-maps=<\fIdev map\fR>
 .br
 [ \-o <\fIoutput name\fR> | \-\-output\-file=<\fIoutput name\fR> ]
@@ -58,6 +60,8 @@ btt \- analyse block i/o traces produces by blktrace
 .br
 [ \-V               | \-\-version ]
 .br
+[ \-X               | \-\-easy\-parse\-avgs ]
+.br
 [ \-z <\fIoutput name\fR> | \-\-q2d\-latencies=<\fIoutput name\fR> ]
 .br
 [ \-Z               | \-\-do\-active ]
@@ -201,6 +205,15 @@ Q2C and D2C latencies. The frequency specified will regulate how often
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
@@ -332,6 +345,14 @@ Shows the version of btt.
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
