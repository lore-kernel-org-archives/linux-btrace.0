From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Fri, 11 Feb 2011 05:38:32 +0000
Subject: Re: replaying blktrace using fio on a different device
Message-Id: <AANLkTim+822AX=Tf5rm4rV_LcpHfOSOxjSm3DtvyyeFR@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <E9E9B636B25C054B8E6B9131614B925A037FD544@EXCHG-BE.marklogic.com>
In-Reply-To: <E9E9B636B25C054B8E6B9131614B925A037FD544@EXCHG-BE.marklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

Why you do not use btreply ? it has a mapping device option.
Would you please let me know how you reply a trace using fio ?


Alireza Haghdoost
Graduate Student
Department of Computer Engineering
Sharif University of Technology
http://ce.sharif.edu/~haghdoost
Phone: (98) (21) 6616 6689





On Fri, Feb 11, 2011 at 02:57, Hsiao Su <Hsiao.Su@marklogic.com> wrote:
>
> Does anyone know if this is possible?  I'd like to record io workload using blktrace for one device, and then use fio to replay it on a different device that's on a different machine.
>
> My brief experiment seems to say no.  If I record it using /dev/sda, then when replaying it, /dev/sda must be there.
>
> Basically, I'm trying to see how two different io subsystems measure up, using a real application's workload.
>
> ---
> Hsiao "Shao" Su
> 650 287 2545 (W)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
