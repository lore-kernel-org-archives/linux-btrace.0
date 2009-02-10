From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 10 Feb 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <499109d2.xyuXC20kkyi4i92/%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 99bb5ebc255618e4af913d2e5f1bf268af552bdf:
  Alan D. Brunelle (1):
        Fix btt to handle large numbers of output files

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Rewrote blktrace to have a single thread per CPU

 blktrace.c | 3230 ++++++++++++++++++++++++++++++++++--------------------------
 btt/list.h |   23 +
 2 files changed, 1878 insertions(+), 1375 deletions(-)
