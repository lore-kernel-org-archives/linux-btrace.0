From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:51 +0000
Subject: [PATCH 02/10] bno_plot.py: Use shutil.rmtree() instead of os.system('/bin/rm')
Message-Id: <20200320214459.7760-3-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/bno_plot.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index f05cfdc..36fc524 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -40,7 +40,7 @@ To exit the plotter, enter 'quit' or ^D at the 'gnuplot> ' prompt.
 
 from __future__ import absolute_import
 from __future__ import print_function
-import getopt, glob, os, sys, tempfile
+import getopt, glob, os, sys, tempfile, shutil
 
 verbose	= 0
 cmds	= """
@@ -125,4 +125,4 @@ if __name__ = '__main__':
 		sys.exit(1)
 
 	os.waitpid(pid, 0)
-	os.system('/bin/rm -rf ' + tmpdir)
+	shutil.rmtree(tmpdir)
-- 
2.20.1
