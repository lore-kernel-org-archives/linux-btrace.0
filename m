From: Jens Axboe <jaxboe@fusionio.com>
Date: Fri, 27 May 2011 04:00:03 +0000
Subject: Recent changes
Message-Id: <20110527040003.0C2B337A382@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit e3d388e310fb9ae8aad89cfc728f8d19c6fb6579:

  blktrace 1.0.2 (2011-03-16 09:06:30 +0100)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Tao Ma (2):
      blkparse: Avoid segfault for wrong cpu number.
      blktrace: Use be32_to_cpu for blk_io_trace->cpu.

 blkparse.c |    6 ++++++
 blktrace.h |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 7ee9f9d..817cb31 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2354,6 +2354,12 @@ static int ms_prime(struct ms_stream *msp)
 		if (verify_trace(bit))
 			goto err;
 
+		if (bit->cpu != pci->cpu) {
+			fprintf(stderr, "cpu %d trace info has error cpu %d\n",
+				pci->cpu, bit->cpu);
+			continue;
+		}
+
 		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
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
