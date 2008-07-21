From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 21 Jul 2008 13:51:08 +0000
Subject: [PATCH app] Change 'ack_mask' to 'cat mask'
Message-Id: <4884944C.1070906@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050001040807030701060209"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------050001040807030701060209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Note: I did /not/ change the '-a' option to blktrace, that would just
lead to more confusion than its worth (did, however, change the
long-format to cat-mask).


--------------050001040807030701060209
Content-Type: text/x-diff;
 name="0001-Changed-act_mask-to-cat_mask-Categories-not-actio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Changed-act_mask-to-cat_mask-Categories-not-actio.patch"

From 60579fdeecd25c4e2d62d9d3ebe96aa2b2c8f05c Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Mon, 21 Jul 2008 09:40:21 -0400
Subject: [PATCH] Changed act_mask to cat_mask - Categories, not actions

The mask actually pertains to /categories/ of actions - multiple actions
are encompassed w/in one category. This leads to confusion at the user
application level: one would /like/ to discriminate based upon individual
actions, we only support categories (for the moment).

This is preparatory to building a true action mask.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blkparse.c       |   16 ++++++++--------
 blktrace.c       |   14 +++++++-------
 blktrace_api.h   |    2 +-
 doc/blktrace.tex |    8 ++++----
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 3c31db6..52a2efe 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -268,7 +268,7 @@ static int per_device_and_cpu_stats = 1;
 static int track_ios;
 static int ppi_hash_by_pid = 1;
 static int verbose;
-static unsigned int act_mask = -1U;
+static unsigned int cat_mask = -1U;
 static int stats_printed;
 int data_is_native = -1;
 
@@ -2065,7 +2065,7 @@ static void show_entries_rb(int force)
 
 		pci->nelems++;
 
-		if (bit->action & (act_mask << BLK_TC_SHIFT))
+		if (bit->action & (cat_mask << BLK_TC_SHIFT))
 			dump_trace(bit, pci, pdi);
 
 		put_trace(pdi, t);
@@ -2453,7 +2453,7 @@ static int handle(struct ms_stream *msp)
 		return 0;
 
 	pdi->last_reported_time = bit->time;
-	if ((bit->action & (act_mask << BLK_TC_SHIFT))&&
+	if ((bit->action & (cat_mask << BLK_TC_SHIFT))&&
 	    t->bit->time >= stopwatch_start)
 		dump_trace(bit, pci, pdi);
 
@@ -2685,7 +2685,7 @@ static void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	int i, c, ret, mode;
-	int act_mask_tmp = 0;
+	int cat_mask_tmp = 0;
 	char *ofp_buffer = NULL;
 	char *bin_ofp_buffer = NULL;
 
@@ -2698,7 +2698,7 @@ int main(int argc, char *argv[])
 					optarg);
 				return 1;
 			}
-			act_mask_tmp |= i;
+			cat_mask_tmp |= i;
 			break;
 
 		case 'A':
@@ -2709,7 +2709,7 @@ int main(int argc, char *argv[])
 					optarg, i);
 				return 1;
 			}
-			act_mask_tmp = i;
+			cat_mask_tmp = i;
 			break;
 		case 'i':
 			if (is_pipe(optarg) && !pipeline) {
@@ -2784,8 +2784,8 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	if (act_mask_tmp != 0)
-		act_mask = act_mask_tmp;
+	if (cat_mask_tmp != 0)
+		cat_mask = cat_mask_tmp;
 
 	memset(&rb_sort_root, 0, sizeof(rb_sort_root));
 
diff --git a/blktrace.c b/blktrace.c
index 4d458ac..8892a33 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -246,7 +246,7 @@ static struct device_information *device_information;
 static char *debugfs_path;
 static char *output_name;
 static char *output_dir;
-static int act_mask = ~0U;
+static int cat_mask = ~0U;
 static int kill_running_trace;
 static unsigned long buf_size = BUF_SIZE;
 static unsigned long buf_nr = BUF_NR;
@@ -397,7 +397,7 @@ static int start_trace(struct device_information *dip)
 	memset(&buts, 0, sizeof(buts));
 	buts.buf_size = dip->buf_size;
 	buts.buf_nr = dip->buf_nr;
-	buts.act_mask = act_mask;
+	buts.cat_mask = cat_mask;
 
 	if (ioctl(dip->fd, BLKTRACESETUP, &buts) < 0) {
 		perror("BLKTRACESETUP");
@@ -1785,7 +1785,7 @@ int main(int argc, char *argv[])
 	struct statfs st;
 	int i, c;
 	int stop_watch = 0;
-	int act_mask_tmp = 0;
+	int cat_mask_tmp = 0;
 
 	while ((c = getopt_long(argc, argv, S_OPTS, l_opts, NULL)) >= 0) {
 		switch (c) {
@@ -1796,7 +1796,7 @@ int main(int argc, char *argv[])
 					optarg);
 				return 1;
 			}
-			act_mask_tmp |= i;
+			cat_mask_tmp |= i;
 			break;
 
 		case 'A':
@@ -1807,7 +1807,7 @@ int main(int argc, char *argv[])
 					optarg, i);
 				return 1;
 			}
-			act_mask_tmp = i;
+			cat_mask_tmp = i;
 			break;
 
 		case 'd':
@@ -1917,8 +1917,8 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	if (act_mask_tmp != 0)
-		act_mask = act_mask_tmp;
+	if (cat_mask_tmp != 0)
+		cat_mask = cat_mask_tmp;
 
 	if (!debugfs_path)
 		debugfs_path = default_debugfs_path;
diff --git a/blktrace_api.h b/blktrace_api.h
index 67720de..2b76d76 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -114,7 +114,7 @@ struct blk_io_trace_remap {
  */
 struct blk_user_trace_setup {
 	char name[32];			/* output */
-	__u16 act_mask;			/* input */
+	__u16 cat_mask;			/* input */
 	__u32 buf_size;			/* input */
 	__u32 buf_nr;			/* input */
 	__u64 start_lba;
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 82c35e8..1b79c73 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -384,7 +384,7 @@ of the more arcane command line options:
 \begin{tabular}{|l|l|l|}\hline
 Short              & Long                       & Description \\ \hline\hline
 -A \emph{hex-mask} & --set-mask=\emph{hex-mask} & Set filter mask to \emph{hex-mask} \\ \hline
--a \emph{mask}     & --act-mask=\emph{mask}     & Add \emph{mask} to current filter (see below for masks) \\ \hline
+-a \emph{mask}     & --cat-mask=\emph{mask}     & Add \emph{mask} to current filter (see below for masks) \\ \hline
 -b \emph{size}     & --buffer-size=\emph{size}  & Specifies buffer size for event extraction (scaled by $2^{10}$) \\ \hline
 -d \emph{dev}      & --dev=\emph{dev}           & Adds \emph{dev} as a device to trace \\ \hline
 -k                 & --kill                     & Kill on-going trace \\ \hline
@@ -398,9 +398,9 @@ Short              & Long                       & Description \\ \hline\hline
 \end{tabular}
 
 \subsubsection{\label{sec:filter-mask}Filter Masks}
-The following masks may be passed with the \emph{-a} command line
-option, multiple filters may be combined via multiple \emph{-a} command
-line options.\smallskip
+The following category masks may be passed with the \emph{-a} command
+line option, multiple filters may be combined via multiple \emph{-a}
+command line options.\smallskip
 
 \begin{tabular}{|l|l|}\hline
 barrier & \emph{barrier} attribute \\ \hline
-- 
1.5.4.3


--------------050001040807030701060209--
