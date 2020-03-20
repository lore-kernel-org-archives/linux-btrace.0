From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:55 +0000
Subject: [PATCH 06/10] btt_plot.py: Fix pylint: singleton-comparison
Message-Id: <20200320214459.7760-7-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Comparison to None should be 'expr is None'

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/btt_plot.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index d6d27aa..653ace7 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -113,8 +113,8 @@ def get_data(files):
 		"""Returns new min, max, and float value for those passed in"""
 
 		v = float(v)
-		if mn = None or v < mn: mn = v
-		if mx = None or v > mx: mx = v
+		if mn is None or v < mn: mn = v
+		if mx is None or v > mx: mx = v
 		return mn, mx, v
 
 	#--------------------------------------------------------------
@@ -235,7 +235,7 @@ def parse_args(args):
 		elif o in ('-v', '--verbose'):
 			verbose = True
 
-	if type = None and not generate_all:
+	if type is None and not generate_all:
 		fatal('Need type of data files to process - (-t <type>)')
 
 	return args
@@ -244,7 +244,7 @@ def parse_args(args):
 def gen_title(fig, type, title_str):
 	"""Sets the title for the figure based upon the type /or/ user title"""
 
-	if title_str != None:
+	if title_str is not None:
 		pass
 	elif type = 'aqd':
 		title_str = 'Average Queue Depth'
@@ -309,7 +309,7 @@ def generate_output(type, db):
 	#----------------------------------------------------------------------
 	global add_legend, output_file, title_str, verbose
 
-	if output_file != None:
+	if output_file is not None:
 		ofile = output_file
 	else:
 		ofile = '%s.png' % type
@@ -340,7 +340,7 @@ def generate_output(type, db):
 		if type = 'bnos':
 			ax.plot(dat['x'], dat['y'], color(idx, 'marker'),
 				markersize=1)
-		elif dat['ax'] = None:
+		elif dat['ax'] is None:
 			continue	# Don't add legend
 		else:
 			ax.plot(dat['ax'], dat['ay'], color(idx, 'line'),
-- 
2.20.1
