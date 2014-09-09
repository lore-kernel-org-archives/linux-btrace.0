From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 09 Sep 2014 12:00:03 +0000
Subject: Recent changes (master)
Message-Id: <20140909120003.8FF8B40246@lyth.info>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit ce9ded7165b846598b28107ceb2864ae1ad4b652:

  remove unused barrier.h (2014-04-11 07:45:54 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 838361c6cfb1319eadd59daaf9074dcdb92746e6:

  signal condition variable at end of stop_tracers (2014-09-08 08:15:58 -0600)

----------------------------------------------------------------
Robert Schiele (1):
      signal condition variable at end of stop_tracers

 blktrace.c |    1 +
 1 file changed, 1 insertion(+)

---

Diff of recent changes:

diff --git a/blktrace.c b/blktrace.c
index 7e64c94..3c8fb4c 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1913,6 +1913,7 @@ static void stop_tracers(void)
 		struct tracer *tp = list_entry(p, struct tracer, head);
 		tp->is_done = 1;
 	}
+	pthread_cond_broadcast(&mt_cond);
 }
 
 static void del_tracers(void)
