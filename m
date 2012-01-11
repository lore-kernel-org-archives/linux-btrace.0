From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Wed, 11 Jan 2012 16:27:14 +0000
Subject: Re: Modifying blktrace to obtain i/o contents?
Message-Id: <CAB-428nfgrboW3OXLZSWFF0w+pLReK071opeCPOvByueX1UrEQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
In-Reply-To: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Interesting discussion... I am agree with Vasily about the hashed
content. If the goal of project is dedub, it would be better to store
hashed contents (MD5 or SHA-1). Moreover, you can find some Dedub
trace with fixed size chunk size and MD5 content hash in the Sylab
webpage at FIU.edu



On Mon, Dec 19, 2011 at 15:06, Vasily Tarasov <tarasov@vasily.name> wrote:
>
> OK, looks like we're not staying on the same ground in this discussion
> :) What is the goal of you project? The answer to your question
> depends on this.
>
> Vasily
>
> On Mon, Dec 19, 2011 at 3:25 PM, Vasily Tarasov <tarasov@vasily.name> wro=
te:
> > OK, looks like we're not staying on the same ground in this discussion =
:)
> > What is the goal of you project? The answer to your question depends on
> > this.
> >
> > Thank you,
> > Vasily
> >
> >
> > On Thu, Dec 15, 2011 at 9:24 AM, Sushil Mantri <sushilmantri@gmail.com>
> > wrote:
> >>
> >> Hi,
> >>
> >> Sorry i couldn't reply back as I was busy with my finals :) . I looked=
 a
> >> bit into device mapper, and feel it could work, but since i have looke=
d into
> >> blktrace already i will take that approach. For now, i need the conten=
ts,
> >> but i am wondering why obtaining hash using blktrace is a good idea an=
d not
> >> the contents itself. I will obtain contents as i mentioned in my first
> >> message.
> >>
> >> Thanks for your replies
> >>
> >>
> >> On Tue, Dec 13, 2011 at 1:06 PM, Vasily Tarasov <tarasov@vasily.name>
> >> wrote:
> >>>
> >>> >
> >>> > Yes, I guess that might be the case. The subject said "i/o contents=
" so
> >>> > I'd assumed that he wanted the complete data rather than just a has=
h.
> >>> > Apologies if I've misunderstood that.
> >>> >
> >>> > Even so, since there are generic tracepoints now, a small device ma=
pper
> >>> > target could produce that information in exactly the same way as
> >>> > blktrace and remain modular. It would also be able to modify the i/o
> >>> > too, which I assumed was the eventual aim,
> >>> >
> >>> > Steve.
> >>> >
> >>>
> >>> Right, dm target would be modular, but he would need to implement
> >>> certain amount of code for efficient export of trace to the
> >>> user-space. Blktrace has implemented it already (and user-space part
> >>> is ready as well), so he would not need to do it. However, if there is
> >>> already a generic way in kernel to export a lot of data to user-space
> >>> efficiently, then dm might work as well. And, of course, if dedup
> >>> itself (not trace) is a final goal - then I agree completely - dm
> >>> target sounds like a good point.
> >>>
> >>> Vasily
> >>
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
