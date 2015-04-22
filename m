From: Brandon Schwartz <schwartz.xn@gmail.com>
Date: Wed, 22 Apr 2015 20:53:44 +0000
Subject: Re: Capturing idle time with blktrace
Message-Id: <CADAGN7VT7d_NgdDCUoUQxTNP642VeCnDgph34gOvTcGQKeAmCA@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CADAGN7WfwEdxivADLsei2KKVvzybzpFLpHqKMwZEd3TQ4nQ78g@mail.gmail.com>
In-Reply-To: <CADAGN7WfwEdxivADLsei2KKVvzybzpFLpHqKMwZEd3TQ4nQ78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

And by blkreplay, I meant replay the blktrace with FIO

On Wed, Apr 22, 2015 at 2:52 PM, Brandon Schwartz <schwartz.xn@gmail.com> wrote:
> Is there an accurate way to capture idle time with blktrace?  For
> example, if I run/trace the following FIO script:
>
> [global]
> direct=1
> ioengine=libaio
> readwrite=read
> blocksizeQ2k
> filename=/dev/sdd
>
> [read]
> runtime
> name=read
>
> [read2]
> stonewall=1
> startdelay@
> runtime
> name=read2
>
> And attempt to replay it using blkreplay, it will ignore the wait time
> and simply read for 20seconds instead of read 10s, wait for 40s, read
> 10s.
>
> Regards,
> Brandon
