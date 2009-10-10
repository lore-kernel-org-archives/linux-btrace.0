From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 10 Oct 2009 04:00:04 +0000
Subject: Recent changes
Message-Id: <20091010040004.0DC0F37A0B7@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit a155ab989ffc8b9cf95a631309e9a825d04bcc68:
  Alan D. Brunelle (1):
        btt: better data file naming

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      btt: Added in I/O activity per device and system-wide

 btt/Makefile         |    2 +-
 btt/args.c           |   12 +-
 btt/bt_timeline.c    |    5 +-
 btt/btt_plot.py      |  102 +-
 btt/devs.c           |    2 +
 btt/doc/Makefile     |    2 +-
 btt/doc/btt.tex      |   73 +-
 btt/doc/live.eps     |65949 ++++++++++++++++++++++++++++++++++++++++++++++++++
 btt/globals.h        |   16 +-
 btt/output.c         |   34 +
 btt/p_live.c         |  202 +
 btt/trace_complete.c |    1 +
 doc/btt.1            |   10 +
 13 files changed, 66380 insertions(+), 30 deletions(-)
 create mode 100644 btt/doc/live.eps
 create mode 100644 btt/p_live.c
