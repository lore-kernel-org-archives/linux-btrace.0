From: John Groves <John@groves.net>
Date: Tue, 05 Jan 2016 00:21:46 +0000
Subject: [PATCH] Add the "-a discard" filter option to the blktrace.8 man page
Message-Id: <CALz7SpWogKeSYkNAmQF+pdqC5gHrT9aBf9j6VH5g5q0eB7=sCA@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Add the "-a discard" filter option to the blktrace.8 man page

---
 doc/blktrace.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index df464be..68f5e15 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -202,6 +202,8 @@ line options.
 .br
 \fIcomplete\fR: completed by driver
 .br
+\fIdiscard\fR: discard / trim traces
+.br
 \fIfs\fR: requests
 .br
 \fIissue\fR: issued to driver
-- 
2.4.0
