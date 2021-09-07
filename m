From: songkai <songkai01@inspur.com>
Date: Tue, 07 Sep 2021 20:26:46 +0000
Subject: [PATCH] blktrace:remove redundant memset() following calloc()
Message-Id: <20210907202646.110452-1-songkai01@inspur.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

memset() is unnecessary when using calloc() to allocate space,remove it.

Signed-off-by: songkai <songkai01@inspur.com>
---
 blktrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 3444fbb..4fd1f83 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1088,7 +1088,6 @@ static int setup_buts(void)
 			if (dpp->stats)
 				free(dpp->stats);
 			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
-			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
 		} else {
 			fprintf(stderr, "BLKTRACESETUP(2) %s failed: %d/%s\n",
 				dpp->path, errno, strerror(errno));
@@ -1658,10 +1657,8 @@ static int open_ios(struct tracer *tp)
 	struct list_head *p;
 
 	tp->ios = calloc(ndevs, sizeof(struct io_info));
-	memset(tp->ios, 0, ndevs * sizeof(struct io_info));
 
 	tp->pfds = calloc(ndevs, sizeof(struct pollfd));
-	memset(tp->pfds, 0, ndevs * sizeof(struct pollfd));
 
 	tp->nios = 0;
 	iop = tp->ios;
@@ -2417,13 +2414,11 @@ static struct devpath *nc_add_dpp(struct cl_conn *nc,
 	dpp->cl_connect_time = connect_time;
 	dpp->ncpus = nc->ncpus;
 	dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
-	memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
 
 	list_add_tail(&dpp->head, &nc->ch->devpaths);
 	nc->ch->ndevs++;
 
 	dpp->ios = calloc(nc->ncpus, sizeof(*iop));
-	memset(dpp->ios, 0, ndevs * sizeof(*iop));
 
 	for (cpu = 0, iop = dpp->ios; cpu < nc->ncpus; cpu++, iop++) {
 		iop->dpp = dpp;
-- 
2.27.0
