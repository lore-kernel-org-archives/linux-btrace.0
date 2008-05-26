From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 26 May 2008 17:05:25 +0000
Subject: Re: [RFC] Implement simple messages in blktrace stream
Message-Id: <20080526170524.GL7712@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <48372A83.9040204@hp.com>
In-Reply-To: <48372A83.9040204@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, May 26 2008, Carl Henrik Lunde wrote:
> On Fri, May 23, 2008 at 04:35:15PM -0400, Alan D. Brunelle wrote:
> > The following two patches (kernel + application) would allow one to
> > annotate parts of the blktrace stream w/ simple messages.
> > 
> > I've included a sample one for elevator switches:
> > 
> >   8,16   1   813055    20.259000000  4692  I   R 3088320 + 8 [dd]
> >   8,16   1   813056    20.259000000  4692  Q   R 3088328 + 8 [dd]
> >   8,16   1             20.259000000     0  m   N elv switch: deadline
> >   8,16   1   813057    20.259000000  4692  G   R 3088328 + 8 [dd]
> >   8,16   1   813058    20.259000000  4692  I   R 3088328 + 8 [dd]
> 
> Hmm, I sometimes use Python split() or awk to parse the output from
> blktrace.  Could we keep the same amount of parameters up to [mIQG..]?
> 
> > These patches are a bit rough (but compile, and appear to work ok so
> > far). In particular, I'd break the kernel patch into a blktrace addition
> > and an elevator switch addition, plus the application patch would need
> > documentation updates.
> > 
> > My nefarious ultimate goal would be to add in the ability for user-level
> > insertions for (e.g.):
> > 
> > 1. Start blktrace
> > 2. Do some stuff...
> > 3. Insert a tag "switching to other stuff"
> > 4. Do other stuff
> > 5. Insert a tag "switching to yet other stuff"
> > 6. Do yet other stuff
> > 
> > This way you could study different parts of the resultant traces using
> > the tags to separate them time-wise. [For now, I'd just switch
> > schedulers back and forth to see the separators.)
> > 
> > Looking for comments (hence the RFC).
> 
> I like the idea, I've added a similar feature to my own kernel, but only
> as a hack.  Defining this ABI would be nice.
> 
> 
> When I applied this patch to 2.6.26-rc3 and added a custom trace point
> using a jprobe I got some weird results, look at the time column:
> 
>   8,0    3      510     5.418563704  8895  I   R 588881520 + 24 [grep]
>   8,0    3      511     5.418564897  8895  D   R 588881520 + 24 [grep]
>   8,0    3      512     5.418613507  8895  U   N [grep] 1
>   8,0    3              6.554785394     0  m   N __cfq_slice_expired timed_out=1
>   8,0    6      506     5.418733743     0  C   R 588881520 + 24 [0]
>   8,0    6      507     5.418773493  8895  A   R 588868016 + 32 <- (8,5) 252127624
>   8,0    6      508     5.418773668  8895  Q   R 588868016 + 32 [grep]
>   8,0    6      509     5.418774478  8895  G   R 588868016 + 32 [grep]
>   8,0    6      510     5.418775305  8895  P   N [grep]
>   8,0    6      511     5.418775543  8895  I   R 588868016 + 32 [grep]
>   8,0    6      512     5.418776783  8895  D   R 588868016 + 32 [grep]
>   8,0    6              5.464497425     0  m   N __cfq_slice_expired timed_out=0
>   8,0    6              5.887160843     0  m   N __cfq_slice_expired timed_out=1
>   8,0    6              5.887165921     0  m   N __cfq_slice_expired timed_out=0
>   8,0    6      513     5.418825167  8895  U   N [grep] 1
>   8,0    5      498     5.418964604     0  C   R 588868016 + 32 [0]
>   8,0    5      499     5.419000075  8895  A   R 588868048 + 24 <- (8,5) 252127656
>   8,0    5      500     5.419000283  8895  Q   R 588868048 + 24 [grep]
> 
> Until now I haven't used anything newer than 2.6.24.7 and blktrace
> ae6d30f447518, so the issue may come from some unrelated change or perhaps
> even jprobes, I've never used them before...
> 
> I use mostly default configuration options except for HZ00.  I'll look
> into it later this week.

Does it work if you add something like this to trace_note()? Will need
to be refined as only the message calls really need to be sequenced, the
other trace notes (like process and time do not matter).

diff --git a/block/blktrace.c b/block/blktrace.c
index b2cbb4e..2824d11 100644
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -38,8 +38,10 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	t = relay_reserve(bt->rchan, sizeof(*t) + len);
 	if (t) {
 		const int cpu = smp_processor_id();
+		unsigned long *sequence = per_cpu_ptr(bt->sequence, cpu);
 
 		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+		t->sequence = ++(*sequence);
 		t->time = ktime_to_ns(ktime_get());
 		t->device = bt->dev;
 		t->action = action;

-- 
Jens Axboe

