From: songkai <songkai01@inspur.com>
Date: Wed, 08 Sep 2021 22:12:19 +0000
Subject: [PATCH] btt:Release overlapping IO after it is replaced in RB-tree
Message-Id: <20210908221219.127593-1-songkai01@inspur.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Currently btt replaces the older IO when finding out new IO that is
beginning at the same sector.But the older IO will not be released
until btt exits, when calling io_free_all(),this is a waste of memory.
So,we can free the original IO after replacing it from RB-tree,avoiding
useless memory occupation when btt is running.

Signed-off-by: songkai <songkai01@inspur.com>
---
 btt/dip_rb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/btt/dip_rb.c b/btt/dip_rb.c
index 6efef6c..2cfda90 100644
--- a/btt/dip_rb.c
+++ b/btt/dip_rb.c
@@ -39,6 +39,11 @@ int rb_insert(struct rb_root *root, struct io *iop)
 			p = &(*p)->rb_right;
 		else {
 			rb_replace_node(parent, &iop->rb_node, root);
+
+			if (__iop->pdu)
+				free(__iop->pdu);
+			io_free(__iop);
+
 			return 1;
 		}
 	}
-- 
2.27.0
