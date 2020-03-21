From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 21 Mar 2020 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20200321120002.367881BC0175@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit f4f8ef7cdea138cfaa2f3ca0ee31fa23d3bcf1cc:

  fix parallel build of btt and blkiomon (2020-01-16 13:33:59 -0700)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to db4f6340e04716285ea56fe26d76381c3adabe58:

  btt_plot.py: Use `with open() as ...` context manager (2020-03-20 15:53:50 -0600)

----------------------------------------------------------------
Vincent Legoll (10):
      btt_plot.py: Use sum() instead of open-coding it to compute list average
      bno_plot.py: Use shutil.rmtree() instead of os.system('/bin/rm')
      bno_plot.py: Use `with open() as ...` context manager to automatically handle close()
      btt_plot.py: Fix pylint: wrong-import-order
      btt_plot.py: Fix pylint: len-as-condition
      btt_plot.py: Fix pylint: singleton-comparison
      btt_plot.py: Fix pylint: no-else-return
      bno_plot.py: Fix pylint: len-as-condition
      bno_plot.py: Fix pylint: singleton-comparison
      btt_plot.py: Use `with open() as ...` context manager

 btt/bno_plot.py | 27 +++++++++++++-------------
 btt/btt_plot.py | 60 ++++++++++++++++++++++++++++-----------------------------
 2 files changed, 42 insertions(+), 45 deletions(-)

---

Diff of recent changes:

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index f05cfdc..3aa4e19 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -40,7 +40,7 @@ To exit the plotter, enter 'quit' or ^D at the 'gnuplot> ' prompt.
 
 from __future__ import absolute_import
 from __future__ import print_function
-import getopt, glob, os, sys, tempfile
+import getopt, glob, os, sys, tempfile, shutil
 
 verbose	= 0
 cmds	= """
@@ -76,7 +76,7 @@ def parse_args(in_args):
 		elif o in ('-K', '--keys-below'):
 			keys_below = True
 
-	if len(args) > 0:	bnos = args
+	if args:	bnos = args
 	else:			bnos = glob.glob('blknos*[rw].dat')
 
 	return (bnos, keys_below)
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
-		if plot_cmd = None: plot_cmd = "splot '%s'" % t
+		if plot_cmd is None: plot_cmd = "splot '%s'" % t
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
@@ -125,4 +124,4 @@ if __name__ = '__main__':
 		sys.exit(1)
 
 	os.waitpid(pid, 0)
-	os.system('/bin/rm -rf ' + tmpdir)
+	shutil.rmtree(tmpdir)
diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index 76fcca8..40bc71f 100755
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
@@ -113,8 +113,8 @@ def get_data(files):
 		"""Returns new min, max, and float value for those passed in"""
 
 		v = float(v)
-		if mn = None or v < mn: mn = v
-		if mx = None or v > mx: mx = v
+		if mn is None or v < mn: mn = v
+		if mx is None or v > mx: mx = v
 		return mn, mx, v
 
 	#--------------------------------------------------------------
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
@@ -171,14 +168,15 @@ def get_data(files):
 
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
@@ -238,7 +236,7 @@ def parse_args(args):
 		elif o in ('-v', '--verbose'):
 			verbose = True
 
-	if type = None and not generate_all:
+	if type is None and not generate_all:
 		fatal('Need type of data files to process - (-t <type>)')
 
 	return args
@@ -247,7 +245,7 @@ def parse_args(args):
 def gen_title(fig, type, title_str):
 	"""Sets the title for the figure based upon the type /or/ user title"""
 
-	if title_str != None:
+	if title_str is not None:
 		pass
 	elif type = 'aqd':
 		title_str = 'Average Queue Depth'
@@ -312,7 +310,7 @@ def generate_output(type, db):
 	#----------------------------------------------------------------------
 	global add_legend, output_file, title_str, verbose
 
-	if output_file != None:
+	if output_file is not None:
 		ofile = output_file
 	else:
 		ofile = '%s.png' % type
@@ -343,7 +341,7 @@ def generate_output(type, db):
 		if type = 'bnos':
 			ax.plot(dat['x'], dat['y'], color(idx, 'marker'),
 				markersize=1)
-		elif dat['ax'] = None:
+		elif dat['ax'] is None:
 			continue	# Don't add legend
 		else:
 			ax.plot(dat['ax'], dat['ay'], color(idx, 'line'),
@@ -352,7 +350,7 @@ def generate_output(type, db):
 			legends.append(get_base(file))
 		idx += 1
 
-	if add_legend and len(legends) > 0:
+	if add_legend and legends:
 		gen_legends(ax, legends)
 	plt.savefig(ofile)
 
@@ -388,23 +386,23 @@ def do_live(files):
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
@@ -453,7 +451,7 @@ if __name__ = '__main__':
 		output_file = title_str = type = None
 		for t in types:
 			files = get_files(t)
-			if len(files) = 0:
+			if files = 0:
 				continue
 			elif t = 'bnos':
 				do_bnos(files)
@@ -463,7 +461,7 @@ if __name__ = '__main__':
 				generate_output(t, get_data(files))
 				continue
 
-	elif len(files) < 1:
+	elif not files:
 		fatal('Need data files to process')
 	else:
 		generate_output(type, get_data(files))
