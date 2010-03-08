From: Xuekun Hu <xuekun.hu@gmail.com>
Date: Mon, 08 Mar 2010 08:38:33 +0000
Subject: Re: accuracy of btt result on btreplay?
Message-Id: <398d69301003080038m705acfdbv3193eb5576bb2f92@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
In-Reply-To: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I think I found where the "S" flag was put for write IO request. In
the kernel function __blockdev_direct_IO(), every write request will
be tagged as "sync". Since btreplay uses O_DIRECT + AIO, which should
go into __blockdev_direct_IO.

So now my views on btreplay:
1. for write request, btreplay will decrease merge rates, thus impact
the latency etc.
2. for read request, btrecord may adjust "-max-pkts"/"-max-bunch-time"
to control the size of bunch to close to the real read IO merge rates.

Thx, Xuekun

On Fri, Mar 5, 2010 at 3:30 PM, Xuekun Hu <xuekun.hu@gmail.com> wrote:
> Updates. I decreased/increased max-pkts to 1/16, however nothing
> changed, still less merges in the replay run.
>
> I think the "S" attribute for "write" should be the reason. First I
> suspected the "S" attribute is brought by io_submit system call,
> however I tested aio-stress tool which uses io_submit to send AIO
> also. In the gathering traces, the write operations doesn't have "S"
> attribute, however during replay, the "S" attribute happened again.
>
> So I wonder where the "S" comes from? Does anyone have suggestions?
> Thanks in advance.
>
> Thx, Xuekun
>
