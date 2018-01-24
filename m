From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 24 Jan 2018 13:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20180124130001.EAA262C0116@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 8fc451c6b0b9a7db7c376ea6865c35321e561f00:

  btt: Fix overlapping IO stats. (2017-11-07 11:25:38 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 519fd9a5d08d85f3d9cb4192d624fe8351e40232:

  fix parallel build failures (2018-01-23 15:59:13 -0700)

----------------------------------------------------------------
Robin H. Johnson (2):
      respect LDFLAGS when linking programs
      fix parallel build failures

 Makefile           | 34 +++++++++++++++-------------------
 btreplay/Makefile  |  4 ++--
 btt/Makefile       |  2 +-
 iowatcher/Makefile |  2 +-
 4 files changed, 19 insertions(+), 23 deletions(-)

---

Diff of recent changes:

diff --git a/Makefile b/Makefile
index fdbded0..5917814 100644
--- a/Makefile
+++ b/Makefile
@@ -4,41 +4,37 @@ ALL_CFLAGS = $(CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
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
 
 blkparse: blkparse.o blkparse_fmt.o rbtree.o act_mask.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^)
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^)
 
 blktrace: blktrace.o act_mask.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
 verify_blkparse: verify_blkparse.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^)
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^)
 
 blkrawverify: blkrawverify.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^)
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^)
 
 blkiomon: blkiomon.o rbtree.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS) -lrt
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^) $(LIBS) -lrt
 
 $(PROGS): | depend
 
@@ -85,7 +81,7 @@ install: all
 	$(INSTALL) -m 755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man8
-	$(INSTALL) -m 755 $(ALL) $(DESTDIR)$(bindir)
+	$(INSTALL) -m 755 $(INSTALL_ALL) $(DESTDIR)$(bindir)
 	$(INSTALL) -m 644 doc/*.1 $(DESTDIR)$(mandir)/man1
 	$(INSTALL) -m 644 doc/*.8 $(DESTDIR)$(mandir)/man8
 
diff --git a/btreplay/Makefile b/btreplay/Makefile
index 2998182..f574a29 100644
--- a/btreplay/Makefile
+++ b/btreplay/Makefile
@@ -32,10 +32,10 @@ clean: docsclean
 	$(CC) $(CFLAGS) -c -o $*.o $<
 
 btrecord: btrecord.o
-	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^)
 
 btreplay: btreplay.o
-	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
 depend:
 	@$(CC) -MM $(CFLAGS) *.c 1> .depend
diff --git a/btt/Makefile b/btt/Makefile
index df7a3de..3207557 100644
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -38,7 +38,7 @@ clean: docsclean
 	$(CC) $(CFLAGS) -c -o $*.o $<
 
 btt: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
 ifneq ($(wildcard .depend),)
 include .depend
diff --git a/iowatcher/Makefile b/iowatcher/Makefile
index e013556..a224a08 100644
--- a/iowatcher/Makefile
+++ b/iowatcher/Makefile
@@ -19,7 +19,7 @@ all: $(ALL)
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 iowatcher: blkparse.o plot.o main.o tracers.o mpstat.o fio.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) -lm -lrt
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^) -lm -lrt
 
 depend:
 	@$(CC) -MM $(ALL_CFLAGS) *.c 1> .depend
