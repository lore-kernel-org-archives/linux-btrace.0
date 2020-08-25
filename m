From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 25 Aug 2020 22:10:09 +0000
Subject: [RFC PATCH 39/39] blktrace: track zone appaend completion sector
Message-Id: <20200825221009.6457-40-chaitanya.kulkarni@wdc.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The request type REQ_OP_ZONE_APPENDT needs zone start the when issued
not the actual sector where this I/O lands and returns completion sector
in for trace complete event 'C'. Right now we cannot track submission &
completion sector for this special request with existing format.

Add a new completion sector field in the blk_io_trace_ext structure,
when generating the trace when req_op is REQ_OP_ZONE_APPEND update
the completion sector from the I/O and store the zone start (where
actual I/O was issued) in the secor field of the trace.

With this new format we can track completion sector. (* is not a part
real trace it is here as a place holder so that it is easy to read for
reviewers) :-

252,0 15  1 92.785481956  6139  Q ZAS N 262144 + 8 [dd]
252,0 15  2 92.785490381  6139  G ZAS N 262144 + 8 [dd]
252,0 15  3 92.785498517  6139  I ZAS N 262144 + 8 [dd]
252,0 15  4 92.785519065   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15  5 92.785541527    86  C ZAS N 262144 + 8 [0] <262144>

252,0 15  6 92.785561936  6139  Q ZAS N 262144 + 8 [dd]
252,0 15  7 92.785568368  6139  G ZAS N 262144 + 8 [dd]
252,0 15  8 92.785574820  6139  I ZAS N 262144 + 8 [dd]
252,0 15  9 92.785587754   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 10 92.785602802    86  C ZAS N 262144 + 8 [0] <262152>

252,0 15 11 92.785619704  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 12 92.785626076  6139  G ZAS N 262144 + 8 [dd]
252,0 15 13 92.785632438  6139  I ZAS N 262144 + 8 [dd]
252,0 15 14 92.785644801   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 15 92.785659939    86  C ZAS N 262144 + 8 [0] <262160>

252,0 15 16 92.785676460  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 17 92.785682872  6139  G ZAS N 262144 + 8 [dd]
252,0 15 18 92.785689294  6139  I ZAS N 262144 + 8 [dd]
252,0 15 19 92.785701487   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 20 92.785716024    86  C ZAS N 262144 + 8 [0] <262168>

252,0 15 21 92.785732335  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 22 92.785738687  6139  G ZAS N 262144 + 8 [dd]
252,0 15 23 92.785745019  6139  I ZAS N 262144 + 8 [dd]
252,0 15 24 92.785757843   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 25 92.785772020    86  C ZAS N 262144 + 8 [0] <262176>

252,0 15 26 92.785788180  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 27 92.785794492  6139  G ZAS N 262144 + 8 [dd]
252,0 15 28 92.785800763  6139  I ZAS N 262144 + 8 [dd]
252,0 15 29 92.785812696   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 30 92.785826762    86  C ZAS N 262144 + 8 [0] <262184>

252,0 15 31 92.785842852  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 32 92.785849104  6139  G ZAS N 262144 + 8 [dd]
252,0 15 33 92.785855346  6139  I ZAS N 262144 + 8 [dd]
252,0 15 34 92.785867599   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 35 92.785881835    86  C ZAS N 262144 + 8 [0] <262192>

252,0 15 36 92.785897845  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 37 92.785904107  6139  G ZAS N 262144 + 8 [dd]
252,0 15 38 92.785910329  6139  I ZAS N 262144 + 8 [dd]
252,0 15 39 92.785922181   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 40 92.785936237    86  C ZAS N 262144 + 8 [0] <262200>

252,0 15 41 92.785952037  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 42 92.785958289  6139  G ZAS N 262144 + 8 [dd]
252,0 15 43 92.785964651  6139  I ZAS N 262144 + 8 [dd]
252,0 15 44 92.785976373   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 45 92.785990419    86  C ZAS N 262144 + 8 [0] <262208>

252,0 15 46 92.786006339  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 47 92.786025204  6139  G ZAS N 262144 + 8 [dd]
252,0 15 48 92.786031566  6139  I ZAS N 262144 + 8 [dd]
252,0 15 49 92.786043869   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 50 92.786058216    86  C ZAS N 262144 + 8 [0] <262216>

