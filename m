From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:28 +0000
Subject: [PATCH 21/31] btt: fix --do-active to not perform --q2d-latencies|-z
Message-Id: <20180427130738.102806-22-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

With flag NULL, val is returned from getopt_long().
Since long option --do-active is short option -Z, val should be capital 'Z'
so the switch construct matches case 'Z' as for the short option.
Otherwise --do-active would end up the same as -z which is --q2d-latencies.
Fixes btt v2.09 in blktrace v1.0.2.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 2e37a10ee8b4 ("btt: Added in I/O activity per device and system-wide")
---
 btt/args.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/args.c b/btt/args.c
index 5c5078ab2c81..4a3ab6fe1044 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -191,7 +191,7 @@ static struct option l_opts[] = {
 		.name = "do-active",
 		.has_arg = no_argument,
 		.flag = NULL,
-		.val = 'z'
+		.val = 'Z'
 	},
 	{
 		.name = "easy-parse-avgs",
-- 
2.14.2

