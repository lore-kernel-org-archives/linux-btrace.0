From: Tao Ma <tm@tao.ma>
Date: Fri, 14 Jan 2011 07:56:10 +0000
Subject: [PATCH] blkiomon: Fix an output error.
Message-Id: <1294991770-16405-1-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Tao Ma <boyu.mt@taobao.com>

When we give out some statistics in blkiomon, we don't consider
the situation that the device has no correspoinding action. See
if there is no disk read during the interval, the output in my box is
like:
sizes read (bytes): num 0, min -1, max 0, sum 0, squ 0, avg nan, var nan

With the fix, now it looks like:
sizes read (bytes): num 0, min -1, max 0, sum 0, squ 0, avg 0.0, var 0.0

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 stats.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/stats.h b/stats.h
index fdedf27..5b9a313 100644
--- a/stats.h
+++ b/stats.h
@@ -75,6 +75,9 @@ static inline void minmax_to_be(struct minmax *mm)
 
 static inline double minmax_avg(struct minmax *mm)
 {
+	if (!mm->num)
+		return 0;
+
 	return (mm->sum / (double)mm->num);
 }
 
@@ -82,6 +85,9 @@ static inline double minmax_var(struct minmax *mm)
 {
 	double num = (double)mm->num;
 
+	if (!mm->num)
+		return 0;
+
 	return ((mm->sos - ((mm->sum * mm->sum) / num)) / num);
 }
 
-- 
1.6.3.GIT
