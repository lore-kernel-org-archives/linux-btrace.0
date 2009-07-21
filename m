From: Jan Blunck <jblunck@suse.de>
Date: Tue, 21 Jul 2009 11:30:42 +0000
Subject: [PATCH] btrecord: Fix memory leak in find_input_files()
Message-Id: <1248175842-11106-1-git-send-email-jblunck@suse.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

David Binderman <dcb314@hotmail.com> found a memory leak in btrecord where
find_input_files() is leaking 256 bytes for every iteration of the while
loop.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 btreplay/btrecord.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index 88ab806..3646257 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -365,7 +365,7 @@ static void find_input_files(char *idir)
 	}
 
 	while ((ent = readdir(dir)) != NULL) {
-		char *p, *dsf = malloc(256);
+		char *p, *dsf;
 
 		if (strstr(ent->d_name, ".blktrace.") = NULL)
 			continue;
-- 
1.6.1.3

