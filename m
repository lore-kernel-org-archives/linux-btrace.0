From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Fri, 11 Feb 2011 18:35:23 +0000
Subject: Re: replaying blktrace using fio on a different device
Message-Id: <AANLkTikDCE1jpLG8NTuYPLk5oaoisD=azqu0sZ+=y3fQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <E9E9B636B25C054B8E6B9131614B925A037FD544@EXCHG-BE.marklogic.com>
In-Reply-To: <E9E9B636B25C054B8E6B9131614B925A037FD544@EXCHG-BE.marklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

What king of analysis you did you mean ?

Alireza Haghdoost



On Fri, Feb 11, 2011 at 21:16, Hsiao Su <Hsiao.Su@marklogic.com> wrote:
>
> Didn't know about btreplay.  But I just read its man page.  Looks like btreplay will only replay the workload, but does not provide any analysis.  It can replay workload on a different device.
>
> In fio, there's a parameter called read_iolog, where you can specify blktrace's binary output files.  Fio will replay this workload and provide analysis.
>
> In fio v1.50, there's an additional parameter called replay_redirect.  You can use this to specify a different device.  Note that this is not documented in fio's man page, but it is documented in the HOWTO file.  I found this option by search archives of this mailing list.
>
> ---
> Hsiao "Shao" Su
> 650 287 2545 (W)
>
>
> -----Original Message-----
> From: Alireza Haghdoost [mailto:haghdoost@gmail.com]
> Sent: Thursday, February 10, 2011 9:27 PM
> To: Hsiao Su
> Cc: linux-btrace@vger.kernel.org
> Subject: Re: replaying blktrace using fio on a different device
>
> Why you do not use btreply ? it has a mapping device option.
> Would you please let me know how you reply a trace using fio ?
>
>
> Alireza Haghdoost
> Graduate Student
> Department of Computer Engineering
> Sharif University of Technology
> http://ce.sharif.edu/~haghdoost
> Phone: (98) (21) 6616 6689
>
>
>
>
>
> On Fri, Feb 11, 2011 at 02:57, Hsiao Su <Hsiao.Su@marklogic.com> wrote:
> >
> > Does anyone know if this is possible?  I'd like to record io workload using blktrace for one device, and then use fio to replay it on a different device that's on a different machine.
> >
> > My brief experiment seems to say no.  If I record it using /dev/sda, then when replaying it, /dev/sda must be there.
> >
> > Basically, I'm trying to see how two different io subsystems measure up, using a real application's workload.
> >
> > ---
> > Hsiao "Shao" Su
> > 650 287 2545 (W)
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
