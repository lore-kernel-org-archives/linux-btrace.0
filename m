From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Mon, 09 Apr 2007 14:53:07 +0000
Subject: [BTT patch] Fixed Makefile
Message-Id: <461A5353.3070302@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080402040902050005040509"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402040902050005040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080402040902050005040509
Content-Type: text/plain;
 name="fix-Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-Makefile"

From: Alan D. Brunelle <Alan.Brunelle@hp.com>

Fixed Makefile back - had the DEBUG version enabled...

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---

 btt/Makefile |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/btt/Makefile b/btt/Makefile
index fcb09a4..920c70c 100644
--- a/btt/Makefile
+++ b/btt/Makefile
@@ -1,16 +1,17 @@
-CC	= gcc
-
-ECFLAGS	= 
-# ECFLAGS	= -DCOUNT_IOS
+#
+# OCFLAGS:
+# 	COUNT_IOS	- Counts struct io's left at end
+# 	DEBUG		- Various and sundy debug asserts
+# 	NDEBUG		- Defined: no asserts, Undefined: asserts
+#
 
-# CFLAGS	= -Wall -O2 -W -g $(ECFLAGS)
-CFLAGS	= -Wall -g -W -UDO_INLINE -DDEBUG $(ECFLAGS)
+CC	= gcc
+INCS	= -I. -I..
+OCFLAGS	= -UCOUNT_IOS -UDEBUG -DNDEBUG
+XCFLAGS	= -Wall -W -g -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
+CFLAGS	= $(INCS) -O2 $(XCFLAGS) $(OCFLAGS)
 
-ALL_CFLAGS = $(CFLAGS) -I.. -D_GNU_SOURCE -D_LARGEFILE_SOURCE \
-		-D_FILE_OFFSET_BITS=64
 PROGS	= btt
-#ELIBS	= -lefence
-#PLIBS	= -lpthread
 LIBS	= $(PLIBS) $(ELIBS)
 OBJS	= args.o bt_timeline.o devmap.o devs.o dip_rb.o iostat.o latency.o \
 	  misc.o output.o proc.o seek.o trace.o trace_complete.o trace_im.o \
@@ -20,19 +21,19 @@ OBJS	= args.o bt_timeline.o devmap.o devs.o dip_rb.o iostat.o latency.o \
 all: depend $(PROGS)
 
 rbtree.o: ../rbtree.c
-	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(CC) -o $*.o -c $(CFLAGS) $<
 
 depend:
-	@$(CC) -MM $(ALL_CFLAGS) -I.. *.c 1> .depend
+	@$(CC) -MM $(CFLAGS) -I.. *.c 1> .depend
 
 clean: docsclean
 	-rm -f *.o $(PROGS) .depend
 
 %.o: %.c
-	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(CC) -o $*.o -c $(CFLAGS) $<
 
 btt: $(OBJS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
 docs:
 	$(MAKE) -C doc all

--------------080402040902050005040509--
