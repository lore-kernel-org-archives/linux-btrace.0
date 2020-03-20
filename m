From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:53 +0000
Subject: [PATCH 04/10] btt_plot.py: Fix pylint: wrong-import-order
Message-Id: <20200320214459.7760-5-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

C0411: standard import "import getopt, glob, os, sys" should be placed
before "import six"

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/btt_plot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index 9c6f207..b135206 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -57,6 +57,7 @@ Arguments:
 
 from __future__ import absolute_import
 from __future__ import print_function
+import getopt, glob, os, sys
 import six
 from six.moves import range
 __author__ = 'Alan D. Brunelle <alan.brunelle@hp.com>'
@@ -65,7 +66,6 @@ __author__ = 'Alan D. Brunelle <alan.brunelle@hp.com>'
 
 import matplotlib
 matplotlib.use('Agg')
-import getopt, glob, os, sys
 import matplotlib.pyplot as plt
 
 plot_size	= [10.9, 8.4]	# inches...
-- 
2.20.1
