From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:57 +0000
Subject: [PATCH 08/10] bno_plot.py: Fix pylint: len-as-condition
Message-Id: <20200320214459.7760-9-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Do not use `len(SEQUENCE)` to determine if a sequence is empty

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/bno_plot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index 1a1937c..be64da0 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -76,7 +76,7 @@ def parse_args(in_args):
 		elif o in ('-K', '--keys-below'):
 			keys_below = True
 
-	if len(args) > 0:	bnos = args
+	if args:	bnos = args
 	else:			bnos = glob.glob('blknos*[rw].dat')
 
 	return (bnos, keys_below)
-- 
2.20.1
