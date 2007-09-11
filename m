From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 11 Sep 2007 04:00:02 +0000
Subject: Recent changes
Message-Id: <46e612c2.SP9gIr+iUZvnqkpS%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit a5981e2e795319502cc8dda629482928f3b7b204:
  Jens Axboe (1):
        blktrace 0.99.3

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (1):
      Major revamping (ver 2.0)

 btt/bt_timeline.c             |    7 +-
 btt/devs.c                    |   26 ++-
 btt/doc/btt.tex               |  323 +++++++----------------------------------
 btt/doc/sample-btt-output.tex |  138 ++++++++++++++++++
 btt/globals.h                 |   41 ++---
 btt/inlines.h                 |  187 ++++--------------------
 btt/iostat.c                  |    6 +-
 btt/output.c                  |  111 ++++++++------
 btt/proc.c                    |   72 +++++++---
 btt/seek.c                    |   18 +--
 btt/trace.c                   |   86 ++---------
 btt/trace_complete.c          |  192 ++++++------------------
 btt/trace_im.c                |   95 ++++---------
 btt/trace_issue.c             |   85 ++++--------
 btt/trace_queue.c             |   62 ++------
 btt/trace_remap.c             |   88 +----------
 btt/trace_requeue.c           |   21 +---
 17 files changed, 523 insertions(+), 1035 deletions(-)
 create mode 100644 btt/doc/sample-btt-output.tex
