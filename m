From: Jens Axboe <jens.axboe@oracle.com>
Date: Sun, 15 Apr 2007 04:00:02 +0000
Subject: Recent changes
Message-Id: <4621a342.oyvdYJu/WU3kiZ/a%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit c8b0b334cc1028ad8aa5407667233747af96a942:
  Alan D. Brunelle (1):
        A couple of weeks ago Ming Zhang had noted that btt was using tremendous

are found in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git

Alan D. Brunelle (1):
      Combine all outstanding patches into one /big patch/

 btt/Makefile      |   31 ++++++++--------
 btt/args.c        |   75 +++++++++++++++++++++++++++++----------
 btt/bno_dump.c    |   92 ++++++++++++++++++++++++++++++++++++++++++++++++
 btt/bt_timeline.c |   53 ++++++++++++++++++----------
 btt/devmap.c      |   10 +++++
 btt/devs.c        |   46 ++++++++++++++++++++++++-
 btt/doc/btt.tex   |   48 ++++++++++++++++++++++++-
 btt/globals.h     |   29 +++++++++++----
 btt/inlines.h     |  100 ++++++++++++++++++++++++++++++++++++-----------------
 btt/misc.c        |   35 +++++++++++++++---
 btt/output.c      |   13 +++----
 btt/proc.c        |   32 ++++++++++++++---
 btt/seek.c        |   50 ++++++++++++++++++++++-----
 btt/trace_issue.c |    1 +
 14 files changed, 492 insertions(+), 123 deletions(-)
 create mode 100644 btt/bno_dump.c
