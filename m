From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 11 Nov 2008 05:00:02 +0000
Subject: Recent changes
Message-Id: <49191152.T+ls3U6vv3VxMXMj%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 07b96824e26286321b99c30526d8d67aca16e584:
  Jens Axboe (1):
        Set release version 1.0.0

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (3):
      Moved btrecord/btreplay to version 1.0.0
      Merge branch 'master' of ssh://alanbrunelle@git.kernel.dk/data/git/blktrace
      Added in -z to provide running waiting-for-issue latencies

 btreplay/btrecord.h |    8 ++++----
 btt/args.c          |   12 +++++++++++-
 btt/bt_timeline.c   |    4 ++--
 btt/devs.c          |    3 +++
 btt/doc/btt.tex     |   23 +++++++++++++++--------
 btt/globals.h       |    8 +++++---
 btt/latency.c       |    7 +++++++
 btt/trace_issue.c   |    2 ++
 doc/btt.1           |   15 +++++++++++++--
 9 files changed, 62 insertions(+), 20 deletions(-)
