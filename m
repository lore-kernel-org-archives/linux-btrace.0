From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 19 Feb 2015 13:00:02 +0000
Subject: Recent changes (master)
Message-Id: <20150219130003.184E3400C0@lyth.info>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 2cf87e6092da7b36d5ef10c830ddf12d9e18121d:

  iowatcher: wrap system() in a checker function (2014-09-25 15:17:06 -0600)

are available in the git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 88d38b4d0a5b33332fa80d7028a87c0717bb5d75:

  Refer to sda instead of hda in man pages (2015-02-18 08:50:02 -0800)

----------------------------------------------------------------
Olaf Hering (1):
      Refer to sda instead of hda in man pages

 doc/blkparse.1 |    2 +-
 doc/blktrace.8 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

---

Diff of recent changes:

diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 9193dbe..be9b34b 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -530,7 +530,7 @@ device and sector offset.
 
 
 .SH EXAMPLES
-To trace the i/o on the device \fI/dev/hda\fB and parse the output to human
+To trace the i/o on the device \fI/dev/sda\fB and parse the output to human
 readable form, use the following command:
 
     % blktrace \-d /dev/sda \-o \- | blkparse \-i \-
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index b5e69b7..df464be 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -236,7 +236,7 @@ sends the command data block as a payload so that blkparse can decode it.
 
 
 .SH EXAMPLES
-To trace the i/o on the device \fI/dev/hda\fR and parse the output to human
+To trace the i/o on the device \fI/dev/sda\fR and parse the output to human
 readable form, use the following command:
 
     % blktrace \-d /dev/sda \-o \- | blkparse \-i \-
