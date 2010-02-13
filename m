From: Eric Sandeen <sandeen@redhat.com>
Date: Sat, 13 Feb 2010 18:32:27 +0000
Subject: [PATCH] add libpthread to btreplay/Makefile LIBS
Message-Id: <4B76F03B.7040206@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Fedora linking changes picked this up:

/usr/bin/ld: btreplay.o: undefined reference to symbol 'pthread_create@@GLIBC_2.2.5'
/usr/bin/ld: note: 'pthread_create@@GLIBC_2.2.5' is defined in DSO /lib64/libpthread.so.0 so try adding it to the linker command line

See also https://bugzilla.redhat.com/show_bug.cgi?idV4775

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Index: blktrace-1.0.1/btreplay/Makefile
=================================--- blktrace-1.0.1.orig/btreplay/Makefile
+++ blktrace-1.0.1/btreplay/Makefile
@@ -13,7 +13,7 @@ XCFLAGS	= -D_GNU_SOURCE -D_LARGEFILE_SOU
 override CFLAGS += $(INCS) $(XCFLAGS) $(OCFLAGS)
 
 PROGS	= btrecord btreplay
-LIBS	= -laio -lrt
+LIBS	= -laio -lrt -lpthread
 
 all: depend $(PROGS)

