From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 31 Oct 2008 05:00:02 +0000
Subject: Recent changes
Message-Id: <490a90d2.I8K0R5SfDFduibp/%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 53cab5f58afd61525674ba7d6de8ac111f173a90:
  Martin Peschke (1):
        blkiomon: add through-put statistics

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Jens Axboe (2):
      Update rbtree to version with unified parent + color
      Set release version 1.0.0

 blkparse.c |    2 +-
 blktrace.c |    2 +-
 rbtree.c   |  195 ++++++++++++++++++++++++++++++-----------------------------
 rbtree.h   |   22 ++++++-
 4 files changed, 119 insertions(+), 102 deletions(-)
