From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 03 Oct 2007 04:00:02 +0000
Subject: Recent changes
Message-Id: <470313c2.KtyKM9LJxdeF5Obf%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 9a8e0e1766abcf7fbc71b7a60cd6d0c85573bd52:
  Bas Zoetekouw (1):
        btt manpages

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (2):
      Added list_splice to btt/list.h
      Add btrecord/btreplay capability

 Makefile                  |   11 +-
 btreplay/Makefile         |   45 ++
 btreplay/btrecord.c       |  780 ++++++++++++++++++++++
 btreplay/btrecord.h       |   95 +++
 btreplay/btreplay.c       | 1590 +++++++++++++++++++++++++++++++++++++++++++++
 btreplay/doc/Makefile     |   18 +
 btreplay/doc/abstract.tex |   34 +
 btreplay/doc/btreplay.tex |  521 +++++++++++++++
 btt/list.h                |   47 ++
 9 files changed, 3140 insertions(+), 1 deletions(-)
 create mode 100644 btreplay/Makefile
 create mode 100644 btreplay/btrecord.c
 create mode 100644 btreplay/btrecord.h
 create mode 100644 btreplay/btreplay.c
 create mode 100644 btreplay/doc/Makefile
 create mode 100644 btreplay/doc/abstract.tex
 create mode 100644 btreplay/doc/btreplay.tex