252,0 10  1 92.783369654  6138  Q ZRS N 262144 + 0 [truncate]
252,0 10  2 92.783384813  6138  G ZRS N 262144 + 0 [truncate]
252,0 10  3 92.783395182  6138  I ZRS N 262144 + 0 [truncate]
252,0 10  4 92.783419628   782  D ZRS N 262144 + 0 [kworker/10:1H]
252,0 10  5 92.783460895    61  C ZRS N 262144 + 0 [0]
252,0  8  1 92.788546342  6140  Q ZRAS N 0 + 0 [blkzone]
252,0  8  2 92.788554628  6140  G ZRAS N 0 + 0 [blkzone]
252,0  8  3 92.788562232  6140  I ZRAS N 0 + 0 [blkzone]
252,0  8  4 92.788580977   934  D ZRAS N 0 + 0 [kworker/8:1H]
252,0  8  5 92.788597268    51  C ZRAS N 0 + 0 [0]

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  1 +
 kernel/trace/blktrace.c           | 36 +++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index ac533a0b0928..ebfe3029cd10 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -155,6 +155,7 @@ struct blk_io_trace_ext {
 	__u32 sequence;		/* event number */
 	__u64 time;		/* in nanoseconds */
 	__u64 sector;		/* disk offset */
+	__u64 completion_sector;/* zone append completion sector */
 	__u32 bytes;		/* transfer length */
 	__u64 action;		/* what happened */
 	__u32 ioprio;		/* I/O priority */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e571c599bdf8..6d78d2cb6976 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -502,7 +502,8 @@ static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
  */
 static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u64 what, int error, int pdu_len,
-		     void *pdu_data, u64 cgid, u32 ioprio, void *bip)
+		     void *pdu_data, u64 cgid, u32 ioprio, void *bip,
+		     sector_t blk_queue_zone_sectors)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -594,6 +595,17 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 		t->cpu = cpu;
 		t->pid = pid;
 
+		if (op = REQ_OP_ZONE_APPEND) {
+			sector_t zno = sector >> ilog2(blk_queue_zone_sectors);
+
+			t->completion_sector = sector;
+			/*
+			 *  Start of the zone sector in which this completion
+			 *  sector belongs to.
+			 */
+			sector = zno * blk_queue_zone_sectors;
+		}
+
 		t->sector = sector;
 		t->bytes = bytes;
 		t->action = what;
@@ -1459,7 +1471,8 @@ static void blk_add_trace_rq(struct request *rq, int error,
 			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
 				    req_op(rq), rq->cmd_flags, what, error, 0,
-				    NULL, cgid, req_get_ioprio(rq), NULL);
+				    NULL, cgid, req_get_ioprio(rq), NULL,
+				    blk_queue_zone_sectors(rq->q));
 	}
 	rcu_read_unlock();
 }
@@ -1607,7 +1620,8 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, what, error, 0, NULL,
 				    blk_trace_bio_get_cgid(q, bio),
-				    bio_prio(bio), bio_integrity(bio));
+				    bio_prio(bio), bio_integrity(bio),
+				    blk_queue_zone_sectors(q));
 	}
 	rcu_read_unlock();
 }
@@ -1769,7 +1783,7 @@ static void blk_add_trace_getrq(void *ignore,
 		} else if (bte) {
 			__blk_add_trace_ext(bte, 0, 0, rw, 0, ta, 0, 0, NULL,
 					    0, bio_prio(bio),
-					    bio_integrity(bio));
+					    bio_integrity(bio), 0);
 
 		}
 		rcu_read_unlock();
@@ -1811,7 +1825,7 @@ static void blk_add_trace_sleeprq(void *ignore,
 		else if (bte)
 			__blk_add_trace_ext(bte, 0, 0, rw, 0, ta, 0, 0, NULL,
 					    0, bio_prio(bio),
-					    bio_integrity(bio));
+					    bio_integrity(bio), 0);
 		rcu_read_unlock();
 	}
 }
@@ -1832,7 +1846,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 	else if (bte)
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
-				    NULL, 0, 0, NULL);
+				    NULL, 0, 0, NULL, 0);
 	rcu_read_unlock();
 }
 
@@ -1864,7 +1878,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER_EXT;
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
-				    &rpdu, 0, 0, NULL);
+				    &rpdu, 0, 0, NULL, 0);
 	}
 	rcu_read_unlock();
 }
@@ -1898,7 +1912,7 @@ static void blk_add_trace_split(void *ignore,
 				    bio->bi_status, sizeof(rpdu), &rpdu,
 				    blk_trace_bio_get_cgid(q, bio),
 				    bio_prio(bio),
-				    bio_integrity(bio));
+				    bio_integrity(bio), 0);
 	}
 	rcu_read_unlock();
 }
@@ -1948,7 +1962,7 @@ static void blk_add_trace_bio_remap(void *ignore,
 				    bio->bi_status, sizeof(r), &r,
 				    blk_trace_bio_get_cgid(q, bio),
 				    bio_prio(bio),
-				    bio_integrity(bio));
+				    bio_integrity(bio), 0);
 	}
 	rcu_read_unlock();
 }
@@ -1997,7 +2011,7 @@ static void blk_add_trace_rq_remap(void *ignore,
 				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
 				    sizeof(r), &r,
 				    blk_trace_request_get_cgid(q, rq), 0,
-				    NULL);
+				    NULL, 0);
 	}
 	rcu_read_unlock();
 }
@@ -2036,7 +2050,7 @@ void blk_add_driver_data(struct request_queue *q,
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
 				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
 				len, data, blk_trace_request_get_cgid(q, rq),
-				req_get_ioprio(rq), NULL);
+				req_get_ioprio(rq), NULL, 0);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1
