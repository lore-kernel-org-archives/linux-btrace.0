From: Jan Blunck <jblunck@suse.de>
Date: Mon, 08 Dec 2008 21:52:14 +0000
Subject: [PATCH] blkparse: Track smallest sequence read per device
Message-Id: <20081208215214.GS14520@bolzano.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When running

 blktrace -d /dev/sda -o - | ./blkparse -i -

only a few traces are actually printed out on stdout. Most of the traces are
queued up and only after hitting ^C and therefore forcing show_entries_rb()
they are printed out. I noticed that once pci->smallest_seq_read is zero,
check_sequence always returns 1:

static int check_sequence(struct per_dev_info *pdi, struct trace *t, int
        force)
{
        ...

        if (expected_sequence < pci->smallest_seq_read) {
                __t = trace_rb_find_last(pdi, pci, expected_sequence);
                if (!__t)
                        goto skip;

                __put_trace_last(pdi, __t);
                return 0;
        } else if (!force) {
                return 1;

       ...
}

This patch fixes the problem by using a variable per device to keep track of
the smallest sequence read on each cpu.

Signed-off-by: Jan Blunck <jblunck@suse.de>
-- 
diff --git a/blkparse.c b/blkparse.c
index d869da6..a558a6d 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -58,6 +58,8 @@ struct per_dev_info {
 	unsigned int max_depth[2];
 	unsigned int cur_depth[2];
 
+	unsigned long smallest_seq_read;
+
 	struct rb_root rb_track;
 
 	int nfiles;
@@ -395,6 +397,7 @@ static struct per_dev_info *get_dev_info(dev_t dev)
 	pdi->dev = dev;
 	pdi->first_reported_time = 0;
 	pdi->last_read_time = 0;
+	pdi->smallest_seq_read = -1UL;
 
 	return pdi;
 }
@@ -1899,10 +1902,14 @@ static int sort_entries(unsigned long long *youngest)
 	struct per_dev_info *pdi = NULL;
 	struct per_cpu_info *pci = NULL;
 	struct trace *t;
+	int i;
 
 	if (!genesis_time)
 		find_genesis();
 
+	for (i = 0; i < ndevices; i++)
+		devices[i].smallest_seq_read = -1UL;
+
 	*youngest = 0;
 	while ((t = trace_list) != NULL) {
 		struct blk_io_trace *bit = t->bit;
@@ -1922,8 +1929,8 @@ static int sort_entries(unsigned long long *youngest)
 		if (!pci || pci->cpu != bit->cpu)
 			pci = get_cpu_info(pdi, bit->cpu);
 
-		if (bit->sequence < pci->smallest_seq_read)
-			pci->smallest_seq_read = bit->sequence;
+		if (bit->sequence < pdi->smallest_seq_read)
+			pdi->smallest_seq_read = bit->sequence;
 
 		if (check_stopwatch(bit)) {
 			bit_free(bit);
@@ -1994,7 +2001,7 @@ static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 		 */
 		if (bit->sequence = 1)
 			return 0;
-		if (bit->sequence = pci->smallest_seq_read)
+		if (bit->sequence = pdi->smallest_seq_read)
 			return 0;
 
 		return check_cpu_map(pdi);
@@ -2007,7 +2014,7 @@ static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 	 * we may not have seen that sequence yet. if we are not doing
 	 * the final run, break and wait for more entries.
 	 */
-	if (expected_sequence < pci->smallest_seq_read) {
+	if (expected_sequence < pdi->smallest_seq_read) {
 		__t = trace_rb_find_last(pdi, pci, expected_sequence);
 		if (!__t)
 			goto skip;
@@ -2535,10 +2542,6 @@ static void do_pipe(int fd)
 	fdblock = -1;
 	while ((events = read_events(fd, 0, &fdblock)) > 0) {
 		read_sequence++;
-	
-#if 0
-		smallest_seq_read = -1U;
-#endif
 
 		if (sort_entries(&youngest))
 			break;
