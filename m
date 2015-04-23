From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Thu, 23 Apr 2015 02:53:39 +0000
Subject: Re: Problem with btt's output
Message-Id: <CAB-428m1o8sjSUShcMrA7UV5djXkxzaJJ9UpnjGg8jTnmEci4g@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAGGT8x42dfXcTVfD2mhvG8dZPH6uxaD+C4+sTsJ9mL0R6kE8ew@mail.gmail.com>
In-Reply-To: <CAGGT8x42dfXcTVfD2mhvG8dZPH6uxaD+C4+sTsJ9mL0R6kE8ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

btt timing is broken if you pipe real time output of blktrace outpu,
verify that by examining blkparse output. You should be able to get
what ever you want from blkparse. Run blktrace, capture trace files,
then run blkparse offline and post process the human readble traces
with your own scripting.

On Wed, Apr 22, 2015 at 1:08 PM, Mansour Shafaei Moghaddam
<mansoor.shafaei@gmail.com> wrote:
> Running btt with -p option on the binary output of blkparse, I noticed
> the following two weird cases and would appreciate it if anyone can
> come up with an explanation for them.
>
> 1) In some IOs the time reported for C is earlier than for example
> D!!!Here is an example:
>
>  8,16 :   159.151387465 Q   75313664+256
>            159.183107850 G   75313664+256
>            159.183108979 I   75313664+256
>            159.183109762 D   75313664+256
>            159.169694274 C   75313664+256
>
> 2) In some others there are very very long (say hundreds of seconds)
> delays between (Q I G D C) steps. Example of this case:
>
>  8,16 : 34386.651240899 Q  106649088+256
>          34386.651241669 G  106649088+256
>          34386.651243565 I  106649088+256
>          34386.651244370 D  106649088+256
>          35548.738015688 C  106649088+256
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
