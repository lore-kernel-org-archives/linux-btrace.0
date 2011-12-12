From: Vasily Tarasov <tarasov@vasily.name>
Date: Mon, 12 Dec 2011 20:18:12 +0000
Subject: Re: Modifying blktrace to obtain i/o contents?
Message-Id: <CAFTzLMP1wggb18vkLu3ccVu_c5+v6ZTpCZ9iuATA=+4+OB+maQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
In-Reply-To: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Steven, I think Sushil just wants to collect block traces that contain
data hashes. If this is the case, then blktrace is the right place to
do it. In fact, I've seen a couple of papers that did exactly that. If
not mistaken, these were papers from FYU.

Sushil, if you will be implementing it - let me know. I'm also
interested in block traces for dedup systems and have some experience
in Linux block layer.

Thank you,
Vasily

On Mon, Dec 12, 2011 at 12:05 PM, Steven Whitehouse <swhiteho@redhat.com> w=
rote:
> Hi,
>
> On Mon, 2011-12-12 at 12:00 -0500, Sushil Mantri wrote:
>> Hi,
>>
>> I am working on de-duplication, for which i need the i/o event traces
>> along with its contents. I have been looking into blktrace kernel code
>> for some time, and have thought of a hacky solution to start with. In
>> all the probe functions where i have "bio" struct i could obtain the
>> "contents" from it, and write that in the relay channel as well. The
>> blkparser would have to be modified as well to take this change into
>> account.
>>
>> Do you guys think i might be missing something or is there an
>> alternative way to handle this?
>>
>> Thanks,
>> Sushil
>
> I don't think that is probably a good way to do deduplication. Have you
> considered just writing a device mapper target for this? Thats probably
> the best way to do it,
>
> Steve.
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
