From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:11:33 +0000
Subject: [PATCH 4/10] Close stream in 'I' switch handling
Message-Id: <4EEB97E5.4030206@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The file containing the list of devices was never closed
after processing was complete.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blktrace.c b/blktrace.c
index 848250d..5f74ef2 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2076,9 +2076,13 @@ static int handle_args(int argc, char *argv[])
 				return 1;
 			}
 
-			while (fscanf(ifp, "%s\n", dev_line) = 1)
-				if (add_devpath(dev_line) != 0)
+			while (fscanf(ifp, "%s\n", dev_line) = 1) {
+				if (add_devpath(dev_line) != 0) {
+					fclose(ifp);
 					return 1;
+				}
+			}
+			fclose(ifp);
 			break;
 		}
 


