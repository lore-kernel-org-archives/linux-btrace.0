From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 06 Feb 2008 05:00:05 +0000
Subject: Recent changes
Message-Id: <47a93ed5.0vBUSi43ed00aRaW%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 00a47cd169f2cc87b5f63fe93226b7231dee678c:
  Alan D. Brunelle (1):
        UNPLUG does the timing stuff, UNPLUG TIMEOUT only does timeout

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (1):
      Added new IOs per unplug table

 btt/bt_timeline.c |    2 +-
 btt/devs.c        |   10 +++-
 btt/doc/btt.tex   |  101 ++++++++++++++++++++++++++++++----------------
 btt/globals.h     |    8 ++-
 btt/output.c      |  115 ++++++++++++++++++++++++++++++++++++++---------------
 btt/trace_plug.c  |   10 ++++-
 6 files changed, 170 insertions(+), 76 deletions(-)
