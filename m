From: Eric Sandeen <sandeen@redhat.com>
Date: Mon, 04 May 2009 20:16:31 +0000
Subject: [PATCH] more manpage fixups
Message-Id: <49FF4D1F.3050205@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Fix various typos & inconsistencies in man pages.

I think the manpages could use a general tidy-up, but this
mostly fixes things which I'd consider "errors" vs. style 
issues.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/doc/blkiomon.8 b/doc/blkiomon.8
index 54ff099..0bc109c 100644
--- a/doc/blkiomon.8
+++ b/doc/blkiomon.8
@@ -13,7 +13,7 @@ blkiomon \- monitor block device I/O based o blktrace data
 
 
 .SH DESCRIPTION
-blkiomon is a block device I/O monitor. It periodically generates per device
+blkiomon is a block device I/O monitor. It periodically generates per-device
 request size and request latency statistics from blktrace data. It provides
 histograms as well as data that can be used to calculate min, max, average
 and variance. For this purpose, it consumes D and C traces read from stdin.
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index fde29d0..11dab65 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -1,4 +1,4 @@
-.TH BLKTPARSE 1 "March  6, 2007" "blktrace git\-20070306202522" ""
+.TH BLKPARSE 1 "March  6, 2007" "blktrace git\-20070306202522" ""
 
 
 .SH NAME
@@ -94,13 +94,6 @@ event type. The single\-character \fItyp\fR field is one of the
 action specifiers described in ACTION IDENTIFIERS.
 .RE
 
-\-m
-.br
-\-\-missing
-.RS
-Print missing entries
-.RE
-
 \-M
 .br
 \-\-no-msgs
diff --git a/doc/blkrawverify.1 b/doc/blkrawverify.1
index 1c52292..9d3b4bc 100644
--- a/doc/blkrawverify.1
+++ b/doc/blkrawverify.1
@@ -6,7 +6,7 @@ blkrawverify \- verifies an output file produced by blkparse
 
 
 .SH SYNOPSIS
-.B verify_blkparse <\fIdev\fR> [<\fIdev\fR>...]
+.B blkrawverify <\fIdev\fR> [<\fIdev\fR>...]
 .br
 
 
diff --git a/doc/bno_plot.1 b/doc/bno_plot.1
index 565c2ba..bd7eb3c 100644
--- a/doc/bno_plot.1
+++ b/doc/bno_plot.1
@@ -1,4 +1,4 @@
-.TH BTT 1 "February 22, 2007" "blktrace git\-20080213182518" ""
+.TH BNO_PLOT 1 "February 22, 2007" "blktrace git\-20080213182518" ""
 
 
 .SH NAME
diff --git a/doc/btrace.8 b/doc/btrace.8
index dc99a59..1e6c06d 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -2,19 +2,19 @@
 
 
 .SH NAME
