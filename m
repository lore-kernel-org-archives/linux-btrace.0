From: Joshua Root <jmr@gelato.unsw.edu.au>
Date: Sun, 07 Oct 2007 22:10:47 +0000
Subject: Re: Linux Kernel Markers - performance characterization with large
Message-Id: <47095967.8060608@gelato.unsw.edu.au>
List-Id: <linux-btrace.vger.kernel.org>
References: <46F92219.9020406@hp.com> <20070925171349.GA6057@Krystal> <46FA7A86.6090804@hp.com> <20071007193256.GA18558@elte.hu>
In-Reply-To: <20071007193256.GA18558@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "Alan D. Brunelle" <Alan.Brunelle@hp.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-kernel@vger.kernel.org, btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

Ingo Molnar wrote:
> actually, the pure marker overhead seems to be a regression:
> 
> Kernel Options       Min val    Avg val    Max val    Std Dev
>> - markers - bt cfg  15.349127  16.169459  16.372980   0.184417
>> + markers - bt cfg  15.280382  16.202398  16.409257   0.191861
> 
> why isnt the marker near zero-cost as it should be? (as long as they are 
> enabled but are not in actual use) 2% increase is _ALOT_.

The increase in the mean is actually 0.033, or 0.2%.

> So there's something wrong going on - either markers have unacceptably 
> high cost, or the measurement is not valid.

The third option is that the measurement just needs to be done more 
times. The standard error in the mean for the + markers case is
0.191861 / sqrt(10) = 0.061, which is twice the size of the difference 
being measured.
-- 
Joshua Root,  jmr AT gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
