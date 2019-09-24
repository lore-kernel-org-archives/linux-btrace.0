From: Hiroaki Mihara <hmihara@redhat.com>
Date: Tue, 24 Sep 2019 22:32:06 +0000
Subject: [PATCH 1/3] blkparse: split off the timestamp correction code in to a separate function
Message-Id: <20190924223206.20125-1-hmihara@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

find_genesis() function has code to correct abs_start_time, which is
later used to calculate the absolute timestamps of each traced
records.

Put this code in a separate function, so that it can be used later by
the blkparse code. No functional change.

Signed-off-by: Hiroaki Mihara <hmihara@redhat.com>
---
 blkparse.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 3de2ebe..cf7a87b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2022,6 +2022,22 @@ static void show_device_and_cpu_stats(void)
 	}
 }
 
+static void correct_abs_start_time(void)
+{
+	long delta = genesis_time - start_timestamp;
+
+	abs_start_time.tv_sec  += SECONDS(delta);
+	abs_start_time.tv_nsec += NANO_SECONDS(delta);
+	if (abs_start_time.tv_nsec < 0) {
+		abs_start_time.tv_nsec += 1000000000;
+		abs_start_time.tv_sec -= 1;
+	} else
+	if (abs_start_time.tv_nsec > 1000000000) {
+		abs_start_time.tv_nsec -= 1000000000;
+		abs_start_time.tv_sec += 1;
+	}
+}
+
 static void find_genesis(void)
 {
 	struct trace *t = trace_list;
@@ -2039,18 +2055,7 @@ static void find_genesis(void)
 	 */
 	if (start_timestamp
 	 && start_timestamp != genesis_time) {
-		long delta = genesis_time - start_timestamp;
-
-		abs_start_time.tv_sec  += SECONDS(delta);
-		abs_start_time.tv_nsec += NANO_SECONDS(delta);
-		if (abs_start_time.tv_nsec < 0) {
-			abs_start_time.tv_nsec += 1000000000;
-			abs_start_time.tv_sec -= 1;
-		} else
-		if (abs_start_time.tv_nsec > 1000000000) {
-			abs_start_time.tv_nsec -= 1000000000;
-			abs_start_time.tv_sec += 1;
-		}
+		correct_abs_start_time();
 	}
 }
 
-- 
2.21.0
