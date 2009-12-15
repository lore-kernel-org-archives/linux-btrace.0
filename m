From: Edward Shishkin <edward@redhat.com>
Date: Tue, 15 Dec 2009 17:48:12 +0000
Subject: [patch 5/5] blktrace: update blkiomon doc
Message-Id: <4B27CBDC.7080002@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050403010205090704090301"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403010205090704090301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050403010205090704090301
Content-Type: text/plain;
 name="blktrace-fix-499398.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blktrace-fix-499398.patch"

Fixup for 499398.

Description of problem:

blkiomon does not understand the output of blktrace when
working with logical volume device (it is quiet, while
working with physical device it prints IO statistics as
expected).

BUG (or design feature?):
/dev/dm-* and /dev/md* don't see BLK_TC_COMPLETE actions:

        /* we need an older D trace and a younger C trace */
        if (t_old->bit.action & BLK_TC_ACT(BLK_TC_ISSUE) &&
            t_young->bit.action & BLK_TC_ACT(BLK_TC_COMPLETE)) {
                /* matching D and C traces - update statistics */
                match++;
                blkiomon_account(&t_old->bit, &t_young->bit);
                blkiomon_free_trace(t_stored);
                return t;
        }

Possible solution:
Update documentation.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
 doc/blkiomon.8 |    2 ++
 1 file changed, 2 insertions(+)

--- blktrace.orig/doc/blkiomon.8
+++ blktrace/doc/blkiomon.8
@@ -17,6 +17,8 @@ blkiomon is a block device I/O monitor. 
 request size and request latency statistics from blktrace data. It provides
 histograms as well as data that can be used to calculate min, max, average
 and variance. For this purpose, it consumes D and C traces read from stdin.
+Note, that this doesn't work for logical volumes, as high-level drivers
+don't see the completion of the events (C).
 
 There are options for binary output and human-readable output to files and
 stdout. Output to a message queue is supported as well.

--------------050403010205090704090301--
