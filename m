From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 16 Dec 2011 19:17:52 +0000
Subject: [PATCH 7/10] btt: close devmap file after processing
Message-Id: <4EEB9960.2030907@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Close the file used for btt's -M argument after
processing.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/btt/devmap.c b/btt/devmap.c
index 9c0348b..0553a9e 100644
--- a/btt/devmap.c
+++ b/btt/devmap.c
@@ -76,6 +76,7 @@ int dev_map_read(char *fname)
 			break;
 	}
 
+	fclose(fp);
 	return 0;
 }
 


