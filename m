From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 13 Feb 2008 16:52:16 +0000
Subject: [PATCH] Cleanups: Fixed IOPs in btt left over at end of run
Message-Id: <47B32040.70606@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

o  Using valgrind, determined we had Q IOPs left over that weren't
   used. Added "all" list, and then deleted these at end.

o  Removed old debug stuff (COUNT_IOS, DEBUG, ...)

o  Fixed a bunch of white space at end of lines.

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 btt/Makefile         |    3 +-
 btt/args.c           |    1 -
 btt/bno_dump.c       |    2 +-
 btt/bt_timeline.c    |   43 ++-------------------
 btt/devs.c           |   56 +--------------------------
 btt/dip_rb.c         |    7 +--
 btt/globals.h        |   44 ++-------------------
 btt/inlines.h        |  104 +++++++-------------------------------------------
 btt/iostat.c         |    2 +-
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
 19 files changed, 51 insertions(+), 278 deletions(-)
