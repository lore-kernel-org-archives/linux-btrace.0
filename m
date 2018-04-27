From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:14 +0000
Subject: [PATCH 07/31] verify_blkparse: man: document prereq and behavior
Message-Id: <20180427130738.102806-8-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 doc/verify_blkparse.1 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/verify_blkparse.1 b/doc/verify_blkparse.1
index c209ef8b4f33..8ea886ef83a3 100644
--- a/doc/verify_blkparse.1
+++ b/doc/verify_blkparse.1
@@ -16,6 +16,18 @@ Verifies an output file from blkparse. All it does is check if the events in
 the file are correctly time ordered. If an entry is found that isn't ordered,
 it's dumped to stdout.
 
+This only works with blkparse's default output header up to and
+including timestamp. The sscanf format string for parsing input lines
+is "%3d,%3d %5d %8d %lf". This corresponds to blkparse's default
+output header prefix "%D %2c %8s %5T.%9t", see section DEFAULT OUTPUT
+HEADER in blkparse(1). Take care when using custom output format with
+blkparse options \fB-F\fR or \fB-f\fR.
+
+On reading an unrecognized input line, the tool exits early.
+
+Currently, false positives for sequence number aliases can be reported,
+because they are only tracked per CPU but not per device (major, minor).
+
 
 .SH AUTHORS
 \fIblkparse\fR was written by Jens Axboe, Alan D. Brunelle and Nathan Scott.  This
-- 
2.14.2

