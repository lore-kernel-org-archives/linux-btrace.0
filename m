From: Vasily Tarasov <tarasov@vasily.name>
Date: Wed, 07 Mar 2012 18:09:41 +0000
Subject: Re: blkparse unplug question
Message-Id: <CAFTzLMNaAG+0URBf0HkaLDPfK5pJ=Q9UMnFV3ez7N6+hA3bVeA@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAKA=qzaR2FryEq6uG299SzH14=BQVShnRvDSie0XRpwijBFsRg@mail.gmail.com>
In-Reply-To: <CAKA=qzaR2FryEq6uG299SzH14=BQVShnRvDSie0XRpwijBFsRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

The value after the process name ("31" in your trace snip) is the
number of requests flushed from the plug queue to the I/O queue during
the unplug.

To identify which inode a block belongs to you can try to use file
system specific utils: e.g., xfs_bmap for xfs, debugfs for ext2/3.
Also there are FIBMAP and FIEMAP ioctls that can help you. Another
ways is to instrument your file system's code to produce a trace/map
of blocks; well, if you have time for that ;)

HTH,
Vasily

On Wed, Mar 7, 2012 at 10:06 AM, Josh Hunt <joshhunt00@gmail.com> wrote:
> I am trying to debug a stall I am seeing with CFQ and in the
> blktrace/blkparse output I see unplugging lines like the following:
>
> 8,3 =A0 =A01 =A0 =A0 7809 =A01532.225997730 =A0 168 =A0U =A0 N [sync_supe=
rs] 31
>
> My question is what does the value after the process name represent? I
> see this value increasing from 1, I believe, and then eventually the
> value appears to get reset.
>
> I was also wondering if it is possible to translate the block
> information provided in blktrace to the corresponding inode?
>
> Thanks for your help!
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
