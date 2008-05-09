From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 09 May 2008 04:00:02 +0000
Subject: Recent changes
Message-Id: <4823cc42.gLMIXll8sQtc98Cb%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 4a7968cc672f39573abc6002f0afbed2a8e8139b:
  Luis Useche (1):
        Add -x accellerator option

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Added -X option - generate easily parseable file

 btt/args.c        |   36 ++++++++++++++++++++++++-----
 btt/bt_timeline.c |    5 ++-
 btt/doc/btt.tex   |   56 +++++++++++++++++++++++++++++++++++++++++++--
 btt/globals.h     |    3 +-
 btt/output.c      |   64 +++++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 148 insertions(+), 16 deletions(-)
