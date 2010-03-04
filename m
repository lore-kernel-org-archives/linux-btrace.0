From: Xuekun Hu <xuekun.hu@gmail.com>
Date: Thu, 04 Mar 2010 01:37:52 +0000
Subject: Re: accuracy of btt result on btreplay?
Message-Id: <398d69301003031737qf8bd1f3q819ba4f3127a2cf9@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
In-Reply-To: <398d69301003022341r5840a9e1g492c243c330bd398@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Hi, Alan

It should be no changes on the system.

I compared the per io dump info, and found the merges did decrease a
lot. Another interesting thing I found from the blkparse output is the
write requests has much more "WS" (synchronous) flag in the replay
run.  Does the merges decrease due to the "S" flag?

Perhaps  I need to tune the "-max-pkts"? In my case, to increase its
value to let more requests have more opportunities to merge?

BTW. I also tried replaying "dd" traces, and found the number of
merges also decreases.

Thx, Xuekun

On Wed, Mar 3, 2010 at 10:05 PM, Alan D. Brunelle <Alan.Brunelle@hp.com> wr=
ote:
>
> Hi Xuekun -
>
> Not sure why they Q2Q N value is down 5%, but the AVG Q2Q is pretty
> close - only 11msec (again, about 5%). After that, things are affected
> by merge rates most likely - note that there were 262882 merges on the
> first run whilst there were only 8970 on the second run. Perhaps you
> could look at the blkparse output from both and get a feel for the vast
> reduction in merges. [Any changes on the system between the runs?]
>
> Regards,
> Alan
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
