From: Li Zefan <lizf@cn.fujitsu.com>
Date: Tue, 14 Apr 2009 08:53:41 +0000
Subject: Re: PATCH 1/3] blktrace: support per-partition tracing
Message-Id: <49E44F15.9030906@cn.fujitsu.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <49E42620.4050701@cn.fujitsu.com> <20090414080919.GB27003@elte.hu> <49E448F6.5010506@cn.fujitsu.com> <20090414083856.GF27003@elte.hu>
In-Reply-To: <20090414083856.GF27003@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tzanussi@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Shawn Du <duyuyang@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-btrace@vger.kernel.org

>>> Lets note that this approach still has the (long existing) 
>>> limitation that only one device can be block-traced at a time.
>>>
>> No, both userspace blktrace and ftrace-plugin trace can trace
>> more than one device at a time.
>>
>>  # btrace /dev/sda /dev/dm-0
>>
>> or
>>
>>  # echo 1 > /sys/block/sda/trace/enable
>>  # echo 1 > /sys/block/dm-0/trace/enable
> 
> When they are independent - but not multiple partitions at a time:
> 

The only way to trace multipl partitions is to trace the whole
sda, or set trace/start_lsa and trace/end_lsa properly.

>  [root@aldebaran ~]# echo 1 > /sys/block/sda/sda1/trace/enable 
>  [root@aldebaran ~]# echo 1 > /sys/block/sda/sda2/trace/enable 
>  -bash: echo: write error: Device or resource busy

That's because struct blk_trace is attached to struct request_queue,
sda1 and sda2 share the same rq:

  # echo 1 > /sys/block/sda/sda1/trace/enable 
  # cat /sys/block/sda/sda1/trace/enable 
  1
  # cat /sys/block/sda/sda2/trace/enable 
  1

>  [root@aldebaran ~]#
> 
> Nor did i see any "trace all block IO in the system" kind of 
> functionality in blktrace. (or maybe there's one that i missed?)
> 

Right, and the only way to do this is 'blktrace sda sdb sdc ...'
