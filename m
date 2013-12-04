From: Jens Axboe <jaxboe@fusionio.com>
Date: Wed, 04 Dec 2013 04:56:52 +0000
Subject: Recent changes (master)
Message-Id: <20131204050001.E421622D57@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 0a915aabe88ff98786a88f30d2e062ef34d0826c:

  blktrace blkreplay: convert to use a dynamic cpu_set_t (2013-08-01 12:13:26 -0600)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Eiichi Tsukata (1):
      blktrace bno_plot.py: output comprehensive message when gnuplot not found

 btt/bno_plot.py |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

---

Diff of recent changes:

diff --git a/btt/bno_plot.py b/btt/bno_plot.py
index 19dfdfd..aa92480 100644
--- a/btt/bno_plot.py
+++ b/btt/bno_plot.py
@@ -114,13 +114,12 @@ if __name__ = '__main__':
 
 	pid = os.fork()
 	if pid = 0:
-		cmd = '/usr/bin/gnuplot %s/plot.cmds -' % tmpdir
+		cmd = 'gnuplot %s/plot.cmds -' % tmpdir
 
 		if verbose: print 'Executing %s' % cmd
 
-		cmd = cmd.split(None)
 		os.chdir(tmpdir)
-		os.execvp(cmd[0], cmd)
+		os.system(cmd)
 		sys.exit(1)
 
 	os.waitpid(pid, 0)
