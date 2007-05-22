From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 22 May 2007 04:00:01 +0000
Subject: Recent changes
Message-Id: <46526ac1.wGsCSY3LqyoWhMOn%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 00cd304410a4e750ef929823dca3b932baa797b0:
  Jens Axboe (1):
        Fix crash with '-' stdin input

are found in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git

Jens Axboe (2):
      Fix queued vs dispatch numbers
      Account size of merges

 blkparse.c |   11 ++++++-----
 blktrace.h |    1 +
 2 files changed, 7 insertions(+), 5 deletions(-)
