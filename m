From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Jan 2018 22:57:55 +0000
Subject: [PATCH] fix parallel build failures
Message-Id: <20180123225755.9927-1-vapier@gentoo.org>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: "Robin H. Johnson" <robbat2@gentoo.org>

When building in parallel, the btreplay/btrecord and btreplay/btreplay
targets cause make to kick off two jobs for `make -C btreplay` and they
sometimes end up clobbering each other.  We could fix this by making one
a dependency of the other, but it's a bit cleaner to refactor things to
be based on subdirs.  This way changes in subdirs also get noticed:
  $ touch btreplay/*.[ch]
  $ make
  <btreplay is now correctly updated>

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Makefile | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 68de59183a73..5917814d0344 100644
--- a/Makefile
+++ b/Makefile
@@ -4,23 +4,19 @@ ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
 PROGS	= blkparse blktrace verify_blkparse blkrawverify blkiomon
 LIBS	= -lpthread
 SCRIPTS	= btrace
+SUBDIRS = btreplay btt iowatcher
 
-ALL = $(PROGS) $(SCRIPTS) btt/btt btreplay/btrecord btreplay/btreplay \
+ALL = $(PROGS) $(SCRIPTS)
+INSTALL_ALL = $(ALL) btt/btt btreplay/btrecord btreplay/btreplay \
       btt/bno_plot.py iowatcher/iowatcher
 
-all: $(ALL)
+all: $(ALL) $(SUBDIRS)
 
-btt/btt:
-	$(MAKE) -C btt
-
-iowatcher/iowatcher:
-	$(MAKE) -C iowatcher
-
-btreplay/btrecord:
-	$(MAKE) -C btreplay
-
-btreplay/btreplay:
-	$(MAKE) -C btreplay
+# We always descend into subdirs because they contain their own dependency
+# information which we don't track in this top level Makefile.
+$(SUBDIRS):
+	$(MAKE) -C $@
+.PHONY: $(SUBDIRS)
 
 %.o: %.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
@@ -85,7 +81,7 @@ install: all
 	$(INSTALL) -m 755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man8
-	$(INSTALL) -m 755 $(ALL) $(DESTDIR)$(bindir)
+	$(INSTALL) -m 755 $(INSTALL_ALL) $(DESTDIR)$(bindir)
 	$(INSTALL) -m 644 doc/*.1 $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 644 doc/*.8 $(DESTDIR)$(mandir)/man8
 
-- 
2.15.1

