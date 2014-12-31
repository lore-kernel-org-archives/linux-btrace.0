From: Chris Mason <clm@fb.com>
Date: Wed, 31 Dec 2014 14:58:24 +0000
Subject: Re: Events out of order
Message-Id: <1420037904.2705.0@mail.thefacebook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Wed, Dec 31, 2014 at 9:36 AM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/30/2014 11:29 PM, Alireza Haghdoost wrote:
>>  Seems to me like you don't run blktrace and blkparse
>>  appropriately. blktrace stores IO trace in multiple files where
>>  each file is associated to a CPU core. However, you force the
>>  output of blktrace to redirect into a single file. This make some
>>  timing Confusion for blkparse in the next step. You are using live
>>  blkparse option (-i -) inappropriately. If you want to run live
>>  blkparse, you need to feed it through blktrace pipe. Like:
>>  #blktrace -d /dev/sda -o - | blkparse -i -
>> 
>>  If you want to store trace in a file then parse it offline, you
>>  need to use --input option of blkparse.
> 
> Whether it is piped directly, or buffered in a file on disk makes no
> difference; blkparse sees exactly the same input byte for byte, and
> produces the same output.  The man page recommends this interactive
> method and doesn't mention that it borks up the ordering, but I
> suppose I can try it the other way and see if that helps.  If the
> interactive method doesn't work correctly it should either be fixed or
> the man page should mention this and not recommend its use.

It's been a while since I looked at this, but looks like blkparse has a 
pipeline mode and a more exact mode.  In pipeline mode, it's really 
trying to get data to the screen quickly and without using a huge 
amount of resources.  In order to put things in order, it would need to 
buffer the entire stream before outputting anything.  So instead it 
works in chunks, which is what you're seeing.

It enables pipeline mode when the input file from -i is a pipe.  You'll 
get better results if you allow blktrace to output into a collection of 
files and pass the prefix to blkparse.

instead of blktrace -o - use blktrace -o prefix ; blkparse -i prefix

For multiple devices, iowatcher uses a directory to store all of them, 
which is easier.

If you really want a single file result, take the per-cpu files from 
blktrace, run them through blkparse and add -d dumpfile, which will 
sort and pack all the results into a single binary file.  It's 
compressable and you can then delete all the per-cpu files.

-chris



