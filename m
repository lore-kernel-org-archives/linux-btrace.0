From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 30 Aug 2018 22:14:20 +0000
Subject: [patch] iowatcher: don't add Q events to the io hash
Message-Id: <x49wos7wlhf.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

Bryan Gurney reported iowatcher taking a *really* long time to generate
a movie for 16GiB worth of trace data.  I took a look, and the io hash
was growing without bounds.  The reason was that the I/O pattern looks
like this:

259,0    5        8     0.000208501 31708  A   W 5435592 + 8 <- (259,1) 5433544
259,1    5        9     0.000209537 31708  Q   W 5435592 + 8 [kvdo30:bioQ0]
259,1    5       10     0.000209880 31708  G   W 5435592 + 8 [kvdo30:bioQ0]
259,0    5       11     0.000211064 31708  A   W 5435600 + 8 <- (259,1) 5433552
259,1    5       12     0.000211347 31708  Q   W 5435600 + 8 [kvdo30:bioQ0]
259,1    5       13     0.000212957 31708  M   W 5435600 + 8 [kvdo30:bioQ0]
259,0    5       14     0.000213379 31708  A   W 5435608 + 8 <- (259,1) 5433560
259,1    5       15     0.000213629 31708  Q   W 5435608 + 8 [kvdo30:bioQ0]
259,1    5       16     0.000213937 31708  M   W 5435608 + 8 [kvdo30:bioQ0]
...
259,1    5      107     0.000246274 31708  D   W 5435592 + 256 [kvdo30:bioQ0]

For each of those Q events, an entry was created in the io_hash.  Then,
upon I/O completion, only the first event (with the right starting
sector) was removed!  The runtime overhead of just iterating the hash
chains was enormous.

The solution is to simply ignore the Q events, so long as there are D
events in the trace.  If there are no D events, then go ahead and hash
the Q events as before.  I'm hoping that if we only have Q and C, that
they will actually be aligned.  If that's an incorrect assumption, we
could account merges in an rbtree.  I'll defer that work until someone
can show me blktrace data that needs it.

The comments should be self explanatory.  Review would be appreciated
as the code isn't well documented, and I don't know if I'm missing some
hidden assumption about the data.

Before applying this patch, iowatcher would take more than 12 hours to
complete.  After the patch:

real	9m44.476s
user	41m35.426s
sys	3m29.106s

'nuf said.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

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
