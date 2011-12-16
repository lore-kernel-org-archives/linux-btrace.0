From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:13:21 +0000
Subject: [PATCH 5/10] Remove extraneous malloc in find_input routines
Message-Id: <4EEB9851.5050902@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

No point in malloc()ing space if we just immediately overwrite
the pointer via strdup.  That'll leak some space.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

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
diff --git a/btreplay/btreplay.c b/btreplay/btreplay.c
index f4f5aa0..20494e0 100644
--- a/btreplay/btreplay.c
+++ b/btreplay/btreplay.c
@@ -596,7 +596,7 @@ static void find_input_devs(char *idir)
 	}
 
 	while ((ent = readdir(dir)) != NULL) {
-		char *p, *dsf = malloc(256);
+		char *p, *dsf;
 
 		if (strstr(ent->d_name, ".replay.") = NULL)
 			continue;


