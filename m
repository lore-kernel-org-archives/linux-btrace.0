From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:26 +0000
Subject: [PATCH 19/31] README: complete tool overview
Message-Id: <20180427130738.102806-20-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 README | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/README b/README
index d7d1fbfd670c..2a3959cea2a9 100644
--- a/README
+++ b/README
@@ -70,6 +70,9 @@ $ blktrace -d <dev> [ -r debug_path ] [ -o output ] [ -k ] [ -w time ]
 	-s Disable network client use of sendfile() to transfer data
 	-V Print program version info.
 
+	Records the I/O event trace information from the kernel for
+	specific block device(s) to file(s).
+
 $ blkparse -i <input> [ -o <output> ] [ -b rb_batch ] [ -s ] [ -t ] [ -q ]
 		      [ -w start:stop ] [ -f output format ] [ -F format spec ]
 		      [ -d <binary> ]
@@ -130,6 +133,12 @@ $ blkparse -i <input> [ -o <output> ] [ -b rb_batch ] [ -s ] [ -t ] [ -q ]
 	-v More verbose for marginal errors.
 	-V Print program version info.
 
+	The blkparse utility attempts to combine streams of events for
+	various devices on various CPUs, and produce a formatted
+	output of the event information. Specifically, it takes the
+	(machine-readable) output of the blktrace utility and convert
+	it to a nicely formatted and human-readable form.
+
 $ verify_blkparse filename
 
 	Verifies an output file from blkparse. All it does is check if
@@ -145,6 +154,52 @@ $ blkrawverify <dev> [<dev>...]
 
 	Errors found will be tracked in <dev>.verify.out.
 
+$ btrecord
+$ btreplay
+
+	The btrecord and btreplay tools provide the ability to record
+	and replay IOs captured by the blktrace utility. Attempts are
+	made to maintain ordering, CPU mappings and time-separation of
+	IOs.
+
+$ btt
+
+	btt takes binary dump data from blkparse, and analyse the
+	events, producing a series of output from the analysis. It
+	also builds .dat files containing "range data" -- showing
+	things like Q activity (periods of time while Q events are
+	being produced), C activity (likewise for command
+	completions), and etc.
+
+$ iowatcher
+
+	iowatcher graphs the results of a blktrace run. It can graph
+	the result of an existing blktrace, start a new blktrace, or
+	start a new blktrace and a benchmark run. It can then create
+	an image or movie of the IO from a given trace. iowatcher can
+	produce either SVG files or movies in mp4 format (with ffmpeg)
+	or ogg format (with png2theora).
+
+$ bno_plot.py
+
+	Utilizes gnuplot to generate a 3D plot of the block number
+	output from btt.
+
+$ blkiomon
+
+	blkiomon is a block device I/O monitor. It periodically
+	generates per-device request size and request latency
+	statistics from blktrace data. It provides histograms as well
+	as data that can be used to calculate min, max, average and
+	variance. For this purpose, it consumes D and C traces read
+	from stdin. Note, that this doesn’t work for logical volumes,
+	as high-level drivers don’t see the completion of the events
+	(C).
+
+$ btrace <device>
+
+	Short for: blktrace -d <device> -o - | blkparse -i -
+
 If you want to do live tracing, you can pipe the data between blktrace
 and blkparse:
 
-- 
2.14.2

