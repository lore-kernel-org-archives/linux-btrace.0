From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:16 +0000
Subject: [PATCH 09/31] blktrace: man: fix typos and formatting, complete and update information
Message-Id: <20180427130738.102806-10-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

complete synopsis with missing options

The indentation of 2n seems not enough for print output (PS/PDF)
and it generates the bullet dash on a separate line,
so just use the default indentation which just works.

add a bit more info about debugfs subdir structure when tracing

".blktrace." in output file names is not a replaceable

typo: invocation the kill (1) => invocation of the kill (1)

-I|--input-devs: content format of file given as option argument

-o|--output:
* is for output not input files
* single-dev/pipe-output applies here, not to -D|--output-dir

--output-dir option description: argument is <dir> not <file>

update filter masks including history:
* mention what fs stands for
* memory hook "dispatch" for issue to driver (D)
* "read traces" and "write traces" sounded to me a bit like it would
  read/write traces while it represents a trace for a read/write request
* added missing readahead and metadata

distinguish vm as virtual memory from potential misinterpretation such as
virtual machine

typo: can be achieve => can be achieved

examples: fix output file names and mention per CPU fact

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/blktrace.8 | 75 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 820b03aa4c16..67ea3ddfaedf 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -6,7 +6,23 @@ blktrace \- generate traces of the i/o traffic on block devices
 
 
 .SH SYNOPSIS
-.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
+.B blktrace
+.RI /dev/ "dev ..." " |"
+.BR "\-d " /dev/\fIdev\fR
+[ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ]
+.RB [ \-b
+.IR size ]
+.RB [ \-I
+.IR file ]
+.RB [ \-n
+.IR num-sub ]
+.RB [ \-h
+.IR host ]
+.RB [ \-p
+.IR port ]
+.RB [ \-D
+.IR dir ]
+.RB [ \-lsvV ]
 .br
 
 
@@ -23,15 +39,16 @@ the relaying through the debug file system). Some background details
 concerning the run\-time behaviour of blktrace will help to understand some
 of the more arcane command line options:
 
-.TP 2
+.TP
 \-
 blktrace receives data from the kernel in buffers passed up through the
-debug file system (relay). Each device being traced has a file created in
+debug file system (relay). Each device being traced has
+a directory with files created under the \fIblock/\fR directory in
 the mounted directory for the debugfs, which defaults to 
 \fI/sys/kernel/debug\fR \-\- this can be overridden with the \fB\-r\fR command
 line argument.
 
-.TP 2
+.TP
 \-
 blktrace defaults to collecting all events that can be traced. To
 limit the events being captured, you can specify one or more filter masks
@@ -41,33 +58,33 @@ Alternatively, one may specify the entire mask utilising a hexadecimal
 value that is version\-specific. (Requires understanding of the internal
 representation of the filter mask.)
 
-.TP 2
+.TP
 \-
 As noted above, the events are passed up via a series of buffers stored
 into debugfs files. The size and number of buffers can be specified via
 the \fB\-b\fR and \fB\-n\fR arguments respectively.
 
-.TP 2
+.TP
 \-
 blktrace stores the extracted data into files stored in the
 local directory. The format of the file names is (by default)
-\fBdevice\fR.\fBblktrace\fR.\fBcpu\fR, where \fBdevice\fR is the base
+\fBdevice\fR.blktrace.\fBcpu\fR, where \fBdevice\fR is the base
 device name (e.g, if we are tracing /dev/sda, the base device name would
 be \fBsda\fR); and \fBcpu\fR identifies a CPU for the event stream.
 
 The \fBdevice\fR portion of the event file name can be changed via
 the \fB\-o\fR option.
 
-.TP 2
+.TP
 \-
 blktrace may also be run concurrently with blkparse to produce
 \fBlive\fR output \-\- to do this specify \fB\-o \-\fR for blktrace.
 
-.TP 2
+.TP
 \- 
 The default behaviour for blktrace is to run forever until explicitly
 killed by the user (via a control-C, or sending SIGINT signal to the
-process via invocation the kill (1) utility). Also you can specify a
+process via invocation of the kill (1) utility). Also you can specify a
 run-time duration for blktrace via the \fB\-w\fR option -- then
 blktrace will run for the specified number of seconds, and then halt.
 
