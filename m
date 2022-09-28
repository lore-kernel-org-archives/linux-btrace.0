From: Sakib Sajal <sakib.sajal@windriver.com>
Date: Wed, 28 Sep 2022 20:55:39 +0000
Subject: [PATCH] bno_plot.py: Ask for python3 specifically
Message-Id: <20220928205539.15585-1-sakib.sajal@windriver.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

python2 is deprecated, use python3.

Signed-off-by: Sakib Sajal <sakib.sajal@windriver.com>
---
 btt/bno_plot.py | 2 +-
 btt/btt_plot.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index 3aa4e19..d7d7159 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # btt blkno plotting interface
 #
diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index 40bc71f..8620d31 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # btt_plot.py: Generate matplotlib plots for BTT generate data files
 #
-- 
2.25.1
