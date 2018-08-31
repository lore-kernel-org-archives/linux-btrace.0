From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 31 Aug 2018 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20180831120002.A429E2C00A8@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 70d5ca2d5f3d6b97c11c641b7e0c5836983219a0:

  make btt scripts python3-ready (2018-05-16 13:09:58 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to f011d96f260a2be5dcc2ad9f4d1bf2d591946723:

  iowatcher: don't add Q events to the io hash (2018-08-30 20:57:53 -0600)

----------------------------------------------------------------
Jeff Moyer (1):
      iowatcher: don't add Q events to the io hash

 iowatcher/blkparse.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

---

Diff of recent changes:

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index c7d1d65..41e20f0 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -1099,16 +1099,28 @@ void add_pending_io(struct trace *trace, struct graph_line_data *gld)
 	if (action = __BLK_TA_QUEUE) {
 		if (io->sector = 0)
 			return;
-		if (trace->found_issue || trace->found_completion) {
-			pio = hash_queued_io(trace->io);
-			/*
-			 * When there are no ISSUE events count depth and
-			 * latency at least from queue events
-			 */
-			if (pio && !trace->found_issue) {
-				pio->dispatch_time = io->time;
-				goto account_io;
-			}
+		/*
+		 * If D (issue) events are available, use them for I/O
+		 * accounting.  Nothing needs to be done for Q.
+		 */
+		if (trace->found_issue)
+			return;
+		/*
+		 * If there are no D or C events, then all that can be
+		 * done is to account the Q event (and make sure not to
+		 * add the I/O to the hash, because it will never be
+		 * removed).
+		 */
+		if (!trace->found_completion)
+			goto account_io;
+		/*
+		 * When there are no ISSUE events, count depth and
+		 * latency from queue events.
+		 */
+		pio = hash_queued_io(trace->io);
+		if (pio) {
+			pio->dispatch_time = io->time;
+			goto account_io;
 		}
 		return;
 	}
