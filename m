From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Tue, 10 Apr 2007 12:53:08 +0000
Subject: [BTT PATCH] More malloc reduction - remove excessive bilink allocations...
Message-Id: <461B88B4.9030504@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060508080008010405060105"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508080008010405060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060508080008010405060105
Content-Type: text/plain;
 name="fix-bilink-allocs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-bilink-allocs"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Reduce amount of allocations done for bilinks.

Used to do 1-for-1 allocations of bilinks for traces processed, we now
have reduced this to the largest tree size left (thousands instead of
millions of allocs for a moderately sized file).

This data set used to result in :

malloc/free: 11,241,958 allocs, 11,241,958 frees, 440,381,362 bytes allocated.

It is now:

malloc/free: 41,076 allocs, 41,076 frees, 9,272,450 bytes allocated.

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/bt_timeline.c |    2 ++
 btt/globals.h     |    3 ++-
 btt/inlines.h     |   25 ++++++++++++++++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 32c900e..d998e99 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -39,6 +39,7 @@ time_t genesis, last_vtrace;
 LIST_HEAD(all_devs);
 LIST_HEAD(all_procs);
 LIST_HEAD(free_ios);
+LIST_HEAD(free_bilinks);
 LIST_HEAD(rmhd);
 LIST_HEAD(retries);
 __u64 q_histo[N_HIST_BKTS], d_histo[N_HIST_BKTS];
@@ -89,6 +90,7 @@ int main(int argc, char *argv[])
 	dip_exit();
 	pip_exit();
 	io_free_all();
+	bilink_free_all();
 	region_exit(&all_regions);
 
 	free(input_name);
diff --git a/btt/globals.h b/btt/globals.h
index 1b54cb0..912bb7c 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -190,6 +190,7 @@ struct bilink {
 	struct list_head down_head, up_head;
 	struct io *diop, *uiop;
 };
+#define bilink_free_head	down_head
 
 /* bt_timeline.c */
 
@@ -205,7 +206,7 @@ extern struct list_head all_devs, all_procs, retries, rmhd;
 extern struct avgs_info all_avgs;
 extern __u64 last_q, next_retry_check;
 extern struct region_info all_regions;
-extern struct list_head free_ios;
+extern struct list_head free_ios, free_bilinks;
 extern __u64 iostat_interval, iostat_last_stamp;
 extern time_t genesis, last_vtrace;
 extern double t_astart, t_aend;
diff --git a/btt/inlines.h b/btt/inlines.h
index edb2182..25e5b21 100644
--- a/btt/inlines.h
+++ b/btt/inlines.h
@@ -127,7 +127,7 @@ static inline struct io *io_alloc(void)
 	struct io *iop;
 
 	if (!list_empty(&free_ios)) {
-		iop = list_entry(free_ios.next, struct io, f_head);
+		iop = list_entry(free_ios.prev, struct io, f_head);
 		LIST_DEL(&iop->f_head);
 
 #		if defined(COUNT_IOS)
@@ -406,12 +406,31 @@ static inline int type2c(enum iop_type type)
 
 static inline void bilink_free(struct bilink *blp)
 {
-	free(blp);
+	list_add_tail(&blp->bilink_free_head, &free_bilinks);
+}
+
+static inline void bilink_free_all(void)
+{
+	struct bilink *blp;
+	struct list_head *p, *q;
+
+	list_for_each_safe(p, q, &free_bilinks) {
+		blp = list_entry(p, struct bilink, bilink_free_head);
+		free(blp);
+	}
 }
 
 static inline struct bilink *bilink_alloc(struct io *diop, struct io *uiop)
 {
-	struct bilink *blp = malloc(sizeof(*blp));
+	struct bilink *blp;
+
+	if (!list_empty(&free_bilinks)) {
+		blp = list_entry(free_bilinks.prev, struct bilink, 
+							bilink_free_head);
+		LIST_DEL(&blp->bilink_free_head);
+	}
+	else
+		blp = malloc(sizeof(*blp));
 
 	blp->diop = diop;
 	blp->uiop = uiop;

--------------060508080008010405060105--
