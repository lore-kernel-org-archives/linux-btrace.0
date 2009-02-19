From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 19 Feb 2009 05:00:01 +0000
Subject: Recent changes
Message-Id: <499ce751.BR2lhwR+tJlTCQYe%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 5d65b5e6333cfdd14ab0e944cef8474445e531b3:
  Alan D. Brunelle (1):
        Fixed EAGAIN handling in blktrace.c

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Jens Axboe (2):
      Update Jenkins hash to lookup3() variant
      Merge branch 'master' of ssh://axboe@router.home.kernel.dk/data/git/blktrace

 jhash.h |  154 ++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 84 insertions(+), 70 deletions(-)
