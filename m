From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Sun, 09 Sep 2007 00:02:10 +0000
Subject: [BTT PATCH] Major revamping (ver 2.0)
Message-Id: <46E33802.9040209@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080505050105020206020700"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505050105020206020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After a lot of fighting with maintaining a tree-styled design (each 
trace having it's own node), it was just getting too cumbersome to work 
in all circumstances. Taking a clue from blkparse itself, I decided to 
just keep track of IOs at queue time, and updating fields based upon 
later traces.

The attached (large) patch works much faster, handles larger test cases 
with less failures, and is managing some pretty large jobs I'm working 
on (large Oracle-based DB analysis - 32-way box w/ lots of storage).

I've also added a Q2Q seek distance feature - it's come in handy when 
comparing results of IO scheduler choice: We can see what the incoming 
IO seek distances are (at queue time), and then see how the scheduler 
itself manages things (via merges & sorting) by looking at D2D seek 
distances generated.

As noted in the subject, I arbitrarily bumped this to version 2.00 as 
the innards are so different. The documentation (btt/doc/btt.tex) has 
been updated to reflect some minor output changes. I also fixed a bug 
dealing with process name notification: there was a problem that if a 
new PID came up with a name that was previously seen, btt wouldn't keep 
track of it right. [When running with Oracle, a lot of processes have 
the same name but different PIDs of course.]

Alan



--------------080505050105020206020700
Content-Type: text/plain;
 name="btt2_diffs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="btt2_diffs.txt"

diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index f38f6a2..f67c2ad 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -25,7 +25,7 @@
 #include <time.h>
 #include "globals.h"
 
-char bt_timeline_version[] = "0.99.1";
+char bt_timeline_version[] = "2.00";
 
 char *devices, *exes, *input_name, *output_name, *seek_name, *bno_dump_name;
 char *d2c_name, *q2c_name, *per_io_name, *unplug_hist_name;
@@ -40,13 +40,10 @@ LIST_HEAD(all_devs);
 LIST_HEAD(all_procs);
 LIST_HEAD(free_ios);
 LIST_HEAD(free_bilinks);
-LIST_HEAD(rmhd);
-LIST_HEAD(retries);
 __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
 
 double range_delta = 0.1;
 __u64 last_q = (__u64)-1;
-__u64 next_retry_check = 0;
 
 struct region_info all_regions = {
 	.qranges = LIST_HEAD_INIT(all_regions.qranges),
@@ -90,7 +87,6 @@ int main(int argc, char *argv[])
 	dip_exit();
 	pip_exit();
 	io_free_all();
-	bilink_free_all();
 	region_exit(&all_regions);
 
 	free(input_name);
@@ -120,7 +116,6 @@ int process(void)
 	}
 
 	io_release(iop);
-	do_retries(0);
 	gettimeofday(&tve, NULL);
 
 	if (verbose) {
diff --git a/btt/devs.c b/btt/devs.c
index 397a945..449d452 100644
--- a/btt/devs.c
+++ b/btt/devs.c
@@ -58,10 +58,7 @@ void __dump_rb_node(struct rb_node *n)
 	struct io *iop = rb_entry(n, struct io, rb_node);
 
 	dbg_ping();
-	if (iop->type == IOP_A)
-		__dump_iop2(stdout, iop, bilink_first_down(iop, NULL));
-	else
-		__dump_iop(stdout, iop, 0);
+	__dump_iop(stdout, iop, 0);
 	if (n->rb_left)
 		__dump_rb_node(n->rb_left);
 	if (n->rb_right)
@@ -92,10 +89,8 @@ void dump_rb_trees(void)
 			dip = list_entry(p, struct d_info, hash_head);
 			printf("Trees for %3d,%-3d\n", MAJOR(dip->device),
 			       MINOR(dip->device));
-			for (type = IOP_Q; type < N_IOP_TYPES; type++) {
-				if (type != IOP_L)
-					__dump_rb_tree(dip, type);
-			}
+			for (type = IOP_Q; type < N_IOP_TYPES; type++)
+				__dump_rb_tree(dip, type);
 		}
 	}
 }
@@ -133,17 +128,29 @@ void dip_exit(void)
 		__destroy_heads(dip->heads);
 		region_exit(&dip->regions);
 		seeki_exit(dip->seek_handle);
+		seeki_exit(dip->q2q_handle);
 		bno_dump_exit(dip->bno_dump_handle);
 		unplug_hist_exit(dip->unplug_hist_handle);
 		free(dip);
 	}
 }
 
+static inline char *mkhandle(char *str, __u32 device, char *post)
+{
+	int mjr = device >> MINORBITS;
+	int mnr = device & ((1 << MINORBITS) - 1);
+
+	sprintf(str, "%03d,%03d%s", mjr, mnr, post);
+	return str;
+}
+
 struct d_info *dip_add(__u32 device, struct io *iop)
 {
 	struct d_info *dip = __dip_find(device);
 
 	if (dip == NULL) {
+		char str[256];
+
 		dip = malloc(sizeof(struct d_info));
 		memset(dip, 0, sizeof(*dip));
 		dip->heads = dip_rb_mkhds();
@@ -151,9 +158,10 @@ struct d_info *dip_add(__u32 device, struct io *iop)
 		dip->device = device;
 		dip->last_q = (__u64)-1;
 		dip->map = dev_map_find(device);
-		dip->seek_handle = seeki_init(device);
 		dip->bno_dump_handle = bno_dump_init(device);
 		dip->unplug_hist_handle = unplug_hist_init(device);
+		dip->seek_handle = seeki_init(mkhandle(str, device, "_d2d"));
+		dip->q2q_handle = seeki_init(mkhandle(str, device, "_q2q"));
 		latency_init(dip);
 		list_add_tail(&dip->hash_head, &dev_heads[DEV_HASH(device)]);
 		list_add_tail(&dip->all_head, &all_devs);
diff --git a/btt/doc/btt.tex b/btt/doc/btt.tex
index e8762e8..c795cb9 100644
--- a/btt/doc/btt.tex
+++ b/btt/doc/btt.tex
@@ -199,13 +199,20 @@ Q2C    0.000207665   0.125405263   1.830917198     2262311
   \item[Device Seek Information]
 
   Another useful measure is the variability in the sector distances
-  between consecutive IOs. The next session provides some rudimentary
+  between consecutively \emph{recieved -- queued} and \emph{submitted
+  -- issued} IOs. The next two sections provides some rudimentary
   statistics to gauge the general nature of the sector differences
   between IOs. Values provided include the number of seeks (number of IOs
   submitted to lower level drivers), the \emph{mean} distance between
   IOs, the \emph{median} value for all seeks, and the \emph{mode} -
   the value(s) and the counts are provided for the latter.
 
+  The first of the two sections displays values for Q2Q seek distances --
+  providing a set of indicators showing how close incoming IO requests
+  are to each other. The second section shows D2D seek distances --
+  providing a set of indicators showing how close the IO requests are
+  that are handled by underlying drivers.
+
 \begin{verbatim}
       DEV | NSEEKS    MEAN MEDIAN | MODE
 --------- | ------ ------- ------ | -------
@@ -219,7 +226,6 @@ Q2C    0.000207665   0.125405263   1.830917198     2262311
   the block IO layer in adjacent sectors. (Obviously, the higher this
   percentage, the better the underlying subsystems can handle them.)
 
-
   \item[Request Queue Plug Information]
 
   During normal operation, requests queues are \emph{plugged} and during
@@ -247,6 +253,7 @@ Q2C    0.000207665   0.125405263   1.830917198     2262311
   ones due to timer unplugs.
 \end{description}
 
+\newpage
 \subsection{\label{sec:detailed-data}Detailed Data}
 
   In addition to the default sections output, if one supplies the
@@ -298,9 +305,6 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
 ( 65,160) 0.000139915 0.001175554 0.073512063 133973
 ( 65,176) 0.000141254 0.001104870 0.073231310 145764
 ( 65,192) 0.000141453 0.001234460 0.167622507 140618
-( 65,208) 0.000143901 0.001126610 0.144651899 178548
-( 65,224) 0.000145020 0.001226478 0.124902029 206241
-( 65,240) 0.000144315 0.001199571 0.102415459 129154
 ...
 \end{verbatim}
 
@@ -343,7 +347,7 @@ pdflush       0.000000790 0.000006752 0.247231307  179791
     on a per-IO basis can be generated. These are described in
     sections~\ref{sec:lat-q2c} and~\ref{sec:lat-d2c}.
 
-    \item[seek details] A data file containing all IO-to-IO
+    \item[seek details] A set of data files containing all IO-to-IO
     sector differences can be output, with details found in
     section~\ref{sec:seek}.
 
@@ -513,36 +517,45 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
 
   The \emph{--per-io-dump} or \emph{-p} option triggers this behavior,
   and will produce a file containing streams of IOs (separated by blank
-  spaces), here is an example:
+  spaces). As an example, here is a snippet of 4 IOs that were merged
+  together, you will note there are 3 merged IOs, and 1 inserted in the
+  stream. The issue and completion traces are replicated per IO.
 
 \begin{verbatim}
-   20.002179731   8,32  Q         34+8
-   20.002181199   8,32  I         34+8
-   20.098329567   8,32  D         34+16
-   20.002182760   8,32  Q         42+8
-   20.002183613   8,32  M         42+8
-   20.098329567   8,32  D         34+16
-   20.692643206   8,32  C         34+16
+ 66,0  :     0.763283556 Q       6208+8   
+             0.763300157 I       6208+8   
+             0.763296365 G       6208+8   
+             0.763338848 D       6208+32  
+             0.763705760 C       6208+32  
+
+ 66,0  :     0.763314550 Q       6224+8   
+             0.763315341 M       6224+8   
+             0.763338848 D       6208+32  
+             0.763705760 C       6208+32  
+
+ 66,0  :     0.763321010 Q       6232+8   
+             0.763321775 M       6232+8   
+             0.763338848 D       6208+32  
+             0.763705760 C       6208+32  
+
+ 65,240:     0.763244173 Q       6216+8   
+             0.763244974 M       6216+8   
+             0.763374288 D       6208+32  
+             0.763826610 C       6208+32  
 \end{verbatim}
 
   The columns provide the following information:
 
   \begin{enumerate}
-    \item Time of the trace (seconds from the start of the run)
-
     \item Device major/minor.
 
+    \item Time of the trace (seconds from the start of the run)
+
     \item Trace type 
 
     \item start block + number of blocks
   \end{enumerate}
   
-  For this pair of initial IOs (Q traces at 20.002179731 and
-  20.002182760), we can follow the insert and merge traces (20.002181199
-  and 20.002183613 respectively), and the issue (duplicate entries for
-  20.098329567), and the completion at 20.692643206. Every Q has its
-  corresponding issue trace bounding any insert or merge operations.
-
 \newpage\section{\label{sec:lat}\label{sec:lat-q2c}\label{sec:lat-d2c}Latency Data Files}
 
   The latency data files which can be optionally produced by \texttt{btt}
@@ -555,7 +568,7 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
 
 \newpage\section{\label{sec:seek}Seek Data File}
 
-  \texttt{btt} can also produce a data file containing all IO-to-IO sector
+  \texttt{btt} can also produce two data files containing all IO-to-IO sector
   deltas, providing seek information which can then be plotted. The
   produced data file contains 3 sets of data:
 
@@ -567,6 +580,25 @@ Device:       rrqm/s   wrqm/s     r/s     w/s    rsec/s    wsec/s
      \item Write data -- just seek deltas for writes
   \end{enumerate}
 
+  The format of the output file names is to have the name generated by 
+  the following fields separated by underscores (\texttt{\_}):
+  
+  \begin{itemize}
+    \item The prefix provided as the argument to the \texttt{-s} option.
+    \item The major and minor numbers of the device separated by a comma.
+    \item The string \texttt{q2q} or \texttt{d2d}, indicating the Q2Q or 
+          D2D seeks, respectively.
+    \item One of the following characters:
+    	\begin{description}
+	  \item[r] For read (device to system) IOs
+	  \item[w] For write (system to device) IOs
+	  \item[c] Combined -- both read and write IOs
+	\end{description}
+  \end{itemize}
+
+  An example name would be after specifying \texttt{-s seek} would be:
+  \texttt{seek\_065,048\_q2q\_w.dat}.
+
   The format of the data is to have the runtime values (seconds since
   the start of the run) in column 1 (X values); and the difference in
   sectors from the previous IO in column 2 (Y values). Here is a snippet
@@ -823,248 +855,5 @@ Output}
   
   Here is a complete output file from a btt run, illustrating a lot of the
   capabilities of btt.
