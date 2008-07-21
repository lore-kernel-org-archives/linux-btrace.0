From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Date: Mon, 21 Jul 2008 19:03:07 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <4884DD6B.6060709@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

On 2008-07-21 21:56, T=F6r=F6k Edwin wrote:
> On 2008-07-21 21:45, Alan D. Brunelle wrote:
>  =20
>> Hi Edwin -
>>
>> With the patches sent out today (kernel & application), you can then use
>> the updated script attached here. It only asks for getrq & sleeprq
>> traces - so it will cut down a lot, but most likely there will still be
>> a lot of getrq's (in particular).
>>
>> Will now have some time to look at the more general issue concerning how
>> to see the effects of the sleeprq's...
>>  =20
>>    =20
>
>  =20

I think it would be useful to somehow "dump" the contents of both queues
when a sleep occurs, at least
the rw_flags, the pid, and the size of the operation.
Maybe that could be done somehow via blktrace on-demand? [it already has
all the relayfs communication ...]

P.S.: I tried to blktrace all queueing events and save that to the disk,
but no matter what buffer size I used,
it kept telling me it has dropped events :(
So the only way to know the contents of the queue is for the kernel to
give it to me on-demand.

Best regards,
--Edwin

> Thanks Alan.
>
> I have been using a slightly modified version of your qsg.py script, I
> want the time delta between
>  =20
[snip]


