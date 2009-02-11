From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 11 Feb 2009 19:04:45 +0000
Subject: [PATCH]  Increased limits fix for blkparse
Message-Id: <4993214D.4020600@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090701070107040209080806"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------090701070107040209080806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090701070107040209080806
Content-Type: text/x-diff;
 name="0001-Increased-limits-fix-for-blkparse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Increased-limits-fix-for-blkparse.patch"

From 3dd2a470c37c0eb3952dab12b63f5451f5d18aa8 Mon Sep 17 00:00:00 2001
From: Alan D. Brunelle <alan.brunelle@hp.com>
Date: Wed, 11 Feb 2009 13:58:14 -0500
Subject: [PATCH] Increased limits fix for blkparse

As with blktrace & btt, added in code to blkparse to handle increasing
the file limits when open errors encountered.

I'm _not_ pushing this out as Jens isn't here, and I don't feel
comfortable playing with the blkparse stuff in his tree. [Anyways, it
seems best to extract this common code and put it somewhere for
blktrace, blkparse & btt to all reference.]

I'm posting this in case anyone else is running into problems with
handling large numbers of cpus/devices. [I'm working on 32 CPUs and 88
devices right now.]

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blkparse.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index ef55697..922eb19 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -31,6 +31,8 @@
 #include <signal.h>
 #include <locale.h>
 #include <libgen.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 
 #include "blktrace.h"
 #include "rbtree.h"
@@ -306,6 +308,71 @@ static int have_drv_data = 0;
 #define CPU_IDX(cpu)	((cpu) / CPUS_PER_LONG)
 #define CPU_BIT(cpu)	((cpu) & (CPUS_PER_LONG - 1))
 
+/*
+ * Due to the N(devs) parts of a lot of the output features provided
+ * by btt, it will fail opens on large(ish) systems. Here we try to
+ * keep bumping our open file limits, and if those fail, we return NULL.
+ *
+ * Root users will probably be OK with this, others...
+ */
+static int increase_limit(int resource, rlim_t increase)
+{
+	struct rlimit rlim;
+	int save_errno = errno;
+
+	if (!getrlimit(resource, &rlim)) {
+		rlim.rlim_cur += increase;
+		if (rlim.rlim_cur >= rlim.rlim_max)
+			rlim.rlim_max = rlim.rlim_cur + increase;
+
+		if (!setrlimit(resource, &rlim))
+			return 1;
+	}
+
+	errno = save_errno;
+	return 0;
+}
+
+static int handle_open_failure(void)
+{
+	if (errno == ENFILE || errno == EMFILE)
+		return increase_limit(RLIMIT_NOFILE, 16);
+	return 0;
+}
+
+FILE *my_fopen(const char *path, const char *mode)
+{
+	FILE *fp;
+
+	do {
+		fp = fopen(path, mode);
+	} while (fp == NULL && handle_open_failure());
+
+	return fp;
+}
+
+FILE *my_fdopen(int fd, const char *mode)
+{
+	FILE *fp;
+
+	do {
+		fp = fdopen(fd, mode);
+	} while (fp == NULL && handle_open_failure());
+
+	return fp;
+}
+
+int my_open(const char *path, int flags)
+{
+	int fd;
+
+	do {
+		fd = open(path, flags);
+	} while (fd < 0 && handle_open_failure());
+
+	return fd;
+}
+
 static void output_binary(void *buf, int len)
 {
 	if (dump_binary) {
@@ -2434,7 +2501,7 @@ static int setup_file(struct per_dev_info *pdi, int cpu)
 	if (!st.st_size)
 		return 1;
 
-	pci->fd = open(pci->fname, O_RDONLY);
+	pci->fd = my_open(pci->fname, O_RDONLY);
 	if (pci->fd < 0) {
 		perror(pci->fname);
 		return 0;
@@ -2569,7 +2636,7 @@ static int do_fifo(void)
 	if (!strcmp(pipename, "-"))
 		fd = dup(STDIN_FILENO);
 	else
-		fd = open(pipename, O_RDONLY);
+		fd = my_open(pipename, O_RDONLY);
 
 	if (fd == -1) {
 		perror("dup stdin");
@@ -2817,13 +2884,13 @@ int main(int argc, char *argv[])
 
 	if (text_output) {
 		if (!output_name) {
-			ofp = fdopen(STDOUT_FILENO, "w");
+			ofp = my_fdopen(STDOUT_FILENO, "w");
 			mode = _IOLBF;
 		} else {
 			char ofname[128];
 
 			snprintf(ofname, sizeof(ofname) - 1, "%s", output_name);
-			ofp = fopen(ofname, "w");
+			ofp = my_fopen(ofname, "w");
 			mode = _IOFBF;
 		}
 
@@ -2840,7 +2907,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (dump_binary) {
-		dump_fp = fopen(dump_binary, "w");
+		dump_fp = my_fopen(dump_binary, "w");
 		if (!dump_fp) {
 			perror(dump_binary);
 			dump_binary = NULL;
-- 
1.5.6.3


--------------090701070107040209080806--
