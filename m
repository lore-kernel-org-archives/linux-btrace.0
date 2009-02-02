From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Mon, 02 Feb 2009 20:53:44 +0000
Subject: Re: -b vs. -n
Message-Id: <49875D58.8090403@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <49821F8D.4050207@hp.com>
In-Reply-To: <49821F8D.4050207@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Alan D. Brunelle wrote:
> Alan D. Brunelle wrote:
>> Jens Axboe wrote:
>>> On Thu, Jan 29 2009, Alan D. Brunelle wrote:
>>>> Has anybody experimented with increasing the _number_ of buffers rather
>>>> than the _size_ of the buffers when confronted with drops? I'm finding
>>>> on a large(ish) system that it is better to have lots of small buffers
>>>> handled by relay rather than fewer larger buffers. In my particular case:
>>>>
>>>> 16 CPUs
>>>> 96 devices
>>>> running some dd's against all the devices...
>>>>
>>>> -b 1024 or -b 2048 still results in drops
>>>>
>>>> but:
>>>>
>>>> -n 512 -b 16 allows things to run smoother.
>>>>
>>>> I _think_ this may have to do with the way relay reports POLLIN: it does
>>>> it only when a buffer switch happens as opposed to when there is data
>>>> ready. Need to look at this some more, but just wondering if others out
>>>> there have found similar things in their testing...
>>> That's interesting. The reason why I exposed both parameters was mainly
>>> that I didn't have the equipment to do adequate testing on what would be
>>> the best setup for this. So perhaps we can change the README to reflect
>>> that it is usually better to bump the number of buffers instead of the
>>> size, if you run into overflow problems?
>>>
>> It's not clear - still running tests. [I know for SMALLER numbers of
>> disks increasing the buffers has worked just fine.] I'm still fighting
>> (part time) with version 2.0 of blktrace, so _that_ may have something
>> to do with it! :-)
>>
>> Alan
> 
> Did some testing over the weekend: purposefully "bad" set up:
> 
> o  48 FC disks having Ext2 file systems created on them (I've found mkfs
> really stresses systems :-) )
> o  5 CCISS disks in LVM w/ an XFS file system used to capture the traces.
> 
> I then did 30 passes for a select set of permutations of -n & -b
> parameters. Here's the averages:
> 
>   -b    4     8    16    32    64   128   256   512  1024  2048  4096
> -n  |----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
>    4|                                           77.9  83.2  88.1  86.7
>    8|                                     77.9  73.7
>   16|                               86.1        65.5
>   32|                         86.0              64.7
>   64|                   85.6
>  128|             85.8
>  256|       85.6
>  512| 86.9
> 1024| 79.8
> 2048| 66.1
> 4096| 70.8
> 
> The values in the chart are percent of traces dropped* (you can see that
> this is a bad set up - >60% drops in all case). (-b is across, and -n is
> down).
> 
> Looking at increasing -b from the default (512) to 4096 whilst keep -n @
> 4 shows _more_ drops: 77.9  83.2  88.1  86.7
> 
> Looking at increasing -n from the default (4) to 2048 whilst keeping -b
> @ 512 shows _fewer_ drops: 77.9, 73.7, 65.5 and then 64.7
> 
> (Doing this with a small buffer size - 4KiB - was a bit inconclusive:
> 86.9 -> 79.8 -> 66.1 but then up to 70.8.)
> 
> The diagonal numbers represent the results from trying to keep the total
> memory consumption level - 4 buffers @ 512K up to 512 buffers @ 4K. Not
> too conclusive, but it seems that there's a benefit to having smaller
> numbers of larger buffers keeping the same memory footprint.
> 
> Anyways, none of this looks too convincing overall - and as noted, it's
> a "bad" case - way too many drops.
> 
> -----------------
> 
> I'm  re-doing this using a more balanced configuration: I'm using the 48
> fibre channel disks to hold the traces, and using 48 CCISS disks to do
> the mkfs operations on. (Preliminary results show we're around the hairy
> edge here - a few % drops on some case (<2.0%).)
> 
> -----------------
> 
> * I have modified blktrace to output the total number of drops, the
> percentage of drops, and changed the suggestion line to read:
> 
> You have 254436128 ( 81.3%) dropped events
> Consider using a larger buffer size (-b) and/or more buffers (-n)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Well, the "balanced configuration" didn't help much: going in either
direction (more buffers or larger buffers) both helped. (This is with 48
FC disks set up in an LV & capturing traces generated whilst doing mkfs
on 48 CCISS disks.)

  -b     4     8    16    32    64   128   256   512  1024  2048  4096
-n   |----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
    4|                                            4.4   0.0   0.0   0.0
    8|                                      1.5   0.0
   16|                                0.1         0.0
   32|                          0.8               0.0
   64|                    1.1
  128|              0.8
  256|        2.6
  512|  2.3
 1024|  0.5
 2048|  0.1
 4096|  0.0

 I _think_ having the error message reflect the possibility of upping
 either buffer size OR number of buffers makes sense. I'll also
 back-port the "You have 254436128 ( 81.3%) dropped events" formatted
 message code too.

 Alan
