From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 14 Mar 2008 11:58:03 +0000
Subject: Re: blktrace/relay/s390: Oops in subbuf_splice_actor
Message-Id: <20080314115802.GK17940@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080314084337.GA9436@schmichrtp.de.ibm.com>
In-Reply-To: <20080314084337.GA9436@schmichrtp.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christof Schmitt <christof.schmitt@de.ibm.com>
Cc: linux-btrace@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 14 2008, Christof Schmitt wrote:
> When i first setup blktrace on a s390 z/VM guest to trace to another
> system and then put some load on the disk traced, the system oopses in
> subbuf_splice_actor. The setup is as simple as
> 
> # blktrace -h tracehost -d /dev/sda
> # dd if=/dev/sda of=/dev/null
> 
> This is the stack trace from the current 2.6.25-rc5, i added
> noinline to subbuf_splice_actor, otherwise it will be inlined:
> 
> Unable to handle kernel pointer dereference at virtual kernel address 0000000000000000 
> Oops: 0004 [#1] PREEMPT SMP DEBUG_PAGEALLOC 
> Modules linked in: binfmt_misc vmur 
> CPU: 1 Not tainted 2.6.25-rc5 #10 
> Process blktrace (pid: 2655, task: 000000002bc38238, ksp: 000000002b0d79a8) 
> Krnl PSW : 0704100180000000 00000000000874e2 (subbuf_splice_actor+0x212/0x364) 
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:1 PM:0 EA:3 
> Krnl GPRS: 0a00000000000001 000000002b2bb000 0000000000001000 00000000000000c8 
>            0000000000001000 0000000000001000 0000000000000000 0000000000000200 
>            0000000000019000 0000000000000019 0000000000066fd8 000000002b0d79e8 
>            000003e040ed7938 0000000000000000 000000000008749e 000000002b0d79e8 
> Krnl Code: 00000000000874d4: e31050b00004       lg      %r1,176(%r5) 
>            00000000000874da: 1854               lr      %r5,%r4 
>            00000000000874dc: e3cc10000004       lg      %r12,0(%r12,%r1) 
>           >00000000000874e2: e3c320000024       stg    >%r12,0(%r3,%r2) 
>            00000000000874e8: e330b2700014       lgf     %r3,624(%r11) 
>            00000000000874ee: eb330004000d       sllg    %r3,%r3,4 
>            00000000000874f4: e320b2680004       lg      %r2,616(%r11) 
>            00000000000874fa: 1814               lr      %r1,%r4 
> Call Trace: 
> ([<000000000008749e>] subbuf_splice_actor+0x1ce/0x364) 
>  [<00000000000876a2>] relay_file_splice_read+0x6e/0xfc 
>  [<00000000000e4f90>] do_splice_to+0x9c/0xb4 
>  [<00000000000e545c>] splice_direct_to_actor+0xd8/0x21c 
>  [<00000000000e55ec>] do_splice_direct+0x4c/0x70 
>  [<00000000000bc2be>] do_sendfile+0x1b6/0x228 
>  [<00000000000bc382>] sys_sendfile64+0x52/0xe4 
>  [<00000000000241c0>] sysc_noemu+0x10/0x16 
>  [<00000200001304da>] 0x200001304da 
> 
> Some debug printks show that subbuf_pages in this case is 512 and the
> for loop goes until spd.nr_pages is 25, before hitting the problem. I
> am wondering if the numbers make sense here, since spd.pages has only
> 16 pages allocated (with PIPE_BUFFERS). But i did not yet understand
> how much data this loop is supposed to assign.

That is indeed a bug, does this work for you?

diff --git a/kernel/relay.c b/kernel/relay.c
index d080b9d..39d1fa8 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1066,7 +1066,7 @@ static int subbuf_splice_actor(struct file *in,
 			       unsigned int flags,
 			       int *nonpad_ret)
 {
-	unsigned int pidx, poff, total_len, subbuf_pages, ret;
+	unsigned int pidx, poff, total_len, subbuf_pages, nr_pages, ret;
 	struct rchan_buf *rbuf = in->private_data;
 	unsigned int subbuf_size = rbuf->chan->subbuf_size;
 	uint64_t pos = (uint64_t) *ppos;
@@ -1098,7 +1098,9 @@ static int subbuf_splice_actor(struct file *in,
 	pidx = (read_start / PAGE_SIZE) % subbuf_pages;
 	poff = read_start & ~PAGE_MASK;
 
-	for (total_len = 0; spd.nr_pages < subbuf_pages; spd.nr_pages++) {
+	nr_pages = min_t(unsigned int, subbuf_pages, PIPE_BUFFERS);
+
+	for (total_len = 0; spd.nr_pages < nr_pages; spd.nr_pages++) {
 		unsigned int this_len, this_end, private;
 		unsigned int cur_pos = read_start + total_len;
 

-- 
Jens Axboe

