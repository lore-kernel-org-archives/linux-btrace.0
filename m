From: Xuekun Hu <xuekun.hu@gmail.com>
Date: Fri, 05 Mar 2010 07:30:12 +0000
Subject: Re: accuracy of btt result on btreplay?
Message-Id: <398d69301003042330n41488485ta1afd85bef0e0b07@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
In-Reply-To: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Updates. I decreased/increased max-pkts to 1/16, however nothing
changed, still less merges in the replay run.

I think the "S" attribute for "write" should be the reason. First I
suspected the "S" attribute is brought by io_submit system call,
however I tested aio-stress tool which uses io_submit to send AIO
also. In the gathering traces, the write operations doesn't have "S"
attribute, however during replay, the "S" attribute happened again.

So I wonder where the "S" comes from? Does anyone have suggestions?
Thanks in advance.

Thx, Xuekun

On Thu, Mar 4, 2010 at 9:37 AM, Xuekun Hu <xuekun.hu@gmail.com> wrote:
> Hi, Alan
>
> It should be no changes on the system.
>
> I compared the per io dump info, and found the merges did decrease a
> lot. Another interesting thing I found from the blkparse output is the
> write requests has much more "WS" (synchronous) flag in the replay
> run. =A0Does the merges decrease due to the "S" flag?
>
> Perhaps =A0I need to tune the "-max-pkts"? In my case, to increase its
> value to let more requests have more opportunities to merge?
>
> BTW. I also tried replaying "dd" traces, and found the number of
> merges also decreases.
>
> Thx, Xuekun
>
