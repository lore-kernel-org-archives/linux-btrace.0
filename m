From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 12 Nov 2008 05:00:01 +0000
Subject: Recent changes
Message-Id: <491a62d1.2kzf6c9AZbBmwF14%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit e47ada103e028a691d296d09d0bc673a3af6a3dc:
  Alan D. Brunelle (1):
        Added in -z to provide running waiting-for-issue latencies

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (6):
      Fixed segfault in aqd.c : need to check for NULL (not requested)
      Fixed 'M' displays on per-io output and added in I/O separator
      Merge branch 'fix-m' into add-P
      Added -P to create a data file w/ Q, D and C per line
      Merge branch 'fix-m'
      Merge branch 'add-P'

 btt/aqd.c            |   22 +++++++++++++---------
 btt/args.c           |   12 +++++++++++-
 btt/bt_timeline.c    |    4 ++--
 btt/devs.c           |   15 +++++++++++++++
 btt/doc/btt.tex      |    9 ++++++++-
 btt/globals.h        |    3 ++-
 btt/trace_complete.c |   24 +++++++++++++++++++++++-
 doc/btt.1            |   11 +++++++++++
 8 files changed, 85 insertions(+), 15 deletions(-)
