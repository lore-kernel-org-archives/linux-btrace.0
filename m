From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Jan 2018 22:47:19 +0000
Subject: [PATCH] respect LDFLAGS when linking programs
Message-Id: <20180123224719.8195-1-vapier@gentoo.org>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: "Robin H. Johnson" <robbat2@gentoo.org>

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Makefile           | 10 +++++-----
 btreplay/Makefile  |  4 ++--
 btt/Makefile       |  2 +-
 iowatcher/Makefile |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index fdbded02ee0a..68de59183a73 100644
--- a/Makefile
+++ b/Makefile
@@ -26,19 +26,19 @@ btreplay/btreplay:
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
 
diff --git a/btreplay/Makefile b/btreplay/Makefile
index 2998182401e7..f574a2976ec1 100644
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
index df7a3de6b3fb..32075573954c 100644
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
index e013556f3ae1..a224a0848cc8 100644
--- a/iowatcher/Makefile
+++ b/iowatcher/Makefile
@@ -19,7 +19,7 @@ all: $(ALL)
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 iowatcher: blkparse.o plot.o main.o tracers.o mpstat.o fio.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) -lm -lrt
+	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $(filter %.o,$^) -lm -lrt
 
 depend:
 	@$(CC) -MM $(ALL_CFLAGS) *.c 1> .depend
-- 
2.15.1

