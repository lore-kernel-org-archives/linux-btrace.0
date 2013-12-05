From: Eiichi Tsukata <devel@etsukata.com>
Date: Thu, 05 Dec 2013 15:00:15 +0000
Subject: [PATCH] blktrace btt: Change bno_dump_add caller action from D-issued to C-complete
Message-Id: <1386255615-20912-1-git-send-email-devel@etsukata.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Currently btt -B option for bno_plot.py writes data when trace action is
"D-issued". But device mapper blktrace data do not contain "D" events, so
bno_plot.py can not plot block IO to dm-target.

This patche changes the caller of bno_dump_add which collects data for
bno_plot.py from handle_issue() to handle_complete(). Device mapper blktrace data
contain "C-complete" events, we can plot block IO to dm-target.

Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 btt/trace_complete.c | 1 +
 btt/trace_issue.c    | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/trace_complete.c b/btt/trace_complete.c
index 44732c5..7d7497c 100644
--- a/btt/trace_complete.c
+++ b/btt/trace_complete.c
@@ -57,6 +57,7 @@ static void handle_complete(struct io *c_iop)
 	FILE *pit_fp = c_iop->dip->pit_fp;
 	double cur = BIT_TIME(c_iop->t.time);
 
+	bno_dump_add(c_iop->dip->bno_dump_handle, c_iop);
 	update_blks(c_iop);
 	update_cregion(&all_regions, c_iop->t.time);
 	update_cregion(&c_iop->dip->regions, c_iop->t.time);
diff --git a/btt/trace_issue.c b/btt/trace_issue.c
index 976fe1c..46af64b 100644
--- a/btt/trace_issue.c
+++ b/btt/trace_issue.c
@@ -29,7 +29,6 @@ static void handle_issue(struct io *d_iop)
 		d_iop->dip->n_act_q--;
 
 	seeki_add(d_iop->dip->seek_handle, d_iop);
-	bno_dump_add(d_iop->dip->bno_dump_handle, d_iop);
 	iostat_issue(d_iop);
 	d_iop->dip->n_ds++;
 	if (!remapper_dev(d_iop->t.device))
-- 
1.8.3.1

