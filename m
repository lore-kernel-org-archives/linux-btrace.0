From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 25 Jul 2007 04:00:04 +0000
Subject: Recent changes
Message-Id: <46a6cac4.muVddcwRpxUtNWOC%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit e0ede9d3eec5d558abf98d94fa9b6098dc5ee013:
  Jens Axboe (1):
        git:// url location update

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Jens Axboe (1):
      Add man pages

 Makefile              |    3 +
 doc/blkparse.1        |  565 +++++++++++++++++++++++++++++++++++++++++++++++++
 doc/blkrawverify.1    |   47 ++++
 doc/blktrace.8        |  255 ++++++++++++++++++++++
 doc/btrace.8          |   84 ++++++++
 doc/btt.1             |  192 +++++++++++++++++
 doc/verify_blkparse.1 |   44 ++++
 7 files changed, 1190 insertions(+), 0 deletions(-)
 create mode 100644 doc/blkparse.1
 create mode 100644 doc/blkrawverify.1
 create mode 100644 doc/blktrace.8
 create mode 100644 doc/btrace.8
 create mode 100644 doc/btt.1
 create mode 100644 doc/verify_blkparse.1
