From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:27 +0000
Subject: [PATCH 20/31] README: remove incomplete tool option descriptions
Message-Id: <20180427130738.102806-21-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Idea: The man pages are the single maintained full reference.

blktrace synopsis was missing options.
blktrace actions were outdated: BARRIER.
blktrace actions were missing:
	DISCARD, AHEAD, META, FLUSH, FUA, NOTIFY, DRV_DATA.

blkparse synopsis was missing options.
blkparse options were missing: -A -a -M -O
blkparse custom output format was missing: %z for calendar time
blkparse custom format specifier was outdated: W for bounce

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 README | 95 +++---------------------------------------------------------------
 1 file changed, 4 insertions(+), 91 deletions(-)

diff --git a/README b/README
index 2a3959cea2a9..4d5a4b5a1cae 100644
--- a/README
+++ b/README
@@ -37,101 +37,12 @@ A blktrace visualization tool, iowatcher, was added to blktrace in version
 Usage
 -----
 
-$ blktrace -d <dev> [ -r debug_path ] [ -o output ] [ -k ] [ -w time ]
-		    [ -a action ] [ -A action mask ]
-
-	-d Use specified device. May also be given last after options.
-	-r Path to mounted debugfs, defaults to /sys/kernel/debug.
-	-o File(s) to send output to.
-	-D Directory to prepend to output file names.
-	-k Kill running trace.
-	-w Stop after defined time, in seconds.
-	-a Only trace specific actions (use more -a options to add actions).
-	   Available actions are:
-
-		READ
-		WRITE
-		BARRIER
-		SYNC
-		QUEUE
-		REQUEUE
-		ISSUE
-		COMPLETE
-		FS
-		PC
-
-	-A Give the trace mask directly as a number.
-
-	-b Sub buffer size in KiB.
-	-n Number of sub buffers.
-	-l Run in network listen mode (blktrace server)
-	-h Run in network client mode, connecting to the given host
-	-p Network port to use (default 8462)
-	-s Disable network client use of sendfile() to transfer data
-	-V Print program version info.
+$ blktrace -d <dev>
 
 	Records the I/O event trace information from the kernel for
 	specific block device(s) to file(s).
 
-$ blkparse -i <input> [ -o <output> ] [ -b rb_batch ] [ -s ] [ -t ] [ -q ]
-		      [ -w start:stop ] [ -f output format ] [ -F format spec ]
-		      [ -d <binary> ]
-
-	-i Input file containing trace data, or '-' for stdin.
-	-D Directory to prepend to input file names.
-	-o Output file. If not given, output is stdout.
-	-b stdin read batching.
-	-s Show per-program io statistics.
-	-h Hash processes by name, not pid.
-	-t Track individual ios. Will tell you the time a request took to
-	   get queued, to get dispatched, and to get completed.
-	-q Quiet. Don't display any stats at the end of the trace.
-	-w Only parse data between the given time interval in seconds. If
-	   'start' isn't given, blkparse defaults the start time to 0.
-	-d Dump sorted data in binary format
-	-f Output format. Customize the output format. The format field
-	   identifiers are:
-
-		%a	- Action
-		%c	- CPU ID
-		%C	- Task command (process) name
-		%d	- Direction (r/w)
-		%D	- Device number
-		%e	- Error number
-		%M	- Major
-		%m	- Minor
-		%N	- Number of bytes
-		%n	- Number of sectors
-		%p	- PID
-		%P	- PDU
-		%s	- Sequence number
-		%S	- Sector number
-		%t	- Time (wallclock - nanoseconds)
-		%T	- Time (wallclock - seconds)
-		%u	- Time (processing - microseconds)
-		%U	- Unplug depth
-
-	-F Format specification. The individual specifiers are:
-
-		A	- Remap
-		B	- Bounce
-		C	- Complete
-		D	- Issue
-		M	- Back merge
-		F	- Front merge
-		G	- Get request
-		I	- Insert
-		P	- Plug
-		Q	- Queue
-		R	- Requeue
-		S	- Sleep requests
-		T	- Unplug timer
-		U	- Unplug IO
-		W	- Bounce
-		X	- Split
-
-	-v More verbose for marginal errors.
-	-V Print program version info.
+$ blkparse -i <input>
 
 	The blkparse utility attempts to combine streams of events for
 	various devices on various CPUs, and produce a formatted
@@ -225,6 +136,8 @@ A users guide is distributed with the source. It is in latex, a
 'make docs' will build a PDF in doc/. You need tetex and latex installed
 to build the document.
 
+The full tool reference is in the corresponding man pages.
+
 
 Resources
 ---------
-- 
2.14.2

