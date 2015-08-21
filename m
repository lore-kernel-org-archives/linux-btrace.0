From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 21 Aug 2015 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20150821120001.63B022C00B7@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 88d38b4d0a5b33332fa80d7028a87c0717bb5d75:

  Refer to sda instead of hda in man pages (2015-02-18 08:50:02 -0800)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 2564a6029e55d6a0507ebb28a5a01f5dffb0bd56:

  btreplay: Fix typo in scaling up the dynamic cpu set size. (2015-08-20 08:58:08 -0700)

----------------------------------------------------------------
Josef Cejka (1):
      btreplay: Fix typo in scaling up the dynamic cpu set size.

 btreplay/btreplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index 5444010..f762279 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -516,7 +516,7 @@ realloc:
 	if (sched_getaffinity(getpid(), size, cpus)) {
 		if( errno = EINVAL && nrcpus < (4096<<4) ) {
 			CPU_FREE(cpus);
-			nrcpus <= 1;
+			nrcpus <<= 1;
 			goto realloc;
 		}
 		fatal("sched_getaffinity", ERR_SYSCALL, "Can't get CPU info\n");
