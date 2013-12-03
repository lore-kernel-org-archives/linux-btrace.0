From: Eiichi Tsukata <devel@etsukata.com>
Date: Tue, 03 Dec 2013 12:04:59 +0000
Subject: [PATCH] blktrace bno_plot.py: output comprehensive message when gnuplot not found
Message-Id: <1386072299-10149-1-git-send-email-devel@etsukata.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Currently, bno_plot.py uses os.execvp which does not show enough information
when executed command is not found. For example, when gnuplot is not found
bno_plot.py shows the following messages:

    Traceback (most recent call last):
      File "/usr/local/bin/bno_plot.py", line 123, in <module>
        os.execvp(cmd[0], cmd)
      File "/usr/lib64/python2.7/os.py", line 344, in execvp
        _execvpe(file, args)
      File "/usr/lib64/python2.7/os.py", line 368, in _execvpe
        func(file, *argrest)
    OSError: [Errno 2] No such file or directory

Users can't understand what happend directly from the message.

Instead of os.execvp, this patch uses os.system which shows the following
messages when gnuplot not found:

    sh: gnuplot: command not found

Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 btt/bno_plot.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
-- 
1.8.3.1

