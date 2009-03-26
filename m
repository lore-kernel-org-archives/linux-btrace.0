From: Eric Sandeen <sandeen@redhat.com>
Date: Thu, 26 Mar 2009 15:54:27 +0000
Subject: [PATCH] fix trivial typo in manpage
Message-Id: <49CBA533.2050301@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Fix small typo as reported by Kent Baxley <kbaxley@redhat.com>
in Red Hat Bug 489941 - tiny typo in blktrace manpage

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Index: blktrace/doc/blktrace.8
=================================--- blktrace.orig/doc/blktrace.8
+++ blktrace/doc/blktrace.8
@@ -169,7 +169,7 @@ line options.
 .RS
 \fIbarrier\fR: barrier attribute 
 .br
-\fIcomplete\fR: completed} by driver
+\fIcomplete\fR: completed by driver
 .br
 \fIfs\fR: requests 
 .br


