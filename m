From: Ingo Molnar <mingo@elte.hu>
Date: Sun, 07 Oct 2007 19:32:56 +0000
Subject: Re: Linux Kernel Markers - performance characterization with large
Message-Id: <20071007193256.GA18558@elte.hu>
List-Id: <linux-btrace.vger.kernel.org>
References: <46F92219.9020406@hp.com> <20070925171349.GA6057@Krystal> <46FA7A86.6090804@hp.com>
In-Reply-To: <46FA7A86.6090804@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-kernel@vger.kernel.org, btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>


* Alan D. Brunelle <Alan.Brunelle@hp.com> wrote:

>  o  All kernels start off with Linux 2.6.23-rc6 + 2.6.23-rc6-mm1
> 
>  o  '- bt cfg' or '+ bt cfg' means a kernel without or with blktrace 
> configured respectively.
> 
>  o  '- markers' or '+ markers' means a kernel without or with the 
> 11-patch marker series respectively.
> 
> 38 runs without blk traces being captured (dropped hi/lo value from 40 runs)
> 
> Kernel Options       Min val    Avg val    Max val    Std Dev
> ------------------  ---------  ---------  ---------  ---------
> - markers - bt cfg  15.349127  16.169459  16.372980   0.184417
> + markers - bt cfg  15.280382  16.202398  16.409257   0.191861
> 
> - markers + bt cfg  14.464366  14.754347  16.052306   0.463665
> + markers + bt cfg  14.421765  14.644406  15.690871   0.233885

actually, the pure marker overhead seems to be a regression:

> - markers - bt cfg  15.349127  16.169459  16.372980   0.184417
> + markers - bt cfg  15.280382  16.202398  16.409257   0.191861

why isnt the marker near zero-cost as it should be? (as long as they are 
enabled but are not in actual use) 2% increase is _ALOT_. That's the 
whole point of good probes: they do not slow down the normal kernel.

_Worst case_ it should be at most a few instructions overhead but that 
does not explain the ~2% wall-clock time regression you measured here.

So there's something wrong going on - either markers have unacceptably 
high cost, or the measurement is not valid.

	Ingo
