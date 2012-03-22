From: Vasily Tarasov <tarasov@vasily.name>
Date: Thu, 22 Mar 2012 15:23:47 +0000
Subject: Re: Does btrace dump actual i/o data?
Message-Id: <CAFTzLMO2yO7gVgO6FjrTp_pGwkGD_-pZoN028VOYzKHE6GNKMQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CA+82U9+-t4z6X0SXHzDuihb+1JnwbbhCkL-DiD9BLHh_kFW=cQ@mail.gmail.com>
In-Reply-To: <CA+82U9+-t4z6X0SXHzDuihb+1JnwbbhCkL-DiD9BLHh_kFW=cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

blktrace does not support dumping a request's data. But it seems that
you can use other tools in your case. E.g.,  if it is a user-space
process writing to a fake file, then you can use  "strace" to capture
complete arguments of every system call.

HTH,
Vasily

On Thu, Mar 22, 2012 at 11:09 AM, Nathan McCorkle <nmz787@gmail.com> wrote:
> I'm trying to reverse engineer some device communication protocols....
> Basically this device shows up as a usb drive, and commands are written t=
o a
> fake file in the root directory. Responses are read from the same fake fi=
le.
>
> Does btrace have the ability to dump the data being written and read from
> the device, or just aggregate i/o statistics?
>
>
>
> --
> Nathan McCorkle
> Rochester Institute of Technology
> College of Science, Biotechnology/Bioinformatics
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrace" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
