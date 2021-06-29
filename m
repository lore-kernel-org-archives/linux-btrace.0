From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 29 Jun 2021 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20210629120001.947451BC0174@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 366d30b9cdb20345c5d064af850d686da79b89eb:

  blktrace 1.3.0 (2021-06-14 08:55:52 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 3a1b1366d30375cdb0f5b299df4edda0c8ba3bcc:

  blktrace: exit directly when nthreads_running != ncpus in run_tracers() (2021-06-28 13:41:32 -0600)

----------------------------------------------------------------
lijinlin (1):
      blktrace: exit directly when nthreads_running != ncpus in run_tracers()

 blktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/blktrace.c b/blktrace.c
index 82a6aad..3444fbb 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2705,8 +2705,10 @@ static int run_tracers(void)
 			printf("blktrace: connected!\n");
 		if (stop_watch)
 			alarm(stop_watch);
-	} else
+	} else {
 		stop_tracers();
+		done = 1;
+	}
 
 	wait_tracers();
 	if (nthreads_running = ncpus)
