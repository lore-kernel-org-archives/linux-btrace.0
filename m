From: Li Zefan <lizf@cn.fujitsu.com>
Date: Tue, 19 May 2009 07:07:54 +0000
Subject: Re: [Patch] blktrace: remove debugfs entries on bad path
Message-Id: <4A125ACA.5080107@cn.fujitsu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4A115BA5.6090905@linux.vnet.ibm.com> <4A1207DE.4000409@cn.fujitsu.com> <4A1255E1.1060301@linux.vnet.ibm.com>
In-Reply-To: <4A1255E1.1060301@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raspl@linux.vnet.ibm.com
Cc: linux-btrace@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Stefan Raspl wrote:
> Li Zefan wrote:
>> A better title:
>> 	[Patch] blktrace: remove debugfs entries on bad path
>>
>> Stefan Raspl wrote:
>>> debugfs directory entries for devices are not removed on bad path.
>> Can you be more elaborate on how to reproduce this issue?
> 
> It can happen for most bad pathes within do_blk_trace_setup(). One

Now I see what you meant by "bad path". :)

I'd say "some failure pathes", but not "most".

> way to trigger is to set the Vmalloc space via the respective kernel
> parameter to a value that is so small that it will not suffice for
> the 2MB per device and cpu that is required. For instance, set
> vmallocM and start blktrace on a system with 2 cpus on 7 devices.
> Depending on how much Vmalloc space is still free, the final 2 or 3
> devices will fail with a message like this:
> 
> 	BLKTRACESETUP(2) /dev/sdu failed: 5/Input/output error
> 

Yes, this can happen under extreme memory stress.

Thanks for the fix:
	Acked-by: Li Zefan <lizf@cn.fujitsu.com>

Could you resend the patch to Ingo, with a better title and a better
changelog (but IMHO we don't need to explain how to set up a memory
stress to trigger this issue) and my ack tag? Now blktrace patches
go to Ingo.

