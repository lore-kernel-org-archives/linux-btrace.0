From: Jan Blunck <jblunck@suse.de>
Date: Sun, 26 Aug 2007 14:57:48 +0000
Subject: [PATCH] Makefile fixes
Message-Id: <20070826145748.GU546@hasse.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Here is a patch with small fixes to the Makefiles which I use in the
openSUSE blktrace package.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 Makefile     |   12 ++++++------
 btt/Makefile |   29 ++++++++++++++---------------
 2 files changed, 20 insertions(+), 21 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -65,12 +65,12 @@ clean: docsclean
 	$(MAKE) -C btt clean
 
 install: all
-	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
-	$(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man1
-	$(INSTALL) -m755 -d $(DESTDIR)$(mandir)/man8
-	$(INSTALL) $(ALL) $(DESTDIR)$(bindir)
-	$(INSTALL) doc/*.1 $(DESTDIR)$(mandir)/man1
-	$(INSTALL) doc/*.8 $(DESTDIR)$(mandir)/man8
+	$(INSTALL) -m 755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man1
+	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man8
+	$(INSTALL) -m 755 $(ALL) $(DESTDIR)$(bindir)
+	$(INSTALL) -m 644 doc/*.1 $(DESTDIR)$(mandir)/man1
+	$(INSTALL) -m 644 doc/*.8 $(DESTDIR)$(mandir)/man8
 
 ifneq ($(wildcard .depend),)
 include .depend
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -6,41 +6,40 @@
 #
 
 CC	= gcc
+CFLAGS	= -Wall -W -O2 -g
 INCS	= -I. -I..
 OCFLAGS	= -UCOUNT_IOS -UDEBUG -DNDEBUG
-XCFLAGS	= -Wall -W -g -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
-CFLAGS	= $(INCS) -O2 $(XCFLAGS) $(OCFLAGS)
+XCFLAGS	= -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITSd
+override CFLAGS += $(INCS) $(XCFLAGS) $(OCFLAGS)
 
 PROGS	= btt
 LIBS	= $(PLIBS) $(ELIBS)
 OBJS	= args.o bt_timeline.o devmap.o devs.o dip_rb.o iostat.o latency.o \
 	  misc.o output.o proc.o seek.o trace.o trace_complete.o trace_im.o \
-	  trace_issue.o trace_queue.o trace_remap.o trace_requeue.o rbtree.o \
-	  mmap.o trace_plug.o bno_dump.o unplug_hist.o
+	  trace_issue.o trace_queue.o trace_remap.o trace_requeue.o \
+	  ../rbtree.o mmap.o trace_plug.o bno_dump.o unplug_hist.o
 
 all: depend $(PROGS)
 
-rbtree.o: ../rbtree.c
-	$(CC) -o $*.o -c $(CFLAGS) $<
+.PHONY : depend
+depend: $(patsubst %.o,%.c,$(filter %.o,$(OBJS)))
+	@$(CC) -MM $(CFLAGS) -I.. $^ 1> .depend
 
-depend:
-	@$(CC) -MM $(CFLAGS) -I.. *.c 1> .depend
+docs:
+	$(MAKE) -C doc all
+
+docsclean:
+	$(MAKE) -C doc clean
 
 clean: docsclean
 	-rm -f *.o $(PROGS) .depend
 
 %.o: %.c
-	$(CC) -o $*.o -c $(CFLAGS) $<
+	$(CC) $(CFLAGS) -c -o $*.o $<
 
 btt: $(OBJS)
 	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
-docs:
-	$(MAKE) -C doc all
-
-docsclean:
-	$(MAKE) -C doc clean
-
 ifneq ($(wildcard .depend),)
 include .depend
 endif
