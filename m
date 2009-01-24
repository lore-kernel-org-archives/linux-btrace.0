From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 24 Jan 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <497aa052.qnaxGTZlTJ4MHO6p%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 61165962f86cb2de0b163f6083bff5649f692e91:
  Martin Peschke (1):
        A couple of min-counters weren't initialised correctly (thrput_r,

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      Increased limits to allow for large system runs
      Fix btt to handle large numbers of output files

 blktrace.c     |   65 +++++++++++++++++++++++++++++++++++++++++++++++++------
 btt/aqd.c      |    2 +-
 btt/args.c     |   10 ++++----
 btt/bno_dump.c |    2 +-
 btt/devmap.c   |    2 +-
 btt/devs.c     |    2 +-
 btt/globals.h  |    1 +
 btt/latency.c  |    2 +-
 btt/misc.c     |   46 ++++++++++++++++++++++++++++++++++++++-
 btt/output.c   |    4 +-
 btt/plat.c     |    2 +-
 btt/seek.c     |    4 +-
 12 files changed, 119 insertions(+), 23 deletions(-)