@@ -96,11 +113,12 @@ Specifies buffer size for event extraction (scaled by 1024). The default
 buffer size is 512KiB.
 .RE
 
-\-d \fIdev\fR
+\-d /dev/\fIdev\fR
 .br
-\-\-dev=\fIdev\fR 
+\-\-dev=/dev/\fIdev\fR
 .RS
-Adds \fIdev\fR as a device to trace  
+Adds /dev/\fIdev\fR as a device to trace. You have to specify a path, blktrace
+does not automatically search for device names under the /dev/ directory.
 .RE
 
 \-I \fIfile\fR
@@ -108,6 +126,7 @@ Adds \fIdev\fR as a device to trace
 \-\-input\-devs=\fIfile\fR
 .RS
 Adds the devices found in \fIfile\fR as devices to trace
+(one device per line)
 .RE
 
 \-n \fInum\-sub\fR 
@@ -149,18 +168,16 @@ Make the network client NOT use sendfile() to transfer data
 .br
 \-\-output=\fIbasename\fR
 .RS
-Specifies base name for input files. Default is device.blktrace.cpu.
+Specifies base name for output files. Default is device.blktrace.cpu.
 Specifying -o - runs in live mode with blkparse (writing data to standard out).
+Otherwise only supported with a single device.
 .RE
 
 \-D \fIdir\fR
 .br
 \-\-output\-dir=\fIdir\fR
 .RS
-Prepend \fIfile\fR to output file name(s)
-
-This only works when supplying a single device, or when piping the output
-via "-o -" with multiple devices.
+Prepend \fIdir\fR to output file name(s)
 .RE
 
 \-r \fIrel-path\fR
@@ -204,21 +221,25 @@ line options.
 .br
 \fIdiscard\fR: discard / trim traces
 .br
-\fIfs\fR: requests 
+\fIfs\fR: file system requests
 .br
-\fIissue\fR: issued to driver 
+\fIissue\fR: issued / dispatched to driver
 .br
 \fIpc\fR: packet command events
 .br
 \fIqueue\fR: queue operations 
 .br
-\fIread\fR: read traces 
+\fIread\fR: read requests
 .br
 \fIrequeue\fR: requeue operations 
 .br
 \fIsync\fR: synchronous attribute 
 .br
-\fIwrite\fR: write traces
+\fIwrite\fR: write requests
+.br
+\fIahead\fR: readahead
+.br
+\fImeta\fR: metadata
 .br
 \fInotify\fR: trace messages
 .br
@@ -232,7 +253,8 @@ and SCSI commands. The former are dubbed \fBfs\fR requests, the latter
 \fBpc\fR requests. File system requests are normal read/write operations, i.e.
 any type of read or write from a specific disk location at a given size. These
 requests typically originate from a user process, but they may also be
-initiated by the vm flushing dirty data to disk or the file system syncing a
+initiated by the vm (virtual memory)
+flushing dirty data to disk or the file system syncing a
 super or journal block to disk. \fBpc\fR requests are SCSI commands. blktrace
 sends the command data block as a payload so that blkparse can decode it.
 
@@ -243,7 +265,7 @@ readable form, use the following command:
 
     % blktrace \-d /dev/sda \-o \- | blkparse \-i \-
 
-This same behaviour can be achieve with the convenience script \fIbtrace\fR.
+This same behaviour can be achieved with the convenience script \fIbtrace\fR.
 The command
 
     % btrace /dev/sda
@@ -257,8 +279,9 @@ To trace the i/o on a device and save the output for later processing with
     % blktrace /dev/sda /dev/sdb
 
 This will trace i/o on the devices \fI/dev/sda\fR and \fI/dev/sdb\fR and save
-the recorded information in the files \fIsda\fR and \fIsdb\fR in the current
-directory, for the two different devices, respectively.  This trace
+the recorded information in the files \fIsda\fR.blktrace.* and
+\fIsdb\fR.blktrace.* in the current
+directory, for the two different devices and per CPU, respectively.  This trace
 information can later be parsed by the \fIblkparse\fR utility:
 
     % blkparse sda sdb
-- 
2.14.2

