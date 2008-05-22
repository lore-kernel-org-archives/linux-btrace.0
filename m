From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 22 May 2008 04:00:04 +0000
Subject: Recent changes
Message-Id: <4834efc4.5BQGJNfG+DcYEeWM%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit ebe2d1aa7f334fc526a97f8acf62f1fe7dac9a8a:
  Jens Axboe (1):
        blkparse: cope with missing process notify event

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      Added in -m option, seeks-per-second
      Handled no difference in seek times

 btt/args.c        |   17 +-
 btt/bt_timeline.c |    5 +-
 btt/doc/btt.tex   |   54 +-
 btt/doc/sps.eps   | 5377 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btt/globals.h     |    2 +-
 btt/seek.c        |   70 +-
 6 files changed, 5517 insertions(+), 8 deletions(-)
 create mode 100644 btt/doc/sps.eps
