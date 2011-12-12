From: Steven Whitehouse <swhiteho@redhat.com>
Date: Mon, 12 Dec 2011 17:05:52 +0000
Subject: Re: Modifying blktrace to obtain i/o contents?
Message-Id: <1323709552.2729.24.camel@menhir>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
In-Reply-To: <CAFFtA87hHc9cG8qawFaYsF2P9aYBqaBsJyKkXFV2utxOrUVNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

On Mon, 2011-12-12 at 12:00 -0500, Sushil Mantri wrote:
> Hi,
> 
> I am working on de-duplication, for which i need the i/o event traces
> along with its contents. I have been looking into blktrace kernel code
> for some time, and have thought of a hacky solution to start with. In
> all the probe functions where i have "bio" struct i could obtain the
> "contents" from it, and write that in the relay channel as well. The
> blkparser would have to be modified as well to take this change into
> account.
> 
> Do you guys think i might be missing something or is there an
> alternative way to handle this?
> 
> Thanks,
> Sushil

I don't think that is probably a good way to do deduplication. Have you
considered just writing a device mapper target for this? Thats probably
the best way to do it,

Steve.



