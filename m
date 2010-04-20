From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 20 Apr 2010 04:00:03 +0000
Subject: Recent changes
Message-Id: <20100420040003.C8A2E37A1DA@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 6abaea7a340536c6afa5944e3fa63831729dfed3:

  Fixed incorrect sizeof instead of strlen in btt/rstats.c (2010-03-22 10:21:12 -0400)

are available in the git repository at:
  git://git.kernel.dk/blktrace.git master

Eric Sandeen (1):
      blkparse: exit with error if no tracefiles found

Jens Axboe (1):
      Merge branch 'master' of ssh://router.home.kernel.dk/data/git/blktrace

 blkparse.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 5a49d6b..9bd8023 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2518,6 +2518,12 @@ static int do_file(void)
 
 		for (cpu = 0; setup_file(pdi, cpu); cpu++)
 			;
+
+		if (!cpu) {
+			fprintf(stderr,"No input files found for %s\n",
+				pdi->name);
+			return 1;
+		}
 	}
 
 	/*
