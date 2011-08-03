From: Jens Axboe <jaxboe@fusionio.com>
Date: Wed, 03 Aug 2011 13:06:42 +0000
Subject: Re: [patch,resend] blkparse: fix up incorrect pc write completion
Message-Id: <4E3947E2.2040508@fusionio.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <x49y5zbso36.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49y5zbso36.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2011-08-02 19:46, Jeff Moyer wrote:
> Hi,
> 
> I noticed in some traces that I was seeing summaries like the following:
> 
> Total (sde):
>  Reads Queued:          76,      304KiB  Writes Queued:      16,384,    1,048MiB
>  Read Dispatches:       76,      304KiB  Write Dispatches:    2,210,    1,048MiB
>  Reads Requeued:         0               Writes Requeued:         0
>  Reads Completed:       76,      304KiB  Writes Completed:    2,210,    1,048MiB
>  Read Merges:            0,        0KiB  Write Merges:       14,174,  907,136KiB
>  PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
>  PC Read Disp.:          4,        0KiB  PC Write Disp.:          0,        0KiB
>  PC Reads Req.:          0               PC Writes Req.:          0
>  PC Reads Compl.:        4               PC Writes Compl.:    2,210
>  IO unplugs:         2,124               Timer unplugs:           0
> 
> Note how there were no PC Writes dispatched, but there were 2210
> completed.  It turns out to be a minor typo in the code.  The attached
> patch fixes the reporting for me.
> 
> Cheers,
> Jeff
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> ---
> 
> Jens, any reason this hasn't been merged?

Nope, thanks for the resend (and the fix) - applied!

-- 
Jens Axboe

