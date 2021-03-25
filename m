From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 25 Mar 2021 02:11:47 +0000
Subject: Re: [bug report] OOM caused by mlock() during exiting blktrace
Message-Id: <CACVXFVMCz0jrCBkhS736Ubh+Uwt1qw5LzbyhQBi3+sxqARhcbw@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CACVXFVNdtEwvMRNi=QcXVaoMfSYu98j+2CuZg+AL4L2bALdWjQ@mail.gmail.com>
In-Reply-To: <CACVXFVNdtEwvMRNi=QcXVaoMfSYu98j+2CuZg+AL4L2bALdWjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello Jeff,

On Wed, Mar 24, 2021 at 11:07 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Ming,
>
> Ming Lei <tom.leiming@gmail.com> writes:
>
> > Hello Guys,
> >
> > It is observed that nr_cpu * mlock(128M) is called when exiting
> > 'blktrace -b 8192 -d $DEV'. And OOM is easily triggered when the
> > machine has lots of CPU cores.
>
> The only mlock in the code appears to happen at setup time.  How did you
> determine this was occurring in the exit path?

It is triggered when pressing 'ctrl^ + C' on 'blktrace -b 8192 -d /dev/nullb0',
at that time blktrace needs to parse collected trace, even though there is
nothing collected on nullb0.

>
> > So can we figure out one way to not lock big buffer for avoiding
> > OOM?
>
> The obvious question is why are you using -b 8192?  Were you losing
> events without that option?

It is used by device-mapper[1] which is covered in Red Hat kernel CKI.

Seems the locked buffer size is 16 * (buffer size) which is specified by '-b'.
So at default per-cpu mlock(16 * 512K) will be done, when nr_cpu is bigger,
it still risks in OOM.

[1] https://github.com/jthornber/device-mapper-test-suite.git


Thanks,
Ming Lei
