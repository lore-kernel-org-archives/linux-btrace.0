From: Eric Sandeen <sandeen@redhat.com>
Date: Wed, 06 May 2009 21:49:49 +0000
Subject: [PATCH] blkiomon: fix unaligned accesses on ia64
Message-Id: <4A0205FD.7070004@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

commit 7aa3ebcec011bfe9cc60d6476252c03376a37551 packed
the blkiomon_stat structure so that traces from one 
arch could be analyzed on another (in truth only x86
is different, at least from x86_64/ia64/ppc/ppc64/s390/s390x)

Rather than packing it, which generates unaligned access
warnings on ia64, just pad the structure out so that it's
naturally aligned on all arches.

Martin, care to test this to be sure it still works for
you?  (I'm not sure if we might also need a 4 byte pad on 
the end of the structure to align the containing structure...)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blkiomon.h b/blkiomon.h
index 2e430a6..ae48b4c 100644
--- a/blkiomon.h
+++ b/blkiomon.h
@@ -34,6 +34,7 @@ struct blkiomon_stat {
 	__u64 time;
 	__u32 size_hist[BLKIOMON_SIZE_BUCKETS];
 	__u32 d2c_hist[BLKIOMON_D2C_BUCKETS];
+	__u32 pad; /* Align the structure */
 	struct minmax size_r;
 	struct minmax size_w;
 	struct minmax d2c_r;
@@ -42,7 +43,7 @@ struct blkiomon_stat {
 	struct minmax thrput_w;
 	__u64 bidir;
 	__u32 device;
-} __attribute__ ((packed));
+};
 
 static struct histlog2 size_hist = {
 	.first = 0,

