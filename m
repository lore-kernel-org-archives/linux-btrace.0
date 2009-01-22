From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 22 Jan 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <4977fd52.kaOjj1waNHBoBuXk%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 19cfaf3f4d8e53ce43cccd809676f8f2a40f0b34:
  Alan D. Brunelle (1):
        Added no messages option to blkparse.c

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Martin Peschke (2):
      The git commit 11914a53d2ec2974a565311af327b8983d8c820d added __BLK_TA_ABORT
      A couple of min-counters weren't initialised correctly (thrput_r,

 blkiomon.c     |    6 +-----
 blktrace_api.h |    2 ++
 2 files changed, 3 insertions(+), 5 deletions(-)
