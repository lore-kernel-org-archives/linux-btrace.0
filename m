From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Dec 2014 15:19:51 +0000
Subject: Re: Events out of order
Message-Id: <54A41417.9000501@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 12/31/2014 08:09 AM, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 12/31/2014 9:58 AM, Chris Mason wrote:
>> It's been a while since I looked at this, but looks like blkparse
>> has a pipeline mode and a more exact mode.  In pipeline mode, it's
>> really trying to get data to the screen quickly and without using a
>> huge amount of resources.  In order to put things in order, it
>> would need to buffer the entire stream before outputting anything.
>> So instead it works in chunks, which is what you're seeing.
>
> Makes sense; it would be nice if the man page mentioned this drawback.
>
>> It enables pipeline mode when the input file from -i is a pipe.
>> You'll get better results if you allow blktrace to output into a
>> collection of files and pass the prefix to blkparse.
>>
>> instead of blktrace -o - use blktrace -o prefix ; blkparse -i
>> prefix
>>
>> For multiple devices, iowatcher uses a directory to store all of
>> them, which is easier.
>>
>> If you really want a single file result, take the per-cpu files
>> from blktrace, run them through blkparse and add -d dumpfile, which
>> will sort and pack all the results into a single binary file.  It's
>> compressable and you can then delete all the per-cpu files.
>
> Thanks; I thought I read something like that at one point but couldn't
> find it in the man page last night.

What Chris writes is completely correct. Pre-process the per-cpu files 
and use that binary sorted trace file for the inspection (or replay) tools.

BTW, the behavior is documented in the README:

----

If you want to do live tracing, you can pipe the data between blktrace 
and blkparse:

% blktrace -d <device> -o - | blkparse -i -
 

This has a small risk of displaying some traces a little out of sync, 
since it will do batch sorts of input events.

----

But I agree, would not hurt to put this in the man pages too.

-- 
Jens Axboe

