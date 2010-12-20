From: "Duy Le (Dan)" <duyle.vn@gmail.com>
Date: Mon, 20 Dec 2010 04:36:54 +0000
Subject: Re: Recent changes
Message-Id: <AANLkTi=0izhb-n=BKoEEehiW6Z-H0_63OpF4Zkxx=50B@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
In-Reply-To: <46171742.iJ5w/0J1D3Q4P+M6%jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Sorry for this newbie question!

I have a disk divided as follows:

=========Disk /dev/sdb: 56.9 GB, 56908316672 bytes
255 heads, 63 sectors/track, 6918 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        1167     9373896   83  Linux
/dev/sdb2            1168        6918    46194907+   5  Extended
/dev/sdb5            1168        2322     9373896   83  Linux
/dev/sdb6            2323        3477     9277506   83  Linux
....
=========
I used blktrace to capture I/Os on sdb5 when I was trying to mount
sdb5. This is a part of the output:

=========...
251,32   0       25     0.000919000  3529  A  RM 18752478 + 8 <- (251,37) 4560
251,32   0       26     0.000919657  3529  Q  RM 18752478 + 8 [mount]
251,32   0       27     0.000920810  3529  G  RM 18752478 + 8 [mount]
251,32   0       28     0.000922188  3529  P   N [mount]
251,32   0       29     0.000923025  3529  I   R 18752478 + 8 [mount]
251,32   0       30     0.000924439  3529  U   N [mount] 1
251,32   0       31     0.000925877  3529  D   R 18752478 + 8 [mount]
251,32   0       32     0.023385527     0  C   R 18752478 + 8 [0]
251,32   0       33     0.023465706  3529  A   R 27664918 + 8 <-
(251,37) 8917000
251,32   0       34     0.023466398  3529  Q   R 27664918 + 8 [mount]
251,32   0       35     0.023467922  3529  G   R 27664918 + 8 [mount]
....
=========
According to blktrace manual, such a number of 18752478 is known as a
"starting block", followed by the size of request. If I understand
correctly, sdb5 is in the range of blocks from 9373897 to
9373896+9373897-1747792. However, blktrace's output shows that a R
request occurs on a block whose index is much larger than the range of
the partition.

How should I understand correctly the value of 18752478? Please help.

Thank you

-- Dan
