From: Tao Ma <tm@tao.ma>
Date: Tue, 11 Jan 2011 08:12:15 +0000
Subject: Re: [PATCH] blkparse: Fix blktrace output pipe broken in the new
Message-Id: <4D2C10DF.3010907@tao.ma>
List-Id: <linux-btrace.vger.kernel.org>
References: <1294728486-5608-1-git-send-email-tm@tao.ma>
In-Reply-To: <1294728486-5608-1-git-send-email-tm@tao.ma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 01/11/2011 03:36 PM, Jens Axboe wrote:
> On 2011-01-11 07:48, Tao Ma wrote:
>> From: Tao Ma<boyu.mt@taobao.com>
>>
>> With the newest kernel(say 2.6.37, some older one should also have the
>> similar problem), some cfq messages are added to blktrace, so it makes
>> the old blkparse broken.
>>
>> See a simple example:
>> 1. blktrace /dev/sdb -o -|blkparse -i -
>> 2. Run the following command(/dev/sdb1 is mounted at /mnt/test_dir):
>> dd if=/mnt/test_dir/test of=/dev/null bs=4k count=1 iflag=direct
>>
>> There are only 2 lines of output there:
>>    8,16   0        1     0.000000000 13183  A   R 114759 + 8<- (8,17) 114696
>>    8,16   0        2     0.000000491 13183  Q   R 114759 + 8 [dd]
>>
>> And even we run a command line like:
>> for((i=0;i<100;i++))do dd if=/mnt/ocfs2/test of=/dev/null bs=4k count=1 iflag=direct;done
>> We are only given the same 2 lines of output.
>>
>> While the really one should look like:
>>    8,16   0        1     0.000000000 13319  A   R 114759 + 8<- (8,17) 114696
>>    8,16   0        2     0.000000376 13319  Q   R 114759 + 8 [dd]
>>    8,16   0        0     0.000005931     0  m   N cfq13319 alloced
>>    8,16   0        3     0.000006259 13319  G   R 114759 + 8 [dd]
>>    8,16   0        4     0.000007143 13319  P   N [dd]
>>    8,16   0        5     0.000007817 13319  I   R 114759 + 8 [dd]
>>    8,16   0        0     0.000008491     0  m   N cfq13319 insert_request
>>    8,16   0        0     0.000009029     0  m   N cfq13319 add_to_rr
>> ...
>>
>> The main reason is that in show_entries_rb, we test sequences every time,
>> but actually with some messages like cfq, the sequence number is always
>> 0 which makes the old sequence check refuses all the logs after it.
>> So only check/store sequence number if it isn't a message.
>
> Thanks for the patch with the nice and detailed description, I have
> applied it.
cool.
>
> But I'm curious, this is a 2.6.37 regression?
Oh, I don't have time to look back the git to see whether it is a 
regression or not. ;)

But it should be a compatible problem in blkparse and it should be a 
problem when we adds cfq tracing to the kernel, a very long time ago I 
guess. I just found this recently when I wanted to know more internals 
about the blktrace.

Regards,
Tao
