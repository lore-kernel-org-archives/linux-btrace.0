From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 25 Jan 2018 13:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20180125130002.0330E2C0092@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 519fd9a5d08d85f3d9cb4192d624fe8351e40232:

  fix parallel build failures (2018-01-23 15:59:13 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to e63098f39398bde67be9b64a49deece1c60614df:

  blktrace: don't stop tracer if not setup trace successfully (2018-01-24 08:40:52 -0700)

----------------------------------------------------------------
weiping zhang (1):
      blktrace: don't stop tracer if not setup trace successfully

 blktrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/blktrace.c b/blktrace.c
index e048f68..d0d271f 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -112,6 +112,7 @@ struct devpath {
 	struct cl_host *ch;
 	u32 cl_id;
 	time_t cl_connect_time;
+	int setup_done;	/* ioctl BLKTRACESETUP done */
 	struct io_info *ios;
 };
 
@@ -1083,6 +1084,7 @@ static int setup_buts(void)
 		if (ioctl(dpp->fd, BLKTRACESETUP, &buts) >= 0) {
 			dpp->ncpus = max_cpus;
 			dpp->buts_name = strdup(buts.name);
+			dpp->setup_done = 1;
 			if (dpp->stats)
 				free(dpp->stats);
 			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
@@ -1285,7 +1287,8 @@ static void rel_devpaths(void)
 		struct devpath *dpp = list_entry(p, struct devpath, head);
 
 		list_del(&dpp->head);
-		__stop_trace(dpp->fd);
+		if (dpp->setup_done)
+			__stop_trace(dpp->fd);
 		close(dpp->fd);
 
 		if (dpp->heads)
