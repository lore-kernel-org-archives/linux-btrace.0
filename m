From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Fri, 20 Mar 2020 21:44:54 +0000
Subject: [PATCH 05/10] btt_plot.py: Fix pylint: len-as-condition
Message-Id: <20200320214459.7760-6-vincent.legoll@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Do not use `len(SEQUENCE)` to determine if a sequence is empty

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 btt/btt_plot.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/btt/btt_plot.py b/btt/btt_plot.py
index b135206..d6d27aa 100755
--- a/btt/btt_plot.py
+++ b/btt/btt_plot.py
@@ -349,7 +349,7 @@ def generate_output(type, db):
 			legends.append(get_base(file))
 		idx += 1
 
-	if add_legend and len(legends) > 0:
+	if add_legend and legends:
 		gen_legends(ax, legends)
 	plt.savefig(ofile)
 
@@ -450,7 +450,7 @@ if __name__ = '__main__':
 		output_file = title_str = type = None
 		for t in types:
 			files = get_files(t)
-			if len(files) = 0:
+			if files = 0:
 				continue
 			elif t = 'bnos':
 				do_bnos(files)
@@ -460,7 +460,7 @@ if __name__ = '__main__':
 				generate_output(t, get_data(files))
 				continue
 
-	elif len(files) < 1:
+	elif not files:
 		fatal('Need data files to process')
 	else:
 		generate_output(type, get_data(files))
-- 
2.20.1
