From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 10 Apr 2018 12:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20180410120002.3E54A2C0079@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit e63098f39398bde67be9b64a49deece1c60614df:

  blktrace: don't stop tracer if not setup trace successfully (2018-01-24 08:40:52 -0700)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 93d9e5b5082258f3570dbc56202276284575fc11:

  blkparse: add documetation for 'R' requeue request (2018-04-09 08:36:43 -0600)

----------------------------------------------------------------
Weiping Zhang (2):
      blkparse: remove duplicated entry for flag M
      blkparse: add documetation for 'R' requeue request

 doc/blkparse.1 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

---

Diff of recent changes:

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index be9b34b..cb21fea 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -243,10 +243,6 @@ Same as the back merge, except this i/o ends where a previously inserted
 requests starts.
 
 .HP 4
-\fBM --front or back merge\fR
-One of the above
-
-.HP 4
 \fBM -- front or back merge\fR
 One of the above.
 
@@ -289,6 +285,10 @@ this and will clone lots of i/o.
 For stacked devices, incoming i/o is remapped to device below it in the i/o
 stack. The remap action details what exactly is being remapped to what.
 
+.HP 4
+\fBR -- requeue\fR
+Put a request back on queue.
+
 
 
 
