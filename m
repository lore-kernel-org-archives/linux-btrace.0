From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Mon, 26 Mar 2007 12:10:54 +0000
Subject: [PATCH BTT]: Re: typo?
Message-Id: <4607B84E.4030600@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060904030708070203000700"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060904030708070203000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060904030708070203000700
Content-Type: text/plain;
 name="fix-output-unplug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-output-unplug"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Fix output of unplug totals (cut-and-paste error with total caption).

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/output.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/btt/output.c b/btt/output.c
index 1278434..6851848 100644
--- a/btt/output.c
+++ b/btt/output.c
@@ -466,8 +466,8 @@ void __dip_output_plug_all(FILE *ofp, struct plug_info *p)
 {
 	fprintf(ofp, "---------- | ---------- ----------  | ----------------\n");
 	fprintf(ofp, "%10s | %10s %10s  | %s\n", 
-	        "DEV", "# Plugs", "# Timer Us", "% Time Q Plugged");
-	fprintf(ofp, "%10s | %10ld(%10ld) | %13.9lf%%\n", "OVERALL",
+	        "Overall", "# Plugs", "# Timer Us", "% Time Q Plugged");
+	fprintf(ofp, "%10s | %10ld(%10ld) | %13.9lf%%\n", "Average",
 	        p->n_plugs / n_plugs, p->n_timer_unplugs / n_plugs, 
 		p->t_percent / n_plugs);
 

--------------060904030708070203000700--
