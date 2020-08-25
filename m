From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:09:34 +0000
Subject: [RFC PATCH 04/39] blktrace: add a new global list
Message-Id: <20200825221009.6457-5-chaitanya.kulkarni@wdc.com>
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
index 7ba62d68885a..7857ac2b37c9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -36,6 +36,9 @@ static bool blk_tracer_enabled __read_mostly;
 static LIST_HEAD(running_trace_list);
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
 
+static LIST_HEAD(running_trace_ext_list);
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_ext_lock);
+
 /* Select an alternative, minimalistic output than the original one */
 #define TRACE_BLK_OPT_CLASSIC	0x1
 #define TRACE_BLK_OPT_CGROUP	0x2
-- 
2.22.1
