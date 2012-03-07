From: Josh Hunt <joshhunt00@gmail.com>
Date: Wed, 07 Mar 2012 20:50:56 +0000
Subject: Re: blkparse unplug question
Message-Id: <CAKA=qzajNybDKYu4AQU0QeMfFA1xaxK+CRNjgZQn3wAuw4=QMg@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAKA=qzaR2FryEq6uG299SzH14=BQVShnRvDSie0XRpwijBFsRg@mail.gmail.com>
In-Reply-To: <CAKA=qzaR2FryEq6uG299SzH14=BQVShnRvDSie0XRpwijBFsRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Vasily

Thanks for the response. I apologize, but can you easily explain or
point me in the direction of some documentation describing the
difference b/t the plug queue and the io queue? In my observation of
the blktrace log, the # of requests appears to be going up in my case,
before eventually (I guess) those requests get flushed to the device.
When I set slice_idle to 0 for CFQ I never see these #s getting above
1. I'm just trying to better understand how changing this value is
causing the requests to apparently get flushed from the io queue
faster (or seemingly so.)

I thought about using debugfs for the block->inode lookup but wasn't
sure. Thanks!

Josh

On Wed, Mar 7, 2012 at 12:09 PM, Vasily Tarasov <tarasov@vasily.name> wrote:
> The value after the process name ("31" in your trace snip) is the
> number of requests flushed from the plug queue to the I/O queue during
> the unplug.
>
> To identify which inode a block belongs to you can try to use file
> system specific utils: e.g., xfs_bmap for xfs, debugfs for ext2/3.
> Also there are FIBMAP and FIEMAP ioctls that can help you. Another
> ways is to instrument your file system's code to produce a trace/map
> of blocks; well, if you have time for that ;)
>
> HTH,
> Vasily
>
> On Wed, Mar 7, 2012 at 10:06 AM, Josh Hunt <joshhunt00@gmail.com> wrote:
>> I am trying to debug a stall I am seeing with CFQ and in the
>> blktrace/blkparse output I see unplugging lines like the following:
>>
>> 8,3 =A0 =A01 =A0 =A0 7809 =A01532.225997730 =A0 168 =A0U =A0 N [sync_sup=
ers] 31
>>
>> My question is what does the value after the process name represent? I
>> see this value increasing from 1, I believe, and then eventually the
>> value appears to get reset.
>>
>> I was also wondering if it is possible to translate the block
>> information provided in blktrace to the corresponding inode?
>>
>> Thanks for your help!
>> Josh
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrace" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>



--=20
Josh
