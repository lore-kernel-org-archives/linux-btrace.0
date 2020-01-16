From: Gwendal Grignou <gwendal@chromium.org>
Date: Thu, 16 Jan 2020 20:33:26 +0000
Subject: [PATCH] fix parallel build of btt and blkiomon
Message-Id: <20200116203326.54058-1-gwendal@chromium.org>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

rbtree.c is used by both binaries. It is possible that when make -C btt
is invoked rbtree.o does not exist yet, but is already schedule by the
compilation of blkiomon. That could result in recompiling rbtree.o again
for btt/btt.
In that case, at install time, make will recompile blkiomon which can
fail in gentoo, because CC variable is not overriden by ebuild script at
install time. (see https://bugs.gentoo.org/705594)

Add a dependency on SUBDIRS to wait for all binary in . to be compiled.
It will guarante rbtree.o exists.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5917814..eb3c6a1 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,7 @@ all: $(ALL) $(SUBDIRS)
 
 # We always descend into subdirs because they contain their own dependency
 # information which we don't track in this top level Makefile.
-$(SUBDIRS):
+$(SUBDIRS): $(PROGS)
 	$(MAKE) -C $@
 .PHONY: $(SUBDIRS)
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog
