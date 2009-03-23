From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Mon, 23 Mar 2009 14:53:11 +0000
Subject: [Patch] fix
Message-Id: <1237819991.5624.20.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens,

Tom fixed my "boken trace magic" issue. Please apply.

Thanks,
Martin


From: Tom Zanussi <tzanussi@gmail.com>

Blktrace failed to lock reader threads on the cpu used by the corresponding
writer. This resulted in stale data being consumed when blktrace accidently
read at a position that was being written to at the same time. This issue
surfaced as "bad trace magic" warnings emitted by blktrace tools.

The problem occured on an SMP System z machine. The patch fixes the issue.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 blktrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/blktrace.c
+++ b/blktrace.c
@@ -610,7 +610,7 @@ static int lock_on_cpu(int cpu)
 
 	CPU_ZERO(&cpu_mask);
 	CPU_SET(cpu, &cpu_mask);
-	if (sched_setaffinity(getpid(), sizeof(cpu_mask), &cpu_mask) < 0)
+	if (sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask) < 0)
 		return errno;
 
 	return 0;


