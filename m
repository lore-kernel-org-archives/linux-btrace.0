From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:05:02 +0000
Subject: [PATCH 1/10] Check setvbuf return value
Message-Id: <4EEB965E.2010501@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Check for setvbuf failure.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blktrace.c b/blktrace.c
index 72866e2..848250d 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2178,7 +2178,10 @@ static int handle_args(int argc, char *argv[])
 		piped_output = 1;
 		handle_pfds = handle_pfds_entries;
 		pfp = stdout;
-		setvbuf(pfp, NULL, _IONBF, 0);
+		if (setvbuf(pfp, NULL, _IONBF, 0)) {
+			perror("setvbuf stdout");
+			return 1;
+		}
 	} else
 		handle_pfds = handle_pfds_file;
 	return 0;


