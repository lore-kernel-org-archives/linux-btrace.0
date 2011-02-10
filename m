From: Jens Axboe <jaxboe@fusionio.com>
Date: Thu, 10 Feb 2011 05:00:04 +0000
Subject: Recent changes
Message-Id: <20110210050004.5732D37A2C9@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit b7e74b0087fe5d687c6a43a01a2e02d60b618ae0:

  blkiomon: Fix an output error (2011-01-14 09:06:03 +0100)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Tao Ma (3):
      blktrace: break mlock in case of is_done.
      blktrace: remove unused idx from devpath.
      gitignore: add blkiomon to .gitignore.

 .gitignore |    3 +++
 blktrace.c |   25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

---

Diff of recent changes:

diff --git a/.gitignore b/.gitignore
index 9038778..2436e34 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,9 @@
 blkparse
 blktrace
 blkrawverify
+blkiomon
+btreplay/btrecord
+btreplay/btreplay
 doc/.depend
 verify_blkparse
 btt/btt
diff --git a/blktrace.c b/blktrace.c
index 4cccb7c..18c5157 100644
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
@@ -1239,7 +1248,7 @@ static int add_devpath(char *path)
 	memset(dpp, 0, sizeof(*dpp));
 	dpp->path = strdup(path);
 	dpp->fd = fd;
-	dpp->idx = ndevs++;
+	ndevs++;
 	list_add_tail(&dpp->head, &devpaths);
 
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