-btrace \- verifies an output file produced by blkparse
+btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B Usage: btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR]  [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR]  [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
 .SH DESCRIPTION
 
-The \fIbtrace\fR script provides a quick and easy way to to live tracing of
-block devices.  All it does is calling \fIblktrace\fR on the specified devices
-and piping its output through \fIblkparse\fR for formatting.  See blktrace (8)
+The \fIbtrace\fR script provides a quick and easy way to do live tracing of
+block devices.  It calls \fIblktrace\fR on the specified devices
+and pipes the output through \fIblkparse\fR for formatting.  See blktrace (8)
 for more in-depth information about how \fIblktrace\fR works.  
 
 .SH OPTIONS
@@ -25,7 +25,7 @@ Displays data sorted by program (see \fIblkparse\fR (1)).
 
 .HP 4
 .B \-t 
-Display time deltas per IO (see \fIblkparse\fR (1)).
+Displays time deltas per IO (see \fIblkparse\fR (1)).
 
 .HP 4
 .B \-w \fIN\fR
@@ -42,7 +42,7 @@ Specifies buffer size for event extraction (scaled by 1024) (see
 
 .HP 4
 .B \-a <\fItrace\fR>...
-Add mask to current filter (see \fIblktrace\fR (8)).
+Adds mask to current filter (see \fIblktrace\fR (8)).
 
 .HP 4
 .B <\fIdev\fR>
@@ -52,7 +52,7 @@ Specifies the device to trace.
 .SH EXAMPLE
 Simply running
 
-    % blktrace /dev/sda
+    % btrace /dev/sda
 
 will show a trace of the device \fI/dev/sda\fR.
 
diff --git a/doc/btrecord.8 b/doc/btrecord.8
index b4318ae..c0655ab 100644
--- a/doc/btrecord.8
+++ b/doc/btrecord.8
@@ -1,4 +1,4 @@
-.TH BTREPLAY 8 "December  8, 2007" "blktrace git\-20071207142532" ""
+.TH BTRECORD 8 "December  8, 2007" "blktrace git\-20071207142532" ""
 
 
 .SH NAME
@@ -105,16 +105,16 @@ Show help and exit.
 Show version number and exit.
 .RE
 
-\-m <\fInanoceconds\fR>
+\-m <\fInanoseconds\fR>
 .br
-\-\-input\-base=<\fInanoceconds\fR>
+\-\-input\-base=<\fInanoseconds\fR>
 .RS
 The \fI\-m\fR option requires a single parameter which specifies an
 amount of time (in nanoseconds) to include in any one bunch of IOs that
 are to be processed. The smaller the value, the smaller the number of
 IOs processed at one time \(em perhaps yielding in more realistic replay.
 However, after a certain point the amount of overhead per bunch may result
-in additonal real replay time, thus yielding less accurate replay times.
+in additional real replay time, thus yielding less accurate replay times.
 .P
 The default value is 10,000,000 nanoseconds (10 milliseconds).
 .RE
@@ -167,7 +167,7 @@ sdab:3: 474773 pkts (tot), 117849 pkts (replay), 69572 bunches, 1.7 pkts/bunch
 .P
 The meaning of the columns is:
 .IP 1. 3
-  The first field contains the device name and CPU identrifer. Thus:
+  The first field contains the device name and CPU identifier. Thus:
   \fIsdab:0:\fR means the device \fIsdab\fR and traces on CPU 0. 
 .IP 2.
   The second field contains the total number of packets processed for each
diff --git a/doc/btreplay.8 b/doc/btreplay.8
index 37e9777..1efcd0d 100644
--- a/doc/btreplay.8
+++ b/doc/btreplay.8
@@ -6,9 +6,7 @@ btreplay \- recreate IO loads recorded by blktrace
 
 
 .SH SYNOPSIS
-.B Usage: 
-
-btreplay [ \fIoptions\fR ] <\fIdev\fR...>
+.B btreplay [ \fIoptions\fR ] <\fIdev\fR...>
 
 
 .SH DESCRIPTION
@@ -128,7 +126,7 @@ to run through the input files. The default value is 1
 \-\-map\-devs=<\fIfilename\fR>
 .RS
 Specify device mappings.  
-This option requires a single paramter which specifies the name of a
+This option requires a single parameter which specifies the name of a
 file contain device mappings. The file must be very simply managed, with
 just two pieces of data per line:
 
@@ -199,8 +197,8 @@ Show version number and exit.
 \-\-write-enable
 .RS
 Enable writing during replay.
-As a precautionary measure, by default \texttt{btreplay} will not
-process \fBwrite requests. In order to enable \fIbtreplay\fR to
+As a precautionary measure, by default \fIbtreplay\fR will not
+process \fBwrite\fR requests. In order to enable \fIbtreplay\fR to
 actually \fBwrite\fR to devices one must explicitly specify the
 \fI\-W\fR option.
 .RE
diff --git a/doc/btt.1 b/doc/btt.1
index 45d6c0c..b9c9ee7 100644
--- a/doc/btt.1
+++ b/doc/btt.1
@@ -7,6 +7,7 @@ btt \- analyse block i/o traces produces by blktrace
 
 .SH SYNOPSIS
 .B btt 
+.br
 [ \-a               | \-\-seek\-absolute ]
 .br
 [ \-A               | \-\-all\-data ]
@@ -74,7 +75,7 @@ of time while Q events are being produced), C activity (likewise for
 command completions), and etc.
 
 Included with the distribution is a simple 3D plotting utility,
-\fIbno_plot\fR, which can plot the block numbers btss outputs if the \fI-B\fR
+\fIbno_plot\fR, which can plot the block numbers btt outputs if the \fI-B\fR
 option is specified. The display will display each IO generated, with the time
 (seconds) along the X-axis, the block number (start) along the Y-axis and the
 number of blocks transferred in the IO represented along the Z-axis.

