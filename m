From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 15 Aug 2009 04:00:02 +0000
Subject: Recent changes
Message-Id: <20090815040002.679D337A05A@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 1e09f6e9012826fca69fa07222b7bc53c3e629ee:
  Jens Axboe (1):
        Version 1.0.1

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      Added in running stats for btt
      Added in running stats documentation

 btt/Makefile         |    2 +-
 btt/bt_timeline.c    |    6 +-
 btt/devs.c           |    2 +
 btt/doc/Makefile     |    2 +-
 btt/doc/btt.tex      |   49 ++-
 btt/doc/rstats.eps   | 1267 ++++++++++++++++++++++++++++++++++++++++++++++++++
 btt/globals.h        |   11 +-
 btt/rstats.c         |  136 ++++++
 btt/trace.c          |    2 +
 btt/trace_complete.c |    4 +-
 10 files changed, 1473 insertions(+), 8 deletions(-)
 create mode 100644 btt/doc/rstats.eps
 create mode 100644 btt/rstats.c
