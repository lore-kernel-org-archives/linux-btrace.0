From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 22 May 2019 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20190522120001.8A2042C00A7@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 10df4b691a68dd440547e393b6d241fc54fd2fad:

  iowatcher: spawn NPROCESSORS_ONLN for rsvg-convert-s (2018-08-31 14:57:57 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to a7263b8fb22f07f4f1a3ec54f0c37193c5908b22:

  blkparse: add support sort program by io event (2019-05-21 08:06:08 -0600)

----------------------------------------------------------------
Weiping Zhang (1):
      blkparse: add support sort program by io event

 blkparse.c     | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/blkparse.1 |  15 ++++++
 2 files changed, 169 insertions(+), 2 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 227cc44..3de2ebe 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -100,6 +100,19 @@ struct per_process_info {
 #define PPI_HASH_SHIFT	(8)
 #define PPI_HASH_SIZE	(1 << PPI_HASH_SHIFT)
 #define PPI_HASH_MASK	(PPI_HASH_SIZE - 1)
+
+enum {
+	SORT_PROG_EVENT_N,   /* Program Name */
+	SORT_PROG_EVENT_QKB, /* KB: Queued read and write */
+	SORT_PROG_EVENT_RKB, /* KB: Queued Read */
+	SORT_PROG_EVENT_WKB, /* KB: Queued Write */
+	SORT_PROG_EVENT_CKB, /* KB: Complete */
+	SORT_PROG_EVENT_QIO, /* IO: Queued read and write */
+	SORT_PROG_EVENT_RIO, /* IO: Queued Read */
+	SORT_PROG_EVENT_WIO, /* IO: Queued Write */
+	SORT_PROG_EVENT_CIO, /* IO: Complete */
+};
+
 static struct per_process_info *ppi_hash_table[PPI_HASH_SIZE];
 static struct per_process_info *ppi_list;
 static int ppi_list_entries;
@@ -189,6 +202,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 's'
 	},
+	{
+		.name = "sort-program-stats",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'S'
+	},
 	{
 		.name = "track-ios",
 		.has_arg = no_argument,
@@ -269,6 +288,7 @@ static unsigned long long stopwatch_end = -1ULL;	/* "infinity" */
 static unsigned long read_sequence;
 
 static int per_process_stats;
+static int per_process_stats_event = SORT_PROG_EVENT_N;
 static int per_device_and_cpu_stats = 1;
 static int track_ios;
 static int ppi_hash_by_pid = 1;
@@ -1758,6 +1778,88 @@ static int ppi_name_compare(const void *p1, const void *p2)
 	return res;
 }
 
+static int ppi_event_compare(const void *p1, const void *p2)
+{
+	struct per_process_info *ppi1 = *((struct per_process_info **) p1);
+	struct per_process_info *ppi2 = *((struct per_process_info **) p2);
+	struct io_stats *ios1 = &ppi1->io_stats;
+	struct io_stats *ios2 = &ppi2->io_stats;
+	unsigned long io1, io2;
+	unsigned long long kb1,kb2;
+	int sort_by_kb = 1;
+
+	io1 = io2 = 0;
+	kb1 = kb2 = 0;
+
+	switch (per_process_stats_event) {
+	case SORT_PROG_EVENT_QKB: /* KB: Queued read and write */
+		kb1 = ios1->qwrite_kb + (ios1->qwrite_b>>10) +
+			ios1->qread_kb + (ios1->qread_b>>10);
+		kb2 = ios2->qwrite_kb + (ios2->qwrite_b>>10) +
+			ios2->qread_kb + (ios2->qread_b>>10);
+		break;
+	case SORT_PROG_EVENT_RKB: /* KB: Queued Read */
+		kb1 = ios1->qread_kb + (ios1->qread_b>>10);
+		kb2 = ios2->qread_kb + (ios2->qread_b>>10);
+		break;
+	case SORT_PROG_EVENT_WKB: /* KB: Queued Write */
+		kb1 = ios1->qwrite_kb + (ios1->qwrite_b>>10);
+		kb2 = ios2->qwrite_kb + (ios2->qwrite_b>>10);
+		break;
+	case SORT_PROG_EVENT_CKB: /* KB: Complete */
+		kb1 = ios1->cwrite_kb + (ios1->cwrite_b>>10) +
+			ios1->cread_kb + (ios1->cread_b>>10);
+		kb2 = ios2->cwrite_kb + (ios2->cwrite_b>>10) +
+			ios2->cread_kb + (ios2->cread_b>>10);
+		break;
+	case SORT_PROG_EVENT_QIO: /* IO: Queued read and write */
+		sort_by_kb = 0;
+		io1 = ios1->qreads + ios1->qwrites;
+		io2 = ios2->qreads + ios2->qwrites;
+		break;
+	case SORT_PROG_EVENT_RIO: /* IO: Queued Read */
+		sort_by_kb = 0;
+		io1 = ios1->qreads;
+		io2 = ios2->qreads;
+		break;
+	case SORT_PROG_EVENT_WIO: /* IO: Queued Write */
+		sort_by_kb = 0;
+		io1 = ios1->qwrites;
+		io2 = ios2->qwrites;
+		break;
+	case SORT_PROG_EVENT_CIO: /* IO: Complete */
+		sort_by_kb = 0;
+		io1 = ios1->creads + ios1->cwrites;
+		io2 = ios2->creads + ios2->cwrites;
+		break;
+	}
+
+
+	/* compare kb */
+	if (sort_by_kb) {
+		if (kb1 > kb2)
+			return 1;
+		else if (kb1 = kb2)
+			return 0;
+		return -1;
+	}
+
+	/* compare io */
+	if (io1 > io2)
+		return 1;
+	else if (io1 = io2)
+		return 0;
+	return -1;
+}
+
+static int ppi_compare(const void *p1, const void *p2)
+{
+	if (per_process_stats_event = SORT_PROG_EVENT_N)
+		return ppi_name_compare(p1, p2);
+
+	return ppi_event_compare(p1, p2);
+}
+
 static void sort_process_list(void)
 {
 	struct per_process_info **ppis;
@@ -1772,7 +1874,7 @@ static void sort_process_list(void)
 		ppi = ppi->list_next;
 	}
 
-	qsort(ppis, ppi_list_entries, sizeof(ppi), ppi_name_compare);
+	qsort(ppis, ppi_list_entries, sizeof(ppi), ppi_compare);
 
 	i = ppi_list_entries - 1;
 	ppi_list = NULL;
@@ -2730,7 +2832,46 @@ static int is_pipe(const char *str)
 	return 0;
 }
 
