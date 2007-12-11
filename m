From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 11 Dec 2007 05:00:03 +0000
Subject: Recent changes
Message-Id: <475e1953.9bH+9OY3g+Vad6Su%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit a84a97fdf8ce07ccda8dcc4f32f0df2291f2f54f:
  Bas Zoetekouw (1):
        btreplay/btrecord man pages

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (1):
      Separated out g/i/m trace handling.

 btt/bt_timeline.c    |    2 +-
 btt/doc/btt.tex      |   46 +++++++++--
 btt/globals.h        |   19 +++--
 btt/inlines.h        |   82 ++++++++++++++++----
 btt/iostat.c         |   17 ++---
 btt/output.c         |  209 +++++++++++++++++++++++++++----------------------
 btt/proc.c           |    7 ++-
 btt/trace_complete.c |   22 ++++--
 btt/trace_im.c       |   52 +++++++-----
 btt/trace_issue.c    |    6 +-
 btt/trace_queue.c    |   11 ++-
 11 files changed, 305 insertions(+), 168 deletions(-)
