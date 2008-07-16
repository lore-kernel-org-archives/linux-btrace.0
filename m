From: Martin Peschke <mp3@de.ibm.com>
Date: Wed, 16 Jul 2008 11:22:54 +0000
Subject: [Patch 1/2] blkiomon: blkparse option for binary output on stdout
Message-Id: <1216207375.26621.76.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-s390@vger.kernel.org, linux-btrace@vger.kernel.org

The option "-d -" makes blkparse dump traces as binary data to
standard output. Blktrace provides a similar capability.
This allows to pipe binary trace data from blkparse to another
tool which does online processing, like I/O statistics.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---
 blkparse.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/blkparse.c
+++ b/blkparse.c
@@ -274,6 +274,7 @@ int data_is_native = -1;
 
 static FILE *dump_fp;
 static char *dump_binary;
+static int dump_binary_stdout = 0;
 
 static unsigned int t_alloc_cache;
 static unsigned int bit_alloc_cache;
@@ -307,6 +308,8 @@ static void output_binary(void *buf, int
 			fclose(dump_fp);
 			dump_binary = NULL;
 		}
+		if (dump_binary_stdout)
+			fflush(dump_fp);
 	}
 }
 
@@ -2823,14 +2826,24 @@ int main(int argc, char *argv[])
 	}
 
 	if (dump_binary) {
-		dump_fp = fopen(dump_binary, "w");
+		int mode, vbuf_size;
+		if (!strcmp(dump_binary, "-")) {
+			dump_fp = fdopen(STDOUT_FILENO, "w");
+			mode = _IOLBF;
+			vbuf_size = 4096;
+			dump_binary_stdout = 1;
+		} else	{
+			dump_fp = fopen(dump_binary, "w");
+			mode = _IOFBF;
+			vbuf_size = 128 * 1024;
+		}
 		if (!dump_fp) {
 			perror(dump_binary);
 			dump_binary = NULL;
 			return 1;
 		}
 		bin_ofp_buffer = malloc(128 * 1024);
-		if (setvbuf(dump_fp, bin_ofp_buffer, _IOFBF, 128 * 1024)) {
+		if (setvbuf(dump_fp, bin_ofp_buffer, mode, vbuf_size)) {
 			perror("setvbuf binary");
 			return 1;
 		}


