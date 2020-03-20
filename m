From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:59 +0000
Subject: [PATCH 10/10] btt_plot.py: Use `with open() as ...` context manager
Message-Id: <20200320214459.7760-11-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

to automatically handle close()

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/btt_plot.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index b67caaa..40bc71f 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -168,14 +168,15 @@ def get_data(files):
 
 		xs = []
 		ys = []
-		for line in open(file, 'r'):
-			f = line.rstrip().split(None)
-			if line.find('#') = 0 or len(f) < 2:
-				continue
-			(min_x, max_x, x) = check(min_x, max_x, f[0])
-			(min_y, max_y, y) = check(min_y, max_y, f[1])
-			xs.append(x)
-			ys.append(y)
+		with open(file, 'r') as fi:
+			for line in fi:
+				f = line.rstrip().split(None)
+				if line.find('#') = 0 or len(f) < 2:
+					continue
+				(min_x, max_x, x) = check(min_x, max_x, f[0])
+				(min_y, max_y, y) = check(min_y, max_y, f[1])
+				xs.append(x)
+				ys.append(y)
 
 		db[file] = {'x':xs, 'y':ys}
 		if len(xs) > 10:
@@ -385,11 +386,12 @@ def do_live(files):
 	def get_live_data(fn):
 		xs = []
 		ys = []
-		for line in open(fn, 'r'):
-			f = line.rstrip().split()
-			if f[0] != '#' and len(f) = 2:
-				xs.append(float(f[0]))
-				ys.append(float(f[1]))
+		with open(fn, 'r') as fi:
+			for line in fi:
+				f = line.rstrip().split()
+				if f[0] != '#' and len(f) = 2:
+					xs.append(float(f[0]))
+					ys.append(float(f[1]))
 		return xs, ys
 
 	#----------------------------------------------------------------------
-- 
2.20.1
