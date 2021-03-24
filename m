From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 24 Mar 2021 15:08:11 +0000
Subject: Re: [bug report] OOM caused by mlock() during exiting blktrace
Message-Id: <x49a6qsd1yc.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <CACVXFVNdtEwvMRNi=QcXVaoMfSYu98j+2CuZg+AL4L2bALdWjQ@mail.gmail.com>
In-Reply-To: <CACVXFVNdtEwvMRNi=QcXVaoMfSYu98j+2CuZg+AL4L2bALdWjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi, Ming,

Ming Lei <tom.leiming@gmail.com> writes:

> Hello Guys,
>
> It is observed that nr_cpu * mlock(128M) is called when exiting
> 'blktrace -b 8192 -d $DEV'. And OOM is easily triggered when the
> machine has lots of CPU cores.

The only mlock in the code appears to happen at setup time.  How did you
determine this was occurring in the exit path?

> So can we figure out one way to not lock big buffer for avoiding
> OOM?

The obvious question is why are you using -b 8192?  Were you losing
events without that option?

-Jeff
