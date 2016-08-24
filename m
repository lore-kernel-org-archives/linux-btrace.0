From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 24 Aug 2016 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20160824120002.23EA92C0286@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 86596c7579c6e374e6e24c2b14398b0808a93f18:

  blktrace: remove -k from manpage synopsis (2016-05-19 15:57:22 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to d1ab783430f5a832e973ed9a293da146c04c6702:

  iowatcher: link with -lrt (2016-08-23 08:45:45 -0600)

----------------------------------------------------------------
Thomas Petazzoni (1):
      iowatcher: link with -lrt

 iowatcher/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/iowatcher/Makefile b/iowatcher/Makefile
index 3551ea0..e013556 100644
--- a/iowatcher/Makefile
+++ b/iowatcher/Makefile
@@ -19,7 +19,7 @@ all: $(ALL)
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 iowatcher: blkparse.o plot.o main.o tracers.o mpstat.o fio.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) -lm
+	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) -lm -lrt
 
 depend:
 	@$(CC) -MM $(ALL_CFLAGS) *.c 1> .depend
