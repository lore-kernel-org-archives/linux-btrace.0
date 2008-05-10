From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 10 May 2008 04:00:03 +0000
Subject: Recent changes
Message-Id: <48251dc3.g7cnRyiHICOSWlF1%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit f028c9584055737f429979e18ab7436583ed41b5:
  Alan D. Brunelle (1):
        Added -X option - generate easily parseable file

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Added S2G times + fixed up -X output to include X2X

 btt/bt_timeline.c    |    2 +-
 btt/doc/btt.tex      |   38 ++++++++++++++++++++++++++++++--------
 btt/globals.h        |    8 ++++++--
 btt/inlines.h        |    5 +++++
 btt/output.c         |   42 +++++++++++++++++++++++++++---------------
 btt/trace.c          |    1 +
 btt/trace_complete.c |    3 +++
 btt/trace_im.c       |   36 +++++++++++++++++++++++++++++++-----
 btt/trace_issue.c    |    4 ++++
 btt/trace_queue.c    |    3 +++
 10 files changed, 111 insertions(+), 31 deletions(-)
