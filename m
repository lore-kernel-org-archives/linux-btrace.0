From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 17 Jul 2019 21:24:02 +0000
Subject: [RFC PATCH 05/38] blktrace: add a new global list
Message-Id: <20190717212435.2990-6-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Add a separate list to hold running extension traces.
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e1c6d79fb4cc..0741dd11531f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -33,6 +33,9 @@ static bool blk_tracer_enabled __read_mostly;
 static LIST_HEAD(running_trace_list);
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
 
+static LIST_HEAD(running_trace_ext_list);
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_ext_lock);
+
 /* Select an alternative, minimalistic output than the original one */
 #define TRACE_BLK_OPT_CLASSIC	0x1
 #define TRACE_BLK_OPT_CGROUP	0x2
-- 
2.17.0
