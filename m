From: Brett Russ <bruss@netezza.com>
Date: Wed, 15 Sep 2010 22:29:19 +0000
Subject: blkparse not displaying all events when tracing >1 devices?
Message-Id: <4C9148BF.1000306@netezza.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello,

If I trace *2* block devices (I only tried 1 or 2, not > 2) using a 
single blktrace command, then blkparse the resulting output file set, I 
get an abridged display of events to only one of the devices.

If I instead launch two separate blktrace commands, each to a single 
block device and unique output file, then blkparse the resulting output 
files independently, I appear to get all the events on each device.

FWIW, the two block devices are actually two paths to the same HDD but I 
doubt that is relevant to this problem.

I'm pasting in my notes below.  This was done using a build from a clone 
of the blktrace git repo taken this afternoon.

> spu0103# blktrace -V
> blktrace version 2.0.0

First tried the multi-device syntax shown in the PDF users guide:

> spu0103# blktrace /dev/sdbk /dev/sdam -o 5 &

This program initiates SCSI commands to both devices and reads to one of 
them:

> spu0103# nzgeninventory > nzgi.5 2>&1
> spu0103# killall blktrace

Evidently blktrace captured everything:

> spu0103# == sdbk =>   CPU  0:                    0 events,        0 KiB data
>   CPU  1:                    4 events,        1 KiB data
>   CPU  2:                    5 events,        1 KiB data
>   CPU  3:                    5 events,        1 KiB data
>   CPU  4:                    5 events,        1 KiB data
>   CPU  5:                    0 events,        0 KiB data
>   CPU  6:                    1 events,        1 KiB data
>   CPU  7:                    1 events,        1 KiB data
>   Total:                    21 events (dropped 0),        2 KiB data
> == sdam =>   CPU  0:                    9 events,        1 KiB data
>   CPU  1:                    7 events,        1 KiB data
>   CPU  2:                    6 events,        1 KiB data
>   CPU  3:                    6 events,        1 KiB data
>   CPU  4:                    6 events,        1 KiB data
>   CPU  5:                   10 events,        1 KiB data
>   CPU  6:                    6 events,        1 KiB data
>   CPU  7:                   11 events,        1 KiB data
>   Total:                    61 events (dropped 0),        4 KiB data
> 
> [1]+  Done                       blktrace /dev/sdbk /dev/sdam -o 5

But blkparse shows me only some events from one of the devices:

> spu0103# blkparse -q -i 5
> Input file 5.blktrace.1 added
> Input file 5.blktrace.2 added
> Input file 5.blktrace.3 added
> Input file 5.blktrace.4 added
> Input file 5.blktrace.6 added
> Input file 5.blktrace.7 added
>  66,96   1        1     0.000000000  3786  G   N [nzgeninventory.]
>  66,96   1        2     0.000002043  3786  P   N [nzgeninventory.]
>  66,96   3        1     0.000496874     0  C   R (12 00 00 00 24 00 ..) [0]
>  66,96   3        2     0.000597626  3786  G   N [nzgeninventory.]
>  66,96   3        3     0.000599460  3786  P   N [nzgeninventory.]
>  66,96   2        1     0.001022051     0  C   R (12 00 00 00 a4 00 ..) [0]
>  66,96   2        2     0.001094954  3786  G   N [nzgeninventory.]
>  66,96   2        3     0.001096781  3786  P   N [nzgeninventory.]
>  66,96   4        1     0.001705551     0  C   R (12 01 83 00 fc 00 ..) [0]
>  66,96   4        2     0.002156748  3786  G   N [nzgeninventory.]
>  66,96   4        3     0.002158788  3786  P   N [nzgeninventory.]


Let's try two separate instances of blktrace?

> spu0103# blktrace /dev/sdbk -o 6a &
> spu0103# blktrace /dev/sdam -o 6b &
> spu0103# nzgeninventory > nzgi.6 2>&1
> spu0103# killall blktrace

Same # of events captured:

> spu0103# == sdbk =>   CPU  0:                    1 events,        1 KiB data
>   CPU  1:                    0 events,        0 KiB data
>   CPU  2:                    1 events,        1 KiB data
>   CPU  3:                    0 events,        0 KiB data
>   CPU  4:                    4 events,        1 KiB data
>   CPU  5:                    5 events,        1 KiB data
>   CPU  6:                    5 events,        1 KiB data
>   CPU  7:                    5 events,        1 KiB data
>   Total:                    21 events (dropped 0),        2 KiB data
> == sdam =>   CPU  0:                   10 events,        1 KiB data
>   CPU  1:                    9 events,        1 KiB data
>   CPU  2:                    7 events,        1 KiB data
>   CPU  3:                    9 events,        1 KiB data
>   CPU  4:                    6 events,        1 KiB data
>   CPU  5:                    6 events,        1 KiB data
>   CPU  6:                    6 events,        1 KiB data
>   CPU  7:                    8 events,        1 KiB data
>   Total:                    61 events (dropped 0),        4 KiB data
> 
> [2]+  Done                       blktrace /dev/sdam -o 6b
> [1]+  Done                       blktrace /dev/sdbk -o 6a

But this time the blkparse output is what I expect:

> spu0103# blkparse -q -i 6a
> Input file 6a.blktrace.0 added
> Input file 6a.blktrace.2 added
> Input file 6a.blktrace.4 added
> Input file 6a.blktrace.5 added
> Input file 6a.blktrace.6 added
> Input file 6a.blktrace.7 added
>  67,224  4        1     0.000000000  4247  G   N [(null)]
>  67,224  4        2     0.000002179  4247  P   N [(null)]
>  67,224  4        3     0.000002361  4247  I   R 36 (12 00 00 00 24 00 ..) [(null)]
>  67,224  4        4     0.000003055  4247  D   R 36 (12 00 00 00 24 00 ..) [(null)]
>  67,224  6        1     0.000498033     0  C   R (12 00 00 00 24 00 ..) [0]
>  67,224  6        2     0.000583480  4247  G   N [(null)]
>  67,224  6        3     0.000585724  4247  P   N [(null)]
>  67,224  6        4     0.000585880  4247  I   R 164 (12 00 00 00 a4 00 ..) [(null)]
>  67,224  6        5     0.000586369  4247  D   R 164 (12 00 00 00 a4 00 ..) [(null)]
>  67,224  5        1     0.000996791     0  C   R (12 00 00 00 a4 00 ..) [0]
>  67,224  5        2     0.001057014  4247  G   N [(null)]
>  67,224  5        3     0.001059622  4247  P   N [(null)]
>  67,224  5        4     0.001059775  4247  I   R 252 (12 01 83 00 fc 00 ..) [(null)]
>  67,224  5        5     0.001065073  4247  D   R 252 (12 01 83 00 fc 00 ..) [(null)]
>  67,224  7        1     0.001683205     0  C   R (12 01 83 00 fc 00 ..) [0]
>  67,224  7        2     0.001989782  4247  G   N [(null)]
>  67,224  7        3     0.001991606  4247  P   N [(null)]
>  67,224  7        4     0.001991753  4247  I   R 252 (12 01 80 00 fc 00 ..) [(null)]
>  67,224  7        5     0.001992269  4247  D   R 252 (12 01 80 00 fc 00 ..) [(null)]
>  67,224  0        1     0.002599310     0  C   R (12 01 80 00 fc 00 ..) [0]
> 
> spu0103# blkparse -q -i 6b
> Input file 6b.blktrace.0 added
> Input file 6b.blktrace.1 added
> Input file 6b.blktrace.2 added
> Input file 6b.blktrace.3 added
> Input file 6b.blktrace.4 added
> Input file 6b.blktrace.5 added
> Input file 6b.blktrace.6 added
> Input file 6b.blktrace.7 added
>  66,96   2        1     0.000000000  4247  G   N [nzgeninventory.]
>  66,96   2        2     0.000002148  4247  P   N [nzgeninventory.]
>  66,96   2        3     0.000002316  4247  I   R 36 (12 00 00 00 24 00 ..) [nzgeninventory.]
>  66,96   2        4     0.000002955  4247  D   R 36 (12 00 00 00 24 00 ..) [nzgeninventory.]
>  66,96   4        1     0.000419015     0  C   R (12 00 00 00 24 00 ..) [0]
>  66,96   4        2     0.000490802  4247  G   N [nzgeninventory.]
>  66,96   4        3     0.000493304  4247  P   N [nzgeninventory.]
>  66,96   4        4     0.000493454  4247  I   R 164 (12 00 00 00 a4 00 ..) [nzgeninventory.]
>  66,96   4        5     0.000493973  4247  D   R 164 (12 00 00 00 a4 00 ..) [nzgeninventory.]
>  66,96   6        1     0.000909171     0  C   R (12 00 00 00 a4 00 ..) [0]
>  66,96   6        2     0.000967297  4247  G   N [nzgeninventory.]
>  66,96   6        3     0.000969818  4247  P   N [nzgeninventory.]
>  66,96   6        4     0.000970016  4247  I   R 252 (12 01 83 00 fc 00 ..) [nzgeninventory.]
>  66,96   6        5     0.000970634  4247  D   R 252 (12 01 83 00 fc 00 ..) [nzgeninventory.]
>  66,96   5        1     0.001573121     0  C   R (12 01 83 00 fc 00 ..) [0]
>  66,96   5        2     0.001883295  4247  G   N [nzgeninventory.]
>  66,96   5        3     0.001885647  4247  P   N [nzgeninventory.]
>  66,96   5        4     0.001885878  4247  I   R 252 (12 01 80 00 fc 00 ..) [nzgeninventory.]
>  66,96   5        5     0.001886469  4247  D   R 252 (12 01 80 00 fc 00 ..) [nzgeninventory.]
>  66,96   7        1     0.002486674     0  C   R (12 01 80 00 fc 00 ..) [0]
>  66,96   7        2     0.002682738  4247  G   N [nzgeninventory.]
>  66,96   7        3     0.002684715  4247  P   N [nzgeninventory.]
>  66,96   7        4     0.002684877  4247  I   R 252 (25 00 ..) [nzgeninventory.]
>  66,96   7        5     0.002685351  4247  D   R 252 (25 00 ..) [nzgeninventory.]
>  66,96   0        1     0.003222215     0  C   R (25 00 ..) [0]
>  66,96   0        2     0.003387279  4247  A   R 2112 + 1 <- (66,97) 2049
>  66,96   0        3     0.003387516  4247  Q   R 2112 + 1 [nzgeninventory.]
>  66,96   0        4     0.003388578  4247  G   R 2112 + 1 [nzgeninventory.]
>  66,96   0        5     0.003389361  4247  P   N [nzgeninventory.]
>  66,96   0        6     0.003389889  4247  I   R 2112 + 1 [nzgeninventory.]
>  66,96   0        7     0.003390646  4247  U   N [nzgeninventory.] 1
>  66,96   0        8     0.003391420  4247  D   R 2112 + 1 [nzgeninventory.]
>  66,96   1        1     0.003547936     0  C   R 2112 + 1 [0]
>  66,96   1        2     0.003743980  4247  A   R 1197744189 + 1 <- (66,99) 2049
>  66,96   1        3     0.003744226  4247  Q   R 1197744189 + 1 [nzgeninventory.]
>  66,96   1        4     0.003745333  4247  G   R 1197744189 + 1 [nzgeninventory.]
>  66,96   1        5     0.003746269  4247  P   N [nzgeninventory.]
>  66,96   1        6     0.003746782  4247  I   R 1197744189 + 1 [nzgeninventory.]
>  66,96   1        7     0.003747532  4247  U   N [nzgeninventory.] 1
>  66,96   1        8     0.003748303  4247  D   R 1197744189 + 1 [nzgeninventory.]
>  66,96   3        1     0.003903074     0  C   R 1197744189 + 1 [0]
>  66,96   3        2     0.004043041  4247  A   R 1944782754 + 1 <- (66,100) 2049
>  66,96   3        3     0.004043263  4247  Q   R 1944782754 + 1 [nzgeninventory.]
>  66,96   3        4     0.004044337  4247  G   R 1944782754 + 1 [nzgeninventory.]
>  66,96   3        5     0.004045072  4247  P   N [nzgeninventory.]
>  66,96   3        6     0.004045558  4247  I   R 1944782754 + 1 [nzgeninventory.]
>  66,96   3        7     0.004046260  4247  U   N [nzgeninventory.] 1
>  66,96   3        8     0.004047013  4247  D   R 1944782754 + 1 [nzgeninventory.]
>  66,96   2        5     0.004201336     0  C   R 1944782754 + 1 [0]


I tried the '-m' (show missing events) option shown in the PDF for 
blkparse, but it doesn't appear to be a valid option.  I don't think 
that it was intended for this purpose anyway...
> spu0103# blkparse -q -m -i 7
> blkparse: invalid option -- 'm'

I also tried an alternate form of launching blktrace, this had no impact:
> spu0103# blktrace -d /dev/sdbk -d /dev/sdam -o 7 &

I assume the problem lies in blkparse.  At least I have a workaround.

Thanks,
Brett