-
-\begin{verbatim}
-==================== All Devices ====================
-
-            ALL           MIN           AVG           MAX           N
---------------- ------------- ------------- ------------- -----------
-Q2Q               0.000000001   0.000015439   0.067431982     4485897
-Q2I               0.000000277   0.000005085  12.844603081     4485736
-I2D               0.000000869   0.000721745  12.845117057     4485736
-D2C               0.000151807   0.005254051   0.097569048     4485736
-Q2C               0.000156268   0.005980882  12.864868116     4485736
-
-\end{verbatim}
-\newpage\begin{verbatim}
-
-==================== Device Overhead ====================
-
-       DEV |    Q2I    I2D    D2C
----------- | ------ ------ ------
- (  8,160) |   0.0%   1.6%  98.4%
- (  8,176) |   0.1%  20.0%  79.9%
- (  8,208) |   1.2%  69.2%  29.5%
- ( 65, 32) |   0.0%   1.1%  98.8%
- ( 65, 64) |   0.0%   3.6%  96.4%
- ( 65,176) |   0.0%   2.5%  97.4%
- ( 65, 96) |   0.0%  15.3%  84.6%
- (  8,224) |   0.0%   1.7%  98.3%
- ( 65,112) |   0.0%   2.4%  97.6%
- (  8,240) |   0.0%   2.3%  97.7%
- ( 65,192) |   0.0%  19.4%  80.6%
- ( 65,240) |   0.0%   1.3%  98.7%
- ( 65, 48) |   0.0%   2.3%  97.7%
- (  8, 32) |   0.0%   7.0%  93.0%
- ( 66, 80) |   0.1%   9.9%  90.0%
- ( 66, 32) |   0.0%   0.7%  99.3%
- ( 65,224) |   0.0%  18.1%  81.9%
- ( 65,144) |   0.1%  39.5%  60.5%
- (  8,144) |   0.0%   0.7%  99.3%
- ( 66,144) |   0.0%   1.5%  98.5%
- ( 66,128) |   0.0%   3.0%  97.0%
- ( 66,176) |   0.0%  12.5%  87.4%
- ( 66,224) |   0.0%  10.2%  89.8%
- ( 66,192) |   0.0%   2.1%  97.9%
- ( 66,160) |   0.0%   9.4%  90.5%
- ( 66,240) |   0.0%   9.8%  90.2%
- ( 66,112) |   0.1%  24.2%  75.7%
- (  8, 64) |   0.0%   9.6%  90.4%
- ( 65,160) |   0.2%  26.2%  73.7%
- ( 65,208) |   0.0%   2.0%  98.0%
- ( 66, 16) |   0.0%   4.5%  95.5%
- ( 65,  0) |   0.0%   2.2%  97.8%
- ( 65, 16) |   0.0%   1.8%  98.1%
- ( 66,208) |   0.0%   2.7%  97.3%
- (  8,128) |   0.2%  23.7%  76.1%
- ( 65, 80) |   0.0%  20.0%  80.0%
- (  8,112) |   0.0%   1.2%  98.7%
- ( 65,128) |   0.0%   1.9%  98.1%
- ( 66, 64) |   0.0%  12.1%  87.9%
- ( 66,  0) |   0.0%   7.2%  92.8%
- ( 66, 48) |   0.0%   2.6%  97.4%
- (  8,192) |   0.0%   2.3%  97.7%
- ( 67, 16) |   0.0%   0.8%  99.2%
- ( 66, 96) |   0.0%  12.3%  87.7%
- (  8, 96) |   0.0%  10.3%  89.7%
- (  8, 80) |   0.0%   1.7%  98.3%
- (  8, 48) |   0.0%   0.7%  99.2%
- ( 67,  0) |   0.0%   2.6%  97.4%
-
-\end{verbatim}
-\newpage\begin{verbatim}
-
-==================== Device Merge Information ====================
-
-       DEV |       #Q       #D   Ratio |   BLKmin   BLKavg   BLKmax    Total
----------- | -------- -------- ------- | -------- -------- -------- --------
- (  8,160) |    75145    47890     1.6 |        8       12     1024   601160
- (  8,176) |    91374    55492     1.6 |        8       13     1024   730992
- (  8,208) |   101039    63944     1.6 |        8       12     1024   809256
- ( 65, 32) |    67919    44494     1.5 |        8       12     1024   543352
- ( 65, 64) |   114614    77396     1.5 |        8       11     1024   916968
- ( 65,176) |    93808    62746     1.5 |        8       11     1024   750464
- ( 65, 96) |    95537    51705     1.8 |        8       14     1024   764296
- (  8,224) |    95435    49753     1.9 |        8       15     1024   765560
- ( 65,112) |   100020    63530     1.6 |        8       12     1024   800160
- (  8,240) |    72282    44700     1.6 |        8       12     1024   578256
- ( 65,192) |    95175    59010     1.6 |        8       12     1024   761400
- ( 65,240) |    86334    53548     1.6 |        8       12     1024   690984
- ( 65, 48) |    69623    44652     1.6 |        8       12     1024   556984
- (  8, 32) |    97816    63116     1.5 |        8       12     1024   782528
- ( 66, 80) |   110873    71526     1.6 |        8       12     1024   886984
- ( 66, 32) |    79242    53134     1.5 |        8       11     1024   633936
- ( 65,224) |   122788    66180     1.9 |        8       14     1024   982304
- ( 65,144) |   116636    70205     1.7 |        8       13     1024   933416
- (  8,144) |    72014    49047     1.5 |        8       11     1024   576112
- ( 66,144) |   109244    70613     1.5 |        8       12     1024   873952
- ( 66,128) |   104688    65381     1.6 |        8       12     1024   837504
- ( 66,176) |    79627    47894     1.7 |        8       13     1024   637016
- ( 66,224) |    88754    58159     1.5 |        8       12     1024   710032
- ( 66,192) |    88919    55417     1.6 |        8       12     1024   711464
- ( 66,160) |   102908    71156     1.4 |        8       11     1024   823264
- ( 66,240) |    94190    66472     1.4 |        8       11     1024   753520
- ( 66,112) |   138799    82027     1.7 |        8       13     1024  1110392
- (  8, 64) |   105011    63892     1.6 |        8       13     1024   840112
- ( 65,160) |    93383    55579     1.7 |        8       13     1024   747064
- ( 65,208) |   109771    67987     1.6 |        8       12     1024   878168
- ( 66, 16) |    96703    56613     1.7 |        8       13     1024   773624
- ( 65,  0) |    83752    51532     1.6 |        8       13     1024   670032
- ( 65, 16) |    64538    35982     1.8 |        8       14     1024   516320
- ( 66,208) |    90636    54306     1.7 |        8       13     1024   725088
- (  8,128) |    96202    59653     1.6 |        8       13     1024   776192
- ( 65, 80) |   107945    65672     1.6 |        8       13     1024   863704
- (  8,112) |    78235    52847     1.5 |        8       11     1024   625880
- ( 65,128) |   104631    63106     1.7 |        8       13     1024   837048
- ( 66, 64) |    86365    50956     1.7 |        8       13     1024   690920
- ( 66,  0) |    90413    46722     1.9 |        8       15     1024   723304
- ( 66, 48) |   106631    65219     1.6 |        8       13     1024   853048
- (  8,192) |    80591    47154     1.7 |        8       13     1024   644728
- ( 67, 16) |    72314    48487     1.5 |        8       11     1024   578512
- ( 66, 96) |    90990    54454     1.7 |        8       13     1024   727920
- (  8, 96) |   110805    73522     1.5 |        8       12     1024   886440
- (  8, 80) |    85032    56643     1.5 |        8       12     1024   680400
- (  8, 48) |    87374    57544     1.5 |        8       12     1024   698992
- ( 67,  0) |    79611    53515     1.5 |        8       11     1024   636888
----------- | -------- -------- ------- | -------- -------- -------- --------
-       DEV |       #Q       #D   Ratio |   BLKmin   BLKavg   BLKmax    Total
-     TOTAL |  4485736  2790572     1.6 |        8       12     1024 35896640
-
-\end{verbatim}
-\newpage\begin{verbatim}
-
-==================== Device Seek Information ====================
-
-       DEV |          NSEEKS            MEAN          MEDIAN | MODE           
----------- | --------------- --------------- --------------- | ---------------
- (  8,160) |           47890        203945.5               0 | 0(2496)
- (  8,176) |           55492        252948.8               0 | 0(2360)
- (  8,208) |           63944        167845.3               0 | 0(4327)
- ( 65, 32) |           44494        224708.3               0 | 0(2683)
- ( 65, 64) |           77396        197838.0               0 | 0(2532)
- ( 65,176) |           62746        168400.5               0 | 0(2675)
- ( 65, 96) |           51705        162500.2               0 | 0(2778)
- (  8,224) |           49753        206665.7               0 | 0(2753)
- ( 65,112) |           63530        146289.8               0 | 0(2598)
- (  8,240) |           44700        167258.3               0 | 0(2735)
- ( 65,192) |           59010        217004.7               0 | 0(2724)
- ( 65,240) |           53548        278194.8               0 | 0(2415)
- ( 65, 48) |           44652        180710.3               0 | 0(2660)
- (  8, 32) |           63116        234049.5               0 | 0(2473)
- ( 66, 80) |           71526        184981.9               0 | 0(2455)
- ( 66, 32) |           53134        198369.5               0 | 0(2415)
- ( 65,224) |           66180        157948.5               0 | 0(2859)
- ( 65,144) |           70205        195689.7               0 | 0(2734)
- (  8,144) |           49047        169282.7               0 | 0(2574)
- ( 66,144) |           70613        149265.7               0 | 0(2717)
- ( 66,128) |           65381        165931.1               0 | 0(2687)
- ( 66,176) |           47894        199744.8               0 | 0(3096)
- ( 66,224) |           58159        161603.9               0 | 0(2738)
- ( 66,192) |           55417        153055.3               0 | 0(2828)
- ( 66,160) |           71156        126479.4               0 | 0(2739)
- ( 66,240) |           66472        142014.0               0 | 0(2933)
- ( 66,112) |           82027        115471.3               0 | 0(2961)
- (  8, 64) |           63892        136632.0               0 | 0(2655)
- ( 65,160) |           55579        154668.3               0 | 0(3377)
- ( 65,208) |           67987        152829.1               0 | 0(2523)
- ( 66, 16) |           56613        150652.8               0 | 0(2886)
- ( 65,  0) |           51532        186889.7               0 | 0(2765)
- ( 65, 16) |           35982        327187.6               0 | 0(2756)
- ( 66,208) |           54306        243784.1               0 | 0(3076)
- (  8,128) |           59653        170797.2               0 | 0(2800)
- ( 65, 80) |           65672        224501.4               0 | 0(2452)
- (  8,112) |           52847        213100.3               0 | 0(2417)
- ( 65,128) |           63106        207821.8               0 | 0(2686)
- ( 66, 64) |           50956        198045.0               0 | 0(2896)
- ( 66,  0) |           46722        205476.3               0 | 0(3159)
- ( 66, 48) |           65219        142716.6               0 | 0(2869)
- (  8,192) |           47154        248778.6               0 | 0(2584)
- ( 67, 16) |           48487        193335.5               0 | 0(2879)
- ( 66, 96) |           54454        185100.7               0 | 0(2158)
- (  8, 96) |           73522        216187.1               0 | 0(2476)
- (  8, 80) |           56643        172561.8               0 | 0(2612)
- (  8, 48) |           57544        219104.1               0 | 0(2472)
- ( 67,  0) |           53515        161613.8               0 | 0(2990)
----------- | --------------- --------------- --------------- | ---------------
-   Overall |          NSEEKS            MEAN          MEDIAN | MODE           
-   Average |         2790572        185170.0               0 | 0(131433)
-
-\end{verbatim}
-\newpage\begin{verbatim}
-==================== Plug Information ====================
-
-       DEV |    # Plugs # Timer Us  | % Time Q Plugged
----------- | ---------- ----------  | ----------------
- (  8,160) |      45092(         0) |   0.003021834%
- (  8,176) |      49430(         0) |   0.003724997%
- (  8,208) |      58950(         0) |   0.004506453%
- ( 65, 32) |      41617(         0) |   0.002710008%
- ( 65, 64) |      74294(         0) |   0.004971739%
- ( 65,176) |      59764(         0) |   0.003827258%
- ( 65, 96) |      47495(         0) |   0.004012641%
- (  8,224) |      46806(         0) |   0.003724031%
- ( 65,112) |      60539(         0) |   0.004272802%
- (  8,240) |      41797(         0) |   0.002832794%
- ( 65,192) |      54754(         0) |   0.004049758%
- ( 65,240) |      50757(         0) |   0.003466684%
- ( 65, 48) |      41749(         0) |   0.002783118%
- (  8, 32) |      59486(         0) |   0.004102902%
- ( 66, 80) |      67519(         0) |   0.004698104%
- ( 66, 32) |      50441(         0) |   0.003229586%
- ( 65,224) |      60219(         0) |   0.005114778%
- ( 65,144) |      64699(         0) |   0.005185315%
- (  8,144) |      46237(         0) |   0.002824578%
- ( 66,144) |      67605(         0) |   0.004459997%
- ( 66,128) |      62418(         0) |   0.004598612%
- ( 66,176) |      43007(         0) |   0.003277143%
- ( 66,224) |      54724(         0) |   0.003682546%
- ( 66,192) |      52395(         0) |   0.003611178%
- ( 66,160) |      67775(         0) |   0.004347445%
- ( 66,240) |      62892(         0) |   0.003906526%
- ( 66,112) |      72351(         0) |   0.005906198%
- (  8, 64) |      59642(         0) |   0.004275726%
- ( 65,160) |      50303(         0) |   0.003841735%
- ( 65,208) |      64750(         0) |   0.004655374%
- ( 66, 16) |      53443(         0) |   0.003936557%
- ( 65,  0) |      48450(         0) |   0.003301599%
- ( 65, 16) |      33047(         0) |   0.002447028%
- ( 66,208) |      51060(         0) |   0.003674090%
- (  8,128) |      52664(         0) |   0.004009472%
- ( 65, 80) |      61974(         0) |   0.004623080%
- (  8,112) |      50106(         0) |   0.003284028%
- ( 65,128) |      60047(         0) |   0.004267589%
- ( 66, 64) |      47590(         0) |   0.003646022%
- ( 66,  0) |      43413(         0) |   0.003600655%
- ( 66, 48) |      61984(         0) |   0.004440717%
- (  8,192) |      44294(         0) |   0.003120507%
- ( 67, 16) |      45482(         0) |   0.002852274%
- ( 66, 96) |      50099(         0) |   0.003970858%
- (  8, 96) |      70266(         0) |   0.004743310%
- (  8, 80) |      53676(         0) |   0.003530690%
- (  8, 48) |      54672(         0) |   0.003527266%
- ( 67,  0) |      50418(         0) |   0.003217817%
----------- | ---------- ----------  | ----------------
-       DEV |    # Plugs # Timer Us  | % Time Q Plugged
-   OVERALL |      54420(         0) |   0.003871155%
-\end{verbatim}
+\input{sample-btt-output.tex}
 \end{document}
