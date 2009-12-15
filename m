From: Edward Shishkin <edward@redhat.com>
Date: Tue, 15 Dec 2009 17:47:59 +0000
Subject: [patch 3/5] blktrace: add back conversion
Message-Id: <4B27CBCF.8070101@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040904010106000103050709"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------040904010106000103050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040904010106000103050709
Content-Type: text/plain;
 name="blktrace-fix-502889.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blktrace-fix-502889.patch"

Fixup for bz 502889.

Problem:
when executing with /dev/cciss/foo (long path names)
btreplay complains (No such file or directory).

Bug: 
Missed back conversion of erscores to slashes.

Solution:
Convert underscores to slashes to restore device
names that have larger paths.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
 btreplay/btreplay.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- blktrace.orig/btreplay/btreplay.c
+++ blktrace/btreplay/btreplay.c
@@ -1314,6 +1314,8 @@ static void reset_input_file(struct thr_
  */
 static void *replay_sub(void *arg)
 {
+        int i;
+	char *mdev;
 	char path[MAXPATHLEN];
 	struct io_bunch bunch;
 	struct thr_info *tip = arg;
@@ -1321,8 +1323,15 @@ static void *replay_sub(void *arg)
 
 	pin_to_cpu(tip);
 
-	sprintf(path, "/dev/%s", map_dev(tip->devnm));
-
+	mdev = map_dev(tip->devnm);
+	sprintf(path, "/dev/%s", mdev);
+	/*
+	 * convert underscores to slashes to
+	 * restore device names that have larger paths
+	 */
+	for (i = 0; i < strlen(mdev); i++)
+	        if (path[strlen("/dev/") + i] == '_')
+		        path[strlen("/dev/") + i] = '/';
 #ifdef O_NOATIME
 	oflags = O_NOATIME;
 #else

--------------040904010106000103050709--
