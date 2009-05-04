From: Eric Sandeen <sandeen@redhat.com>
Date: Mon, 04 May 2009 21:04:51 +0000
Subject: [PATCH] blkiomon manpage and usage reference invalid "msg-queue-name"
Message-Id: <49FF5873.5050307@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

the blkiomon usage text and man page reference a
"msg-queue-name" option, but getopts is only looking
for "msg-qeueue" - fix the docs to match the code.

Reported-by: Milos Malik <mmalik@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blkiomon.c b/blkiomon.c
index c3c1b11..7e3aa46 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -600,7 +600,7 @@ static char usage_str[] = "\n\nblkiomon " \
 	"[ -h <file>         | --human-readable=<file> ]\n" \
 	"[ -b <file>         | --binary=<file> ]\n" \
 	"[ -D <file>         | --debug=<file> ]\n" \
-	"[ -Q <path name>    | --msg-queue-name=<path name>]\n" \
+	"[ -Q <path name>    | --msg-queue=<path name>]\n" \
 	"[ -q <msg queue id> | --msg-queue-id=<msg queue id>]\n" \
 	"[ -m <msg id>       | --msg-id=<msg id>]\n" \
 	"[ -V                | --version ]\n\n" \
diff --git a/doc/blkiomon.8 b/doc/blkiomon.8
index 0bc109c..dbed0df 100644
--- a/doc/blkiomon.8
+++ b/doc/blkiomon.8
@@ -57,7 +57,7 @@ Output file for debugging data. Use '\-' for stdout.
 
 \-Q \fIpath_name\fR
 .br
-\-\-msg\-queue\-name=\fIpath_name\fR
+\-\-msg\-queue=\fIpath_name\fR
 .RS
 Sets \fIpath_name\fR as path name for existing message queue to be used
 for binary output.

