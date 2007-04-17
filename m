From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 17 Apr 2007 04:00:01 +0000
Subject: Recent changes
Message-Id: <46244641.P+OSUh0Z0qEbmPqX%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 6904079488cd3063d171021c8954f955f4236849:
  Alan D. Brunelle (1):
        Combine all outstanding patches into one /big patch/

are found in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git

Alan D. Brunelle (2):
      Cleaned out the btt/README file.
      Add in unplug IO count histogram

 btt/Makefile      |    2 +-
 btt/README        |   75 ++------------------------------------------
 btt/args.c        |   12 ++++++-
 btt/bt_timeline.c |    2 +-
 btt/devs.c        |    2 +
 btt/doc/btt.tex   |   36 +++++++++++++++++++--
 btt/globals.h     |    9 ++++-
 btt/trace_plug.c  |    1 +
 btt/unplug_hist.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 149 insertions(+), 80 deletions(-)
 create mode 100644 btt/unplug_hist.c
