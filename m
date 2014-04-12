From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 12 Apr 2014 12:00:03 +0000
Subject: Recent changes (master)
Message-Id: <20140412120003.3409140167@rt116.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 3726f669cd305741e35ae759e0b21f3b04084e4e:

  blktrace bno_plot.py: output comprehensive message when gnuplot not found (2013-12-03 19:25:21 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to ce9ded7165b846598b28107ceb2864ae1ad4b652:

  remove unused barrier.h (2014-04-11 07:45:54 -0600)

----------------------------------------------------------------
Riku Voipio (1):
      remove unused barrier.h

 barrier.h |   33 ---------------------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 barrier.h

---

Diff of recent changes:

diff --git a/barrier.h b/barrier.h
deleted file mode 100644
index 14d06b5..0000000
--- a/barrier.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef BARRIER_H
-#define BARRIER_H
-
-#if defined(__ia64__)
-  #define store_barrier()         asm volatile ("mf" ::: "memory")
-#elif defined(__x86_64__)
-  #define store_barrier()         asm volatile("sfence" ::: "memory")
-#elif defined(__i386__)
-  #define store_barrier()         asm volatile ("": : :"memory")
-#elif defined(__ppc__) || defined(__powerpc__)
-  #define store_barrier()         asm volatile ("eieio" : : : "memory")
-#elif defined(__s390__) || defined(__s390x__)
-  #define store_barrier()         asm volatile ("bcr 15,0" : : : "memory")
-#elif defined(__alpha__)
-  #define store_barrier()         asm volatile("wmb": : :"memory")
-#elif defined(__hppa__)
-  #define store_barrier()         asm volatile("":::"memory")
-#elif defined(__sparc__)
-  #define store_barrier()         asm volatile("":::"memory")
-#elif defined(__m68000__) || defined(__m68k__) || defined(mc68000) || defined(_M_M68K)
-  #define store_barrier()         asm volatile("":::"memory")
-#elif defined(__mips__)  /* also mipsel */
-  #define store_barrier()         do { } while(0)
-#elif defined(__arm__)
-  /* taken from linux/arch/arm/kernel/entry-armv.S, thanks to pbrook! */
-  typedef void (__kernel_dmb_t)(void);
-  #define __kernel_dmb (*(__kernel_dmb_t *)0xffff0fa0)
-  #define store_barrier()        __kernel_dmb()
-#else
-  #error Define store_barrier() for your CPU
-#endif
-
-#endif
