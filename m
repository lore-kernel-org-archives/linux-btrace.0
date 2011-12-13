From: Vasily Tarasov <tarasov@vasily.name>
Date: Tue, 13 Dec 2011 18:06:24 +0000
Subject: Re: Modifying blktrace to obtain i/o contents?
Message-Id: <CAFTzLMPWURwMMDZ8AX_e6n3R6oMGqfkczm=YjJR606kOOX6oXw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
In-Reply-To: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

>
> Yes, I guess that might be the case. The subject said "i/o contents" so
> I'd assumed that he wanted the complete data rather than just a hash.
> Apologies if I've misunderstood that.
>
> Even so, since there are generic tracepoints now, a small device mapper
> target could produce that information in exactly the same way as
> blktrace and remain modular. It would also be able to modify the i/o
> too, which I assumed was the eventual aim,
>
> Steve.
>

Right, dm target would be modular, but he would need to implement
certain amount of code for efficient export of trace to the
user-space. Blktrace has implemented it already (and user-space part
is ready as well), so he would not need to do it. However, if there is
already a generic way in kernel to export a lot of data to user-space
efficiently, then dm might work as well. And, of course, if dedup
itself (not trace) is a final goal - then I agree completely - dm
target sounds like a good point.

Vasily
