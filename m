From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 02 Oct 2007 04:00:02 +0000
Subject: Recent changes
Message-Id: <4701c242.U1MsLWi85fds3urI%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 4c48f14ea8ae2fae86811ac4dc1d72ad9bb601c2:
  Alan D. Brunelle (1):
        Major revamping (ver 2.0)

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Bas Zoetekouw (2):
      Fix compilation on m68k
      btt manpages

 barrier.h |    2 +-
 doc/btt.1 |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 141 insertions(+), 24 deletions(-)
