From: Eric Sandeen <sandeen@redhat.com>
Date: Thu, 09 May 2013 02:00:53 +0000
Subject: [PATCH] blktrace: document -k option
Message-Id: <518B0355.3030905@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The -k option was missing from the usage() output and was present
only in the man page synopsis.  Say a few more words about it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blktrace.c b/blktrace.c
index 89aaaac..4e96573 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -450,6 +450,7 @@ static char usage_str[] = "\n\n" \
         "[ -p <port number>   | --port=<port number>]\n" \
         "[ -s                 | --no-sendfile]\n" \
         "[ -I <devs file>     | --input-devs=<devs file>]\n" \
+        "[ -k                 | --kill]\n" \
         "[ -v <version>       | --version]\n" \
         "[ -V <version>       | --version]\n" \
 
@@ -467,6 +468,7 @@ static char usage_str[] = "\n\n" \
 	"\t-p Network port to use (default 8462)\n" \
 	"\t-s Make the network client NOT use sendfile() to transfer data\n" \
 	"\t-I Add devices found in <devs file>\n" \
+	"\t-k Kill a running trace\n" \
 	"\t-v Print program version info\n" \
 	"\t-V Print program version info\n\n";
 
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index b5e69b7..7f13231 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -163,6 +163,13 @@ This only works when supplying a single device, or when piping the output
 via "-o -" with multiple devices.
 .RE
 
+\-k
+.br
+\-\-kill
+.RS
+Kill a running trace if blktrace dies
+.RE
+
 \-r \fIrel-path\fR
 .br
 \-\-relay=\fIrel-path\fR     


