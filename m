From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 01 Feb 2008 05:00:02 +0000
Subject: Recent changes
Message-Id: <47a2a752.WPjaXw1Bg3DaxLcz%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 461afe819c41fa811f9c6264524cb8edbd2acc63:
  Dave Boutcher (1):
        Fix Q counts during requeue and merges.

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (2):
      Fixed excess bucket information for unplug histograms.
      UNPLUG does the timing stuff, UNPLUG TIMEOUT only does timeout

 btt/devs.c        |   18 ++++++++++++------
 btt/globals.h     |    3 ++-
 btt/output.c      |    2 +-
 btt/trace_plug.c  |   14 +++++---------
 btt/unplug_hist.c |    4 ++--
 5 files changed, 22 insertions(+), 19 deletions(-)
