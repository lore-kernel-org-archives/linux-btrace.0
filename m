From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:52 +0000
Subject: [PATCH 03/10] bno_plot.py: Use `with open() as ...` context manager to automatically handle close()
Message-Id: <20200320214459.7760-4-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/bno_plot.py | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index 36fc524..1a1937c 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -98,21 +98,20 @@ if __name__ = '__main__':
 	for f in bnos:
 		t = '%s/%s' % (tmpdir, f)
 
-		fo = open(t, 'w')
-		for line in open(f, 'r'):
-			fld = line.split(None)
-			print(fld[0], fld[1], int(fld[2])-int(fld[1]), file=fo)
-		fo.close()
+		with open(t, 'w') as fo:
+			with open(f, 'r') as fi:
+				for line in fi:
+					fld = line.split(None)
+					print(fld[0], fld[1], int(fld[2])-int(fld[1]), file=fo)
 
 		t = t[t.rfind('/')+1:]
 		if plot_cmd = None: plot_cmd = "splot '%s'" % t
 		else:                plot_cmd = "%s,'%s'" % (plot_cmd, t)
 
-	fo = open('%s/plot.cmds' % tmpdir, 'w')
-	print(cmds, file=fo)
-	if len(bnos) > 10 or keys_below: print('set key below', file=fo)
-	print(plot_cmd, file=fo)
-	fo.close()
+	with open('%s/plot.cmds' % tmpdir, 'w') as fo:
+		print(cmds, file=fo)
+		if len(bnos) > 10 or keys_below: print('set key below', file=fo)
+		print(plot_cmd, file=fo)
 
 	pid = os.fork()
 	if pid = 0:
-- 
2.20.1
