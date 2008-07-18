From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 18 Jul 2008 13:24:34 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <48809992.20104@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

T=F6r=F6k Edwin wrote:
> On 2008-07-18 13:31, Martin Peschke wrote:
>> recent changes:
>> - added man page
>> - beautified human-readable output
>> - fixed an x86 compile error caused by incomplete endianess handling
>> - fixed some x86 __u64 vs. unsigned long compiler warnings
>> - fixed checking of a command line argument
>>
>>
>> blkiomon periodicaly generates per devive request size and request laten=
cy
>> statistics from blktrace data. It provides histograms as well as data th=
at
>>  =20
>=20
> Does it also measure latency caused by the request queues being full?
> (which happens around here):
> blk-core.c:get_request:
> /*
>                      * The queue is full and the allocating
>                      * process is not a "batcher", and not
>                      * exempted by the IO scheduler
>                      */
>                     goto out;
>=20
> That would be very useful to trace some high latencies I am seeing, see
> discussion here:
> http://lkml.org/lkml/2008/7/12/104
>=20
> Best regards,
> --Edwin

Hi Edwin -

It would probably be pretty hard to do so - Martin is mostly interested
in issue & complete information. The stuff you needs comes from sleep
requests.

The btt tool is static, but does output some data concerning the amount
of time spent "sleeping" - waiting for a request to be made available.
(But only for the whole duration of the run, you're looking for an
instantaneous output.)

I've also looked at seekwatcher - but it too just looks at the issue &
complete stuff, but I will see if there is some way of handling sleep
request stuff "live".

Alan
