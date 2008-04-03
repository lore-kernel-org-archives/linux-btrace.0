From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 03 Apr 2008 04:00:01 +0000
Subject: Recent changes
Message-Id: <47f45641.fmXIuwKgcq40xE7P%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 967492e81cd045b058fc93dacc15924bebd00b9b:
  Bas Zoetekouw (1):
        Fix section of btrecord and btreplay man pages

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Christof Schmitt (2):
      blkparse: Add PC requests to depth trace
      blkparse: Introduce optional accounting of PC requests

 blkparse.c |  138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 blktrace.h |    3 +
 2 files changed, 139 insertions(+), 2 deletions(-)
