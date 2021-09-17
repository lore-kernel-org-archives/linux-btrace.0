From: songkai <songkai01@inspur.com>
Date: Fri, 17 Sep 2021 09:18:45 +0000
Subject: [PATCH] btt: fix potential memory leak problem in io_free_all()
Message-Id: <20210917091845.133913-1-songkai01@inspur.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

In “struct io” , the "void *pdu" member points to the memory
which is allocated in convert_to_cpu(). We should free memory
pdu point to before we free "struct io", or memory leak occurred.

Signed-off-by: songkai <songkai01@inspur.com>
---
 btt/inlines.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/btt/inlines.h b/btt/inlines.h
index 64b5a2c..fa5a546 100644
--- a/btt/inlines.h
+++ b/btt/inlines.h
@@ -153,6 +153,9 @@ static inline void io_free_all(void)
 
 	list_for_each_safe(p, q, &all_ios) {
 		iop = list_entry(p, struct io, a_head);
+
+		if (iop->pdu)
+			free(iop->pdu);
 		free(iop);
 	}
 }
-- 
2.27.0
