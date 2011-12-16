From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:08:14 +0000
Subject: [PATCH 3/10] Free pdu_buff on bad pdu path in process()
Message-Id: <4EEB971E.5030100@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On this error path, pdu_buf was never freed.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blkrawverify.c b/blkrawverify.c
index 4638eb7..ed5d258 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -201,6 +201,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 			if (n = 0) {
 				INC_BAD("bad pdu");
 				nbad_seq++;
+				free(pdu_buf);
 				break;
 			}
 			free(pdu_buf);


