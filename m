From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 17 Oct 2008 04:00:02 +0000
Subject: Recent changes
Message-Id: <48f80dc2.fRPVKRmp739/4FZH%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit abf63eafd11e42e0f065e56fc4773e6854087d41:
  Alan D. Brunelle (1):
        Removed excessive amounts of seek modes (for random sets of I/Os)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      Added in -Q / --active-queue-depth option
      Added in -L option - output periodic latency information

Jens Axboe (1):
      blktrace: accept -v (lower case) for version info as well

Martin Peschke (1):
      blkiomon: I/O monitor

Stefan Raspl (1):
      Add driver data support

 Makefile             |    5 +-
 act_mask.c           |    1 +
 blkiomon.c           |  708 ++++++++++++++++++++++++++++++++++++++++++++++++++
 blkiomon.h           |  105 ++++++++
 blkparse.c           |    3 +
 blktrace.c           |    9 +-
 blktrace_api.h       |    3 +
 btt/Makefile         |    3 +-
 btt/aqd.c            |   83 ++++++
 btt/args.c           |   22 ++-
 btt/bt_timeline.c    |    4 +-
 btt/devs.c           |    8 +
 btt/doc/btt.tex      |   18 ++-
 btt/globals.h        |   19 ++-
 btt/latency.c        |    2 +
 btt/plat.c           |  102 ++++++++
 btt/trace_complete.c |    1 +
 btt/trace_issue.c    |    1 +
 doc/blkiomon.8       |  116 ++++++++
 doc/btt.1            |   23 ++-
 stats.h              |  155 +++++++++++
 21 files changed, 1381 insertions(+), 10 deletions(-)
 create mode 100644 blkiomon.c
 create mode 100644 blkiomon.h
 create mode 100644 btt/aqd.c
 create mode 100644 btt/plat.c
 create mode 100644 doc/blkiomon.8
 create mode 100644 stats.h
