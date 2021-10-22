From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 22 Oct 2021 12:00:01 +0000
Subject: Recent changes (master)
Message-Id: <20211022120001.8949A1BC0126@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20130320050001.E340522DFC@kernel.dk>
In-Reply-To: <20130320050001.E340522DFC@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

The following changes since commit 3a1b1366d30375cdb0f5b299df4edda0c8ba3bcc:

  blktrace: exit directly when nthreads_running != ncpus in run_tracers() (2021-06-28 13:41:32 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 7f5d2c5173d72018aa29c583c9291ef10abaf8df:

  blkparse: fix incorrectly sized memset in check_cpu_map (2021-10-21 08:45:17 -0600)

----------------------------------------------------------------
Jeff Mahoney (2):
      blkparse: skip check_cpu_map with pipe input
      blkparse: fix incorrectly sized memset in check_cpu_map

 blkparse.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index f88204a..9d2029a 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2229,11 +2229,14 @@ static int check_cpu_map(struct per_dev_info *pdi)
 	unsigned int i;
 	int ret, cpu;
 
+	/* Pipe input doesn't do CPU online tracking. */
+	if (!pdi->cpu_map_max)
+		return 0;
+
 	/*
 	 * create a map of the cpus we have traces for
 	 */
-	cpu_map = malloc(pdi->cpu_map_max / sizeof(long));
-	memset(cpu_map, 0, sizeof(*cpu_map));
+	cpu_map = calloc(1, pdi->cpu_map_max / sizeof(long));
 	n = rb_first(&rb_sort_root);
 	while (n) {
 		__t = rb_entry(n, struct trace, rb_node);
