From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 08 Dec 2007 05:00:02 +0000
Subject: Recent changes
Message-Id: <475a24d2.rcM6YowSgE1b35/C%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 99a55a0392b1634ce81e594f48a1105e8ebc1d58:
  Joshua Root (1):
        Remove strange make dependency

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (2):
      Added in Q2D histograms (requires -A)
      Merge branch 'master' into add-q2d

 btt/Makefile      |    2 +-
 btt/devs.c        |    4 ++
 btt/doc/btt.tex   |   21 +++++++++
 btt/globals.h     |   11 +++++
 btt/output.c      |   48 +++++++++++++++++++++
 btt/q2d.c         |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btt/trace_issue.c |    4 ++
 7 files changed, 210 insertions(+), 1 deletions(-)
 create mode 100644 btt/q2d.c
