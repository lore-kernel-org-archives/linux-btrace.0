From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 03 Feb 2009 12:12:34 +0000
Subject: [PATCH] Provide more information when drops are seen
Message-Id: <498834B2.6080601@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030603090203040505050609"
List-Id: <linux-btrace.vger.kernel.org>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------030603090203040505050609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030603090203040505050609
Content-Type: text/x-diff;
 name="0001-Provide-more-information-when-drops-are-seen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Provide-more-information-when-drops-are-seen.patch"


This will provide the user with the percentage of drops encountered,
allowing them to know how far off they are in being able to capturing all
traces. It will also suggest trying to increase _either_ the buffer size
(-b) or trying more buffers (-n) when drops are found. We have found
that some times the latter is more helpful than the former.

The output would now look something like:

You have 114704 (  0.7%) dropped events
Consider using a larger buffer size (-b) and/or more buffers (-n)

Signed-off-by: Alan D. Brunelle <alan.brunelle@hp.com>
---
 blktrace.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index afcc42f..c55b491 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1321,7 +1321,7 @@ static void show_stats(struct device_information *dips, int ndips, int cpus)
 	struct device_information *dip;
 	struct thread_information *tip;
 	unsigned long long events_processed, data_read;
-	unsigned long total_drops;
+	unsigned long total_drops, total_events;
 	int i, j, no_stdout = 0;
 
 	if (is_stat_shown())
@@ -1333,12 +1333,20 @@ static void show_stats(struct device_information *dips, int ndips, int cpus)
 	stat_shown = 1;
 
 	total_drops = 0;
+	total_events = 0;
 	__for_each_dip(dip, dips, ndips, i) {
 		if (!no_stdout)
 			printf("Device: %s\n", dip->path);
 		events_processed = 0;
 		data_read = 0;
 		__for_each_tip(dip, tip, cpus, j) {
+			/*
+			 * Estimate number of events if not known
+			 */
+			if (tip->events_processed == 0)
+				tip->events_processed = tip->data_read /
+						sizeof(struct blk_io_trace);
+
 			if (!no_stdout)
 				printf("  CPU%3d: %20lu events, %8llu KiB data\n",
 			       		tip->cpu, tip->events_processed,
@@ -1347,14 +1355,19 @@ static void show_stats(struct device_information *dips, int ndips, int cpus)
 			data_read += tip->data_read;
 		}
 		total_drops += dip->drop_count;
+		total_events += (dip->drop_count + events_processed);
 		if (!no_stdout)
 			printf("  Total:  %20llu events (dropped %lu), %8llu KiB data\n",
 					events_processed, dip->drop_count,
 					(data_read + 1023) >> 10);
 	}
 
-	if (total_drops)
-		fprintf(stderr, "You have dropped events, consider using a larger buffer size (-b)\n");
+	if (total_drops) {
+		fprintf(stderr, "\nYou have %lu (%5.1lf%%) dropped events\n"
+			        "Consider using a larger buffer size (-b) "
+				"and/or more buffers (-n)\n", total_drops,
+			100.0 * (double)total_drops / (double)total_events);
+	}
 }
 
 static struct device_information *net_get_dip(struct net_connection *nc,
-- 
1.5.6.3


--------------030603090203040505050609--
