From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:10:07 +0000
Subject: [RFC PATCH 37/39] blktrace: add integrity tracking support
Message-Id: <20200825221009.6457-38-chaitanya.kulkarni@wdc.com>
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

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/uapi/linux/blktrace_api.h |  2 +
 kernel/trace/blktrace.c           | 69 ++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index fdb3a5cdfa22..ac533a0b0928 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -158,6 +158,8 @@ struct blk_io_trace_ext {
 	__u32 bytes;		/* transfer length */
 	__u64 action;		/* what happened */
 	__u32 ioprio;		/* I/O priority */
+	__u64 seed;		/* integrity seed */
+	__u64 integrity;	/* store integrity flags */
 	__u32 pid;		/* who did it */
 	__u32 device;		/* device number */
 	__u32 cpu;		/* on what cpu did it happen */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 23e3c6b33f1d..3cf1b2bbae79 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -66,6 +66,26 @@ static int blk_probes_ref;
 static void blk_register_tracepoints(void);
 static void blk_unregister_tracepoints(void);
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void set_integrity(struct blk_io_trace_ext *t,
+			  struct bio_integrity_payload *bip)
+{
+	t->seed = (u64)bip_get_seed(bip);
+	/*
+	 * We store integrity buffer size and flags as :-
+	 *
+	 * 63            48          32            16     5           0
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
  * Send out a notify message.
  */
@@ -115,7 +135,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 }
 
 static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
-			   const void *data, size_t len, u64 cgid, u32 ioprio)
+			   const void *data, size_t len, u64 cgid, u32 ioprio,
+			   struct bio_integrity_payload *bip)
 {
 	struct blk_io_trace_ext *t;
 	struct ring_buffer_event *event = NULL;
@@ -148,6 +169,8 @@ static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
 		t->device = bt->dev;
 		t->action = action | (cgid ? __BLK_TN_CGROUP : 0);
 		t->ioprio = ioprio;
+		if (bip)
+			set_integrity(t, bip);
 		t->pid = pid;
 		t->cpu = cpu;
 		t->pdu_len = len + cgid_len;
@@ -178,7 +201,8 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
-static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
+static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio,
+			       struct bio_integrity_payload *bip)
 {
 	unsigned long flags;
 	struct blk_trace_ext *bt;
@@ -187,7 +211,7 @@ static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
 	spin_lock_irqsave(&running_trace_ext_lock, flags);
 	list_for_each_entry(bt, &running_trace_ext_list, running_ext_list) {
 		trace_note_ext(bt, tsk->pid, BLK_TN_PROCESS_EXT, tsk->comm,
-			   sizeof(tsk->comm), 0, ioprio);
+			       sizeof(tsk->comm), 0, ioprio, bip);
 	}
 	spin_unlock_irqrestore(&running_trace_ext_lock, flags);
 }
@@ -220,7 +244,7 @@ static void trace_note_time_ext(struct blk_trace_ext *bt)
 	words[1] = now.tv_nsec;
 
 	local_irq_save(flags);
-	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0, 0);
+	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0, 0, NULL);
 	local_irq_restore(flags);
 }
 
@@ -290,9 +314,9 @@ void __trace_note_message_ext(struct blk_trace_ext *bt, struct blkcg *blkcg,
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n,
-		blkcg ? cgroup_id(blkcg->css.cgroup) : 1, 0);
+		blkcg ? cgroup_id(blkcg->css.cgroup) : 1, 0, NULL);
 #else
-	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, 0, 0);
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, 0, 0, NULL);
 #endif
 	local_irq_restore(flags);
 }
@@ -478,7 +502,7 @@ static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
  */
 static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u64 what, int error, int pdu_len,
-		     void *pdu_data, u64 cgid, u32 ioprio)
+		     void *pdu_data, u64 cgid, u32 ioprio, void *bip)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -545,7 +569,7 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 	}
 
 	if (unlikely(tsk->btrace_seq != blktrace_seq))
-		trace_note_tsk_ext(tsk, ioprio);
+		trace_note_tsk_ext(tsk, ioprio, bip);
 
 	/*
 	 * A word about the locking here - we disable interrupts to reserve
@@ -1435,7 +1459,7 @@ static void blk_add_trace_rq(struct request *rq, int error,
 			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
 				    req_op(rq), rq->cmd_flags, what, error, 0,
-				    NULL, cgid, req_get_ioprio(rq));
+				    NULL, cgid, req_get_ioprio(rq), NULL);
 	}
 	rcu_read_unlock();
 }
@@ -1583,7 +1607,7 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, what, error, 0, NULL,
 				    blk_trace_bio_get_cgid(q, bio),
-				    bio_prio(bio));
+				    bio_prio(bio), bio_integrity(bio));
 	}
 	rcu_read_unlock();
 }
@@ -1744,7 +1768,9 @@ static void blk_add_trace_getrq(void *ignore,
 			__blk_add_trace(bt, 0, 0, rw, 0, ta, 0, 0, NULL, 0);
 		} else if (bte) {
 			__blk_add_trace_ext(bte, 0, 0, rw, 0, ta, 0, 0, NULL,
-					0, 0);
+					    0, bio_prio(bio),
+					    bio_integrity(bio));
+
 		}
 		rcu_read_unlock();
 	}
@@ -1784,7 +1810,8 @@ static void blk_add_trace_sleeprq(void *ignore,
 			__blk_add_trace(bt, 0, 0, rw, 0, ta, 0, 0, NULL, 0);
 		else if (bte)
 			__blk_add_trace_ext(bte, 0, 0, rw, 0, ta, 0, 0, NULL,
-					0, 0);
+					    0, bio_prio(bio),
+					    bio_integrity(bio));
 		rcu_read_unlock();
 	}
 }
@@ -1805,7 +1832,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 	else if (bte)
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
-				    NULL, 0, 0);
+				    NULL, 0, 0, NULL);
 	rcu_read_unlock();
 }
 
@@ -1837,7 +1864,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER_EXT;
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
-				&rpdu, 0, 0);
+				    &rpdu, 0, 0, NULL);
 	}
 	rcu_read_unlock();
 }
@@ -1869,7 +1896,9 @@ static void blk_add_trace_split(void *ignore,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, BLK_TA_SPLIT_EXT,
 				    bio->bi_status, sizeof(rpdu), &rpdu,
-				    blk_trace_bio_get_cgid(q, bio), 0);
+				    blk_trace_bio_get_cgid(q, bio),
+				    bio_prio(bio),
+				    bio_integrity(bio));
 	}
 	rcu_read_unlock();
 }
@@ -1917,7 +1946,9 @@ static void blk_add_trace_bio_remap(void *ignore,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, BLK_TA_REMAP_EXT,
 				    bio->bi_status, sizeof(r), &r,
-				    blk_trace_bio_get_cgid(q, bio), 0);
+				    blk_trace_bio_get_cgid(q, bio),
+				    bio_prio(bio),
+				    bio_integrity(bio));
 	}
 	rcu_read_unlock();
 }
@@ -1965,8 +1996,8 @@ static void blk_add_trace_rq_remap(void *ignore,
 		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
 				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
 				    sizeof(r), &r,
-				    blk_trace_request_get_cgid(q, rq), 0);
-
+				    blk_trace_request_get_cgid(q, rq), 0,
+				    NULL);
 	}
 	rcu_read_unlock();
 }
@@ -2005,7 +2036,7 @@ void blk_add_driver_data(struct request_queue *q,
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
 				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
 				len, data, blk_trace_request_get_cgid(q, rq),
-				req_get_ioprio(rq));
+				req_get_ioprio(rq), NULL);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1
