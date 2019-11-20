From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 20 Nov 2019 04:25:08 +0000
Subject: [RFC PATCH 38/39] blktrace: add integrity tracking support
Message-Id: <20191120042509.12835-39-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This patch adds support to track the integrity related information.
We update struct blk_io_trace_ext with two new members :-
1. seed :- to track the integrity seed.
2. integrity :- to store the integrity related flags and integrity
   size buffer.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  2 +
 kernel/trace/blktrace.c           | 63 ++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index cf2ad90fd399..3e85f7acd73c 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -154,6 +154,8 @@ struct blk_io_trace_ext {
 	__u32 bytes;            /* transfer length */
 	__u64 action;           /* what happened */
 	__u32 ioprio;           /* I/O priority */
+	__u64 seed;		/* integrity seed */
+	__u64 integrity;	/* store integrity flags */
 	__u32 pid;              /* who did it */
 	__u32 device;           /* device number */
 	__u32 cpu;              /* on what cpu did it happen */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3f204bd9a311..8644e58ba1c9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -114,7 +114,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 
 static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
 			   const void *data, size_t len,
-			   union kernfs_node_id *cgid, u32 ioprio)
+			   union kernfs_node_id *cgid, u32 ioprio,
+			   struct bio_integrity_payload *bip)
 {
 	struct blk_io_trace_ext *t;
 	struct ring_buffer_event *event = NULL;
@@ -177,7 +178,8 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
-static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
+static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio,
+			       struct bio_integrity_payload *bip)
 {
 	unsigned long flags;
 	struct blk_trace_ext *bt;
@@ -186,7 +188,7 @@ static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
 	spin_lock_irqsave(&running_trace_ext_lock, flags);
 	list_for_each_entry(bt, &running_trace_ext_list, running_ext_list) {
 		trace_note_ext(bt, tsk->pid, BLK_TN_PROCESS_EXT, tsk->comm,
-			   sizeof(tsk->comm), NULL, ioprio);
+			   sizeof(tsk->comm), NULL, ioprio, bip);
 	}
 	spin_unlock_irqrestore(&running_trace_ext_lock, flags);
 }
@@ -219,7 +221,7 @@ static void trace_note_time_ext(struct blk_trace_ext *bt)
 	words[1] = now.tv_nsec;
 
 	local_irq_save(flags);
-	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), NULL, 0);
+	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), NULL, 0, NULL);
 	local_irq_restore(flags);
 }
 
@@ -289,9 +291,10 @@ void __trace_note_message_ext(struct blk_trace_ext *bt, struct blkcg *blkcg,
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n,
-		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : NULL, 0);
+		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : NULL, 0,
+		NULL);
 #else
-	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, NULL, 0);
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, NULL, 0, NULL);
 #endif
 	local_irq_restore(flags);
 }
@@ -461,6 +464,26 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void set_integrity(struct blk_io_trace_ext *t,
+			  struct bio_integrity_payload *bip)
+{
+	t->seed = (u64)bip_get_seed(bip);
+	/*
+	 * We store integrity buffer size and flags as :-
+	 *
+	 * 63            48          32            16     5          0
+	 * |          reserved       | buffer size | rsvd | bip flags |
+	 */
+	t->integrity = (bip->bip_iter.bi_size << 16) | bip->bip_flags;
+}
+#else
+static void set_integrity(struct blk_io_trace_ext *t, void *bip)
+{
+
+}
+#endif
+
 /*
  * Data direction bit lookup
  */
@@ -477,7 +500,8 @@ static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
  */
 static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u64 what, int error, int pdu_len,
-		     void *pdu_data, union kernfs_node_id *cgid, u32 ioprio)
+		     void *pdu_data, union kernfs_node_id *cgid, u32 ioprio,
+		     void *bip)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -536,7 +560,7 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 	}
 
 	if (unlikely(tsk->btrace_seq != blktrace_seq))
