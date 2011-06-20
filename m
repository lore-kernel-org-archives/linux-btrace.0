From: Matthew Boyle <mlb@corefiling.co.uk>
Date: Mon, 20 Jun 2011 13:12:17 +0000
Subject: [PATCH] blktrace:  pass a valid pointer to realloc.
Message-Id: <4DFF4731.6010001@corefiling.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090405050901020509030201"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405050901020509030201
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

When blktrace is writing to stdout, and there's sufficient disk activity
to fill the trace buffer, tb_combine() tries to increase the buffer
size.  But the pointer it passes to realloc isn't to the head of the
block of memory.  glibc's realloc gets really quite upset at this, and
aborts the process.

This just passes in the pointer handed out by malloc.

Signed-off-by: Matt Boyle <mlb@corefiling.co.uk>
---
  blktrace.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)



--------------090405050901020509030201
Content-Type: text/x-patch;
 name="0001-blktrace-pass-a-valid-pointer-to-realloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-blktrace-pass-a-valid-pointer-to-realloc.patch"

diff --git a/blktrace.c b/blktrace.c
index 72866e2..d4d5111 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1330,7 +1330,7 @@ static struct trace_buf *tb_combine(struct trace_buf *prev,
 		 * the whole structures, as the other fields
 		 * are "static".
 		 */
-		prev = realloc(prev->buf, sizeof(*prev) + tot_len);
+		prev = realloc(prev, sizeof(*prev) + tot_len);
 		prev->buf = (void *)(prev + 1);
 	}
 


--------------090405050901020509030201--
