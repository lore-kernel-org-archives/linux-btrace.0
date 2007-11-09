From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 09 Nov 2007 05:00:03 +0000
Subject: Recent changes
Message-Id: <4733e953.gcyocJQZzrUKPP4D%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit c0c1840adae820efa96fb0ff797b8bc60a672d63:
  Aneesh Kumar K.V (1):
        blktrace segfault

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (1):
      Fixed REMAP to update Q2A & fixed #Q calculations

 btt/globals.h     |    2 +-
 btt/output.c      |   18 ++++++++++++++----
 btt/trace_queue.c |    1 +
 btt/trace_remap.c |   34 ++++++++++++++++++++++++----------
 4 files changed, 40 insertions(+), 15 deletions(-)
