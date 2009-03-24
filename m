From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 24 Mar 2009 05:00:03 +0000
Subject: Recent changes
Message-Id: <20090324050003.9939037A244@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 726d2aee9d2b97b32daa08824857c77f9536609f:
  Alan D. Brunelle (1):
        Generate matplotlib plots for btt generated data

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Tom Zanussi (1):
      Blktrace failed to lock reader threads on the cpu used by the corresponding writer. This resulted in stale data being consumed when blktrace accidently read at a position that was being written to at the same time. This issue surfaced as "bad trace magic" warnings emitted by blktrace tools.

 blktrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
