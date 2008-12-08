From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 08 Dec 2008 18:59:53 +0000
Subject: Re: [PATCH] blkparse: Globally track smallest sequence read
Message-Id: <20081208185953.GM23742@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20081208153727.GN14520@bolzano.suse.de>
In-Reply-To: <20081208153727.GN14520@bolzano.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Dec 08 2008, Jan Blunck wrote:
> When running
> 
>  blktrace -d /dev/sda -o - | ./blkparse -i -
> 
> Only a few traces are actually dumped to stdout. Most of the traces are
> stored up and printed only after hitting ^C by forcing show_entries_rb() to
> print them out. I noticed that once pci->smallest_seq_read is zero
> check_sequence always returns 1:
> 
> static int check_sequence(struct per_dev_info *pdi, struct trace *t, int
>         force)
> {
>         ...
> 
>         if (expected_sequence < pci->smallest_seq_read) {
>                 __t = trace_rb_find_last(pdi, pci, expected_sequence);
>                 if (!__t)
>                         goto skip;
> 
>                 __put_trace_last(pdi, __t);
>                 return 0;
>         } else if (!force) {
>                 return 1;
> 
>        ...
> }
> 
> Here is a patch to fix this. It uses a global variable to keep track of the
> smallest sequence read yet on any cpu.

Shouldn't this be stored in the per-device info - IOW, the smallest
sequence read yet on this device on any CPU?

-- 
Jens Axboe

