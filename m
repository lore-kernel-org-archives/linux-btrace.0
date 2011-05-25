From: Tao Ma <tm@tao.ma>
Date: Wed, 25 May 2011 15:43:52 +0000
Subject: [PATCH] blktrace: Use be32_to_cpu for blk_io_trace->cpu.
Message-Id: <1306338232-10670-1-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: taoma <taoma@taoma-laptop2.(none)>

blk_io_trace->cpu is u32, so use be32_to_cpu instead.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 blktrace.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/blktrace.h b/blktrace.h
index 816ce61..8b3e031 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -110,7 +110,7 @@ static inline void trace_to_cpu(struct blk_io_trace *t)
 	t->action	= be32_to_cpu(t->action);
 	t->pid		= be32_to_cpu(t->pid);
 	t->device	= be32_to_cpu(t->device);
-	t->cpu		= be16_to_cpu(t->cpu);
+	t->cpu		= be32_to_cpu(t->cpu);
 	t->error	= be16_to_cpu(t->error);
 	t->pdu_len	= be16_to_cpu(t->pdu_len);
 }
-- 
1.7.1

