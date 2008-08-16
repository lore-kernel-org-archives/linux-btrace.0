From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 16 Aug 2008 04:00:02 +0000
Subject: Recent changes
Message-Id: <48a650c2.GQJhi1wrema4WTcm%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit ea86559e392fc012f9b30eb109d3421d463c8848:
  Jeff Moyer (1):
        spelling and grammar fixes for btreplay.tex

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

David Woodhouse (2):
      blktrace: support discard requests
      Add documentation of 'D' discard operation

 act_mask.c       |    1 +
 blkparse_fmt.c   |    5 ++++-
 blkrawverify.c   |    1 +
 blktrace_api.h   |    1 +
 doc/blkparse.1   |    6 +++---
 doc/blktrace.tex |    4 ++--
 6 files changed, 12 insertions(+), 6 deletions(-)
