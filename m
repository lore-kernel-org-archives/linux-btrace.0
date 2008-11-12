From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 12 Nov 2008 12:09:29 +0000
Subject: [PATCH] Fix compiler warning - check return value from ftruncate
Message-Id: <491AC779.8070301@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030806030003050603020709"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806030003050603020709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030806030003050603020709
Content-Type: text/x-diff;
 name="0001-Fix-compiler-warning-check-return-value-from-ftrun.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename*0="0001-Fix-compiler-warning-check-return-value-from-ftrun.patc";
 filename*1="h"


gcc 4.3.2 has started to warn about:

gcc -o blktrace.o -c -Wall -O2 -g -W -D_GNU_SOURCE -D_LARGEFILE_SOURCE
-D_FILE_OFFSET_BITS=64 blktrace.c
blktrace.c: In function ���������tip_ftrunc_final���������:
blktrace.c:662: warning: ignoring return value of ���������ftruncate���������, declared
with attribute warn_unused_result

This simple patch overcomes that - no exit is performed as this is not
fatal, and the thread will be exitting soon enough.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 7e27f14..ad54db5 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -654,12 +654,18 @@ static void tip_ftrunc_final(struct thread_information *tip)
 	 * truncate to right size and cleanup mmap
 	 */
 	if (tip->ofile_mmap && tip->ofile) {
+		int ret;
 		int ofd = fileno(tip->ofile);
 
 		if (tip->fs_buf)
 			munmap(tip->fs_buf, tip->fs_buf_len);
 
-		ftruncate(ofd, tip->fs_size);
+		ret = ftruncate(ofd, tip->fs_size);
+		if (ret < 0) {
+			perror(tip->fn);
+			fprintf(stderr, "Warning: thread %d ftrunc failed\n",
+				tip->cpu);
+		}
 	}
 }
 
-- 
1.5.6.3


--------------030806030003050603020709--
