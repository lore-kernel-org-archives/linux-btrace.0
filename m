From: Stefan Raspl <raspl@linux.vnet.ibm.com>
Date: Tue, 19 May 2009 06:46:57 +0000
Subject: Re: [Patch] blktrace: remove debugfs entries on bad path
Message-Id: <4A1255E1.1060301@linux.vnet.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4A115BA5.6090905@linux.vnet.ibm.com> <4A1207DE.4000409@cn.fujitsu.com>
In-Reply-To: <4A1207DE.4000409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: linux-btrace@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Li Zefan wrote:
> A better title:
> 	[Patch] blktrace: remove debugfs entries on bad path
> 
> Stefan Raspl wrote:
>> debugfs directory entries for devices are not removed on bad path.
> 
> Can you be more elaborate on how to reproduce this issue?

It can happen for most bad pathes within do_blk_trace_setup(). One
way to trigger is to set the Vmalloc space via the respective kernel
parameter to a value that is so small that it will not suffice for
the 2MB per device and cpu that is required. For instance, set
vmallocM and start blktrace on a system with 2 cpus on 7 devices.
Depending on how much Vmalloc space is still free, the final 2 or 3
devices will fail with a message like this:

	BLKTRACESETUP(2) /dev/sdu failed: 5/Input/output error

Best regards,
Stefan Raspl