-		trace_note_tsk_ext(tsk, ioprio);
+		trace_note_tsk_ext(tsk, ioprio, bip);
 
 	/*
 	 * A word about the locking here - we disable interrupts to reserve
@@ -565,6 +589,8 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 		t->bytes = bytes;
 		t->action = what;
 		t->ioprio = ioprio;
+		if (bip)
+			set_integrity(t, bip);
 		t->device = bt->dev;
 		t->error = error;
 		t->pdu_len = pdu_len + cgid_len;
@@ -1394,7 +1420,7 @@ static void blk_add_trace_rq(struct request *rq, int error,
 			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
 				    req_op(rq), rq->cmd_flags, what, error, 0,
-				    NULL, cgid, req_get_ioprio(rq));
+				    NULL, cgid, req_get_ioprio(rq), NULL);
 	}
 }
 
@@ -1482,7 +1508,7 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf,what, error, 0, NULL,
 				    blk_trace_bio_get_cgid(q, bio),
-				    bio_prio(bio));
+				    bio_prio(bio), bio_integrity(bio));
 	}
 }
 
@@ -1575,7 +1601,7 @@ static void blk_add_trace_getrq(void *ignore,
 					NULL, NULL);
 		} else if (q->blk_trace_ext) {
 			__blk_add_trace_ext(bte, 0, 0, rw, 0, BLK_TA_GETRQ_EXT,
-					    0, 0, NULL, NULL, 0);
+					    0, 0, NULL, NULL, 0, NULL);
 		}
 	}
 }
@@ -1600,7 +1626,7 @@ static void blk_add_trace_sleeprq(void *ignore,
 		} else if (q->blk_trace_ext) {
 			__blk_add_trace_ext(bte, 0, 0, rw, 0,
 					    BLK_TA_SLEEPRQ_EXT,
-					    0, 0, NULL, NULL, 0);
+					    0, 0, NULL, NULL, 0, NULL);
 		}
 	}
 }
@@ -1614,7 +1640,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL);
 	} else if (q->blk_trace_ext) {
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
-				    NULL, NULL, 0);
+				    NULL, NULL, 0, NULL);
 	}
 }
 
@@ -1645,7 +1671,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 				&rpdu, NULL);
 	} else if (q->blk_trace_ext) {
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
-				    &rpdu, NULL, 0);
+				    &rpdu, NULL, 0, NULL);
 	}
 }
 
@@ -1667,7 +1693,7 @@ static void blk_add_trace_split(void *ignore,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
 				BLK_TA_SPLIT_EXT, bio->bi_status, sizeof(rpdu),
 				&rpdu, blk_trace_bio_get_cgid(q, bio),
-				bio_prio(bio));
+				bio_prio(bio), bio_integrity(bio));
 	}
 }
 
@@ -1705,7 +1731,8 @@ static void blk_add_trace_bio_remap(void *ignore,
 		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
 				BLK_TA_REMAP_EXT, bio->bi_status, sizeof(r), &r,
-				blk_trace_bio_get_cgid(q, bio), bio_prio(bio));
+				blk_trace_bio_get_cgid(q, bio), bio_prio(bio),
+				bio_integrity(bio));
 	}
 }
 
@@ -1743,7 +1770,7 @@ static void blk_add_trace_rq_remap(void *ignore,
 		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
 				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
 				    sizeof(r), &r, blk_trace_request_get_cgid(q, rq),
-				    req_get_ioprio(rq));
+				    req_get_ioprio(rq), NULL);
 	}
 }
 
@@ -1773,7 +1800,7 @@ void blk_add_driver_data(struct request_queue *q,
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), blk_rq_bytes(rq),
 				0, 0, BLK_TA_DRV_DATA_EXT, 0, len, data,
 				blk_trace_request_get_cgid(q, rq),
-				req_get_ioprio(rq));
+				req_get_ioprio(rq), NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
-- 
2.22.1
