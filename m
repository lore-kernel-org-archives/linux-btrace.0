From: Ming Zhang <blackmagic02881@gmail.com>
Date: Mon, 09 Apr 2007 15:03:02 +0000
Subject: Re: [BTT PATCH] Clean up all memory leaks
Message-Id: <1176130982.3677.61.camel@fs0004.ibrix.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <461A4CA0.10808@hp.com>
In-Reply-To: <461A4CA0.10808@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, 2007-04-09 at 10:24 -0400, Alan D. Brunelle wrote:
> Ensure that all allocated memory was released.
> 
> Lots of minor clean up to help ensure all allocated memory is freed
> prior to exit. (Also closed a few files that were left open.)
> 
> # valgrind --leak-check=yes --show-reachable=yes btt -i bp.bin -o btt
> -v
> =21322= Memcheck, a memory error detector.
> =21322= Copyright (C) 2002-2006, and GNU GPL'd, by Julian Seward et
> al.
> =21322= Using LibVEX rev 1658, a library for dynamic binary
> translation.
> =21322= Copyright (C) 2004-2006, and GNU GPL'd, by OpenWorks LLP.
> =21322= Using valgrind-3.2.1-Debian, a dynamic binary
> instrumentation framework.
> =21322= Copyright (C) 2000-2006, and GNU GPL'd, by Julian Seward et
> al.
> =21322= For more details, rerun with: -v
> =21322= 
> Sending range data to btt.dat
> Sending stats data to btt.avg
>    4581291 traces @ 10.7 Ktps in 426.578804
> seconds                                     tree = |0|
>    =21322= 
>    =21322= ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 8
> from 1)
>    =21322= malloc/free: in use at exit: 0 bytes in 0 blocks.
>    =21322= malloc/free: 11,241,958 allocs, 11,241,958 frees,
> 440,381,362 bytes allocated.
>    =21322= For counts of detected errors, rerun with: -v
>    =21322= All heap blocks were freed -- no leaks are possible.
> 
> Signed-off-by: Alan D. Brunelle <Alan.Brunelle@hp.com>
> --- 

cool. really great to see this.

