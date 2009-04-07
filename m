From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 07 Apr 2009 04:00:03 +0000
Subject: Recent changes
Message-Id: <20090407040003.7987037A16C@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit d8ba9b683e1a341ab72c40836c05a360875c2e5e:
  Eric Sandeen (1):
        fix trivial typo in manpage

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

Alan D. Brunelle (2):
      Working on fixing % time q plugged
      Fixed plug/unplug logic in btt

 btt/devs.c       |   19 ++++++++++++-------
 btt/globals.h    |    4 ++--
 btt/output.c     |   17 +++++++++--------
 btt/trace_plug.c |    3 ++-
 4 files changed, 25 insertions(+), 18 deletions(-)
