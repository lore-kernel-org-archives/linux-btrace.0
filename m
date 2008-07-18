From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Date: Fri, 18 Jul 2008 20:44:43 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <488100BB.5040004@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 2008-07-18 18:28, Alan D. Brunelle wrote:
>> Thanks for the patch, I'll give it a try today.
>> The most  reliable way to reproduce is to run a dd that copies about
>> 10-20Gb, and rm the file immediately.
>> Then try that find / ^C stuff, it usually occurs right at the end of the
>> dd (when the file is probably removed).
>>
>> Best regards,
>> --Edwin
>>     
>
> The system /is/ acting very strange: I'm seeing very, very poor
> responsiveness - trying to start anything with very large dd's going on
> takes a long time (maybe forever, I'm just trying to log in right now
> and it won't budge).
>
> I do have vmstat & iostat running, what's strange is I'm seeing a lot of
> I/O from iostat:
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0.47    0.00    2.14   90.51    0.00    6.88
>
> Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
> sda             163.50        20.00    157296.00         40     314592
>
>
> but /not/ vmstat (I thought I'd see the 'bo' column going):
>
> procs -----------memory---------- ---swap-- -----io---- -system--
> ----cpu----
>  r  b   swpd   free  inact active   si   so    bi    bo   in   cs us sy
> id wa
>  0  0      0 2795940 3326292 1649612    0    0     0    26  183 2104  8
>  0 92  0
>
> Anyways, I'm hoping the Python script helps diagnose some stuff.

I just had a ~10-20 seconds delay, but the script showed that everything
was fine (in fact it stopped outputting when the delay occured, and
continued right after it ended).
Actually there was a 100%CPU usage from blktrace/python for several
seconds after disk IO went idle.
Is there a way to filter what events get sent to blktrace at the kernel
level? [if not, I'll just comment out everything except 'S' and 'G'
events for testing ]
I am afraid that some of the trace might get lost, due to some buffer
getting full, or the CPU not being able to process all that trace data
fast enough.

I'll do some more testing tomorrow.

2 sleepers min=  0.014129453 avg=  0.071728689 max=  0.129327925
   2 sleepers min=  0.103887255 avg=  0.129989463 max=  0.156091670
   1 sleepers                         0.008757261
   1 sleepers                         0.108588692
   1 sleepers                         0.096539950
   1 sleepers                         0.001614172
   1 sleepers                         0.068393348
   1 sleepers                         0.048992553
   1 sleepers                         0.027390360
   1 sleepers                         0.040583661
   1 sleepers                         0.075555992
   1 sleepers                         0.052888021
   1 sleepers                         0.135416410
   1 sleepers                         0.107794456
   1 sleepers                         0.112709328
   1 sleepers                         0.013893949
   1 sleepers                         0.011218468
   1 sleepers                         0.033538071
   1 sleepers                         0.053633368
   1 sleepers                         0.170540997
   2 sleepers min=  0.040374975 avg=  0.102662378 max=  0.164949781
   1 sleepers                         0.000017321
   1 sleepers                         0.057629687
   1 sleepers                         0.090667694
   1 sleepers                         0.125543645
   1 sleepers                         0.021752771
   1 sleepers                         0.022358434
   1 sleepers                         0.039035978
   1 sleepers                         0.018768592
   1 sleepers                         0.033759328
   2 sleepers min=  0.001489855 avg=  0.016873658 max=  0.032257461
   1 sleepers                         0.067795228
   1 sleepers                         0.225957273
   2 sleepers min=  0.019794700 avg=  0.019810764 max=  0.019826827
   2 sleepers min=  0.071565819 avg=  0.083588998 max=  0.095612178


>  I'm
> looking into how to measure other things that are put off because we are
> congested in the request allocation path...
>
> Alan
>   

Yes, maybe it doesn't even reach the place where the tracepoints are set.

Best regards,
--Edwin
