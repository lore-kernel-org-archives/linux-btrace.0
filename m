From: Sushil Mantri <sushilmantri@gmail.com>
Date: Thu, 15 Dec 2011 14:25:43 +0000
Subject: Re: Modifying blktrace to obtain i/o contents?
Message-Id: <CAFFtA86hiJAHMPJy6ZfwnJ2R0Xzk5=ar8jszTaoYa+GRo8Qjwg@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
In-Reply-To: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

Sorry i couldn't reply back as I was busy with my finals :) . I looked
a bit into device mapper, and feel it could work, but since i have
looked into blktrace already i will take that approach. For now, i
need the contents, but i am wondering why obtaining hash using
blktrace is a good idea and not the contents itself. I will obtain
contents as i mentioned in my first message.

Thanks for your replies

On Tue, Dec 13, 2011 at 1:06 PM, Vasily Tarasov <tarasov@vasily.name> wrote:
>>
>> Yes, I guess that might be the case. The subject said "i/o contents" so
>> I'd assumed that he wanted the complete data rather than just a hash.
>> Apologies if I've misunderstood that.
>>
>> Even so, since there are generic tracepoints now, a small device mapper
>> target could produce that information in exactly the same way as
>> blktrace and remain modular. It would also be able to modify the i/o
>> too, which I assumed was the eventual aim,
>>
>> Steve.
>>
>
> Right, dm target would be modular, but he would need to implement
> certain amount of code for efficient export of trace to the
> user-space. Blktrace has implemented it already (and user-space part
> is ready as well), so he would not need to do it. However, if there is
> already a generic way in kernel to export a lot of data to user-space
> efficiently, then dm might work as well. And, of course, if dedup
> itself (not trace) is a final goal - then I agree completely - dm
> target sounds like a good point.
>
> Vasily
