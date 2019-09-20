From: Hiroaki Mihara <hmihara@redhat.com>
Date: Fri, 20 Sep 2019 05:03:36 +0000
Subject: [PATCH] blkparse: man: add absolute timestamp printing option
Message-Id: <20190920050336.16191-1-hmihara@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The functionality of printing out absolute timestamps has been
implemented in code but not documented in man pages.

When comparing the timings of related events with block I/O traces,
the absolute timestams play a key role.  I think that the
documentation of this might be beneficial to blktrace users.

The related commit was done in 2006 as follows,

> commit 7bd4fd0a4fca645bb50a641afac1e460a4e32dfd
> Author: Olaf Kirch <okir@lst.de>
> Date:   Fri Dec 1 10:34:11 2006 +0100
> 
>     [PATCH] Add timestamp support
> 
>     Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> 

URL of the above patch,
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git/commit/?id{d4fd0a4fca645bb50a641afac1e460a4e32dfd

Signed-off-by: Hiroaki Mihara <hmihara@redhat.com>
---
 doc/blkparse.1 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 627b7b1..e494b6e 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -368,6 +368,9 @@ Elapsed value in microseconds (\fI\-t\fR command line option)
 .IP \fBU\fR 4
 Payload unsigned integer
 
+.IP \fBz\fR 4
+The absolute time, as local time in your time zone, with no date displayed
+
 .PP
 Note that the user can optionally specify field display width, and optionally a
 left-aligned specifier. These precede field specifiers, with a '%' character,
-- 
2.21.0
