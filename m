From: Gangadhar Mylapuram <gangadhar.m@gmail.com>
Date: Thu, 07 Jul 2011 12:57:08 +0000
Subject: Re: blktrace on my block device
Message-Id: <CAKVu3CMitvaLCb21XsiJAt7zOxM7UOADFMS6L44sU1do=SBa3A@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4E158201.3020907@tao.ma>
In-Reply-To: <4E158201.3020907@tao.ma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Thanks. yes, that is the reason. I just found that our block driver is
not using request queue because our device is flash memory.

-Gangadhar

On Thu, Jul 7, 2011 at 3:23 PM, Tao Ma <tm@tao.ma> wrote:
> On 07/07/2011 05:41 PM, Gangadhar Mylapuram wrote:
>> Hi,
>>
>> As for my understanding I no need to handle (BLKRESTART, BLKTRACESTOP,
>> BLKTRACESETUP ..) in my device ioctl handling. It is block l/O layer
>> which intercepts the
>> statistics and does the job.
>>
>> But for my device (not sda or hda), blktrace only show the Q events.
>> It is not showing even C (completed) events. Do I need to add the
>> support in my device ioctl handling code?
> These trace pointers are only recorded if they are met.
> So I guess the reason is that your device implements your own
> make_request_fn(So you can see 'Q' event) and no other trace point is
> met at all.
>
> Thanks,
> Tao
>
