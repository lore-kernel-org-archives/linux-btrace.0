From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Tue, 10 Apr 2007 16:59:28 +0000
Subject: [BTT PATCH] Add back in combined seek output file
Message-Id: <461BC38D.5040405@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050603050306050902010601"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603050306050902010601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050603050306050902010601
Content-Type: text/plain;
 name="seek_c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seek_c"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Add in combined seek output

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/seek.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/btt/seek.c b/btt/seek.c
index e23f6bb..fb62714 100644
--- a/btt/seek.c
+++ b/btt/seek.c
@@ -29,7 +29,7 @@ struct seek_bkt {
 };
 
 struct seeki {
-	FILE *rfp, *wfp;
+	FILE *rfp, *wfp, *cfp;
 	struct rb_root root;
 	long long tot_seeks;
 	double total_sectors;
@@ -125,6 +125,7 @@ void *seeki_init(__u32 device)
 
 	sip->rfp = seek_open(device, 'r');
 	sip->wfp = seek_open(device, 'w');
+	sip->cfp = seek_open(device, 'c');
 	sip->tot_seeks = 0;
 	sip->total_sectors = 0.0;
 	sip->last_start = sip->last_end = 0;
@@ -149,9 +150,12 @@ void seeki_add(void *handle, struct io *iop)
 	struct seeki *sip = handle;
 	long long dist = seek_dist(sip, iop);
 	FILE *fp = IOP_READ(iop) ? sip->rfp : sip->wfp;
+	double tstamp = BIT_TIME(iop->t.time);
 
 	if (fp)
-		fprintf(fp, "%15.9lf %13lld\n", BIT_TIME(iop->t.time), dist);
+		fprintf(fp, "%15.9lf %13lld\n", tstamp, dist);
+	if (sip->cfp)
+		fprintf(sip->cfp, "%15.9lf %13lld\n", tstamp, dist);
 
 	dist = llabs(dist);
 	sip->tot_seeks++;

--------------050603050306050902010601--
