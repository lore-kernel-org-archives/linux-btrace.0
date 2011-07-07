From: Tao Ma <tm@tao.ma>
Date: Thu, 07 Jul 2011 09:53:05 +0000
Subject: Re: blktrace on my block device
Message-Id: <4E158201.3020907@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 07/07/2011 05:41 PM, Gangadhar Mylapuram wrote:
> Hi,
> 
> As for my understanding I no need to handle (BLKRESTART, BLKTRACESTOP,
> BLKTRACESETUP ..) in my device ioctl handling. It is block l/O layer
> which intercepts the
> statistics and does the job.
> 
> But for my device (not sda or hda), blktrace only show the Q events.
> It is not showing even C (completed) events. Do I need to add the
> support in my device ioctl handling code?
These trace pointers are only recorded if they are met.
So I guess the reason is that your device implements your own
make_request_fn(So you can see 'Q' event) and no other trace point is
met at all.

Thanks,
Tao
