From: Edward Shishkin <edward@redhat.com>
Date: Tue, 15 Dec 2009 17:47:53 +0000
Subject: [patch 2/5] blktrace: print correct usage
Message-Id: <4B27CBC9.50409@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020709040506040406060403"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709040506040406060403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020709040506040406060403
Content-Type: text/plain;
 name="blktrace-fix-498898.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blktrace-fix-498898.patch"

Fixup for 498898:

Problem:
When somebody runs blktrace without parameters, it
shows the usage message. The usage message suggests
that version number "x.y.z" is a required parameter,
which is not true.

Solution:
Don't print version number when running
blktrace, blkparce, btt without parameters.

Signed-off-by: Edward Shishkin <edward@redhat.com>
---
 blkparse.c |    2 +-
 blktrace.c |    2 +-
 btt/args.c |    3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

--- blktrace.orig/blkparse.c
+++ blktrace/blkparse.c
@@ -2696,7 +2696,7 @@ static char usage_str[] =    "\n\n" \
 
 static void usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s %s %s", prog, blkparse_version, usage_str);
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
 }
 
 int main(int argc, char *argv[])
--- blktrace.orig/blktrace.c
+++ blktrace/blktrace.c
@@ -493,7 +493,7 @@ static inline void pdc_nev_update(struct
 
 static void show_usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s %s %s", prog, blktrace_version, usage_str);
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
 }
 
 /*
--- blktrace.orig/btt/args.c
+++ blktrace/btt/args.c
@@ -244,8 +244,7 @@ static char usage_str[] = \
 
 static void usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s %s %s", prog, bt_timeline_version,
-		usage_str);
+	fprintf(stderr, "Usage: %s %s", prog, usage_str);
 }
 
 static FILE *setup_ofile(char *fname)

--------------020709040506040406060403--
