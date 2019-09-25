From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 25 Sep 2019 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20190925120001.5EBDA2C02C1@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 667ac92a1a72b6038f0fae4acfc6a280fd69697b:

  btreplay: fix device IO remap functionality (2019-09-16 10:30:23 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 9c73da91540b27adaaf56065629e831cc50c5a3d:

  doc: tex: add absolute timestamp printing option (2019-09-25 00:22:13 -0600)

----------------------------------------------------------------
Hiroaki Mihara (4):
      blkparse: man: add absolute timestamp printing option
      blkparse: split off the timestamp correction code in to a separate function
      blkparse: fix absolute timestamp when reading from file
      doc: tex: add absolute timestamp printing option

 blkparse.c       | 37 +++++++++++++++++++++++++------------
 doc/blkparse.1   |  3 +++
 doc/blktrace.tex |  1 +
 3 files changed, 29 insertions(+), 12 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 3de2ebe..28bdf15 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2022,6 +2022,22 @@ static void show_device_and_cpu_stats(void)
 	}
 }
 
+static void correct_abs_start_time(void)
+{
+	long delta = genesis_time - start_timestamp;
+
+	abs_start_time.tv_sec  += SECONDS(delta);
+	abs_start_time.tv_nsec += NANO_SECONDS(delta);
+	if (abs_start_time.tv_nsec < 0) {
+		abs_start_time.tv_nsec += 1000000000;
+		abs_start_time.tv_sec -= 1;
+	} else
+	if (abs_start_time.tv_nsec > 1000000000) {
+		abs_start_time.tv_nsec -= 1000000000;
+		abs_start_time.tv_sec += 1;
+	}
+}
+
 static void find_genesis(void)
 {
 	struct trace *t = trace_list;
@@ -2039,18 +2055,7 @@ static void find_genesis(void)
 	 */
 	if (start_timestamp
 	 && start_timestamp != genesis_time) {
-		long delta = genesis_time - start_timestamp;
-
-		abs_start_time.tv_sec  += SECONDS(delta);
-		abs_start_time.tv_nsec += NANO_SECONDS(delta);
-		if (abs_start_time.tv_nsec < 0) {
-			abs_start_time.tv_nsec += 1000000000;
-			abs_start_time.tv_sec -= 1;
-		} else
-		if (abs_start_time.tv_nsec > 1000000000) {
-			abs_start_time.tv_nsec -= 1000000000;
-			abs_start_time.tv_sec += 1;
-		}
+		correct_abs_start_time();
 	}
 }
 
@@ -2704,6 +2709,14 @@ static int do_file(void)
 	if (ms_head)
 		genesis_time = ms_peek_time(ms_head);
 
+	/*
+	 * Correct abs_start_time if necessary
+	 */
+	if (start_timestamp
+	 && start_timestamp != genesis_time) {
+		correct_abs_start_time();
+	}
+
 	/*
 	 * Keep processing traces while any are left
 	 */
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 627b7b1..e494b6e 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -368,6 +368,9 @@ Elapsed value in microseconds (\fI\-t\fR command line option)
 .IP \fBU\fR 4
 Payload unsigned integer
 
+.IP \fBz\fR 4
+The absolute time, as local time in your time zone, with no date displayed
+
 .PP
 Note that the user can optionally specify field display width, and optionally a
 left-aligned specifier. These precede field specifiers, with a '%' character,
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 4d8278e..3647c75 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -613,6 +613,7 @@ the event's device \\
 \emph{T} & Time stamp (seconds) \\ \hline
 \emph{u} & Elapsed value in microseconds (\emph{-t} command line option) \\ \hline
 \emph{U} & Payload unsigned integer \\ \hline
+\emph{z} & Absolute time stamp \\ \hline
 \end{tabular}
 
 Note that the user can optionally specify field display width, and
