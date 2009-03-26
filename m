From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 26 Mar 2009 05:00:02 +0000
Subject: Recent changes
Message-Id: <20090326050002.8404237A23E@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit f547a39d32d514eb7bce82b955193b73e9828c85:
  Tom Zanussi (1):
        Blktrace failed to lock reader threads on the cpu used by the corresponding writer. This resulted in stale data being consumed when blktrace accidently read at a position that was being written to at the same time. This issue surfaced as "bad trace magic" warnings emitted by blktrace tools.

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Carl Henrik Lunde (1):
      Add NOTIFY to activity mask

 act_mask.c       |    1 +
 doc/blktrace.8   |    2 ++
 doc/blktrace.tex |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)
