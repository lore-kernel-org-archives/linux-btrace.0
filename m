From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 29 Oct 2008 05:00:02 +0000
Subject: Recent changes
Message-Id: <4907edd2.fCnkI6JoNmgLoDyW%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 3bc3451b471fe4cea365654481258a1a1913018e:
  Martin Peschke (1):
        blkiomon: drv_data traces pass-through

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Martin Peschke (6):
      blkiomon: fix cross-arch data analysis issue
      blkiomon: fix unit in histogram output
      blkiomon: fix trace debug output
      blkiomon: fix some debug messages
      blkiomon: separate statistics for read and write requests
      blkiomon: add through-put statistics

 blkiomon.c |   62 +++++++++++++++++++++++++++++++++++------------------------
 blkiomon.h |   56 ++++++++++++++++++++++++++++++++---------------------
 2 files changed, 71 insertions(+), 47 deletions(-)
