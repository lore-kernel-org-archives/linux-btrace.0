From: Alireza Haghdoost <haghdoost@gmail.com>
Date: Wed, 31 Dec 2014 04:29:20 +0000
Subject: Re: Events out of order
Message-Id: <CAB-428kS7S=zuOGLnpuK5U_LDdSCZYKUqcgrMb8ZWC6izjJwRg@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <54A355D2.5060704@ubuntu.com>
In-Reply-To: <54A355D2.5060704@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Seems to me like you don't run blktrace and blkparse appropriately.
blktrace stores IO trace in multiple files where each file is
associated to a CPU core. However, you force the output of blktrace to
redirect into a single file. This make some timing Confusion for
blkparse in the next step. You are using live blkparse option (-i -)
inappropriately. If you want to run live blkparse, you need to feed it
through blktrace pipe. Like:
#blktrace -d /dev/sda -o - | blkparse -i -

If you want to store trace in a file then parse it offline, you need
to use --input option of blkparse.

Hope it helps
Alireza

On Tue, Dec 30, 2014 at 9:23 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On 12/30/2014 08:53 PM, Alireza Haghdoost wrote:
>> Can you please share an example ? How much time backward you
>> observed after switch ?
>
>   8,64   2      606     0.019550771   480  D   R 2816 + 128 [kworker/2:1H]
>   8,64   2      607     0.019551057   480  R   R 2816 + 128 [0]
>   8,64   2      608     0.019551151   480  I   R 2816 + 128 [kworker/2:1H]
>   8,64   2      609     0.019979263     0  D   R 2816 + 128 [swapper/2]
>   8,64   2      610     0.019980728     0  D   R 2944 + 128 [swapper/2]
>   8,64   2      611     0.020403185     0  C   R 2816 + 128 [0]
>   8,64   2      612     0.020416690     0  R   R 2944 + 128 [0]
>   8,64   2      613     0.020416798     0  I   R 2944 + 128 [swapper/2]
>   8,64   2      614     0.020420237   480  D   R 2944 + 128 [kworker/2:1H]
>   8,64   2      615     0.020420511   480  R   R 2944 + 128 [0]
>   8,80   2        2     0.000000042 27566  G   R 0 + 8 [hdparm]
>   8,80   2        3     0.000001130 27566  P   N [hdparm]
>   8,80   2        4     0.000003388 27566  Q   R 8 + 8 [hdparm]
>   8,80   2        5     0.000004343 27566  M   R 8 + 8 [hdparm]
>   8,80   2        6     0.000005793 27566  Q   R 16 + 8 [hdparm]
>   8,80   2        7     0.000005979 27566  M   R 16 + 8 [hdparm]
>   8,80   2        8     0.000006934 27566  Q   R 24 + 8 [hdparm]
>   8,80   2        9     0.000007092 27566  M   R 24 + 8 [hdparm]
>
> Come to think of it, in this example it didn't even switch to the
> other cpu, just the other device ( though typically when that happens
> it seems to also switch the cpu ).
>
> Here is one that is worse:
>
>   8,64   1     1026     0.075645831 27565  Q   R 7800 + 8 [hdparm]
>   8,64   1     1027     0.075646030 27565  M   R 7800 + 8 [hdparm]
>   8,64   1     1028     0.075646911 27565  Q   R 7808 + 8 [hdparm]
>   8,64   1     1029     0.075647447 27565  G   R 7808 + 8 [hdparm]
>   8,80   0        1     0.035128312 27566  Q   R 5376 + 8 [hdparm]
>   8,80   0        2     0.035130922 27566  G   R 5376 + 8 [hdparm]
>   8,80   0        3     0.035131724 27566  P   N [hdparm]
>
> Would you like the raw trace file?
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iQEcBAEBCgAGBQJUo2wwAAoJENRVrw2cjl5RIooH/juX4p9Cz9XLjYbpLL0HtZhb
> JnGw4yaZQEBeqBs5h1LL3A6JZnNHx/yAxMO6LteWr4aQf+nKWUyLD+Yj0jid3n+u
> MF4yAwYI7PtJZtRzYpY0YlCorQdX2GKj1ajcX4mCHXrmMr2AXr4Ionyek042Q/Lp
> cpJRJUL7OfHHhtpTRTf5Xg36yLo/nK1cIFU0bNz21U3o7jWKRKo7PAmulZymCdN0
> 4FULblVSqiC3iqWPFQC8ScYLxZa0uKnsA73hFB4NbVXVXOoDor2DbgiQoF8gKVWn
> MmYlMwf5wfBwuPDTaTcVVLNA7weK6Gs79T71/6FLiJGnpaeedDAQyKvYx3j+5PQ> =nd6f
> -----END PGP SIGNATURE-----
