From: Jens Axboe <jens.axboe@oracle.com>
Date: Sat, 23 Feb 2008 05:00:02 +0000
Subject: Recent changes
Message-Id: <47bfa852.ezXHDHXMzt9Lyemc%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 8b10aae0cd4137f1cc9848181e4f45a9fa20de24:
  Alan D. Brunelle (1):
        Cleanups: Fixed IOPs in btt left over at end of run

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Bas Zoetekouw (4):
      Added man page for bno_plot and updated btt man page to refer to bno_plot
      Really commit the changes to btt.1
      Don't like btrecord against libaio and librt, as it doesn't use any of their symbols
      Fix section of btrecord and btreplay man pages

 btreplay/Makefile |    2 +-
 doc/bno_plot.1    |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/btrecord.8    |    2 +-
 doc/btreplay.8    |    2 +-
 doc/btt.1         |    8 +++++-
 5 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100644 doc/bno_plot.1
