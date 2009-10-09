From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 09 Oct 2009 04:00:02 +0000
Subject: Recent changes
Message-Id: <20091009040002.51DB137A0B3@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 677ef89ccb24fb3e38b13b02b9394318afb78f30:
  Jens Axboe (1):
        Merge branch 'master' of ssh://router.home.kernel.dk/data/git/blktrace

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      btt: better data file naming

 btt/aqd.c         |    6 ++--
 btt/bno_dump.c    |   18 ++++++---------
 btt/devs.c        |   63 +++++++++++++++++++++++-----------------------------
 btt/globals.h     |   15 ++++++------
 btt/latency.c     |   18 ++++++--------
 btt/misc.c        |    5 ++++
 btt/plat.c        |    6 ++--
 btt/rstats.c      |   14 ++++++-----
 btt/seek.c        |    8 ++++--
 btt/unplug_hist.c |   15 ++++++------
 10 files changed, 83 insertions(+), 85 deletions(-)
