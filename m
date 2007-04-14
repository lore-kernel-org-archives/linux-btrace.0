From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 14 Apr 2007 04:00:02 +0000
Subject: Recent changes
Message-Id: <462051c2.eDcZoh5ezCBa3UU2%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 425c69552d4fbf7705c74aef4761324ed641cb28:
  Bas Zoetekouw (1):
        Add store barrier defines for a bunch of archs

are found in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git

Alan D. Brunelle (1):
      A couple of weeks ago Ming Zhang had noted that btt was using tremendous

 btt/Makefile         |   12 +++++--
 btt/bt_timeline.c    |   41 ++++++++++++++++++---
 btt/devs.c           |   11 +++---
 btt/globals.h        |   27 +++++++++-----
 btt/inlines.h        |   94 +++++++++++++++++++++++++++++++++++---------------
 btt/trace.c          |   17 +++++----
 btt/trace_complete.c |   19 +++++-----
 btt/trace_im.c       |   43 ++++++++--------------
 btt/trace_issue.c    |   41 +++++++--------------
 btt/trace_queue.c    |    8 ++--
 btt/trace_remap.c    |   12 +++---
 btt/trace_requeue.c  |   18 +++++-----
 12 files changed, 200 insertions(+), 143 deletions(-)
