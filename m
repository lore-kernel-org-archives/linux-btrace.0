From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 14 Feb 2008 05:00:01 +0000
Subject: Recent changes
Message-Id: <47b3cad1.KjCLdJCPFqsFZji8%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit ef14423994b40499402269896fc1aa5567bcdba9:
  Alan D. Brunelle (1):
        Added info about bno_plot.py and clean ups

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Aaron Carroll (2):
      btt: fix iostat interval default
      btt: fix missing cleanup call

Alan D. Brunelle (1):
      Cleanups: Fixed IOPs in btt left over at end of run

 btt/Makefile         |    3 +-
 btt/args.c           |    1 -
 btt/bno_dump.c       |    2 +-
 btt/bt_timeline.c    |   44 ++-------------------
 btt/devs.c           |   56 +--------------------------
 btt/dip_rb.c         |    7 +--
 btt/globals.h        |   45 ++-------------------
 btt/inlines.h        |  104 +++++++-------------------------------------------
 btt/iostat.c         |    4 +-
 btt/misc.c           |    4 +-
 btt/mmap.c           |    8 +---
 btt/output.c         |    2 -
 btt/proc.c           |   11 ++---
 btt/seek.c           |    8 ++--
 btt/trace.c          |   13 +-----
 btt/trace_complete.c |    8 ++--
 btt/trace_issue.c    |    8 +--
 btt/trace_queue.c    |    2 +-
 btt/unplug_hist.c    |    3 -
 19 files changed, 54 insertions(+), 279 deletions(-)
