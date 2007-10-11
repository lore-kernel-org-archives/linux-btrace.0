From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 11 Oct 2007 04:00:02 +0000
Subject: Recent changes
Message-Id: <470d9fc2.D4oTaukVRdGxlxoi%jens.axboe@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 0106d9cfa13b912042bace7bbb2d2475dfd35e10:
  Alan D. Brunelle (1):
        Converted fatal to an inline function

are available in the git repository at:

  git://git.kernel.dk/data/git/blktrace.git master

Alan D. Brunelle (3):
      Converted fatal from macro to inline
      Merge branch 'master' of git://brick.kernel.dk/data/git/blktrace
      Added O_NOATIME to replay file

Joshua Root (1):
      Fix segfault in replay_sub when verbose is 1

 btreplay/btreplay.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
