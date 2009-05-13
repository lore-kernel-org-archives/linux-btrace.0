From: Eric Sandeen <sandeen@redhat.com>
Date: Wed, 13 May 2009 22:16:29 +0000
Subject: [PATCH] blkparse: exit with error if no tracefiles found
Message-Id: <4A0B46BD.4030202@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

If no tracefiles are found, exit with non-0 status

Resolves Red Hat Bugzilla #500118

Reported-by: Milos Malik <mmalik@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---


diff --git a/blkparse.c b/blkparse.c
index eec4952..db6a418 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2518,6 +2518,12 @@ static int do_file(void)
 
 		for (cpu = 0; setup_file(pdi, cpu); cpu++)
 			;
+
+		if (!cpu) {
+			fprintf(stderr,"No input files found for %s\n",
+				pdi->name);
+			return 1;
+		}
 	}
 
 	/*