-#define S_OPTS  "a:A:b:D:d:f:F:hi:o:Oqstw:vVM"
+static int get_program_sort_event(const char *str)
+{
+	char evt = str[0];
+
+	switch (evt) {
+	case 'N':
+		per_process_stats_event = SORT_PROG_EVENT_N;
+		break;
+	case 'Q':
+		per_process_stats_event = SORT_PROG_EVENT_QKB;
+		break;
+	case 'q':
+		per_process_stats_event = SORT_PROG_EVENT_QIO;
+		break;
+	case 'R':
+		per_process_stats_event = SORT_PROG_EVENT_RKB;
+		break;
+	case 'r':
+		per_process_stats_event = SORT_PROG_EVENT_RIO;
+		break;
+	case 'W':
+		per_process_stats_event = SORT_PROG_EVENT_WKB;
+		break;
+	case 'w':
+		per_process_stats_event = SORT_PROG_EVENT_WIO;
+		break;
+	case 'C':
+		per_process_stats_event = SORT_PROG_EVENT_CKB;
+		break;
+	case 'c':
+		per_process_stats_event = SORT_PROG_EVENT_CIO;
+		break;
+	default:
+		return 1;
+	}
+
+	return 0;
+}
+
+#define S_OPTS  "a:A:b:D:d:f:F:hi:o:OqsS:tw:vVM"
 static char usage_str[] =    "\n\n" \
 	"-i <file>           | --input=<file>\n" \
 	"[ -a <action field> | --act-mask=<action field> ]\n" \
@@ -2745,6 +2886,7 @@ static char usage_str[] =    "\n\n" \
 	"[ -O                | --no-text-output ]\n" \
 	"[ -q                | --quiet ]\n" \
 	"[ -s                | --per-program-stats ]\n" \
+	"[ -S <event>        | --sort-program-stats=<event> ]\n" \
 	"[ -t                | --track-ios ]\n" \
 	"[ -w <time>         | --stopwatch=<time> ]\n" \
 	"[ -M                | --no-msgs\n" \
@@ -2764,6 +2906,11 @@ static char usage_str[] =    "\n\n" \
 	"\t-O Do NOT output text data\n" \
 	"\t-q Quiet. Don't display any stats at the end of the trace\n" \
 	"\t-s Show per-program io statistics\n" \
+	"\t-S Show per-program io statistics sorted by N/Q/q/R/r/W/w/C/c\n" \
+	"\t   N:Name, Q/q:Queued(read & write), R/r:Queued Read, W/w:Queued Write, C/c:Complete.\n" \
+	"\t   Sort programs by how much data(KB): Q,R,W,C.\n" \
+	"\t   Sort programs by how many IO operations: q,r,w,c.\n" \
+	"\t   if -S was used, the -s parameter will be ignored.\n" \
 	"\t-t Track individual ios. Will tell you the time a request took\n" \
 	"\t   to get queued, to get dispatched, and to get completed\n" \
 	"\t-w Only parse data between the given time interval in seconds.\n" \
@@ -2830,6 +2977,11 @@ int main(int argc, char *argv[])
 		case 's':
 			per_process_stats = 1;
 			break;
+		case 'S':
+			per_process_stats = 1;
+			if (get_program_sort_event(optarg))
+				return 1;
+			break;
 		case 't':
 			track_ios = 1;
 			break;
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index cb21fea..627b7b1 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -165,6 +165,21 @@ Quiet mode
 Displays data sorted by program
 .RE
 
+\-S \fIevent\fR
+.br
+\-\-sort\-program\-stats=\fIevent\fR
+.br
+.RS
+Displays each program's data sorted by program name or io event, like
+Queued, Read, Write and Complete. When \-S is specified the \-s will be ignored.
+The capital letters Q,R,W,C stand for KB, then q/r/w/c stand for IO.
+
+If you want to soct programs by how many data they queued, you can use:
+
+blkparse -i sda.blktrace. -q \-S Q \-o sda.parse
+.RE
+
+
 \-t
 .br
 \-\-track\-ios
