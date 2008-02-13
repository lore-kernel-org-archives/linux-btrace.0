From: Aaron Carroll <aaronc@gelato.unsw.edu.au>
Date: Wed, 13 Feb 2008 07:48:14 +0000
Subject: [PATCH] btt: fix missing cleanup call
Message-Id: <47B2A0BE.1030709@gelato.unsw.edu.au>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

clean_args() exists but is never called, thus any files opened in args remain
open while the buffers backing those files are closed.

Signed-off-by: Aaron Carroll <aaronc@gelato.unsw.edu.au>
---
 btt/bt_timeline.c |    1 +
 btt/globals.h     |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/btt/bt_timeline.c b/btt/bt_timeline.c
index 981b909..17a1b23 100644
--- a/btt/bt_timeline.c
+++ b/btt/bt_timeline.c
@@ -92,6 +92,7 @@ int main(int argc, char *argv[])
 	free(input_name);
 	if (output_name) free(output_name);
 
+	clean_args();
 	clean_bufs();
 
 	return 0;
diff --git a/btt/globals.h b/btt/globals.h
index f6041de..486a3fc 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -228,6 +228,7 @@ extern struct list_head cios;
 
 /* args.c */
 void handle_args(int argc, char *argv[]);
+void clean_args();
 
 /* devmap.c */
 int dev_map_read(char *fname);
