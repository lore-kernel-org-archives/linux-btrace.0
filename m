From: Joshua Root <jmr@gelato.unsw.edu.au>
Date: Thu, 06 Dec 2007 05:46:36 +0000
Subject: [PATCH] Remove strange make dependency
Message-Id: <47578CBC.1040904@gelato.unsw.edu.au>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Listing "-lpthread" as a dependency in a make rule doesn't make much sense.

Signed-off-by: Joshua Root <jmr@gelato.unsw.edu.au>
---
  Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
  mode change 100644 => 100755 Makefile

diff --git a/Makefile b/Makefile
old mode 100644
new mode 100755
index fda76f4..edc6ca9
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ btreplay/btreplay:
  blkparse: blkparse.o blkparse_fmt.o rbtree.o act_mask.o
  	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^)

-blktrace: blktrace.o act_mask.o $(LIBS)
+blktrace: blktrace.o act_mask.o
  	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)

  verify_blkparse: verify_blkparse.o
-- 
1.5.3.4
