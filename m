From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 11 Oct 2008 04:00:02 +0000
Subject: Recent changes
Message-Id: <48f024c2.PCx+jLLTiAFu7+qo%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 4133e838c72f5f66e0c5b57af1aa24bf10a23b07:
  Nathan Scott (1):
        spec file tweak

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (3):
      Added in %done for btt
      Merge branch 'master' of ssh://alanbrunelle@git.kernel.dk/data/git/blktrace
      Removed excessive amounts of seek modes (for random sets of I/Os)

 btt/globals.h |    1 +
 btt/mmap.c    |    5 +++++
 btt/output.c  |   18 +++++++++++++-----
 btt/trace.c   |    2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)
