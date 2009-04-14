From: Li Zefan <lizf@cn.fujitsu.com>
Date: Tue, 14 Apr 2009 08:27:34 +0000
Subject: Re: PATCH 1/3] blktrace: support per-partition tracing
Message-Id: <49E448F6.5010506@cn.fujitsu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <49E42620.4050701@cn.fujitsu.com> <20090414080919.GB27003@elte.hu>
In-Reply-To: <20090414080919.GB27003@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tzanussi@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Shawn Du <duyuyang@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org

Ingo Molnar wrote:
> * Li Zefan <lizf@cn.fujitsu.com> wrote:
> 
>> From: Shawn Du <duyuyang@gmail.com>
>>
>> Though one can specify '-d /dev/sda1' when using blktrace, it 
>> still traces the whole sda.
>>
>> To support per-partition tracing, when we start tracing, we 
>> initialize bt->start_lba and bt->end_lba to the start and end 
>> sector of that partition.
>>
>> Note some actions are per device, thus we don't filter 0-sector 
>> events.
>>
>> The original patch and discussion can be found here:
>> 	http://marc.info/?l=linux-btrace&m2949374214540&w=2
>>
>> Signed-off-by: Shawn Du <duyuyang@gmail.com>
>> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> 
> Thanks - beyond the small detail i mailed about a few minutes ago 
> the series looks good: i'll queue this up in tracing/blktrace unless 
> Jens has second thoughts.
> 
> Lets note that this approach still has the (long existing) 
> limitation that only one device can be block-traced at a time.
> 

No, both userspace blktrace and ftrace-plugin trace can trace
more than one device at a time.

 # btrace /dev/sda /dev/dm-0

or

 # echo 1 > /sys/block/sda/trace/enable
 # echo 1 > /sys/block/dm-0/trace/enable

> Furthermore, various other aspects of act_log_check() itself could 
> be expressed in terms of per tracepoint filters as well: the PID 
> filter field for example - which is supported in the ioctl ABI but 
> currently not exposed in the user-space blktrace utility. Same goes 
> for the action mask which is frequently used.
> 

Actually action mask can be specified by 'blktrace -a/-A mask/mask_name'

But yes the pid filter is not exposed in user-space blktrace.

> But before we can lift all these limitations and can have equivalent 
> functionality in the generic event tracer we still need more filter 
> engine infrastructure work (range operators and dev_t field 
> support). Plus TRACE_EVENT() based blk tracepoints.
> 
> Once we have that, the conversion will be straightforward: all 
> existing filter functionality of blktrace is static, so it will map 
> directly to new-style filter expressions. That will give us block 
> tracing for an arbitrary number of block devices (including the 
> basic mode of 'trace all block IO in the system') and a much wider 
> range of filtering capabilities.
> 
> Thanks,
> 
> 	Ingo
> 
> 
