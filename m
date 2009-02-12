From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 12 Feb 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <4993acd2.twOI1uqXj975EzXA%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 3fe0b570b01622e329b9c999ebf867b1f1cb2e20:
  Alan D. Brunelle (1):
        Rewrote blktrace to have a single thread per CPU

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (5):
      Added accept as a system call needing resource increases
      Invoke gethostbyname once, handle errors better
      Synchronized trace gathering
      btt: fixed open in setup_ifile
      Moved starting of tracing after tracers are going

 blktrace.c    |  119 ++++++++++++++++++++++++++++++++++++++++++++++----------
 btt/globals.h |    1 +
 btt/misc.c    |   64 +++++++++++++++++++------------
 btt/mmap.c    |    3 +-
 4 files changed, 139 insertions(+), 48 deletions(-)