diff --git a/btt/globals.h b/btt/globals.h
index 5a6982f..b4ef4e3 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -72,14 +72,14 @@ enum iop_type {
 	IOP_Q = 0,
 	IOP_X = 1,
 	IOP_A = 2,
-	IOP_I = 3,
+	IOP_G = 3,
 	IOP_M = 4,
 	IOP_D = 5,
 	IOP_C = 6,
 	IOP_R = 7,
-	IOP_L = 8, 	// IOP_A -> IOP_A + IOP_L
+	IOP_I = 8
 };
-#define N_IOP_TYPES	(IOP_L + 1)
+#define N_IOP_TYPES	(IOP_I + 1)
 
 struct file_info {
 	struct file_info *next;
@@ -158,7 +158,7 @@ struct d_info {
 	void *heads;
 	struct region_info regions;
 	struct devmap *map;
-	void *seek_handle, *bno_dump_handle, *unplug_hist_handle;
+	void *q2q_handle, *seek_handle, *bno_dump_handle, *unplug_hist_handle;
 	FILE *d2c_ofp, *q2c_ofp;
 	struct avgs_info avgs;
 	struct stats stats, all_stats;
@@ -172,26 +172,23 @@ struct d_info {
 
 struct io {
 	struct rb_node rb_node;
-	struct list_head f_head, c_pending, retry, rm_head;
-	struct list_head down_list, up_list;
+	struct list_head f_head;
 	struct d_info *dip;
 	struct p_info *pip;
 	void *pdu;
+	__u64 bytes_left, i_time, gm_time, d_time, c_time, d_sec, c_sec;
+	__u32 d_nsec, c_nsec;
+
 	struct blk_io_trace t;
-	__u64 bytes_left;
-	int linked, on_retry_list, down_len, up_len, on_rm_list;
+
+	int linked, is_getrq;
 	enum iop_type type;
+
 #if defined(COUNT_IOS)
 	struct list_head cio_head;
 #endif
 };
 
-struct bilink {
-	struct list_head down_head, up_head;
-	struct io *diop, *uiop;
-};
-#define bilink_free_head	down_head
-
 /* bt_timeline.c */
 
 extern char bt_timeline_version[], *devices, *exes, *input_name, *output_name;
@@ -202,11 +199,11 @@ extern FILE *ranges_ofp, *avgs_ofp, *iostat_ofp, *per_io_ofp;
 extern int verbose, done, time_bounded, output_all_data, seek_absolute;
 extern unsigned int n_devs;
 extern unsigned long n_traces;
-extern struct list_head all_devs, all_procs, retries, rmhd;
+extern struct list_head all_devs, all_procs;
 extern struct avgs_info all_avgs;
-extern __u64 last_q, next_retry_check;
+extern __u64 last_q;
 extern struct region_info all_regions;
-extern struct list_head free_ios, free_bilinks;
+extern struct list_head free_ios;
 extern __u64 iostat_interval, iostat_last_stamp;
 extern time_t genesis, last_vtrace;
 extern double t_astart, t_aend;
@@ -253,7 +250,7 @@ void rb_foreach(struct rb_node *n, struct io *iop,
 
 /* iostat.c */
 void iostat_init(void);
-void iostat_insert(struct io *iop);
+void iostat_getrq(struct io *iop);
 void iostat_merge(struct io *iop);
 void iostat_issue(struct io *iop);
 void iostat_unissue(struct io *iop);
@@ -299,7 +296,7 @@ void bno_dump_add(void *handle, struct io *iop);
 void bno_dump_clean(void);
 
 /* seek.c */
-void *seeki_init(__u32 device);
+void *seeki_init(char *str);
 void seeki_exit(void *param);
 void seek_clean(void);
 void seeki_add(void *handle, struct io *iop);
@@ -309,15 +306,10 @@ long long seeki_median(void *handle);
 int seeki_mode(void *handle, struct mode *mp);
 
 /* trace.c */
-void __dump_iop(FILE *ofp, struct io *iop, int extra_nl);
-void __dump_iop2(FILE *ofp, struct io *a_iop, struct io *l_iop);
-void release_iops(void);
 void add_trace(struct io *iop);
-void do_retries(__u64 now);
 
 /* trace_complete.c */
 void trace_complete(struct io *c_iop);
-void retry_complete(struct io *c_iop, __u64 now);
 
 /* trace_im.c */
 void run_im(struct io *im_iop, struct io *d_iop, struct io *c_iop);
@@ -325,6 +317,7 @@ void run_unim(struct io *im_iop, struct io *d_iop, struct io *c_iop);
 int ready_im(struct io *im_iop, struct io *c_iop);
 void trace_insert(struct io *i_iop);
 void trace_merge(struct io *m_iop);
+void trace_getrq(struct io *g_iop);
 
 /* trace_issue.c */
 void run_issue(struct io *d_iop, struct io *u_iop, struct io *c_iop);
diff --git a/btt/inlines.h b/btt/inlines.h
index 25e5b21..43dada0 100644
--- a/btt/inlines.h
+++ b/btt/inlines.h
@@ -143,13 +143,9 @@ static inline struct io *io_alloc(void)
 	}
 
 	memset(iop, 0, sizeof(struct io));
-	INIT_LIST_HEAD(&iop->down_list);
-	INIT_LIST_HEAD(&iop->up_list);
 
 #	if defined(DEBUG)
 		iop->f_head.next = LIST_POISON1;
-		iop->c_pending.next = LIST_POISON1;
-		iop->retry.next = LIST_POISON1;
 #	endif
 
 #	if defined(COUNT_IOS)
@@ -199,10 +195,6 @@ static inline int io_setup(struct io *iop, enum iop_type type)
 static inline void io_release(struct io *iop)
 {
 	ASSERT(iop->f_head.next == LIST_POISON1);
-	ASSERT(iop->c_pending.next == LIST_POISON1);
-	ASSERT(iop->retry.next == LIST_POISON1);
-	ASSERT(list_empty(&iop->up_list));
-	ASSERT(list_empty(&iop->down_list));
 
 	if (iop->linked)
 		dip_rem(iop);
@@ -278,15 +270,14 @@ static inline void unupdate_i2d(struct io *iop, __u64 d_time)
 	UNUPDATE_AVGS(i2d, iop, iop->pip, d_time);
 }
 
-static inline void update_d2c(struct io *iop, int n, __u64 c_time)
+static inline void update_d2c(struct io *iop, __u64 c_time)
 {
 #	if defined(DEBUG)
 		if (per_io_ofp) 
-			fprintf(per_io_ofp, "d2c %13.9f\n", 
-							n*BIT_TIME(c_time));
+			fprintf(per_io_ofp, "d2c %13.9f\n", BIT_TIME(c_time));
 #	endif
 
-	UPDATE_AVGS_N(d2c, iop, iop->pip, c_time, n);
+	UPDATE_AVGS(d2c, iop, iop->pip, c_time);
 }
 
 static inline void update_blks(struct io *iop)
@@ -333,37 +324,9 @@ static inline struct io *dip_rb_find_sec(struct d_info *dip,
 	return rb_find_sec(__get_root(dip, type), sec);
 }
 
-static inline void bump_retry(__u64 now)
+static inline __u64 tdelta(__u64 from, __u64 to)
 {
-	if (!list_empty(&retries))
-		next_retry_check = now + (100 * 1000); // 100 usec
-	else 
-		next_retry_check = 0;
-}
-
-static inline void add_retry(struct io *iop)
-{
-	bump_retry(iop->t.time);
-	if (!iop->on_retry_list) {
-		list_add_tail(&iop->retry, &retries);
-		iop->on_retry_list = 1;
-	}
-}
-
-static inline void del_retry(struct io *iop)
-{
-	if (iop->on_retry_list) {
-		LIST_DEL(&iop->retry);
-		iop->on_retry_list = 0;
-	}
-	bump_retry(iop->t.time);
-}
-
-static inline __u64 tdelta(struct io *iop1, struct io *iop2)
-{
-	__u64 t1 = iop1->t.time;
-	__u64 t2 = iop2->t.time;
-	return (t1 < t2) ? (t2 - t1) : 1;
+	return (from < to) ? (to - from) : 1;
 }
 
 static inline int remapper_dev(__u32 dev)
@@ -372,18 +335,6 @@ static inline int remapper_dev(__u32 dev)
 	return mjr == 9 || mjr == 253 || mjr == 254;
 }
 
-static inline void dump_iop(struct io *iop, int extra_nl)
-{
-	if (per_io_ofp) 
-		__dump_iop(per_io_ofp, iop, extra_nl);
-}
-
-static inline void dump_iop2(struct io *a_iop, struct io *l_iop)
-{
-	if (per_io_ofp) 
-		__dump_iop2(per_io_ofp, a_iop, l_iop);
-}
-
 static inline int type2c(enum iop_type type)
 {
 	int c;
@@ -397,130 +348,54 @@ static inline int type2c(enum iop_type type)
 	case IOP_D: c = 'D'; break;
 	case IOP_C: c = 'C'; break;
 	case IOP_R: c = 'R'; break;
-	case IOP_L: c = 'L'; break;
+	case IOP_G: c = 'G'; break;
 	default   : c = '?'; break;
 	}
 
 	return c;
 }
 
-static inline void bilink_free(struct bilink *blp)
-{
-	list_add_tail(&blp->bilink_free_head, &free_bilinks);
-}
-
-static inline void bilink_free_all(void)
-{
-	struct bilink *blp;
-	struct list_head *p, *q;
-
-	list_for_each_safe(p, q, &free_bilinks) {
-		blp = list_entry(p, struct bilink, bilink_free_head);
-		free(blp);
-	}
-}
-
-static inline struct bilink *bilink_alloc(struct io *diop, struct io *uiop)
-{
-	struct bilink *blp;
-
-	if (!list_empty(&free_bilinks)) {
-		blp = list_entry(free_bilinks.prev, struct bilink, 
-							bilink_free_head);
-		LIST_DEL(&blp->bilink_free_head);
-	}
-	else
-		blp = malloc(sizeof(*blp));
-
-	blp->diop = diop;
-	blp->uiop = uiop;
-
-	return blp;
-}
-
-static inline void bilink(struct io *diop, struct io *uiop)
+static inline int histo_idx(__u64 nbytes)
 {
-	struct bilink *blp = bilink_alloc(diop, uiop);
-
-	list_add_tail(&blp->down_head, &diop->up_list);
-	list_add_tail(&blp->up_head, &uiop->down_list);
-
-	diop->up_len++;
-	uiop->down_len++;
+	int idx = (nbytes >> 9) - 1;
+	return min(idx, N_HIST_BKTS-1);
 }
 
-static inline void biunlink(struct bilink *blp)
+static inline void update_q_histo(__u64 nbytes)
 {
-	LIST_DEL(&blp->down_head);
-	LIST_DEL(&blp->up_head);
-	blp->diop->up_len--;
-	blp->uiop->down_len--;
-	bilink_free(blp);
+	q_histo[histo_idx(nbytes)]++;
 }
 
-static inline struct io *bilink_first_down(struct io *iop, 
- 							struct bilink **blp_p)
+static inline void update_d_histo(__u64 nbytes)
 {
-	struct bilink *blp;
-
-	if (list_empty(&iop->down_list))
-		return NULL;
-	blp = list_entry(iop->down_list.next, struct bilink, up_head);
-
-	if (blp_p != NULL) 
-		*blp_p = blp;
-	return blp->diop;
+	d_histo[histo_idx(nbytes)]++;
 }
 
-static inline struct io *bilink_first_up(struct io *iop, struct bilink **blp_p)
+static inline struct io *io_first_list(struct list_head *head)
 {
-	struct bilink *blp;
-
-	if (list_empty(&iop->up_list))
+	if (list_empty(head))
 		return NULL;
-	blp = list_entry(iop->up_list.next, struct bilink, down_head);
 
-	if (blp_p != NULL) 
-		*blp_p = blp;
-	return blp->uiop;
+	return list_entry(head->next, struct io, f_head);
 }
 
-typedef void (*bilink_func)(struct io *diop, struct io *uiop, 
-							struct io *c_iop);
-static inline void bilink_for_each_down(bilink_func func, struct io *uiop,
-				        struct io *c_iop, int ul)
+static inline void __dump_iop(FILE *ofp, struct io *iop, int extra_nl)
 {
-	struct bilink *blp;
-	struct list_head *p, *q;
-
-	list_for_each_safe(p, q, &uiop->down_list) {
-		blp = list_entry(p, struct bilink, up_head);
-		func(blp->diop, uiop, c_iop);
-		if (ul)
-			biunlink(blp);
-	}
+	fprintf(ofp, "%5d.%09lu %3d,%-3d %c %10llu+%-4u\n",
+		(int)SECONDS(iop->t.time),
+		(unsigned long)NANO_SECONDS(iop->t.time),
+		MAJOR(iop->t.device), MINOR(iop->t.device), type2c(iop->type),
+		(unsigned long long)iop->t.sector, t_sec(&iop->t));
+	if (extra_nl) fprintf(ofp, "\n");
 }
 
-static inline int histo_idx(__u64 nbytes)
+static inline void __dump_iop2(FILE *ofp, struct io *a_iop, struct io *l_iop)
 {
-	int idx = (nbytes >> 9) - 1;
-	return min(idx, N_HIST_BKTS-1);
-}
-
-static inline void update_q_histo(__u64 nbytes)
-{
-	q_histo[histo_idx(nbytes)]++;
-}
-
-static inline void update_d_histo(__u64 nbytes)
-{
-	d_histo[histo_idx(nbytes)]++;
-}
-
-static inline void add_rmhd(struct io *iop)
-{
-	if (!iop->on_rm_list) {
-		list_add_tail(&iop->rm_head, &rmhd);
-		iop->on_rm_list = 1;
-	}
+	fprintf(ofp, "%5d.%09lu %3d,%-3d %c %10llu+%-4u <- (%3d,%-3d) %10llu\n",
+		(int)SECONDS(a_iop->t.time),
+		(unsigned long)NANO_SECONDS(a_iop->t.time),
+		MAJOR(a_iop->t.device), MINOR(a_iop->t.device), 
+		type2c(a_iop->type), (unsigned long long)a_iop->t.sector, 
+		t_sec(&a_iop->t), MAJOR(l_iop->t.device), 
+		MINOR(l_iop->t.device), (unsigned long long)l_iop->t.sector);
 }
diff --git a/btt/iostat.c b/btt/iostat.c
index 360d972..785029d 100644
--- a/btt/iostat.c
+++ b/btt/iostat.c
@@ -62,7 +62,7 @@ void dump_hdr(void)
 
 void im2d2c_func(struct io *c_iop, struct io *im_iop)
 {
-	ADD_STAT(c_iop->dip, wait, tdelta(im_iop, c_iop));
+	ADD_STAT(c_iop->dip, wait, tdelta(im_iop->t.time, c_iop->t.time));
 }
 
 void iostat_init(void)
@@ -247,7 +247,7 @@ void iostat_check_time(__u64 stamp)
 	}
 }
 
