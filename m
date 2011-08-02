From: Jeff Moyer <jmoyer@redhat.com>
Date: Tue, 02 Aug 2011 17:46:53 +0000
Subject: [patch,resend] blkparse: fix up incorrect pc write completion count
Message-Id: <x49y5zbso36.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I noticed in some traces that I was seeing summaries like the following:

Total (sde):
 Reads Queued:          76,      304KiB  Writes Queued:      16,384,    1,048MiB
 Read Dispatches:       76,      304KiB  Write Dispatches:    2,210,    1,048MiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:       76,      304KiB  Writes Completed:    2,210,    1,048MiB
 Read Merges:            0,        0KiB  Write Merges:       14,174,  907,136KiB
 PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
 PC Read Disp.:          4,        0KiB  PC Write Disp.:          0,        0KiB
 PC Reads Req.:          0               PC Writes Req.:          0
 PC Reads Compl.:        4               PC Writes Compl.:    2,210
 IO unplugs:         2,124               Timer unplugs:           0

Note how there were no PC Writes dispatched, but there were 2210
completed.  It turns out to be a minor typo in the code.  The attached
patch fixes the reporting for me.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---

Jens, any reason this hasn't been merged?


diff --git a/blkparse.c b/blkparse.c
index 7ee9f9d..8d5746f 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1675,7 +1675,7 @@ static void dump_io_stats(struct per_dev_info *pdi, struct io_stats *ios,
 		fprintf(ofp, " PC Reads Req.:   %s\t\t", size_cnv(x, ios->rrqueue_pc, 0));
 		fprintf(ofp, " PC Writes Req.:   %s\n", size_cnv(x, ios->wrqueue_pc, 0));
 		fprintf(ofp, " PC Reads Compl.: %s\t\t", size_cnv(x, ios->creads_pc, 0));
-		fprintf(ofp, " PC Writes Compl.: %s\n", size_cnv(x, ios->cwrites, 0));
+		fprintf(ofp, " PC Writes Compl.: %s\n", size_cnv(x, ios->cwrites_pc, 0));
 	}
 	fprintf(ofp, " IO unplugs:      %'8lu%8c\t", ios->io_unplugs, ' ');
 	fprintf(ofp, " Timer unplugs:    %'8lu\n", ios->timer_unplugs);
