From: Tao Ma <tm@tao.ma>
Date: Sun, 30 Jan 2011 09:18:24 +0000
Subject: [PATCH] blktrace: break mlock in case of is_done.
Message-Id: <1296379106-6009-1-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Tao Ma <boyu.mt@taobao.com>

In 38-rc2, there is a bug in mlock which will return
error in mlock of blktrace(I have sent the corresponding
patch to the lkml). So when we try to break the blktrace
by "ctrl+c", mlock will loop forever and in the end, I
have to use "kill -9" to kill it and then run "blktrace -k"
to stop the tracer. I don't think it is good.

How to reproduce it is simple:
Use a 38-rc kernel, and run
blktrace /dev/sdx
then use "ctrl+c", it doesn't exit.

So this patch adds the check for tp->is_done. In
case of is_done is set, break mlock so that we don't
deadloop in the mlock. In case of the real mlock error,
I will let it to retry 10 times and it should succeed
after 10 tries in case of tp->is_done. If tp isn't set
or tp->is_done isn't set, it works like the original
design.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 blktrace.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 851b8a8..18c5157 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -721,18 +721,24 @@ static void *my_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	return new;
 }
 
-static int my_mlock(const void *addr, size_t len)
+static int my_mlock(struct tracer *tp,
+		    const void *addr, size_t len)
 {
-	int ret;
+	int ret, retry = 0;
 
 	do {
 		ret = mlock(addr, len);
+		if ((retry >= 10) && tp && tp->is_done)
+			break;
+		retry++;
 	} while (ret < 0 && handle_mem_failure(len));
 
 	return ret;
 }
 
-static int setup_mmap(int fd, unsigned int maxlen, struct mmap_info *mip)
+static int setup_mmap(int fd, unsigned int maxlen,
+		      struct mmap_info *mip,
+		      struct tracer *tp)
 {
 	if (mip->fs_off + maxlen > mip->fs_buf_len) {
 		unsigned long nr = max(16, mip->buf_nr);
@@ -759,7 +765,10 @@ static int setup_mmap(int fd, unsigned int maxlen, struct mmap_info *mip)
 			perror("setup_mmap: mmap");
 			return 1;
 		}
-		my_mlock(mip->fs_buf, mip->fs_buf_len);
+		if (my_mlock(tp, mip->fs_buf, mip->fs_buf_len) < 0) {
+			perror("setup_mlock: mlock");
+			return 1;
+		}
 	}
 
 	return 0;
@@ -1683,7 +1692,7 @@ static int handle_pfds_file(struct tracer *tp, int nevs, int force_read)
 		if (pfd->revents & POLLIN || force_read) {
 			mip = &iop->mmap_info;
 
-			ret = setup_mmap(iop->ofd, buf_size, mip);
+			ret = setup_mmap(iop->ofd, buf_size, mip, tp);
 			if (ret < 0) {
 				pfd->events = 0;
 				break;
@@ -2381,7 +2390,7 @@ static void net_client_read_data(struct cl_conn *nc, struct devpath *dpp,
 	struct io_info *iop = &dpp->ios[bnh->cpu];
 	struct mmap_info *mip = &iop->mmap_info;
 
-	if (setup_mmap(iop->ofd, bnh->len, &iop->mmap_info)) {
+	if (setup_mmap(iop->ofd, bnh->len, &iop->mmap_info, NULL)) {
 		fprintf(stderr, "ncd(%s:%d): mmap failed\n",
 			nc->ch->hostname, nc->fd);
 		exit(1);
-- 
1.6.3.GIT

