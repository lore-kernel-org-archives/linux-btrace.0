From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 18 Feb 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <499b95d2.+3eyxhIqGH2vWBSC%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit ee27874baa43db7d697b5de72938e4ccb71bdabb:
  Alan D. Brunelle (1):
        btt: Added no remap option

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (1):
      Fixed EAGAIN handling in blktrace.c

Jens Axboe (1):
      O_NOATIME isn't always present

 blktrace.c          |    7 +++++--
 btreplay/btreplay.c |    9 ++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)
