From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 27 May 2008 12:45:33 +0000
Subject: [PATCH 2/2] Added in elevator switch message to blktrace stream
Message-Id: <483C026D.5060302@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <483C0216.70008@hp.com>
In-Reply-To: <483C0216.70008@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-btrace@vger.kernel.org


Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 block/elevator.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 980f8ae..902dd13 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1110,6 +1110,8 @@ static int elevator_switch(struct request_queue
*q, struct elevator_type *new_e)
 	queue_flag_clear(QUEUE_FLAG_ELVSWITCH, q);
 	spin_unlock_irq(q->queue_lock);

+	blk_add_trace_msg(q, "elv switch: %s", e->elevator_type->elevator_name);
+
 	return 1;

 fail_register:
-- 
1.5.4.3

