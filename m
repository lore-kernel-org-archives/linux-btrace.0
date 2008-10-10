From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 10 Oct 2008 12:44:32 +0000
Subject: [PATCH] Removed excessive amounts of seek modes (for random sets
Message-Id: <48EF4E30.7040206@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020704010609070907030407"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------020704010609070907030407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Jens -

Pushed this out...

Alan

--------------020704010609070907030407
Content-Type: text/x-diff;
 name="0001-Removed-excessive-amounts-of-seek-modes-for-random.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Removed-excessive-amounts-of-seek-modes-for-random.patc";
 filename*1="h"

From abf63eafd11e42e0f065e56fc4773e6854087d41 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Fri, 10 Oct 2008 08:40:57 -0400
Subject: [PATCH] Removed excessive amounts of seek modes (for random sets of I/Os)

When doing a random load, we'd get a LARGE amount of single-seek buckets,
this patch just notes that fact, without dumping all the data...

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/output.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/btt/output.c b/btt/output.c
index 3076412..00ffce5 100644
--- a/btt/output.c
+++ b/btt/output.c
@@ -351,8 +351,12 @@ void output_seek_mode_info(FILE *ofp, struct o_seek_info *sip)
 	        "Average", sip->nseeks, sip->mean / sip->nseeks,
 		sip->median / sip->nseeks, new_list->mode, new_list->nseeks);
 
-	for (p = new_list->next; p != NULL; p = p->next)
-		fprintf(ofp, " %lld(%d)", p->mode, p->nseeks);
+	if (new_list->next) {
+		int i = 0;
+		for (p = new_list->next; p != NULL; p = p->next)
+			i++;
+		fprintf(ofp, "\n%10s   %15s %15s %15s   ...(%d more)\n", "", "", "", "", i);
+	}
 }
 
 void add_seek_mode_info(struct o_seek_info *sip, struct mode *mp)
@@ -401,9 +405,13 @@ static void do_output_dip_seek_info(struct d_info *dip, FILE *ofp, int is_q2q)
 		fprintf(ofp, "%10s | %15lld %15.1lf %15lld | %lld(%d)",
 			make_dev_hdr(dev_info, 15, dip, 1), nseeks, mean,
 			median, nmodes > 0 ? m.modes[0] : 0, m.most_seeks);
-		for (i = 1; i < nmodes; i++)
-			fprintf(ofp, " %lld", m.modes[i]);
-		fprintf(ofp, "\n");
+		if (nmodes > 2)
+			fprintf(ofp, "\n%10s   %15s %15s %15s   ...(%d more)\n", "", "", "", "", nmodes-1);
+		else  {
+			for (i = 1; i < nmodes; i++)
+				fprintf(ofp, " %lld", m.modes[i]);
+			fprintf(ofp, "\n");
+		}
 
 		if (easy_parse_avgs) {
 			char *rec = is_q2q ? "QSK" : "DSK";
-- 
1.5.4.3


--------------020704010609070907030407--
