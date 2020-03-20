From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:56 +0000
Subject: [PATCH 07/10] btt_plot.py: Fix pylint: no-else-return
Message-Id: <20200320214459.7760-8-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Unnecessary "elif" after "return"

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/btt_plot.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index 653ace7..b67caaa 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -396,12 +396,11 @@ def do_live(files):
 	def live_sort(a, b):
 		if a[0] = 'sys' and b[0] = 'sys':
 			return 0
-		elif a[0] = 'sys' or a[2][0] < b[2][0]:
+		if a[0] = 'sys' or a[2][0] < b[2][0]:
 			return -1
-		elif b[0] = 'sys' or a[2][0] > b[2][0]:
+		if b[0] = 'sys' or a[2][0] > b[2][0]:
 			return  1
-		else:
-			return  0
+		return  0
 
 	#----------------------------------------------------------------------
 	def turn_off_ticks(ax):
-- 
2.20.1
