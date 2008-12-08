From: Jan Blunck <jblunck@suse.de>
Date: Mon, 08 Dec 2008 15:37:28 +0000
Subject: [PATCH] blkparse: Globally track smallest sequence read
Message-Id: <20081208153727.GN14520@bolzano.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

When running

 blktrace -d /dev/sda -o - | ./blkparse -i -

Only a few traces are actually dumped to stdout. Most of the traces are
stored up and printed only after hitting ^C by forcing show_entries_rb() to
print them out. I noticed that once pci->smallest_seq_read is zero
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

Here is a patch to fix this. It uses a global variable to keep track of the
smallest sequence read yet on any cpu.

Comments?

Cheers,
Jan

-- 
diff --git a/blkparse.c b/blkparse.c
index d869da6..f70cd1b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -262,6 +262,7 @@ static unsigned long long last_allowed_time;
 static unsigned long long stopwatch_start;	/* start from zero by default */
 static unsigned long long stopwatch_end = -1ULL;	/* "infinity" */
 static unsigned long read_sequence;
+static unsigned long smallest_seq_read;
 
 static int per_process_stats;
 static int per_device_and_cpu_stats = 1;
@@ -1922,8 +1923,8 @@ static int sort_entries(unsigned long long *youngest)
 		if (!pci || pci->cpu != bit->cpu)
 			pci = get_cpu_info(pdi, bit->cpu);
 
-		if (bit->sequence < pci->smallest_seq_read)
-			pci->smallest_seq_read = bit->sequence;
+		if (bit->sequence < smallest_seq_read)
+			smallest_seq_read = bit->sequence;
 
 		if (check_stopwatch(bit)) {
 			bit_free(bit);
@@ -1994,7 +1995,7 @@ static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 		 */
 		if (bit->sequence = 1)
 			return 0;
-		if (bit->sequence = pci->smallest_seq_read)
+		if (bit->sequence = smallest_seq_read)
 			return 0;
 
 		return check_cpu_map(pdi);
@@ -2007,7 +2008,7 @@ static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 	 * we may not have seen that sequence yet. if we are not doing
 	 * the final run, break and wait for more entries.
 	 */
-	if (expected_sequence < pci->smallest_seq_read) {
+	if (expected_sequence < smallest_seq_read) {
 		__t = trace_rb_find_last(pdi, pci, expected_sequence);
 		if (!__t)
 			goto skip;
@@ -2535,10 +2536,7 @@ static void do_pipe(int fd)
 	fdblock = -1;
 	while ((events = read_events(fd, 0, &fdblock)) > 0) {
 		read_sequence++;
-	
-#if 0
 		smallest_seq_read = -1U;
-#endif
 
 		if (sort_entries(&youngest))
 			break;
