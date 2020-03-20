From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:50 +0000
Subject: [PATCH 01/10] btt_plot.py: Use sum() instead of open-coding it to compute list average
Message-Id: <20200320214459.7760-2-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/btt_plot.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index 76fcca8..9c6f207 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -125,10 +125,7 @@ def get_data(files):
 		def _avg(vals):
 			"""Computes average for array of values passed"""
 
-			total = 0.0
-			for val in vals:
-				total += val
-			return total / len(vals)
+			return sum(vals) / len(vals)
 
 		#------------------------------------------------------
 		if len(xs) < 1000:
-- 
2.20.1
