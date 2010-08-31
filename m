From: Xuekun Hu <xuekun.hu@gmail.com>
Date: Tue, 31 Aug 2010 12:25:42 +0000
Subject: Re: blktrace could cause system hang under 1G memory size and 20
Message-Id: <AANLkTinUzOxqQtj54xB9oP82m7UGHME-HXLxf+ZZhpvk@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <AANLkTi=++sLx+dJc-TRp41Sog+_Eqy9nNesumvCEd90o@mail.gmail.com>
In-Reply-To: <AANLkTi=++sLx+dJc-TRp41Sog+_Eqy9nNesumvCEd90o@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Thanks for suggestions. I will try to disable some traffics.

After the system reboot, I found "oom -killer" in syslog, I assuemd it
was caused by blktrace. :-)

On Tue, Aug 31, 2010 at 7:32 PM, Alan D. Brunelle <alan.brunelle@hp.com> wr=
ote:
> On 08/31/2010 02:32 AM, Xuekun Hu wrote:
>>
>> Hi, Guys
>>
>> My Linux system (2.6.18, x86_64, RHEL5) only has 1G memory, and I
>> would like to use blktrace (1.0.1) to capture 20 minutes of IO traces
>> with medium IO traffics. After 20 minutes, system would hang. I think
>> at this phase, blktrace is exiting and =A0printing the summary section
>> that number of events captured on each cpu.
>>
>> I'm guessing the system hang due to out of memory. (I can ping the
>> system, but can't login). I'm wondering is there a workaround?
>>
>> Thx, Xuekun
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrace" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> Well, you'd have to prove that the system was out of memory - note that
> blktrace statically allocates it's memory at the beginning of the run (or=
 at
> least, used to). So it's direct use of memory shouldn't expand over time.
> Indirectly - as it puts data out to disk - it could be consuming buffers =
for
> that operation.
>
> One workaround (to try) would be to go into network mode and send the data
> to some other machine to process. Of course, network traffic consumes its
> own buffers as well...
>
> Another option is to limit the traces to collect - if there are only cert=
ain
> things you are interested in, you could limit collection & saving to just
> those traces. [One thing to disable would be the I/O scheduler traffic if
> you are not interested in that - I found in the past that some of those
> (CFQ) could generate a tremendous amount of traces.]
>
> Regards,
> Alan
>
