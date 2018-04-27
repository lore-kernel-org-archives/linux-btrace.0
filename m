From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:25 +0000
Subject: [PATCH 18/31] blktrace: doc: alternatives to blktrace traditional tooling
Message-Id: <20180427130738.102806-19-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 doc/blktrace.tex | 397 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 397 insertions(+)

diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 6307b9343c44..b5fc769ab891 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -256,6 +256,7 @@ You can use SCSI tracepoints instead
 Correlation between blktrace and SCSI tracing:
 A blktrace issue event (D) causes a scsi\_dispatch\_cmd\_start event;
 a scsi\_dispatch\_cmd\_done tracepoint causes a blktrace complete event (C).
+See also Sec.~\ref{sec:form-text-outp} and Sec.~\ref{sec:block-trace-events}.
 
 \subsection{blktrace -- post-processing}
 \label{sec:blktrace-post}
@@ -370,6 +371,399 @@ Total (65,160):
 ...
 \end{verbatim}
 
+\subsection{blktrace -- alternative user interfaces via ftrace}
+\label{sec:blktrace-ftrace}
+
+\subsubsection{Ftrace blk tracer}
+
+As a (mutually exclusive) alternative to the IOCTLs used by
+traditional blktrace, there is also a user interface\footnote{ v2.6.30
+  commit c71a89615411 (``blktrace: add ftrace plugin'')} based on
+sysfs and debugfs / tracefs.
+
+To use this, switch the current tracer of the ftrace kernel tracing
+infrastructure to the ``blk'' tracer:
+\begin{verbatim}
+echo blk > /sys/kernel/debug/tracing/current_tracer
+\end{verbatim}
+
+The internal trace record format is similar to traditional blktrace.
+But now the traced io actions no longer go to the relay kernel-user
+interface but instead to the kernel ftrace buffer. This means, the
+blktrace user space tool cannot record traces anymore.
+
+Suppose we want to trace block events on the first partition of a SCSI
+disk block device sda1. Things work likewise for the full block device sda.
+If the block device is not open by any means, you
+might get an error ENXIO ``No such device or address'' on trying to access
+the sysfs control interface. ``Open'' includes but is not limited to:
+filesystem in that block device mounted, block device opened directly,
+block device being part of a device-mapper (dm) table
+or of a multi-device (md) such as software RAID. For our examples with a
+block device, we use a workaround to temporarily open the device
+by means of input redirection to an unused file descriptor (42)
+limited in scope by the subshell opened by the surrounding parentheses.
+
+By default things are disabled:
+\begin{verbatim}
+% ( exec 42< /dev/sda1 ; tail /sys/block/sda/sda1/trace/* )
+=> /sys/block/sda/sda1/trace/act_mask <=
+disabled
+=> /sys/block/sda/sda1/trace/enable <=
+0
+=> /sys/block/sda/sda1/trace/end_lba <=
+disabled
+=> /sys/block/sda/sda1/trace/pid <=
+disabled
+=> /sys/block/sda/sda1/trace/start_lba <=
+disabled
+\end{verbatim}
+
+Enable full tracing for the partition:
+\begin{verbatim}
+% ( exec 42< /dev/sda1 ; echo 1 > /sys/block/sda/sda1/trace/enable )
+\end{verbatim}
+
+This enabled all block io actions, and set start and end LBA to the partition:
+\begin{verbatim}
+% ( exec 42< /dev/sda1 ; tail /sys/block/sda/sda1/trace/* )
+=> /sys/block/sda/sda1/trace/act_mask <=
+read,write,flush,sync,queue,requeue,issue,complete,fs,pc,notify,\
+ahead,meta,discard,drv_data,fua
+=> /sys/block/sda/sda1/trace/enable <=
+1
+=> /sys/block/sda/sda1/trace/end_lba <=
+1050624
+=> /sys/block/sda/sda1/trace/pid <=
+0
+=> /sys/block/sda/sda1/trace/start_lba <=
+2048
+\end{verbatim}
+Optionally writing to the sysfs attributes act\_mask, start\_lba,
+end\_lba, and pid modifies the filters.
+
+Include trace events for the SCSI command (cf.\ Sec.~\ref{sec:pc-blktrace}):
+\begin{verbatim}
+% lsscsi
+[0:0:0:1083850880]disk    ...      ...              ...   /dev/sda
+% echo "host_no=0 && channel=0 && id=0 && lun=1083850880" > \
+  /sys/kernel/debug/tracing/events/scsi/filter
+% echo 1 > /sys/kernel/debug/tracing/events/scsi/scsi_dispatch_cmd_start/enable
+% echo 1 > /sys/kernel/debug/tracing/events/scsi/scsi_dispatch_cmd_done/enable
+\end{verbatim}
+
+\begin{verbatim}
+% dd if=/dev/sda1 of=/dev/null iflag=direct count=1
+\end{verbatim}
+
+\paragraph{Formatted text output}
+\label{sec:form-text-outp}
+
+By default, the output uses the same prefix as ftrace up to and
+including the timestamp:
+
+{\footnotesize
+\begin{verbatim}
+% cat /sys/kernel/debug/tracing/trace
+# tracer: blk
+#
+              dd-15122 [001] d..1 112569.703948:   8,1    A   R 2048 + 1 <- (8,1) 0
+              dd-15122 [001] d..1 112569.703963:   8,1    Q   R 2048 + 1 [dd]
+              dd-15122 [001] d..1 112569.703981:   8,1    G   R 2048 + 1 [dd]
+              dd-15122 [001] d..2 112569.703984:   8,1    I   R 2048 + 1 [dd]
+              dd-15122 [001] d..2 112569.703987:   8,1    D   R 2048 + 1 [dd]
+              dd-15122 [001] .... 112569.704011: scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=SCSI_PROT_NORMAL \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00)
+          <idle>-0     [000] d.s2 112569.704236: scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=SCSI_PROT_NORMAL \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+          <idle>-0     [000] d.s2 112569.704249:   8,1    C   R 2048 + 1 [0]
+\end{verbatim}
+}
+This output format allows to use other ftrace functionality and
+options such as stacktrace.
+
+The equivalent of a manual blktrace message (see Sec.~\ref{sec:message})
+is to use the global ftrace marker functionality:
+
+{\footnotesize
+\begin{verbatim}
+% echo "hello world" > /sys/kernel/debug/tracing/trace_marker
+% cat /sys/kernel/debug/tracing/trace
+           <...>-11531 [002] .... 99702.761307: tracing_mark_write: hello world
+\end{verbatim}
+}
+
+To get an output format similar to the blkparse user space tool
+default output, enable the blk tracer option blk\_classic:
+\begin{verbatim}
+% echo blk_classic > /sys/kernel/debug/tracing/trace_options
+\end{verbatim}
+
+\begin{verbatim}
+% cat /sys/kernel/debug/tracing/trace
+# tracer: blk
+#
+# DEV   CPU TIMESTAMP     PID ACT FLG
+#  |     |     |           |   |   |
+  8,1    1 112569.703948210 15122  A   R 2048 + 1 <- (8,1) 0
+  8,1    1 112569.703962961 15122  Q   R 2048 + 1 [dd]
+  8,1    1 112569.703980542 15122  G   R 2048 + 1 [dd]
+  8,1    1 112569.703983690 15122  I   R 2048 + 1 [dd]
+  8,1    1 112569.703986659 15122  D   R 2048 + 1 [dd]
+  0,0    1 112569.704011337 15122  U   R [dd] 2882303761651335168
+Unknown action 28
+  8,1    0 112569.704248800     0  C   R 2048 + 1 [0]
+\end{verbatim}
+Currently, blk\_classic does not support sequence numbers
+(Sec.~\ref{sec:record}).
+
+If you enable other ftrace options such as SCSI trace events together
+with blk\_classic, you can get broken output or ``Unknown action
+\dots'' in the formatted text output for any event which is not
+blktrace. The ftrace buffer still contains the other events, and
+disabling blk\_classic formats these events again.
+
+\paragraph{Binary output in blktrace format}
+
+To support post-processing traces with the existing blktrace tools
+such as blkparse, the blk tracer can generate binary output in the
+format of traditional ``blktrace -o -'' (see
+Sec.~\ref{sec:live-blktrace}) on the fly when reading the ftrace
+buffer \footnote{v2.6.30 commit 08a06b83ff8b (``blkftrace: binary
+  tracing, synthesizing old format'')\newline v2.6.31 commit
+  f3948f8857ef (``blktrace: fix context-info when mixed-using blk
+  tracer and trace events'')}.
+
+\begin{verbatim}
+% echo nocontext-info > /sys/kernel/debug/tracing/trace_options
+% echo bin > /sys/kernel/debug/tracing/trace_options
+% echo blk > /sys/kernel/debug/tracing/current_tracer
+% cat /sys/kernel/debug/tracing/trace_pipe | blkparse -q -i -
+\end{verbatim}
+
+Here we intentionally do not read from trace but trace\_pipe because
+the former contains two header lines which blkparse does not expect:
+\begin{verbatim}
+# tracer: blk
+#
+\end{verbatim}
+
+\begin{verbatim}
+% dd if=/dev/sda1 iflag=direct of=/dev/null count=1
+\end{verbatim}
+
+Generating I/O causes above blkparse to output (might be batched and delayed):
+\begin{verbatim}
+  8,0    0        0     0.000000000 14607  A   R 2048 + 1 <- (8,1) 0
+  8,1    0        0     0.000009762 14607  Q   R 2048 + 1 [(null)]
+  8,1    0        0     0.000020908 14607  G   R 2048 + 1 [(null)]
+  8,1    0        0     0.000023119 14607  I   R 2048 + 1 [(null)]
+  8,1    0        0     0.000025013 14607  D   R 2048 + 1 [(null)]
+  8,1    0        0     0.000303335     0  C   R 2048 + 1 [0]
+\end{verbatim}
+
+Currently, the synthesized binary blk trace does not support: sequence
+numbers (Sec.~\ref{sec:record}), calendar time
+(Sec.~\ref{sec:timestamp}), process mapping
+(Sec.~\ref{sec:process-mapping}).
+
+\subsubsection{Block trace events}
+\label{sec:block-trace-events}
+
+Since kernel v2.6.30 and v2.6.31\footnote{2.6.30 commit 5f3ea37c7716
+  (``blktrace: port to tracepoints'')\newline v2.6.31 commit
+  55782138e47d (``tracing/events: convert block trace points to
+  TRACE\_EVENT()'')}, the traditional blktrace shares the same trigger
+infrastructure with the new block trace events. So the following new
+block trace events provide the same information:
+
+\begin{verbatim}
+% ls -1 /sys/kernel/debug/tracing/events/block/
+block_bio_backmerge   block_bio_remap     block_rq_insert   block_split
+block_bio_bounce      block_dirty_buffer  block_rq_issue    block_touch_buffer
+block_bio_complete    block_getrq         block_rq_remap    block_unplug
+block_bio_frontmerge  block_plug          block_rq_requeue
+block_bio_queue       block_rq_complete   block_sleeprq
+\end{verbatim}
+
+They use their own internal trace record format independently of
+traditional blktrace, and both can run in parallel.
+
+Block trace events can be combined with an arbitrary ftrace tracer,
+such as ``function'', as they do not need the ``blk'' tracer. They can
+also be combined with other ftrace functionality or options.
+
+To trace all io actions incl.\ SCSI command (cf.\
+Sec.~\ref{sec:pc-blktrace}) on SCSI disk sda and its partitions, we
+can filter on the device major (8) and its minors for the block events
+as well as the SCSI device HCTL identifiers for the SCSI events.
+Currently there are block events, where the device major and minor are
+always zero, e.g.\ some empty requests (RWBS value `N'), so we also
+match zero in the filter:
+\begin{verbatim}
+% lsscsi -d
+[0:0:0:1083850880]disk    ...      ...              ...   /dev/sda [8:0]
+% echo "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" > \
+  /sys/kernel/debug/tracing/events/block/filter
+% echo 1 > /sys/kernel/debug/tracing/events/block/enable
+% echo "host_no=0 && channel=0 && id=0 && lun=1083850880" > \
+  /sys/kernel/debug/tracing/events/scsi/filter
+% echo 1 > /sys/kernel/debug/tracing/events/scsi/scsi_dispatch_cmd_start/enable
+% echo 1 > /sys/kernel/debug/tracing/events/scsi/scsi_dispatch_cmd_done/enable
+\end{verbatim}
+See the kernel ftrace documentation for more details.
+
+\begin{verbatim}
+% dd if=/dev/sda1 iflag=direct of=/dev/null count=1
+\end{verbatim}
+
+{\footnotesize
+\begin{verbatim}
+% cat /sys/kernel/debug/tracing/trace
+              dd-1099  [003] ....   384.607936: block_bio_remap: 8,0 R 2048 + 1 <- (8,1) 0
+              dd-1099  [003] ....   384.607947: block_bio_queue: 8,0 R 2048 + 1 [dd]
+              dd-1099  [003] ....   384.607960: block_getrq: 8,0 R 2048 + 1 [dd]
+              dd-1099  [003] d..1   384.607964: block_rq_insert: 8,0 R 512 () 2048 + 1 [dd]
+              dd-1099  [003] d..1   384.607966: block_rq_issue: 8,0 R 512 () 2048 + 1 [dd]
+              dd-1099  [003] ....   384.607982: scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=SCSI_PROT_NORMAL \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00)
+          <idle>-0     [002] d.s2   384.608185: scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=SCSI_PROT_NORMAL \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+          <idle>-0     [002] ..s1   384.608195: block_rq_complete: 8,0 R () 2048 + 1 [0]
+     kworker/3:2-350   [003] ....   384.608826: block_getrq: 0,0 R 0 + 0 [kworker/3:2]
+     kworker/3:2-350   [003] d..1   384.608829: block_rq_insert: 0,0 N 0 () 0 + 0 [kworker/3:2]
+     kworker/3:2-350   [003] d..1   384.608830: block_rq_issue: 0,0 N 0 () 0 + 0 [kworker/3:2]
+     kworker/3:2-350   [003] ....   384.608833: scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL \
+cmnd=(TEST_UNIT_READY - raw  00 00 00 00 00)
+          <idle>-0     [001] d.s2   384.608949: scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=0 prot_sgl=0 prot_op=SCSI_PROT_NORMAL \
+cmnd=(TEST_UNIT_READY - raw  00 00 00 00 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+          <idle>-0     [001] ..s1   384.608959: block_rq_complete: 0,0 N () 18446744073709551615 + 0 [0]
+\end{verbatim}
+}
+
+To trace and efficiently stream more events into a default output file
+trace.dat than fit into the ftrace buffer\footnote{
+  \url{git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git}}
+(cf.\ the blktrace user space tool in Sec.~\ref{sec:blktrace-post}):
+\begin{verbatim}
+% trace-cmd record -e block \
+  -f "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e scsi_dispatch_cmd_start \
+  -f "host_no=0 && channel=0 && id=0 && lun=1083850880" \
+  -e scsi_dispatch_cmd_done \
+  -f "host_no=0 && channel=0 && id=0 && lun=1083850880"
+Hit Ctrl^C to stop recording
+\end{verbatim}
+``trace-cmd record'' also has an option -{}-date for calendar time stamps
+(cf.\ Sec.~\ref{sec:timestamp}).
+
+Alternatively, you can use the perf tool\footnote{
+  \url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf}}
+instead of trace-cmd:
+\begin{verbatim}
+
+% perf record -a -e block:block_plug -e block:block_unplug \
+  -e "block:block_b*" --filter "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e "block:block_d*" --filter "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e "block:block_g*" --filter "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e "block:block_r*" --filter "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e "block:block_s*" --filter "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e "block:block_t*" --filter "(dev >= 0x800000 && dev <= 0x80000f) || dev = 0" \
+  -e scsi:scsi_dispatch_cmd_start \
+  --filter "host_no=0 && channel=0 && id=0 && lun=1083850880" \
+  -e scsi:scsi_dispatch_cmd_done \
+  --filter "host_no=0 && channel=0 && id=0 && lun=1083850880"
+\end{verbatim}
+Since we cannot specify ``block'' as subsystem but have to qualify individual
+events (optionally with wildcards), and since the (un)plug events have no
+``dev'' field to filter, we need a longer event and filter option list.
+
+Perform I/O in parallel to the recording:
+\begin{verbatim}
+% dd if=/dev/sda1 iflag=direct of=/dev/null count=1
+\end{verbatim}
+
+Stop the recording.
+
+Format the recorded report (needs at least trace-cmd-v2.4 to fully
+decode the SCSI trace events\footnote{trace-cmd-v2.4 commit
+  3338f3c3b7c6 (``tools lib traceevent: Add scsi plugin'')}):
+
+{\footnotesize
+\begin{verbatim}
+% trace-cmd report -l
+CPU 3 is empty
+cpus=4
+              dd-1138  [000]   562.064728: block_bio_remap:      8,0 R 2048 + 1 <- (8,1) 0
+              dd-1138  [000]   562.064783: block_bio_queue:      8,0 R 2048 + 1 [dd]
+              dd-1138  [000]   562.064794: block_getrq:          8,0 R 2048 + 1 [dd]
+              dd-1138  [000]   562.064797: block_rq_insert:      8,0 R 512 () 2048 + 1 [dd]
+              dd-1138  [000]   562.064799: block_rq_issue:       8,0 R 512 () 2048 + 1 [dd]
+              dd-1138  [000]   562.064812: scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=0x0 \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00)
+          <idle>-0     [000]   562.064986: scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=0x0 \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+          <idle>-0     [000]   562.064994: block_rq_complete:    8,0 R () 2048 + 1 [0]
+     kworker/0:1-5     [000]   562.065043: block_getrq:          0,0 R 0 + 0 [kworker/0:1]
+     kworker/0:1-5     [000]   562.065045: block_rq_insert:      0,0 N 0 () 0 + 0 [kworker/0:1]
+     kworker/0:1-5     [000]   562.065046: block_rq_issue:       0,0 N 0 () 0 + 0 [kworker/0:1]
+     kworker/0:1-5     [000]   562.065049: scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=0 prot_sgl=0 prot_op=0x0 \
+cmnd=(TEST_UNIT_READY - raw  00 00 00 00 00)
+          <idle>-0     [001]   562.065163: scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=0 prot_sgl=0 prot_op=0x0 \
+cmnd=(TEST_UNIT_READY - raw  00 00 00 00 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+          <idle>-0     [001]   562.065171: block_rq_complete:    0,0 N () 18446744073709551615 + 0 [0]
+\end{verbatim}
+}
+
+If you have instead used the perf tool to record:
+
+{\footnotesize
+\begin{verbatim}
+% perf script
+              dd  1193 [000]   771.144338:        block:block_bio_remap: 8,0 R 2048 + 1 <- (8,1) 0
+              dd  1193 [000]   771.144347:        block:block_bio_queue: 8,0 R 2048 + 1 [dd]
+              dd  1193 [000]   771.144357:            block:block_getrq: 8,0 R 2048 + 1 [dd]
+              dd  1193 [000]   771.144361:        block:block_rq_insert: 8,0 R 512 () 2048 + 1 [dd]
+              dd  1193 [000]   771.144364:         block:block_rq_issue: 8,0 R 512 () 2048 + 1 [dd]
+              dd  1193 [000]   771.144375: scsi:scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=0x0 \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00)
+         swapper     0 [000]   771.144553:  scsi:scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=1 prot_sgl=0 prot_op=0x0 \
+cmnd=(READ_10 lba 48 txlen=1 protect=0 raw( 00 00 00 08 00 00 00 01 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+         swapper     0 [000]   771.144562:      block:block_rq_complete: 8,0 R () 2048 + 1 [0]
+     kworker/0:1     5 [000]   771.144609:            block:block_getrq: 0,0 R 0 + 0 [kworker/0:1]
+     kworker/0:1     5 [000]   771.144613:        block:block_rq_insert: 0,0 N 0 () 0 + 0 [kworker/0:1]
+     kworker/0:1     5 [000]   771.144615:         block:block_rq_issue: 0,0 N 0 () 0 + 0 [kworker/0:1]
+     kworker/0:1     5 [000]   771.144620: scsi:scsi_dispatch_cmd_start: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=0 prot_sgl=0 prot_op=0x0 \
+cmnd=(TEST_UNIT_READY - raw  00 00 00 00 00)
+         swapper     0 [001]   771.144732:  scsi:scsi_dispatch_cmd_done: \
+host_no=0 channel=0 id=0 lun83850880 data_sgl=0 prot_sgl=0 prot_op=0x0 \
+cmnd=(TEST_UNIT_READY - raw  00 00 00 00 00) \
+result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
+         swapper     0 [001]   771.144741:      block:block_rq_complete: 0,0 N () 18446744073709551615 + 0 [0]
+\end{verbatim}
+}
+
+
+
 %----------------------------
 \newpage\section{blktrace User Guide}
 \label{sec:blktrace-ug}
@@ -1022,6 +1416,7 @@ struct blk_io_trace_remap {
 \label{sec:records-special}
 
 \subsubsection{Timestamp}
+\label{sec:timestamp}
 
 On starting tracing, blktrace writes a notification record with time
 of day. The message payload consists of u32 for seconds and u32 for
@@ -1030,6 +1425,7 @@ for each trace record instead of just monotonic nanoseconds as with
 the time field of struct blk\_io\_trace.
 
 \subsubsection{Process Mapping}
+\label{sec:process-mapping}
 
 On writing any trace record, blktrace conditionally writes a preceding
 additional process record if it has not done so already for this
@@ -1044,6 +1440,7 @@ tracking list of active tracers. On trace emit, struct task\_struct of
 the process remembers the current epoch.
 
 \subsubsection{Message}
+\label{sec:message}
 
 Text message generated via kernel call to
 \texttt{blk\_add\_trace\_msg} from e.g.\ CFQ I/O scheduler, or written to
-- 
2.14.2

