From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:58 +0000
Subject: [PATCH 09/10] bno_plot.py: Fix pylint: singleton-comparison
Message-Id: <20200320214459.7760-10-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Comparison to None should be 'expr is None'

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/bno_plot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index be64da0..3aa4e19 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -105,7 +105,7 @@ if __name__ = '__main__':
 					print(fld[0], fld[1], int(fld[2])-int(fld[1]), file=fo)
 
 		t = t[t.rfind('/')+1:]
-		if plot_cmd = None: plot_cmd = "splot '%s'" % t
+		if plot_cmd is None: plot_cmd = "splot '%s'" % t
 		else:                plot_cmd = "%s,'%s'" % (plot_cmd, t)
 
 	with open('%s/plot.cmds' % tmpdir, 'w') as fo:
-- 
2.20.1
