From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 14 Feb 2009 05:00:03 +0000
Subject: Recent changes
Message-Id: <49964fd3.DHAX/Rlz6CigrUHZ%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 8f34184f8c7905bb929862d224a7c4969bc9190e:
  Alan D. Brunelle (1):
        btt: Missed fopen conversion to my_fopen

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      btt general cleanup plus valgrind clean
      btt: Added no remap option

 btt/aqd.c         |   13 +----
 btt/args.c        |  111 ++++++++++++++++++++--------------------------
 btt/bno_dump.c    |   36 +++++----------
 btt/bt_timeline.c |   28 ++++--------
 btt/devmap.c      |   60 +++++++++++++++----------
 btt/devs.c        |   50 ++++++++++-----------
 btt/doc/btt.tex   |    7 +++-
 btt/globals.h     |   63 ++++++++++-----------------
 btt/inlines.h     |    7 +--
 btt/iostat.c      |   61 ++++++++++---------------
 btt/latency.c     |   33 +++++--------
 btt/misc.c        |  126 +++++++++++++++++++++++++----------------------------
 btt/mmap.c        |   12 +++--
 btt/output.c      |    4 +-
 btt/plat.c        |   19 ++------
 btt/proc.c        |   31 +++++++------
 btt/q2d.c         |    4 +-
 btt/seek.c        |  109 +++++++++++++++++++++-------------------------
 btt/trace.c       |   15 +++----
 btt/trace_plug.c  |    2 +-
 btt/trace_remap.c |    6 ++-
 btt/unplug_hist.c |   11 ++---
 doc/btt.1         |   10 ++++
 23 files changed, 375 insertions(+), 443 deletions(-)
