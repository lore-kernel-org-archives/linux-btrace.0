From: Brandon Schwartz <schwartz.xn@gmail.com>
Date: Wed, 22 Apr 2015 23:35:35 +0000
Subject: Re: Capturing idle time with blktrace
Message-Id: <CADAGN7UYdpd_gQWK4fGWFJnhJE8R+t1G6r_JxP-8v=LsnZtKYw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CADAGN7WfwEdxivADLsei2KKVvzybzpFLpHqKMwZEd3TQ4nQ78g@mail.gmail.com>
In-Reply-To: <CADAGN7WfwEdxivADLsei2KKVvzybzpFLpHqKMwZEd3TQ4nQ78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Ah, I think it was an issue with the version of FIO I was using.
Running 2.1.4 did not replay the blktrace properly and would ignore
the idle time between jobs.  I pulled 2.2.7 and it seems to be working
as expected, accurately including the idle time.

Regards,
Brandon

On Wed, Apr 22, 2015 at 4:51 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 04/22/2015 02:53 PM, Brandon Schwartz wrote:
>>
>> And by blkreplay, I meant replay the blktrace with FIO
>>
>> On Wed, Apr 22, 2015 at 2:52 PM, Brandon Schwartz <schwartz.xn@gmail.com>
>> wrote:
>>>
>>> Is there an accurate way to capture idle time with blktrace?  For
>>> example, if I run/trace the following FIO script:
>>>
>>> [global]
>>> direct=1
>>> ioengine=libaio
>>> readwrite=read
>>> blocksizeQ2k
>>> filename=/dev/sdd
>>>
>>> [read]
>>> runtime
>>> name=read
>>>
>>> [read2]
>>> stonewall=1
>>> startdelay@
>>> runtime
>>> name=read2
>>>
>>> And attempt to replay it using blkreplay, it will ignore the wait time
>>> and simply read for 20seconds instead of read 10s, wait for 40s, read
>>> 10s.
>
>
>
> replay_no_stall=1
>
> --
> Jens Axboe
>
