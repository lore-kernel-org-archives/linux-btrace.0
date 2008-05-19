From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 19 May 2008 04:00:02 +0000
Subject: Recent changes
Message-Id: <4830fb42.fbcxZ9LAyIX26JXd%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit dd14158dca460522c22afbd7e22343e4012fffe0:
  Alan D. Brunelle (1):
        Fixed percentage calculations for phases of an I/O

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Jens Axboe (1):
      blkparse: cope with missing process notify event

 blkparse.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)
