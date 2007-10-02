From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 02 Oct 2007 16:39:22 +0000
Subject: [PATCH] Added list_splice to btt/list.h
Message-Id: <4702743A.2050503@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020806070400050006000509"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------020806070400050006000509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------020806070400050006000509
Content-Type: text/x-patch;
 name="0001-Added-list_splice-to-btt-list.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Added-list_splice-to-btt-list.h.patch"

From ffeeb70251c738006077fade10f2f664f2a91199 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <Alan.Brunelle@hp.com>
Date: Tue, 2 Oct 2007 12:08:34 -0400
Subject: [PATCH] Added list_splice to btt/list.h

list_splice is needed for the addition of btrecord/btreplay.

Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
---
 btt/list.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/btt/list.h b/btt/list.h
index f28f0fb..363c888 100644
--- a/btt/list.h
+++ b/btt/list.h
@@ -1,6 +1,28 @@
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
 
+#include <stdio.h>
+
+#ifndef offsetof
+/**
+ * Get offset of a member
+ */
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+#endif
+
+#ifndef container_of
+/**
+ * Casts a member of a structure out to the containing structure
+ * @param ptr        the pointer to the member.
+ * @param type       the type of the container struct this is embedded in.
+ * @param member     the name of the member within the struct.
+ *
+ */
+#define container_of(ptr, type, member) ({                      \
+        const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+	        (type *)( (char *)__mptr - offsetof(type,member) );})
+#endif
+
 /*
  * These are non-NULL pointers that will result in page faults
  * under normal circumstances, used to verify that nobody uses
@@ -166,4 +188,29 @@ static inline void list_move_tail(struct list_head *list,
         list_add_tail(list, head);
 }
 
+static inline void __list_splice(struct list_head *list,
+                                 struct list_head *head)
+{
+        struct list_head *first = list->next;
+        struct list_head *last = list->prev;
+        struct list_head *at = head->next;
+
+        first->prev = head;
+        head->next = first;
+
+        last->next = at;
+        at->prev = last;
+}
+
+/**
+ *  * list_splice - join two lists
+ *   * @list: the new list to add.
+ *    * @head: the place to add it in the first list.
+ *     */
+static inline void list_splice(struct list_head *list, struct list_head *head)
+{
+        if (!list_empty(list))
+                __list_splice(list, head);
+}
+
 #endif
-- 
1.5.2.5


--------------020806070400050006000509--
