From: Tao Ma <tm@tao.ma>
Date: Sun, 30 Jan 2011 09:18:25 +0000
Subject: [PATCH] blktrace: remove unused idx from devpath.
Message-Id: <1296379106-6009-2-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Tao Ma <boyu.mt@taobao.com>

idx isn't used, so remove it.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 blktrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 4cccb7c..851b8a8 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -93,7 +93,7 @@ struct devpath {
 	char *path;			/* path to device special file */
 	char *buts_name;		/* name returned from bt kernel code */
 	struct pdc_stats *stats;
-	int fd, idx, ncpus;
+	int fd, ncpus;
 	unsigned long long drops;
 
 	/*
@@ -1239,7 +1239,7 @@ static int add_devpath(char *path)
 	memset(dpp, 0, sizeof(*dpp));
 	dpp->path = strdup(path);
 	dpp->fd = fd;
-	dpp->idx = ndevs++;
+	ndevs++;
 	list_add_tail(&dpp->head, &devpaths);
 
 	return 0;
-- 
1.6.3.GIT

