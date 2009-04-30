From: Eric Sandeen <sandeen@redhat.com>
Date: Thu, 30 Apr 2009 15:56:04 +0000
Subject: [PATCH] fix max-pkts option inconsistencies
Message-Id: <49F9CA14.6060808@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

This is for RH bug 498426,
btrecord doesn't recognize --max-pkts and --max-packets cmd line options

Usage text and some documentation references "--max-pkts" and
the man page references "--max-packets" but the getopts code
is looking for --max_pkts.

I'm not sure if it's best to make the code match the majority
of the docs, or fix the docs to match the code?  This patch does
the former, but I'm not picky if you want to go the other way :)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index 09329f7..88ab806 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -152,7 +152,7 @@ static struct option l_opts[] = {
 		.val = 'm'
 	},
 	{
-		.name = "max_pkts",
+		.name = "max-pkts",
 		.has_arg = required_argument,
 		.flag = NULL,
 		.val = 'M'
diff --git a/doc/btrecord.8 b/doc/btrecord.8
index f8477da..b4318ae 100644
--- a/doc/btrecord.8
+++ b/doc/btrecord.8
@@ -121,7 +121,7 @@ The default value is 10,000,000 nanoseconds (10 milliseconds).
 
 \-M <\fInum\fR>
 .br
-\-\-max\-packets=<\fInum\fR>
+\-\-max\-pkts=<\fInum\fR>
 .RS
 Set maximum number of packets per bunch.
 The \fI\-M\fR option requires a single parameter which specifies the

