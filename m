From: Nathan Zimmer <nzimmer@sgi.com>
Date: Mon, 15 Apr 2013 14:53:35 +0000
Subject: [PATCH 4/5] blktrace: use number of configured cpus instead of online cpus
Message-Id: <1366037616-20159-5-git-send-email-nzimmer@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

We want to run on all online processors.  However is there is a hole in the
online cpumask this won't happen.  We need the number of configured processors
instead of online.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
---
 blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 89aaaac..63125ab 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2656,9 +2656,9 @@ int main(int argc, char *argv[])
 
 	setlocale(LC_NUMERIC, "en_US");
 	pagesize = getpagesize();
-	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+	ncpus = sysconf(_SC_NPROCESSORS_CONF);
 	if (ncpus < 0) {
-		fprintf(stderr, "sysconf(_SC_NPROCESSORS_ONLN) failed %d/%s\n",
+		fprintf(stderr, "sysconf(_SC_NPROCESSORS_CONF) failed %d/%s\n",
 			errno, strerror(errno));
 		ret = 1;
 		goto out;
-- 
1.8.1.2

