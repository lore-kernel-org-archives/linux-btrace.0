From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Date: Tue, 15 Aug 2017 21:17:52 +0000
Subject: [PATCH] blkparse: man - Elaborate definitions of RWBS fields.
Message-Id: <20170815211752.9643-1-rgoldwyn@suse.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The RWBS fields can output more fields, which need detailed description.
This information is extracted from fill_rwbs() function. If there is more
to it, I'd be happy to include it.

I did not see Barrier Operations in the fill_rwbs() function. Also,
Flush and FUA have the same code, F. Besides, I am not sure if the N
field's description is correct.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index be9b34b..fb70318 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -413,10 +413,32 @@ Split
 
 .SH "RWBS DESCRIPTION"
 
-This is a small string containing at least one character ('R' for read, 'W'
-for write, or 'D' for block discard operation), and optionally either
-a 'B' (for barrier operations) or 'S' (for synchronous operations).
+This is a small string containing at least one character for the operation(s)
+performed. It is described by the following table:
 
+.IP R
+Read
+
+.IP W
+Write
+
+.IP D
+Discard Block
+
+.IP S
+Synchronous
+
+.IP N
+Nil or Nothing, a place holder.
+
+.IP F
+Flush or Force Unit Access (FUA)
+
+.IP A
+Read-Ahead
+
+.IP M
+Metadata
 
 .SH "DEFAULT OUTPUT"
 
