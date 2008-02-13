From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 13 Feb 2008 05:00:02 +0000
Subject: Recent changes
Message-Id: <47b27952.MSZ4m/7bTC6JnSFG%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit feb161907bf39fab6bedacf066fe7de6639cea93:
  Alan D. Brunelle (1):
        Merge branch 'bno_plot.submit'

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (1):
      Added info about bno_plot.py and clean ups

 btt/bno_plot.py               |    4 +-
 btt/doc/Makefile              |    2 +-
 btt/doc/bno_plot.eps          | 7696 +++++++++++++++++++++++++++++++++++++++++
 btt/doc/btt.tex               |   70 +-
 btt/doc/sample-btt-output.tex |  177 +-
 5 files changed, 7828 insertions(+), 121 deletions(-)
 create mode 100644 btt/doc/bno_plot.eps
