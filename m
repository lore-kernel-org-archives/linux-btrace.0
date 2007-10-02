From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 02 Oct 2007 18:05:14 +0000
Subject: Re: [PATCH] Add btrecord/btreplay capability
Message-Id: <4702885A.6000602@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <47027480.2040408@hp.com>
In-Reply-To: <47027480.2040408@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens Axboe wrote:
>
> This looks pretty nifty and useful. I've applied both your patches. They
> do have a few build warnings here, involving fatal():
>
> btrecord.c: In function 'stream_open':
> btrecord.c:685: warning: the address of 'ofile_name' will always
> evaluate as 'true'
> btrecord.c:704: warning: the address of 'vfile_name' will always
> evaluate as 'true'
>
> btreplay.c: In function 'tip_init':
> btreplay.c:783: warning: the address of 'fn' will always evaluate as
> 'true'
> btreplay.c: In function 'replay_sub':
> btreplay.c:1314: warning: the address of 'path' will always evaluate as
> 'true'
>
>   
Hi Jens -

Thanks for taking these in - I have no idea why I'm not seeing that
here, it builds clean on ia64 (SLES10/gcc=4.1.0) and x86_64
(Ubuntu/gcc=4.1.2).

I see why the warnings come out, and will think of a way to clean that up.

Alan
