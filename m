From: Andrew Price <anprice@redhat.com>
Date: Thu, 25 Sep 2014 21:04:16 +0000
Subject: [PATCH 4/4] Add iowatcher requirements to README
Message-Id: <1411679056-32596-5-git-send-email-anprice@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Merge the requirements bits of iowatcher/README into README

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index f52f48d..d7d1fbf 100644
--- a/README
+++ b/README
@@ -31,6 +31,8 @@ your browser to:
 
 http://git.kernel.dk/
 
+A blktrace visualization tool, iowatcher, was added to blktrace in version
+1.1.0. It requires librsvg and either png2theora or ffmpeg to generate movies.
 
 Usage
 -----
-- 
1.9.3

