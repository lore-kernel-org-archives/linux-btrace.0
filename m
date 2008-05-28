From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 28 May 2008 04:00:04 +0000
Subject: Recent changes
Message-Id: <483cd8c4./BMQ0SS/xEZmPjxm%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 5bebfd168c3f3f42acfd4a0263e9f4d1f5faea16:
  Alan D. Brunelle (1):
        Handled no difference in seek times

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (3):
      Added in handling of MESSAGE notes
      Added in new message updates to the documentation.
      Put message notes from kernel into a separate file for easy tracking

 blkparse.c        |   24 +++++++++++++++++++++---
 blkparse_fmt.c    |    6 +++++-
 blktrace_api.h    |    2 ++
 btt/args.c        |   11 ++++++++++-
 btt/bt_timeline.c |    4 +++-
 btt/globals.h     |    3 ++-
 btt/iostat.c      |    2 +-
 btt/misc.c        |   16 ++++++++++++++++
 btt/output.c      |   52 ++++++++++++++++------------------------------------
 btt/trace.c       |   19 +++++++++++++++++++
 doc/blktrace.tex  |   13 ++++++++++++-
 11 files changed, 107 insertions(+), 45 deletions(-)
