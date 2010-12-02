From: Jens Axboe <jaxboe@fusionio.com>
Date: Thu, 02 Dec 2010 05:00:04 +0000
Subject: Recent changes
Message-Id: <20101202050004.16B3B37A2D3@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 5798ffb25496ab8dcb419a2bdc5418802d7f10fc:

  blktrace: btt documentation update (2010-10-22 20:54:11 +0200)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Fixed build warning for btreplay

 btreplay/btreplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---

Diff of recent changes:

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index cba099a..f4f5aa0 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -1314,7 +1314,7 @@ static void reset_input_file(struct thr_info *tip)
  */
 static void *replay_sub(void *arg)
 {
-        int i;
+        unsigned int i;
 	char *mdev;
 	char path[MAXPATHLEN];
 	struct io_bunch bunch;
