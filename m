From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Thu, 23 Apr 2015 02:54:00 +0000
Subject: Re: Capturing idle time with blktrace
Message-Id: <CAB-428m4V771GCHJDUzUQMixFXNWFnF-T+GZv2=4c6OmLMvA6w@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CADAGN7WfwEdxivADLsei2KKVvzybzpFLpHqKMwZEd3TQ4nQ78g@mail.gmail.com>
In-Reply-To: <CADAGN7WfwEdxivADLsei2KKVvzybzpFLpHqKMwZEd3TQ4nQ78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

It should be capable to do that. Report your issue if you find out it
does not do the job. Capture your fio workload with blktrace, then run
captured traces through btrecord with small -m value and finally
replay back with btreplay.... Not sure how replay is useful in this
case when you do have access to fio to generate the same IO workload
for you.

On Wed, Apr 22, 2015 at 3:53 PM, Brandon Schwartz <schwartz.xn@gmail.com> wrote:
> And by blkreplay, I meant replay the blktrace with FIO
>
> On Wed, Apr 22, 2015 at 2:52 PM, Brandon Schwartz <schwartz.xn@gmail.com> wrote:
>> Is there an accurate way to capture idle time with blktrace?  For
>> example, if I run/trace the following FIO script:
>>
>> [global]
>> direct=1
>> ioengine=libaio
>> readwrite=read
>> blocksizeQ2k
>> filename=/dev/sdd
>>
>> [read]
>> runtime
>> name=read
>>
>> [read2]
>> stonewall=1
>> startdelay@
>> runtime
>> name=read2
>>
>> And attempt to replay it using blkreplay, it will ignore the wait time
>> and simply read for 20seconds instead of read 10s, wait for 40s, read
>> 10s.
>>
>> Regards,
>> Brandon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
