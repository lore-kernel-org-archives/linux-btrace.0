From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 22 Apr 2009 04:00:02 +0000
Subject: Recent changes
Message-Id: <20090422040002.45F9837A133@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 60886290e2ba6ddae1213f3a13929193180c8c55:
  Jeff Moyer (1):
        handle race to mkdir at startup

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Martin Peschke (2):
      fix include statement in stats.h
      fix off-by-one issues in blkiomon.h

 stats.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