-void iostat_insert(struct io *iop)
+void iostat_getrq(struct io *iop)
 {
 	update_tot_qusz(iop->dip, TO_SEC(iop->t.time));
 	INC_STAT(iop->dip, cur_qusz);
@@ -295,5 +295,5 @@ void iostat_complete(struct io *d_iop, struct io *c_iop)
 	update_idle_time(dip, now, 0);
 	DEC_STAT(dip, cur_dev);
 
-	ADD_STAT(dip, svctm, tdelta(d_iop, c_iop));
+	ADD_STAT(dip, svctm, tdelta(d_iop->t.time, c_iop->t.time));
 }
diff --git a/btt/output.c b/btt/output.c
index 18d1d53..fd9392a 100644
--- a/btt/output.c
+++ b/btt/output.c
@@ -257,7 +257,6 @@ void output_dip_prep_ohead(FILE *ofp)
 	fprintf(ofp, "\n");
 }
 
-int n_seeks;
 struct seek_mode_info {
 	struct seek_mode_info *next;
 	long long mode;
@@ -267,12 +266,9 @@ struct o_seek_info {
 	long long nseeks, median;
 	double mean;
 	struct seek_mode_info *head;
-} seek_info = {
-	.nseeks = 0L,
-	.median = 0L,
-	.mean = 0.0,
-	.head = NULL
-};
+} seek_info;
+int n_seeks;
+
 void output_seek_mode_info(FILE *ofp, struct o_seek_info *sip)
 {
 	struct seek_mode_info *p, *this, *new_list = NULL;
@@ -280,46 +276,30 @@ void output_seek_mode_info(FILE *ofp, struct o_seek_info *sip)
 	ASSERT(sip->head != NULL);
 	while ((this = sip->head) != NULL) {
 		sip->head = this->next;
-		if (new_list == NULL) {
-			this->next = NULL;
+		this->next = NULL;
+
+		if (new_list == NULL || this->nseeks > new_list->nseeks)
 			new_list = this;
-			continue;
-		}
-		if (this->nseeks < new_list->nseeks) {
-			free(this);
-			continue;
-		}
-		if (this->nseeks > new_list->nseeks) {
-			while ((p = new_list) != NULL) {
-				new_list = p->next;
-				free(p);
-			}
-			this->next = NULL;
+		else if (this->nseeks == new_list->nseeks) {
+			assert(this->nseeks == new_list->nseeks);
+			for (p = new_list; p != NULL; p = p->next)
+				if (p->mode == this->mode)
+					break;
+
+			if (p)
+				this->nseeks += p->nseeks;
+			else
+				this->next = new_list;
 			new_list = this;
-			continue;
 		}
-		for (p = new_list; p; p++) 
-			if (p->mode == this->mode) {
-				this->nseeks += p->nseeks;
-				free(p);
-				break;
-			}
-		if (p)
-			p->next = new_list;
 	}
 
 	fprintf(ofp, "%10s | %15lld %15.1lf %15lld | %lld(%d)",
 	        "Average", sip->nseeks, sip->mean / sip->nseeks, 
 		sip->median / sip->nseeks, new_list->mode, new_list->nseeks);
 
-	p = new_list;
-	new_list = p->next;
-	free(p);
-	while((p = new_list) != NULL) {
-		fprintf(ofp, " %lld", p->mode);
-		new_list = p->next;
-		free(p);
-	}
+	for (p = new_list->next; p != NULL; p = p->next)
+		fprintf(ofp, " %lld(%d)", p->mode, p->nseeks);
 }
 
 void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
@@ -329,9 +309,9 @@ void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
 	struct seek_mode_info *smip;
 
 	n_seeks++;
-	for (i = 0; i < mp->nmds; i++) {
+	for (i = 0; i < mp->nmds; i++, lp++) {
 		for (smip = sip->head; smip; smip = smip->next) {
-			if (smip->mode == lp[i]) {
+			if (smip->mode == *lp) {
 				smip->nseeks += mp->most_seeks;
 				break;
 			}
@@ -341,7 +321,7 @@ void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
 
 			new->next = sip->head; 
 			sip->head = new;
-			new->mode = lp[i];
+			new->mode = *lp;
 			new->nseeks = mp->most_seeks;
 
 			add_buf(new);
@@ -349,7 +329,7 @@ void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
 	}
 }
 
-void __output_dip_seek_info(struct d_info *dip, void *arg)
+static void do_output_dip_seek_info(struct d_info *dip, FILE *ofp, int is_q2q)
 {
 	double mean;
 	int i, nmodes;
@@ -357,13 +337,13 @@ void __output_dip_seek_info(struct d_info *dip, void *arg)
 	char dev_info[15];
 	long long median;
 	struct mode m;
-	FILE *ofp = arg;
+	void *handle = is_q2q ? dip->q2q_handle : dip->seek_handle;
 
-	nseeks = seeki_nseeks(dip->seek_handle);
+	nseeks = seeki_nseeks(handle);
 	if (nseeks > 0) {
-		mean = seeki_mean(dip->seek_handle);
-		median = seeki_median(dip->seek_handle);
-		nmodes = seeki_mode(dip->seek_handle, &m);
+		mean = seeki_mean(handle);
+		median = seeki_median(handle);
+		nmodes = seeki_mode(handle, &m);
 
 		fprintf(ofp, "%10s | %15lld %15.1lf %15lld | %lld(%d)",
 			make_dev_hdr(dev_info, 15, dip), nseeks, mean, median, 
@@ -380,8 +360,21 @@ void __output_dip_seek_info(struct d_info *dip, void *arg)
 	}
 }
 
+void __output_dip_seek_info(struct d_info *dip, void *arg)
+{
+	do_output_dip_seek_info(dip, (FILE *)arg, 0);
+}
+
+void __output_dip_q2q_seek_info(struct d_info *dip, void *arg)
+{
+	do_output_dip_seek_info(dip, (FILE *)arg, 1);
+}
+
 void output_dip_seek_info(FILE *ofp)
 {
+	n_seeks = 1;
+	memset(&seek_info, 0, sizeof(seek_info));
+
 	fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", "DEV", "NSEEKS", 
 			"MEAN", "MEDIAN", "MODE");
 	fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
@@ -396,6 +389,25 @@ void output_dip_seek_info(FILE *ofp)
 	fprintf(ofp, "\n");
 }
 
+void output_dip_q2q_seek_info(FILE *ofp)
+{
+	n_seeks = 1;
+	memset(&seek_info, 0, sizeof(seek_info));
+
+	fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", "DEV", "NSEEKS", 
+			"MEAN", "MEDIAN", "MODE");
+	fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
+	dip_foreach_out(__output_dip_q2q_seek_info, ofp);
+	if (n_seeks > 1) {
+		fprintf(ofp, "---------- | --------------- --------------- --------------- | ---------------\n");
+		fprintf(ofp, "%10s | %15s %15s %15s | %-15s\n", 
+		        "Overall", "NSEEKS", "MEAN", "MEDIAN", "MODE");
+		output_seek_mode_info(ofp, &seek_info);
+		fprintf(ofp, "\n");
+	}
+	fprintf(ofp, "\n");
+}
+
 struct __opa {
 	FILE *ofp;
 	ai_pip_t (*func)(struct p_info *);
@@ -573,7 +585,10 @@ int output_avgs(FILE *ofp)
 	output_section_hdr(ofp, "Device Merge Information");
 	output_dip_merge_ratio(ofp);
 
-	output_section_hdr(ofp, "Device Seek Information");
+	output_section_hdr(ofp, "Device Q2Q Seek Information");
+	output_dip_q2q_seek_info(ofp);
+
+	output_section_hdr(ofp, "Device D2D Seek Information");
 	output_dip_seek_info(ofp);
 
 	output_section_hdr(ofp, "Plug Information");
diff --git a/btt/proc.c b/btt/proc.c
index e24948f..0756320 100644
--- a/btt/proc.c
+++ b/btt/proc.c
@@ -89,20 +89,7 @@ struct p_info *__find_process_name(char *name)
 	return NULL;
 }
 
-struct p_info *find_process(__u32 pid, char *name)
-{
-	struct p_info *pip;
-
-	if (pid != ((__u32)-1) && ((pip = __find_process_pid(pid)) != NULL))
-		return pip;
-
-	if (name)
-		return __find_process_name(name);
-
-	return NULL;
-}
-
-static void insert_pid(struct p_info *that)
+static void insert_pid(struct p_info *that, __u32 pid)
 {
 	struct pn_info *this;
 	struct rb_node *parent = NULL;
@@ -112,9 +99,9 @@ static void insert_pid(struct p_info *that)
 		parent = *p;
 		this = rb_entry(parent, struct pn_info, rb_node);
 
-		if (that->pid < this->u.pid)
+		if (pid < this->u.pid)
 			p = &(*p)->rb_left;
-		else if (that->pid > this->u.pid)
+		else if (pid > this->u.pid)
 			p = &(*p)->rb_right;
 		else {
 			ASSERT(strcmp(that->name, this->pip->name) == 0);
@@ -123,7 +110,7 @@ static void insert_pid(struct p_info *that)
 	}
 
 	this = malloc(sizeof(struct pn_info));
-	this->u.pid = that->pid;
+	this->u.pid = pid;
 	this->pip = that;
 
 	rb_link_node(&this->rb_node, parent, p);
@@ -160,22 +147,67 @@ static void insert_name(struct p_info *that)
 
 static void insert(struct p_info *pip)
 {
-	insert_pid(pip);
+	insert_pid(pip, pip->pid);
 	insert_name(pip);
 }
 
+static inline struct p_info *pip_alloc(void)
+{
+	return memset(malloc(sizeof(struct p_info)), 0, sizeof(struct p_info));
+}
+
+struct p_info *find_process(__u32 pid, char *name)
+{
+	struct p_info *pip;
+
+	if (pid != ((__u32)-1)) {
+		if ((pip = __find_process_pid(pid)) != NULL)
+			return pip;
+		else if (name) {
+			pip = __find_process_name(name);
+
+			if (pip && pid != pip->pid) {
+				/*
+				 * This is a process with the same name
+				 * as another, but a different PID.
+				 *
+				 * We'll store a reference in the PID
+				 * tree...
+				 */
+				insert_pid(pip, pid);
+			}
+			return pip;
+		}
+
+		/*
+		 * We're here because we have a pid, and no name, but
+		 * we didn't find a process ... 
+		 *
+		 * We'll craft one using the pid...
+		 */
+
+		name = alloca(256);
+		sprintf(name, "pid%09u", pid);
+		add_process(pid, name);
+		return __find_process_pid(pid);
+	}
+
+	assert(name != NULL);
+	return __find_process_name(name);
+}
+
 void add_process(__u32 pid, char *name)
 {
 	struct p_info *pip = find_process(pid, name);
 
 	if (pip == NULL) {
-		pip = memset(malloc(sizeof(*pip)), 0, sizeof(*pip));
+		pip = pip_alloc();
 		pip->pid = pid;
 		region_init(&pip->regions);
 		pip->last_q = (__u64)-1;
 		pip->name = strdup(name);
 
-		insert(pip);
+	 	insert(pip);
 	}
 }
 
diff --git a/btt/seek.c b/btt/seek.c
index 8738698..cbbd1a3 100644
--- a/btt/seek.c
+++ b/btt/seek.c
@@ -36,19 +36,15 @@ struct seeki {
 	long long last_start, last_end;
 };
 
-static FILE *seek_open(__u32 device, char rw)
+static FILE *seek_open(char *str, char rw)
 {
 	FILE *fp;
 	char *oname;
-	int mjr, mnr;
 
 	if (seek_name == NULL) return NULL;
 
-	mjr = device >> MINORBITS;
-	mnr = device & ((1 << MINORBITS) - 1);
-
-	oname = malloc(strlen(seek_name)+32);
-	sprintf(oname, "%s_%03d,%03d_%c.dat", seek_name, mjr, mnr, rw);
+	oname = malloc(strlen(seek_name) + strlen(str) + 32);
+	sprintf(oname, "%s_%s_%c.dat", seek_name, str, rw);
 	if ((fp = fopen(oname, "w")) == NULL)
 		perror(oname);
 	else
@@ -124,13 +120,13 @@ long long seek_dist(struct seeki *sip, struct io *iop)
 	return dist;
 }
 
-void *seeki_init(__u32 device)
+void *seeki_init(char *str)
 {
 	struct seeki *sip = malloc(sizeof(struct seeki));
 
-	sip->rfp = seek_open(device, 'r');
-	sip->wfp = seek_open(device, 'w');
-	sip->cfp = seek_open(device, 'c');
+	sip->rfp = seek_open(str, 'r');
+	sip->wfp = seek_open(str, 'w');
+	sip->cfp = seek_open(str, 'c');
 	sip->tot_seeks = 0;
 	sip->total_sectors = 0.0;
 	sip->last_start = sip->last_end = 0;
diff --git a/btt/trace.c b/btt/trace.c
index 7f8e689..1348e89 100644
--- a/btt/trace.c
+++ b/btt/trace.c
@@ -20,65 +20,9 @@
  */
 #include "globals.h"
 
-int dump_level;
-
-void __dump_iop(FILE *ofp, struct io *iop, int extra_nl)
-{
-	fprintf(ofp, "%5d.%09lu %3d,%-3d %c %10llu+%-4u\n",
-		(int)SECONDS(iop->t.time),
-		(unsigned long)NANO_SECONDS(iop->t.time),
-		MAJOR(iop->t.device), MINOR(iop->t.device), type2c(iop->type),
-		(unsigned long long)iop->t.sector, t_sec(&iop->t));
-	if (extra_nl) fprintf(ofp, "\n");
-}
-
-void __dump_iop2(FILE *ofp, struct io *a_iop, struct io *l_iop)
-{
-	fprintf(ofp, "%5d.%09lu %3d,%-3d %c %10llu+%-4u <- (%3d,%-3d) %10llu\n",
-		(int)SECONDS(a_iop->t.time),
-		(unsigned long)NANO_SECONDS(a_iop->t.time),
-		MAJOR(a_iop->t.device), MINOR(a_iop->t.device), 
-		type2c(a_iop->type), (unsigned long long)a_iop->t.sector, 
-		t_sec(&a_iop->t), MAJOR(l_iop->t.device), 
-		MINOR(l_iop->t.device), (unsigned long long)l_iop->t.sector);
-}
-
-void release_iops(void)
-{
-	struct io *x_iop;
-	struct list_head *p, *q;
-
-	list_for_each_safe(p, q, &rmhd) {
-		x_iop = list_entry(p, struct io, rm_head);
-		LIST_DEL(&x_iop->rm_head);
-		io_release(x_iop);
-	}
-}
-
-void do_retries(__u64 now)
-{
-	struct io *iop;
-	struct list_head *p, *q;
-
-	list_for_each_safe(p, q, &retries) {
-		iop = list_entry(p, struct io, retry);
-		ASSERT(iop->type == IOP_C);
-
-		// iop could be gone after call...
-		retry_complete(iop, now);
-	}
-}
-
-static inline int retry_check_time(__u64 t)
-{
-	return next_retry_check && (t > next_retry_check);
-}
-
 static void __add_trace(struct io *iop)
 {
 	time_t now = time(NULL);
-	__u64 tstamp = iop->t.time;
-	int run_retry = retry_check_time(iop->t.time);
 
 	n_traces++;
 	iostat_check_time(iop->t.time);
@@ -86,8 +30,8 @@ static void __add_trace(struct io *iop)
 	if (verbose && ((now - last_vtrace) > 0)) {
 
 #	if defined(DEBUG)
-		printf("%10lu t\tretries=|%10d|\ttree size=|%10d|\r", 
-			n_traces, list_len(&retries), rb_tree_size);
+		printf("%10lu t\ttree size=|%10d|\r", 
+			n_traces, rb_tree_size);
 #	else
 		printf("%10lu t\r", n_traces);
 #	endif
@@ -100,7 +44,8 @@ static void __add_trace(struct io *iop)
 	switch (iop->t.action & 0xffff) {
 	case __BLK_TA_QUEUE:		trace_queue(iop); break;
 	case __BLK_TA_REMAP:		trace_remap(iop); break;
-	case __BLK_TA_GETRQ:		trace_insert(iop); break;
+	case __BLK_TA_INSERT:		trace_insert(iop); break;
+	case __BLK_TA_GETRQ:		trace_getrq(iop); break;
 	case __BLK_TA_BACKMERGE:	trace_merge(iop); break;
 	case __BLK_TA_FRONTMERGE:	trace_merge(iop); break;
 	case __BLK_TA_REQUEUE:		trace_requeue(iop); break;
@@ -113,24 +58,21 @@ static void __add_trace(struct io *iop)
 		io_release(iop); 
 		return;
 	}
-
-	if (run_retry && !list_empty(&retries)) {
-		do_retries(tstamp);
-		bump_retry(tstamp);
-	}
 }
 
 void add_trace(struct io *iop)
 {
 	if (iop->t.action & BLK_TC_ACT(BLK_TC_NOTIFY)) {
-		if (iop->t.pid == 0) 
-			add_process(0, "kernel");
-		else {
-			char *slash = strchr(iop->pdu, '/');
-			if (slash)
-				*slash = '\0';
-
-			add_process(iop->t.pid, iop->pdu);
+		if (iop->t.action == BLK_TN_PROCESS) {
+			if (iop->t.pid == 0) 
+				add_process(0, "kernel");
+			else {
+				char *slash = strchr(iop->pdu, '/');
+				if (slash)
+					*slash = '\0';
+
+				add_process(iop->t.pid, iop->pdu);
+			}
 		}
 		io_release(iop);
 	}
diff --git a/btt/trace_complete.c b/btt/trace_complete.c
index b48bf79..c51d43d 100644
--- a/btt/trace_complete.c
+++ b/btt/trace_complete.c
@@ -20,170 +20,72 @@
  */
 #include "globals.h"
 
-LIST_HEAD(pending_cs);
-
-static inline void __run_complete(struct io *c_iop)
+static inline void __out(FILE *ofp, __u64 tm, enum iop_type type, 
+					__u64 sec, __u32 nsec, int indent)
 {
-	if (remapper_dev(c_iop->t.device)) {
-		struct bilink *blp = blp;
-		struct io *iop = bilink_first_down(c_iop, &blp);
-
-		if (iop->type == IOP_Q) {
-			run_queue(iop, c_iop, c_iop);
-			biunlink(blp);
-		}
-		else
-			bilink_for_each_down(run_remap, c_iop, c_iop, 1);
+	if (tm != (__u64)-1) {
+		if (indent) 
+			fprintf(ofp, "         ");
+		fprintf(ofp, "%5d.%09lu %c %10llu+%-4u\n", 
+			(int)SECONDS(tm), (unsigned long)NANO_SECONDS(tm),
+			type2c(type), (unsigned long long)sec, nsec);
 	}
-	else
-		bilink_for_each_down(run_issue, c_iop, c_iop, 1);
-
-	dump_iop(c_iop, 1);
-
-	LIST_DEL(&c_iop->c_pending);
-	del_retry(c_iop);
-	add_rmhd(c_iop);
+}
 
-	release_iops();
+static void display_io_track(FILE *ofp, struct io *iop)
+{
+	fprintf(ofp, "%3d,%-3d: ", MAJOR(iop->t.device), MINOR(iop->t.device));
+	__out(ofp, iop->t.time, IOP_Q, iop->t.sector, t_sec(&iop->t), 0);
+	__out(ofp, iop->i_time, IOP_I, iop->t.sector, t_sec(&iop->t), 1);
+	__out(ofp, iop->gm_time, iop->is_getrq ? IOP_G : IOP_M, 
+					iop->t.sector, t_sec(&iop->t), 1);
+	__out(ofp, iop->d_time, IOP_D, iop->d_sec, iop->d_nsec, 1);
+	__out(ofp, iop->c_time, IOP_C, iop->c_sec, iop->c_nsec, 1);
+	fprintf(ofp, "\n");
 }
 
-static int ready_complete_remapper(struct io *c_iop)
+static void handle_complete(struct io *c_iop)
 {
 	LIST_HEAD(head);
 	struct list_head *p, *q;
 
-	dip_foreach_list(c_iop, IOP_L, &head);
-	if (list_empty(&head)) {
-		struct io *q_iop;
-
-		dip_foreach_list(c_iop, IOP_Q, &head);
-		list_for_each_safe(p, q, &head) {
-			q_iop = list_entry(p, struct io, f_head);
-			LIST_DEL(&q_iop->f_head);
+	update_blks(c_iop);
+	update_cregion(&all_regions, c_iop->t.time);
+	update_cregion(&c_iop->dip->regions, c_iop->t.time);
+	if (c_iop->pip)
+		update_cregion(&c_iop->pip->regions, c_iop->t.time);
 
-			ASSERT(list_empty(&q_iop->up_list));
-			ASSERT(list_empty(&q_iop->down_list));
-			ASSERT(q_iop->t.bytes == c_iop->t.bytes);
-			if (ready_queue(q_iop, c_iop)) {
-				dip_rem(q_iop);
-				bilink(q_iop, c_iop);
-				c_iop->bytes_left -= q_iop->t.bytes;
-			}
-		}
-	}
-	else {
-		struct io *l_iop, *a_iop;
-
-		list_for_each_safe(p, q, &head) {
-			l_iop = list_entry(p, struct io, f_head);
-			LIST_DEL(&l_iop->f_head);
-
-			ASSERT(!list_empty(&l_iop->up_list));
-			a_iop = bilink_first_up(l_iop, NULL);
-			if (ready_remap(a_iop, c_iop)) {
-				dip_rem(l_iop);
-				bilink(a_iop, c_iop);
-				c_iop->bytes_left -= a_iop->t.bytes;
-			}
-		}
-	}
+	dip_foreach_list(c_iop, IOP_Q, &head);
+	list_for_each_safe(p, q, &head) {
+		struct io *q_iop = list_entry(p, struct io, f_head);
+		__u64 q2c = tdelta(q_iop->t.time, c_iop->t.time);
+		__u64 d2c = tdelta(q_iop->d_time, c_iop->t.time);
 
-	return c_iop->bytes_left == 0;
-}
+		c_iop->bytes_left -= q_iop->t.bytes;
 
-int ready_complete(struct io *c_iop)
-{
-	__u64 d2c;
-	struct io *d_iop;
+		update_q2c(q_iop, q2c);
+		latency_q2c(q_iop->dip, q_iop->t.time, q2c);
 
-	if (c_iop->bytes_left == 0)
-		return 1;
+		update_d2c(q_iop, d2c);
+		latency_d2c(q_iop->dip, c_iop->t.time, d2c);
+		iostat_complete(q_iop, c_iop);
 
-	if (remapper_dev(c_iop->t.device))
-		return ready_complete_remapper(c_iop);
-
-	if (!list_empty(&c_iop->down_list))
-		return 1;
-
-	d_iop = dip_find_sec(c_iop->dip, IOP_D, BIT_START(c_iop));
-	if (!d_iop)
-		return -1;
+		if (per_io_ofp) {
+			q_iop->c_time = c_iop->t.time;
+			q_iop->c_sec = c_iop->t.sector;
+			q_iop->c_nsec = t_sec(&c_iop->t);
+			display_io_track(per_io_ofp, q_iop);
+		}
 
-	if (c_iop->t.bytes != d_iop->t.bytes) {
-		fprintf(stderr, 
-			"\nFATAL: Probable time anomaly detected\n");
-		fprintf(stderr, 
-			"D @ %15.9lf missing C, later C @ %15.9lf\n", 
-			BIT_TIME(d_iop->t.time), 
-			BIT_TIME(c_iop->t.time));
-		exit(1);
+		LIST_DEL(&q_iop->f_head);
+		io_release(q_iop);
 	}
-
-	if (!ready_issue(d_iop, c_iop))
-		return 0;
-
-	c_iop->bytes_left = 0;
-
-	d2c = tdelta(d_iop, c_iop);
-	update_d2c(d_iop, d_iop->down_len, d2c);
-	latency_d2c(d_iop->dip, c_iop->t.time, d2c);
-	iostat_complete(d_iop, c_iop);
-
-	bilink(d_iop, c_iop);
-	dip_rem(d_iop);
-	return 1;
 }
 
 void trace_complete(struct io *c_iop)
 {
-	if (io_setup(c_iop, IOP_C)) {
-		update_blks(c_iop);
-		update_cregion(&all_regions, c_iop->t.time);
-		update_cregion(&c_iop->dip->regions, c_iop->t.time);
-		if (c_iop->pip)
-			update_cregion(&c_iop->pip->regions, c_iop->t.time);
+	if (io_setup(c_iop, IOP_C))
+		handle_complete(c_iop);
 
-		list_add_tail(&c_iop->c_pending, &pending_cs);
-		switch (ready_complete(c_iop)) {
-		case  1: 
-			__run_complete(c_iop); 
-			break;
-		case  0: 
-			add_retry(c_iop); 
-			break;
-		case -1: 
-			LIST_DEL(&c_iop->c_pending);
-			del_retry(c_iop);
-			io_release(c_iop);
-			break;
-		}
-	}
-	else 
-		io_release(c_iop);
-}
-
-void retry_complete(struct io *c_iop, __u64 now)
-{
-	double tc = BIT_TIME(c_iop->t.time);
-
-	switch (ready_complete(c_iop)) {
-	case  1: 
-#		if defined(DEBUG)
-			fprintf(stderr, "Retried %15.9lf success!\n", tc);
-#		endif
-
-		__run_complete(c_iop); 
-		break;
-	case  0:
-		if (now == 0 || ((BIT_TIME(now) - tc) < 1.0))
-			break;
-		if (!list_empty(&c_iop->down_list))
-			break;
-		/*FALLTHROUGH*/
-	case -1: 
-		LIST_DEL(&c_iop->c_pending);
-		del_retry(c_iop);
-		io_release(c_iop);
-		break;
-	}
+	io_release(c_iop);
 }
diff --git a/btt/trace_im.c b/btt/trace_im.c
index c16f1a8..f97c59b 100644
--- a/btt/trace_im.c
+++ b/btt/trace_im.c
@@ -20,88 +20,51 @@
  */
 #include "globals.h"
 
-static void __run_im(struct io *q_iop, struct io *im_iop, struct io *c_iop)
+static void handle_igm(struct io *igm_iop)
 {
-	run_queue(q_iop, im_iop, c_iop);
-	dump_iop(im_iop, 0);
-}
-
-static void __run_unim(struct io *q_iop, struct io *im_iop, 
-		       __attribute__((__unused__))struct io *c_iop)
-{
-	if (q_iop->bytes_left == 0) {
-		q_iop->linked = dip_rb_ins(q_iop->dip, q_iop);
-		ASSERT(q_iop->linked);
+	LIST_HEAD(head);
+	struct io *q_iop = dip_find_sec(igm_iop->dip, IOP_Q, igm_iop->t.sector);
 
-#		if defined(DEBUG)
-			rb_tree_size++;
-#		endif
+	if (igm_iop->type == IOP_I) {
+		if (q_iop)
+			q_iop->i_time = igm_iop->t.time;
+		return;
 	}
 
-	q_iop->bytes_left += im_iop->t.bytes;
-	unupdate_q2i(q_iop, tdelta(q_iop, im_iop));
-}
-
-void run_im(struct io *im_iop, __attribute__((__unused__))struct io *d_iop, 
-	    struct io *c_iop)
-{
-	bilink_for_each_down(__run_im, im_iop, c_iop, 1);
-	add_rmhd(im_iop);
-}
+	if (igm_iop->type == IOP_G) 
+		iostat_getrq(igm_iop);
+	else {
+		assert(igm_iop->type == IOP_M);
+		iostat_merge(igm_iop);
+	}
 
-void run_unim(struct io *im_iop, __attribute__((__unused__))struct io *d_iop, 
-	      struct io *c_iop)
-{
-	bilink_for_each_down(__run_unim, im_iop, c_iop, 1);
-	add_rmhd(im_iop);
+	if (q_iop) {
+		update_q2i(q_iop, tdelta(q_iop->t.time, igm_iop->t.time));
+		q_iop->gm_time = igm_iop->t.time;
+		q_iop->is_getrq = (igm_iop->type == IOP_G);
+	}
 }
 
-int ready_im(struct io *im_iop, struct io *c_iop)
+void trace_insert(struct io *i_iop)
 {
-	if (im_iop->bytes_left > 0) {
-		__u64 xfer;
-		LIST_HEAD(head);
-		struct io *q_iop;
-		struct list_head *p, *q;
-
-		dip_foreach_list(im_iop, IOP_Q, &head);
-		list_for_each_safe(p, q, &head) {
-			q_iop = list_entry(p, struct io, f_head);
-			LIST_DEL(&q_iop->f_head);
-
-			if (ready_queue(q_iop, c_iop)) {
-				update_q2i(q_iop, tdelta(q_iop, im_iop));
-
-				bilink(q_iop, im_iop);
-				dip_rem(q_iop);
-
-				xfer = min(im_iop->bytes_left, 
-							    q_iop->bytes_left);
-				im_iop->bytes_left -= xfer;
-				q_iop->bytes_left -= xfer;
-
-				if (q_iop->bytes_left == 0)
-					dip_rem(q_iop);
-			}
-		}
-	}
+	if (io_setup(i_iop, IOP_I))
+		handle_igm(i_iop);
 
-	return im_iop->bytes_left == 0;
+	io_release(i_iop);
 }
 
-void trace_insert(struct io *i_iop)
+void trace_getrq(struct io *g_iop)
 {
-	if (io_setup(i_iop, IOP_I))
-		iostat_insert(i_iop);
-	else
-		io_release(i_iop);
+	if (io_setup(g_iop, IOP_G))
+		handle_igm(g_iop);
 
+	io_release(g_iop);
 }
 
 void trace_merge(struct io *m_iop)
 {
 	if (io_setup(m_iop, IOP_M))
-		iostat_merge(m_iop);
-	else
-		io_release(m_iop);
+		handle_igm(m_iop);
+
+	io_release(m_iop);
 }
diff --git a/btt/trace_issue.c b/btt/trace_issue.c
index d2b0832..8b1571a 100644
--- a/btt/trace_issue.c
+++ b/btt/trace_issue.c
@@ -20,71 +20,38 @@
  */
 #include "globals.h"
 
-static void __run_issue(struct io *im_iop, struct io *d_iop, struct io *c_iop)
+static void handle_issue(struct io *d_iop)
 {
-	update_i2d(im_iop, tdelta(im_iop, d_iop));
-	run_im(im_iop, d_iop, c_iop);
-	dump_iop(d_iop, 0);
-}
-
-static void __run_unissue(struct io *im_iop, struct io *d_iop, 
-			  struct io *c_iop)
-{
-	unupdate_i2d(im_iop, tdelta(im_iop, d_iop));
-	run_unim(im_iop, d_iop, c_iop);
-}
-
-void run_issue(struct io *d_iop, __attribute__((__unused__))struct io *u_iop, 
-							struct io *c_iop)
-{
-	bilink_for_each_down(__run_issue, d_iop, c_iop, 1);
-	add_rmhd(d_iop);
-}
-
-void run_unissue(struct io *d_iop, 
-		 __attribute__((__unused__))struct io *u_iop, 
-		 struct io *c_iop)
-{
-	bilink_for_each_down(__run_unissue, d_iop, c_iop, 1);
-	add_rmhd(d_iop);
-}
-
-int ready_issue(struct io *d_iop, struct io *c_iop)
-{
-	if (d_iop->bytes_left > 0) {
-		LIST_HEAD(head);
-		struct io *im_iop;
-		struct list_head *p, *q;
-
-		dip_foreach_list(d_iop, IOP_I, &head);
-		dip_foreach_list(d_iop, IOP_M, &head);
-		list_for_each_safe(p, q, &head) {
-			im_iop = list_entry(p, struct io, f_head);
-			LIST_DEL(&im_iop->f_head);
-
-			ASSERT(d_iop->bytes_left >= im_iop->t.bytes);
-			if (ready_im(im_iop, c_iop)) {
-				bilink(im_iop, d_iop);
-				dip_rem(im_iop);
-				d_iop->bytes_left -= im_iop->t.bytes;
-			}
-		}
+	LIST_HEAD(head);
+	struct list_head *p, *q;
+
+	seeki_add(d_iop->dip->seek_handle, d_iop);
+	bno_dump_add(d_iop->dip->bno_dump_handle, d_iop);
+	iostat_issue(d_iop);
+	d_iop->dip->n_ds++;
+	if (!remapper_dev(d_iop->t.device))
+		update_d_histo(d_iop->t.bytes);
+
+	dip_foreach_list(d_iop, IOP_Q, &head);
+	list_for_each_safe(p, q, &head) {
+		struct io *q_iop = list_entry(p, struct io, f_head);
+		
+		update_i2d(q_iop, tdelta(q_iop->gm_time, d_iop->t.time));
+		d_iop->bytes_left -= q_iop->t.bytes;
+		LIST_DEL(&q_iop->f_head);
+
+		q_iop->d_time = d_iop->t.time;
+		q_iop->d_sec = d_iop->t.sector;
+		q_iop->d_nsec = t_sec(&d_iop->t);
 	}
 
-	return d_iop->bytes_left == 0;
+	assert(d_iop->bytes_left == 0);
 }
 
 void trace_issue(struct io *d_iop)
 {
-	if (io_setup(d_iop, IOP_D)) {
-		seeki_add(d_iop->dip->seek_handle, d_iop);
-		bno_dump_add(d_iop->dip->bno_dump_handle, d_iop);
-		iostat_issue(d_iop);
-		d_iop->dip->n_ds++;
-		if (!remapper_dev(d_iop->t.device))
-			update_d_histo(d_iop->t.bytes);
-	}
-	else
-		io_release(d_iop);
+	if (io_setup(d_iop, IOP_D))
+		handle_issue(d_iop);
+	io_release(d_iop);
 
 }
diff --git a/btt/trace_queue.c b/btt/trace_queue.c
index ad5e30c..f882ad2 100644
--- a/btt/trace_queue.c
+++ b/btt/trace_queue.c
@@ -20,60 +20,24 @@
  */
 #include "globals.h"
 
-static inline void __update_q2c(struct io *q_iop, struct io *c_iop)
+static void handle_queue(struct io *q_iop)
 {
-	__u64 q2c = tdelta(q_iop, c_iop);
-
-	update_q2c(q_iop, q2c);
-	latency_q2c(q_iop->dip, q_iop->t.time, q2c);
-}
-
-void run_queue(struct io *q_iop, __attribute__((__unused__))struct io *u_iop,
-	       struct io *c_iop)
-{
-	struct bilink *blp;
-	struct io *a_iop = bilink_first_down(q_iop, &blp);
-
-	if (a_iop) {
-		run_remap(a_iop, q_iop, c_iop);
-		biunlink(blp);
-	}
-
-	__update_q2c(q_iop, c_iop);
-	dump_iop(q_iop, 0);
-	add_rmhd(q_iop);
-}
-
-int ready_queue(struct io *q_iop, struct io *c_iop)
-{
-	struct io *a_iop;
-
-	if (!list_empty(&q_iop->down_list))
-		return 1;
-
-	a_iop = dip_find_sec(q_iop->dip, IOP_A, BIT_START(q_iop));
-	if (!a_iop)
-		return 1;
-
-	if (!ready_remap(a_iop, c_iop))
-		return 0;
-
-	ASSERT(q_iop->t.bytes == a_iop->t.bytes);
-	bilink(a_iop, q_iop);
-	dip_rem(a_iop);
-	return 1;
+	seeki_add(q_iop->dip->q2q_handle, q_iop);
+	update_lq(&last_q, &all_avgs.q2q, q_iop->t.time);
+	update_qregion(&all_regions, q_iop->t.time);
+	dip_update_q(q_iop->dip, q_iop);
+	pip_update_q(q_iop);
+	if (!remapper_dev(q_iop->t.device))
+		update_q_histo(q_iop->t.bytes);
+
+	q_iop->i_time = q_iop->gm_time = q_iop->d_time = (__u64)-1;
+	q_iop->is_getrq = -1;
 }
 
 void trace_queue(struct io *q_iop)
 {
-	if (io_setup(q_iop, IOP_Q)) {
-		update_lq(&last_q, &all_avgs.q2q, q_iop->t.time);
-		update_qregion(&all_regions, q_iop->t.time);
-		dip_update_q(q_iop->dip, q_iop);
-		pip_update_q(q_iop);
-		if (!remapper_dev(q_iop->t.device))
-			update_q_histo(q_iop->t.bytes);
-	}
+	if (io_setup(q_iop, IOP_Q))
+		handle_queue(q_iop);
 	else
 		io_release(q_iop);
 }
diff --git a/btt/trace_remap.c b/btt/trace_remap.c
index c5203e8..1e11ddc 100644
--- a/btt/trace_remap.c
+++ b/btt/trace_remap.c
@@ -20,95 +20,23 @@
  */
 #include "globals.h"
 
-void run_remap(struct io *a_iop, __attribute__((__unused__)) struct io *u_iop,
-				 struct io *c_iop)
-{
-	struct bilink *blp = blp, *blp2;
-	struct io *q_iop, *l_iop = bilink_first_down(a_iop, &blp);
-
-	ASSERT(l_iop);
-	q_iop = bilink_first_down(l_iop, &blp2);
-	if (q_iop) {
-		run_queue(q_iop, a_iop, c_iop);
-		biunlink(blp2);
-	}
-
-	dump_iop2(a_iop, l_iop);
-	biunlink(blp);
-
-	add_rmhd(l_iop);
-	add_rmhd(a_iop);
-}
-
-int ready_dev_remap(struct io *l_iop, struct io *c_iop)
+static void handle_remap(struct io *a_iop)
 {
+	struct blk_io_trace_remap *rp = a_iop->pdu;
 	struct io *q_iop;
 
-	if (!list_empty(&l_iop->down_list)) 
-		return 1;
-
-	q_iop = dip_find_sec(l_iop->dip, IOP_Q, l_iop->t.sector);
-	if (!q_iop || !ready_queue(q_iop, c_iop))
-		return 0;
-
-	ASSERT(l_iop->t.bytes <= q_iop->t.bytes);
-	update_q2a(q_iop, tdelta(q_iop, l_iop));
-	bilink(q_iop, l_iop);
-
-	q_iop->bytes_left -= l_iop->t.bytes;
-	if (q_iop->bytes_left == 0)
-		dip_rem(q_iop);
-	return 1;
-}
-
-int ready_self_remap(struct io *l_iop)
-{
-	struct io *a_iop = dip_find_sec(l_iop->dip, IOP_A, l_iop->t.sector);
-
-	if (a_iop) {
-		update_q2a(a_iop, tdelta(a_iop, l_iop));
-		dip_rem(a_iop);
-	}
-
-	return 1;
-}
-
-int ready_remap(struct io *a_iop, struct io *c_iop)
-{
-	struct io *l_iop = bilink_first_down(a_iop, NULL);
-
-	ASSERT(l_iop);
-	if (remapper_dev(l_iop->t.device))
-		return ready_dev_remap(l_iop, c_iop);
-	else
-		return ready_self_remap(l_iop);
+	q_iop = dip_find_sec(a_iop->dip, IOP_Q, be64_to_cpu(rp->sector));
+	if (q_iop) 
+		update_q2a(q_iop, tdelta(q_iop->t.time, a_iop->t.time));
 }
 
 void trace_remap(struct io *a_iop)
 {
-	struct io *l_iop;
 	struct blk_io_trace_remap *rp = a_iop->pdu;
 
 	a_iop->t.device = be32_to_cpu(rp->device_from);
-	if (!io_setup(a_iop, IOP_A)) {
-		io_release(a_iop);
-		return;
-	}
-
-	l_iop = io_alloc();
-	memcpy(&l_iop->t, &a_iop->t, sizeof(a_iop->t));
-	if (l_iop->t.pdu_len) {
-		l_iop->pdu = malloc(l_iop->t.pdu_len);
-		memcpy(l_iop->pdu, a_iop->pdu, l_iop->t.pdu_len);
-	}
-
-	l_iop->t.device = be32_to_cpu(rp->device);
-	l_iop->t.sector = be64_to_cpu(rp->sector);
-	if (!io_setup(l_iop, IOP_L)) {
-		io_release(l_iop);
-		io_release(a_iop);
-		return;
-	}
+	if (io_setup(a_iop, IOP_A))
+		handle_remap(a_iop);
 
-	bilink(l_iop, a_iop);
+	io_release(a_iop);
 }
diff --git a/btt/trace_requeue.c b/btt/trace_requeue.c
index 4baf66e..db5f7b7 100644
--- a/btt/trace_requeue.c
+++ b/btt/trace_requeue.c
@@ -22,24 +22,5 @@
 
 void trace_requeue(struct io *r_iop)
 {
-	struct io *d_iop;
-
-	if ((io_setup(r_iop, IOP_R) == 0) ||
-	    (d_iop = dip_find_sec(r_iop->dip, IOP_D, 
-	    					BIT_START(r_iop))) == NULL) {
-		io_release(r_iop);
-		return;
-	}
-	dip_rem(d_iop);
-
-#	if defined(DEBUG)
-		ASSERT(ready_issue(d_iop, r_iop) != 0);
-#	else
-		(void)ready_issue(d_iop, r_iop);
-#	endif
-
-	run_unissue(d_iop, r_iop, r_iop);
-	add_rmhd(r_iop);
-
-	release_iops();
+	io_release(r_iop);
 }

--------------080505050105020206020700--
