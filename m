From: Eric Sandeen <sandeen@redhat.com>
Date: Wed, 29 Jun 2016 17:02:20 +0000
Subject: [PATCH] blktrace: handle failed BLKTRACESETUP gracefully
Message-Id: <98700be9-4c65-7ee7-65b1-673b8629218e@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Today if BLKTRACESETUP fails, we carry on and try to tear
down things at the end of the run, leading to lots of
error spew.

This can be seen, for example, with:

# blktrace -d /dev/sda -w 10 &
# kill -9 %1
# blktrace -d /dev/sda -w 10

(In this case, debugfs files remain, so the 2nd blktrace setup
fails in a rather cryptic way, stating "No such file or directory"
when in fact the problem is more like EEXIST, but that's another
long sad story about debugfs).

If BLKTRACESETUP fails, we can remove that devpath from the
list so no further actions are taken on it.  If no devpaths
remain, just exit.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Please do give this a proper review, as I may well have missed
something :)

I think one side effect of this is that now, nothing will try
to clean up the debugfs paths, so the leftover state from
a killed/crashed prior run can only be removed with the
undocumented "-k" option ...

diff --git a/blktrace.c b/blktrace.c
index b445524..a1d29ef 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1059,9 +1059,9 @@ static void close_client_connections(void)
 
 static void setup_buts(void)
 {
-	struct list_head *p;
+	struct list_head *p, *q;
 
-	__list_for_each(p, &devpaths) {
+	list_for_each_safe(p, q, &devpaths) {
 		struct blk_user_trace_setup buts;
 		struct devpath *dpp = list_entry(p, struct devpath, head);
 
@@ -1077,9 +1077,13 @@ static void setup_buts(void)
 				free(dpp->stats);
 			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
 			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
-		} else
+		} else {
 			fprintf(stderr, "BLKTRACESETUP(2) %s failed: %d/%s\n",
 				dpp->path, errno, strerror(errno));
+			list_del(&dpp->head);
+			dpp_free(dpp);
+			ndevs--;
+		}
 	}
 }
 
@@ -2626,6 +2630,9 @@ static int run_tracers(void)
 
 	setup_buts();
 
+	if (list_empty(&devpaths))
+		return 1;
+
 	if (use_tracer_devpaths()) {
 		if (setup_tracer_devpaths())
 			return 1;

