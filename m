From: Tao Ma <tm@tao.ma>
Date: Sun, 30 Jan 2011 09:18:26 +0000
Subject: [PATCH] gitignore: add blkiomon to .gitignore.
Message-Id: <1296379106-6009-3-git-send-email-tm@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

From: Tao Ma <boyu.mt@taobao.com>

Add blkiomon, btreplay/btrecord and btreplay/btreplay to
.gitignore so that they don't show up in "Untracked files.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Tao Ma <boyu.mt@taobao.com>
---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 9038778..2436e34 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,9 @@
 blkparse
 blktrace
 blkrawverify
+blkiomon
+btreplay/btrecord
+btreplay/btreplay
 doc/.depend
 verify_blkparse
 btt/btt
-- 
1.6.3.GIT

