From: Eric Sandeen <sandeen@redhat.com>
Date: Thu, 07 May 2009 16:08:25 +0000
Subject: [PATCH] blkrawverify: warn and return error if no traces are found
Message-Id: <4A030779.7090707@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

blkrawverify is prints no errors and returns success if the
requested tracefiles aren't found:

# blkrawverify foobar
Verifying foobar
# echo $?
0

With this change it's a bit more informative:

# ./blkrawverify foobar
Verifying foobar
No tracefiles found for foobar
# echo $?
1

Resolves Red Hat Bugzilla #499581

Reported-by: Milos Malik <mmalik@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Index: blktrace/blkrawverify.c
=================================--- blktrace.orig/blkrawverify.c
+++ blktrace/blkrawverify.c
@@ -296,8 +296,14 @@ int main(int argc, char *argv[])
 		printf("Verifying %s\n", devname); fflush(stdout);
 		for (cpu = 0; ; cpu++) {
 			sprintf(fname, "%s.blktrace.%d", devname, cpu);
-			if (stat(fname, &st) < 0)
+			if (stat(fname, &st) < 0) {
+				if (cpu = 0) {
+					fprintf(stderr, "No tracefiles found for %s\n",
+						devname);
+					rval = 1;
+				}
 				break;
+			}
 			printf("    CPU %d ", cpu); fflush(stdout);
 			nbad = process(&ofp, devname, fname, cpu);
 			if (nbad) {

