From: Jan Kara <jack@suse.cz>
Date: Thu, 26 Jan 2017 10:23:55 +0000
Subject: [PATCH 3/3] blktrace: Create empty output files for non-existent cpus
Message-Id: <20170126102355.19802-3-jack@suse.cz>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When CPU number space is sparse, we don't start threads for non-existent
CPUs. As a result, there are no output files created for these CPUs
which confuses tools like blkparse which expect that CPU numbers are
contiguous. Create fake empty files for non-existent CPUs so that other
tools don't have to bother.

Note that in network mode, the server will create all files in the range
0..max_cpus automatically.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 blktrace.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/blktrace.c b/blktrace.c
index 3a25338cc9ad..e8f2f8773522 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -1893,6 +1893,26 @@ static int start_tracer(int cpu)
 	return 0;
 }
 
+static int create_output_files(int cpu)
+{
+	char fname[MAXPATHLEN + 64];
+	struct list_head *p;
+	FILE *f;
+
+	__list_for_each(p, &devpaths) {
+		struct devpath *dpp = list_entry(p, struct devpath, head);
+
+		if (fill_ofname(fname, sizeof(fname), NULL, dpp->buts_name,
+				cpu))
+			return 1;
+		f = my_fopen(fname, "w+");
+		if (!f)
+			return 1;
+		fclose(f);
+	}
+	return 0;
+}
+
 static void start_tracers(void)
 {
 	int cpu, started = 0;
@@ -1900,8 +1920,16 @@ static void start_tracers(void)
 	size_t alloc_size = CPU_ALLOC_SIZE(max_cpus);
 
 	for (cpu = 0; cpu < max_cpus; cpu++) {
-		if (!CPU_ISSET_S(cpu, alloc_size, online_cpus))
+		if (!CPU_ISSET_S(cpu, alloc_size, online_cpus)) {
+			/*
+			 * Create fake empty output files so that other tools
+			 * like blkparse don't have to bother with sparse CPU
+			 * number space.
+			 */
+			if (create_output_files(cpu))
+				break;
 			continue;
+		}
 		if (start_tracer(cpu))
 			break;
 		started++;
-- 
2.10.2

