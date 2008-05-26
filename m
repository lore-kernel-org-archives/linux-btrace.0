From: Carl Henrik Lunde <chlunde@ping.uio.no>
Date: Mon, 26 May 2008 18:45:35 +0000
Subject: Re: [RFC] Implement simple messages in blktrace stream
Message-Id: <20080526184535.GA22466@ping.uio.no>
List-Id: <linux-btrace.vger.kernel.org>
References: <48372A83.9040204@hp.com>
In-Reply-To: <48372A83.9040204@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, May 26, 2008 at 07:05:25PM +0200, Jens Axboe wrote:
> On Mon, May 26 2008, Carl Henrik Lunde wrote:
> > On Fri, May 23, 2008 at 04:35:15PM -0400, Alan D. Brunelle wrote:
> > > The following two patches (kernel + application) would allow one to
> > > annotate parts of the blktrace stream w/ simple messages.
[...]
> > When I applied this patch to 2.6.26-rc3 and added a custom trace point
> > using a jprobe I got some weird results, look at the time column:
> > 
> >   8,0    3      510     5.418563704  8895  I   R 588881520 + 24 [grep]
> >   8,0    3      511     5.418564897  8895  D   R 588881520 + 24 [grep]
> >   8,0    3      512     5.418613507  8895  U   N [grep] 1
> >   8,0    3              6.554785394     0  m   N __cfq_slice_expired timed_out=1
> >   8,0    6      506     5.418733743     0  C   R 588881520 + 24 [0]
> >   8,0    6      507     5.418773493  8895  A   R 588868016 + 32 <- (8,5) 252127624
> >   8,0    6      508     5.418773668  8895  Q   R 588868016 + 32 [grep]
> >   8,0    6      509     5.418774478  8895  G   R 588868016 + 32 [grep]
> >   8,0    6      510     5.418775305  8895  P   N [grep]
> >   8,0    6      511     5.418775543  8895  I   R 588868016 + 32 [grep]
> >   8,0    6      512     5.418776783  8895  D   R 588868016 + 32 [grep]
> >   8,0    6              5.464497425     0  m   N __cfq_slice_expired timed_out=0
> >   8,0    6              5.887160843     0  m   N __cfq_slice_expired timed_out=1
> >   8,0    6              5.887165921     0  m   N __cfq_slice_expired timed_out=0
> >   8,0    6      513     5.418825167  8895  U   N [grep] 1
> >   8,0    5      498     5.418964604     0  C   R 588868016 + 32 [0]
> >   8,0    5      499     5.419000075  8895  A   R 588868048 + 24 <- (8,5) 252127656
> >   8,0    5      500     5.419000283  8895  Q   R 588868048 + 24 [grep]
> > 
> > Until now I haven't used anything newer than 2.6.24.7 and blktrace
> > ae6d30f447518, so the issue may come from some unrelated change or perhaps
> > even jprobes, I've never used them before...
> > 
> > I use mostly default configuration options except for HZ00.  I'll look
> > into it later this week.
> 
> Does it work if you add something like this to trace_note()? Will need
> to be refined as only the message calls really need to be sequenced, the
> other trace notes (like process and time do not matter).
> 
> diff --git a/block/blktrace.c b/block/blktrace.c
> index b2cbb4e..2824d11 100644
> --- a/block/blktrace.c
> +++ b/block/blktrace.c
> @@ -38,8 +38,10 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
>  	t = relay_reserve(bt->rchan, sizeof(*t) + len);
>  	if (t) {
>  		const int cpu = smp_processor_id();
> +		unsigned long *sequence = per_cpu_ptr(bt->sequence, cpu);
>  
>  		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
> +		t->sequence = ++(*sequence);
>  		t->time = ktime_to_ns(ktime_get());
>  		t->device = bt->dev;
>  		t->action = action;
> 

That did not work, but this (on top of the original patch) does seem to work

diff --git a/blkparse.c b/blkparse.c
index 09a77f6..a34516e 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -597,11 +597,10 @@ static void handle_notify(struct blk_io_trace *bit)
 			memcpy(msg, (char *)payload, bit->pdu_len);
 			msg[bit->pdu_len] = '\0';
 
-			bit->time -= genesis_time;
 			fprintf(ofp,
 				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
 				MAJOR(bit->device), MINOR(bit->device),
-				bit->cpu, "", (int) SECONDS(bit->time),
+				bit->cpu, "0", (int) SECONDS(bit->time),
 				(unsigned long) NANO_SECONDS(bit->time),
 				0, "m", "N", msg);
 		}
@@ -1594,7 +1593,9 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
-		if (t->action & BLK_TC_ACT(BLK_TC_PC))
+		if (t->action = BLK_TN_MESSAGE)
+			handle_notify(t);
+		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
 			dump_trace_pc(t, pdi, pci);
 		else
 			dump_trace_fs(t, pdi, pci);
@@ -2193,7 +2194,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		/*
 		 * not a real trace, so grab and handle it here
 		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY)) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			continue;
@@ -2336,7 +2337,7 @@ static int ms_prime(struct ms_stream *msp)
 		if (verify_trace(bit))
 			goto err;
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY)) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);

-- 
Carl Henrik
