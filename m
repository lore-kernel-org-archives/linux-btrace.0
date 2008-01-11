From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 09:10:04 +0000
Subject: Re: How to interpret this
Message-Id: <20080111091004.GJ6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <000001c853a6$d9a5afd0$970d15ac@pei>
In-Reply-To: <000001c853a6$d9a5afd0$970d15ac@pei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Jan 10 2008, Pei Yan wrote:
> Hi,
> 
>   8,16   0        8     0.000594537  3420  Q   R 1318936 + 8 [fio]
>   8,16   0        9     0.000596873  3420  G   R 1318936 + 8 [fio]
>   8,16   0       10     0.000597670  3420  P   N [fio]
>   8,16   0       11     0.000598051  3420  I   R 1318936 + 8 [fio]
>   8,16   0       12     0.000600492  3420  D   R 1318936 + 8 [fio]
>   8,16   0       13     0.000669173  3420  U   N [fio] 1
> > 8,16   0       14     0.015246002  3380  C   R 1318936 + 8 [0]
>   8,16   0       15     0.121368302  3421  Q   R 12328 + 8 [fio]
>   8,16   0       16     0.121376327  3421  G   R 12328 + 8 [fio]
>   8,16   0       17     0.121378041  3421  P   N [fio]
>   8,16   0       18     0.121378833  3421  I   R 12328 + 8 [fio]
>   8,16   0       19     0.121381194  3421  U   N [fio] 1
>   8,16   0       20     0.121732327  3422  Q   R 1576976 + 8 [fio]
>   8,16   0       21     0.121735570  3422  G   R 1576976 + 8 [fio]
>   8,16   0       22     0.121736232  3422  I   R 1576976 + 8 [fio]
>   8,16   0       23     0.121737335  3422  U   N [fio] 2
> > 8,16   0       24     0.128906924    17  D   R 12328 + 8 [kblockd/0]
> > 8,16   0       25     0.129079556     0  C   R 12328 + 8 [0]
>   8,16   0       26     0.129139932  3421  Q   R 12336 + 8 [fio]
>   8,16   0       27     0.129142609  3421  G   R 12336 + 8 [fio]
>   8,16   0       28     0.129143370  3421  I   R 12336 + 8 [fio]
>   8,16   0       29     0.129145791  3421  D   R 12336 + 8 [fio]
>   8,16   0       30     0.129213867  3421  U   N [fio] 2
> > 8,16   0       31     0.129276092     0  C   R 12336 + 8 [0]
> 
> 
> Q: why are the pids in four tagged lines above changed? For example, in the
> first tagged line, the pid related to the same request(1318936 + 8) changes
> to 3380 from 3420. Why? 

The pid denotes who did the action listed. So for eg completions, they
typically happen from irq context and thus aren't specific to a process.

> Are there any methods to ensure that all activities initiated by a process
> be all tagged with the pid of that initiating process?

No, you should track by location like blkparse does.

-- 
Jens Axboe

