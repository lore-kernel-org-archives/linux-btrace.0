From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 13 Feb 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <4994fe52.u2m3yyrczqekF2yn%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 3b552a2d1ff8ecccbbb82668f73d1cb134fca1e9:
  Alan D. Brunelle (1):
        Moved starting of tracing after tracers are going

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (4):
      Cleaned up devs that have no data
      Reworked blktrace master/thread interface
      Code review updates
      btt: Missed fopen conversion to my_fopen

 blktrace.c        |  738 ++++++++++++++++++++++++++++-------------------------
 btt/bt_timeline.c |    2 +
 btt/devs.c        |   52 +++--
 btt/globals.h     |    1 +
 btt/unplug_hist.c |    2 +-
 5 files changed, 433 insertions(+), 362 deletions(-)
