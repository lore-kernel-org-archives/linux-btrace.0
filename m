From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 29 Jul 2011 13:13:27 +0000
Subject: Re: [PATCH] blktrace: add FLUSH/FUA support
Message-Id: <x49mxfxi614.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <x494o26ma11.fsf@segfault.boston.devel.redhat.com>
	<1311895164.1913.57.camel@leonhard>
In-Reply-To: <1311895164.1913.57.camel@leonhard> (Namhyung Kim's message of
	"Fri, 29 Jul 2011 08:19:24 +0900")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Namhyung Kim <namhyung@gmail.com>
Cc: Jens Axboe <jaxboe@fusionio.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org

Namhyung Kim <namhyung@gmail.com> writes:

> 2011-07-28 (=EB=AA=A9), 16:21 -0400, Jeff Moyer:
>> Hi,
>>=20
>> Sorry, I don't have the original posting of this message, so I've just
>> cut-n-paste from the archives on lkml.org:
>>   https://lkml.org/lkml/2011/6/1/235
>>=20
>
> Hello, Jeff.
>
> Thanks for finding and replying to this :)
>
>
>> The proposal was this:
>>=20
>> > Add FLUSH/FUA support to blktrace. As FLUSH precedes WRITE and/or
>> > FUA follows WRITE, use the same 'F' flag for both cases and
>> > distinguish them by their (relative) position. The end results
>> > look like (other flags might be shown also):
>> >=20
>> >  - WRITE:            W
>> >  - WRITE_FLUSH:      FW
>> >  - WRITE_FUA:        WF
>> >  - WRITE_FLUSH_FUA:  FWF
>>=20
>> I'm not sure I'll ever be able to keep that straight.  How about we use
>> 'F' for FUA, since FUA is capitalized anyway, and use 'f' for flush?
>> Too subtle?
>>=20
>
> Either way is fine to me. Jens?

OK, having read your [1] below, Jens' suggestion was to have:

Write:        W
Write Flush:  F
Write + FUA:  WF
Flush + FUA:  FF

That actually makes sense to me.

>> Next...
>>=20
>> > @@ -14,7 +14,7 @@
>> >  enum blktrace_cat {
>> >  	BLK_TC_READ	=3D 1 << 0,	/* reads */
>> >  	BLK_TC_WRITE	=3D 1 << 1,	/* writes */
>> > -	BLK_TC_BARRIER	=3D 1 << 2,	/* barrier */
>> > +	BLK_TC_FUA	=3D 1 << 2,	/* fua requests */
>>=20
>> I would prefer to replace BARRIER with FLUSH, as I think they are closer
>> relatives.  Doing it the way you've suggested would mean that older
>> blktrace user-space would report FUA as a Barrier.
>>=20
>
> I thought about that too. But as I said in the changelog, it led to a
> negative number at the rhs of MASC_TC_BIT calculation, so the end result
> was not good.

Yeah, I ran into that when trying this myself.

> In the meantime, I found that Matthew Wilcox posted a patch which
> relocates some REQ_ flags to appropriate positions.
>
> https://lkml.org/lkml/2011/6/2/324
>
> With the patch, it seems ok to replace BARRIER with FLUSH. However it
> looks like the patch isn't included into the tree yet.

OK, that's good to know.

> BTW, I'm thinking about user-space again. I'm not sure it's ok if older
> blktrace tool reports FLUSH/FUA as BARRIER. Actually I posted a patch
> that treats FLUSH as BARRIER [1], and Jens and others commented we
> should not do that.

> To end that, I could leave BLK_TC_BARRIER as is, and add
> BLK_TC_{FLUSH,FUA} at the end of blktrace_cat. But as we exhause space
> in the 16-bit act_mask, it would require a substantial change.
>
> Any thoughts?

This is a rat hole.  ;-)  Expanding the bit space is not easy, since
there is no versioning in the kernel<->userspace protocol.  The only way
I can think of to accomplish that would be to add a new setup ioctl for
the newer blktrace utility.  Then, for the older utility, we would
simply not report any barriers at all.

Really, though, when I look at blktrace output, and I'm trying to figure
out what's going on (assuming a newer kernel and older blktrace), I'd
rather have write cache flushes reported as barriers than FUA.  FUA
isn't supported by all hardware, and I think the cache flush will be
more commensurate with the hit in performance associated with the
barriers of yore.  If we went this route, then we could just overload
barrier with flush and be done with it.

I'm open to other opinions, though.

Cheers,
Jeff


> [1] https://lkml.org/lkml/2011/5/27/206
