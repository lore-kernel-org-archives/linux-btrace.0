From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 08 Nov 2017 13:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20171108130001.8F7652C02B3@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 07d76e12aa46fa0bad4b736d581ec5aca62264f7:

  btt/devs: silence warning on sprintf overflow (2017-11-05 08:54:41 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 8fc451c6b0b9a7db7c376ea6865c35321e561f00:

  btt: Fix overlapping IO stats. (2017-11-07 11:25:38 -0700)

----------------------------------------------------------------
Gwendal Grignou (1):
      btt: Fix overlapping IO stats.

 btt/dip_rb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---

Diff of recent changes:

diff --git a/btt/dip_rb.c b/btt/dip_rb.c
index 2aa7ffc..6efef6c 100644
--- a/btt/dip_rb.c
+++ b/btt/dip_rb.c
@@ -57,7 +57,7 @@ struct io *rb_find_sec(struct rb_root *root, __u64 sec)
 		__iop = rb_entry(n, struct io, rb_node);
 		if (sec < BIT_START(__iop))
 			n = n->rb_left;
-		else if (sec >= BIT_END(__iop))
+		else if (sec > BIT_START(__iop))
 			n = n->rb_right;
 		else
 			return __iop;
@@ -82,7 +82,7 @@ void rb_foreach(struct rb_node *n, struct io *iop,
 		}
 		if (iop_s < this_s)
 			rb_foreach(n->rb_left, iop, fnc, head);
-		if (this_e < iop_e)
+		if ((this_e < iop_e) || (this_s < iop_s))
 			rb_foreach(n->rb_right, iop, fnc, head);
 	}
 }
