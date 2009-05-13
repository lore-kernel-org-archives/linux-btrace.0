From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 13 May 2009 04:00:02 +0000
Subject: Recent changes
Message-Id: <20090513040002.1D3F537A0FD@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit b5f8804a588fffdea10a0cd46a36fc196acea9f2:
  Martin Peschke (1):
        fix off-by-one issues in blkiomon.h

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Converted to using the correct remap entries

Eric Sandeen (5):
      fix max-pkts option inconsistencies
      more manpage fixups
      fix up btrace options & manpage
      blkiomon manpage and usage reference invalid "msg-queue-name" option
      blkrawverify: warn and return error if no traces are found

Jens Axboe (1):
      Version 1.0.1

Martin Peschke (1):
      blkiomon: fix unaligned accesses on ia64

 blkiomon.c          |    4 ++--
 blkiomon.h          |    4 ++--
 blkparse.c          |    2 +-
 blkparse_fmt.c      |   27 ++++++++++++++++-----------
 blkrawverify.c      |    8 +++++++-
 blktrace_api.h      |    4 ++--
 btrace              |    7 ++-----
 btreplay/btrecord.c |    2 +-
 btt/trace_remap.c   |    9 ++++-----
 doc/blkiomon.8      |    4 ++--
 doc/blkparse.1      |    9 +--------
 doc/blkrawverify.1  |    2 +-
 doc/bno_plot.1      |    2 +-
 doc/btrace.8        |   20 ++++++++++++--------
 doc/btrecord.8      |   12 ++++++------
 doc/btreplay.8      |   10 ++++------
 doc/btt.1           |    3 ++-
 17 files changed, 66 insertions(+), 63 deletions(-)
