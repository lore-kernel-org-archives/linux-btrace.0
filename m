From: Nathan Scott <nscott@aconex.com>
Date: Fri, 01 Aug 2008 06:16:09 +0000
Subject: [patch] man page typo
Message-Id: <1217571369.4422.86.camel@verge.scott.net.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-JE1BwQecv4CQu2bITj81"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org


--=-JE1BwQecv4CQu2bITj81
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes up a formatting problem when displaying the blktrace
man pages - just a typo (bold mode not correctly terminated, so
it flows on until the next bold-mode-termination a few lines on).

--
Nathan

--=-JE1BwQecv4CQu2bITj81
Content-Disposition: attachment; filename=man.patch
Content-Type: text/x-patch; name=man.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index e87feae..4b34dff 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -201,7 +201,7 @@ sends the command data block as a payload so that blkparse can decode it.
 
 
 .SH EXAMPLES
-To trace the i/o on the device \fI/dev/hda\fB and parse the output to human
+To trace the i/o on the device \fI/dev/hda\fR and parse the output to human
 readable form, use the following command:
 
     % blktrace \-d /dev/sda \-o \- | blkparse \-i \-

--=-JE1BwQecv4CQu2bITj81--

