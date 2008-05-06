From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 06 May 2008 04:00:03 +0000
Subject: Recent changes
Message-Id: <481fd7c3.BeQR09PRo9+YBBqY%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 801646d63fe28ae2c50ab5bd0e9ea4f75ff64d97:
  Christof Schmitt (1):
        blkparse: Introduce optional accounting of PC requests

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Luis Useche (3):
      eliminate check of empty -F format
      Fix problem with -w option
      Add -x accellerator option

 blkparse.c                |   10 ++++++----
 blkparse_fmt.c            |    4 ----
 btreplay/btreplay.c       |   27 ++++++++++++++++++++++++---
 btreplay/doc/btreplay.tex |   13 ++++++++++++-
 4 files changed, 42 insertions(+), 12 deletions(-)
