From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 23 Mar 2010 05:00:02 +0000
Subject: Recent changes
Message-Id: <20100323050002.9864E37A104@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 0d76d14f46195eb4295c35bf15531890378c7684:

  add libpthread to btreplay/Makefile LIBS (2010-02-22 19:56:52 +0100)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      Corrected memory leak in btt/p_live.c
      Fixed incorrect sizeof instead of strlen in btt/rstats.c

 btt/p_live.c |    1 +
 btt/rstats.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

---

Diff of recent changes:

diff --git a/btt/p_live.c b/btt/p_live.c
index 8bbb893..17f06bb 100644
--- a/btt/p_live.c
+++ b/btt/p_live.c
@@ -86,6 +86,7 @@ static void __p_live_add(struct rb_root *root, __u64 dt, __u64 ct)
 			list_del(&plp->head);
 			rb_erase(&plp->rb_node, root);
 			__p_live_add(root, min(plp->dt, dt), max(plp->ct, ct));
+			free(plp);
 			return;
 		}
 
diff --git a/btt/rstats.c b/btt/rstats.c
index 71f010b..5a336fe 100644
--- a/btt/rstats.c
+++ b/btt/rstats.c
@@ -38,7 +38,7 @@ static LIST_HEAD(rstats);
 
 static int do_open(struct files *fip, char *bn, char *pn)
 {
-	fip->nm = malloc(sizeof(bn) + 16);
+	fip->nm = malloc(strlen(bn) + 16);
 	sprintf(fip->nm, "%s_%s.dat", bn, pn);
 
 	fip->fp = my_fopen(fip->nm, "w");
@@ -55,6 +55,7 @@ static int init_rsip(struct rstat *rsip, struct d_info *dip)
 {
 	char *nm = dip ? dip->dip_name : "sys";
 
+	rsip->base_sec = -1;
 	rsip->ios = rsip->nblks = 0;
 	if (do_open(&rsip->files[0], nm, "iops_fp") ||
 			    do_open(&rsip->files[1], nm, "mbps_fp"))
