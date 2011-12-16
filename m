From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:06:31 +0000
Subject: [PATCH 2/10] Fix potential array overrun in act_to_str
Message-Id: <4EEB96B7.1020902@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The acts[] array is only N_ACTS elements, so we should not
ever set acts[N_ACTS]

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blkrawverify.c b/blkrawverify.c
index b6ceb9d..4638eb7 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -87,7 +87,7 @@ static char *act_to_str(__u32 action)
 	unsigned int act = action & 0xffff;
 	unsigned int trace = (action >> BLK_TC_SHIFT) & 0xffff;
 
-	if (act <= N_ACTS) {
+	if (act < N_ACTS) {
 		sprintf(buf, "%s ", acts[act].string);
 		for (i = 0; i < N_TRACES; i++)
 			if (trace & (1 << i)) {


