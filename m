From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 09 Jan 2016 13:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20160109130001.784792C00E7@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit dd093eb1c48e0d86b835758b96a9886fb7773aa4:

  Fix warnings on newer gcc (2015-09-15 08:48:06 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 8a1209713563b4dedea962909c18b941fb09d01a:

  Add the "-a discard" filter option to the blktrace.8 man page (2016-01-08 11:46:03 -0700)

----------------------------------------------------------------
John Groves (1):
      Add the "-a discard" filter option to the blktrace.8 man page

 doc/blktrace.8 | 2 ++
 1 file changed, 2 insertions(+)

---

Diff of recent changes:

diff --git a/doc/blktrace.8 b/doc/blktrace.8
index df464be..68f5e15 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -202,6 +202,8 @@ line options.
 .br
 \fIcomplete\fR: completed by driver
 .br
+\fIdiscard\fR: discard / trim traces
+.br
 \fIfs\fR: requests 
 .br
 \fIissue\fR: issued to driver 
