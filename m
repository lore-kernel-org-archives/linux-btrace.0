From: Robert Schiele <rschiele@gmail.com>
Date: Mon, 08 Sep 2014 07:38:52 +0000
Subject: [PATCH] signal condition variable at end of stop_tracers
Message-Id: <20140908073852.GA19062@ulegcprs1.emea.nsn-net.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

stop_tracers modifies tp->is_done and thus must signal the condition
variable tracer_wait_unblock is waiting on to monitor tp->is_done.
Not doing so might cause the tool to deadlock if stop_tracers is
called while a tracer thread is in tracer_wait_unblock.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 blktrace.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
1.8.4.5
