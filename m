From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 14 Nov 2007 05:00:02 +0000
Subject: Recent changes
Message-Id: <473a80d2.AHo4jGso+ivzCite%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 77f256cda4b2f076f5169fdf1bc815f629eea361:
  Alan D. Brunelle (1):
        Fixed REMAP to update Q2A & fixed #Q calculations

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (1):
      Added active requests at Q information.

 btt/doc/btt.tex   |   32 +++++++++++++++++++++++++++++---
 btt/globals.h     |    1 +
 btt/output.c      |   42 ++++++++++++++++++++++++++++++++++++++++++
 btt/trace_issue.c |    3 +++
 btt/trace_queue.c |    3 +++
 5 files changed, 78 insertions(+), 3 deletions(-)
