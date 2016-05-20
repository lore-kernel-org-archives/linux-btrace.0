From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 May 2016 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20160520120002.305E72C00DF@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 7644909627859a9d9d837df8b2ecf21a169f0ff0:

  Fixup graph name in help text (2016-05-05 09:20:18 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 86596c7579c6e374e6e24c2b14398b0808a93f18:

  blktrace: remove -k from manpage synopsis (2016-05-19 15:57:22 -0600)

----------------------------------------------------------------
Eric Sandeen (1):
      blktrace: remove -k from manpage synopsis

 doc/blktrace.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 68f5e15..820b03a 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -6,7 +6,7 @@ blktrace \- generate traces of the i/o traffic on block devices
 
 
 .SH SYNOPSIS
-.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [\-k ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
+.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
 .br
 
 
