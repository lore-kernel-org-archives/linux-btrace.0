From: Eric Sandeen <sandeen@redhat.com>
Date: Wed, 18 May 2016 16:15:07 +0000
Subject: [PATCH] blktrace: remove -k from manpage synopsis
Message-Id: <49be338d-da1d-eac9-e6db-357032f3a0d4@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

An earlier commit:

  fb7f8667 blktrace: disable kill option - take 2

removed the "-k" option documentation, but left
it in the synopsis.

This is a bit unusual and unhelpful and probably
unintended; remove it from the synopsis as well.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 68f5e15..820b03a 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -6,7 +6,7 @@ blktrace \- generate traces of the i/o traffic on block devices
 
 
 .SH SYNOPSIS
-.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [\-k ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
+.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
 .br
 
 

