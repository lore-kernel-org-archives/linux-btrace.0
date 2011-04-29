From: Adam Crume <adamcrume@gmail.com>
Date: Fri, 29 Apr 2011 22:44:19 +0000
Subject: Unrealistic D2C times
Message-Id: <BANLkTikMSmsAakkb0SKr0tf4y_Y+QnpvpQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I'm trying to capture IO traces and average access times (by which I
mean time spent by the hardware and firmware).  btt seems to give me
incorrect time for D2C, though.  As I understand it, it's saying the
average access time is 0.3ms, while iostat says it's 8.25ms.  Am I
misusing the tool somehow?  How can I get it to report the data I
want?


Here's how I get my data:
blktrace -d /dev/sdb -o $TRACE.rawtrace
blkparse $TRACE.rawtrace -O -d $TRACE.bin
btt -i $TRACE.bin


This is what btt reports:
========== All Devices ==========

            ALL           MIN           AVG           MAX           N
--------------- ------------- ------------- ------------- -----------

Q2Q               0.000003631   0.006093295   5.546805679       13446
Q2G               0.000002235   0.000004725   0.000134377        6893
G2I               0.000001676   0.000118613   0.047795413        9166
Q2M               0.000001676   0.000002203   0.000071798        6554
I2D               0.000008661   0.003768198   0.048250506        7158
M2D               0.000019835   0.000142260   0.016255688        6799
D2C               0.000136332   0.000326485   0.005760325       13447
Q2C               0.000159799   0.002395819   0.048427905       13447


This is what iostat reports:
Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
sdb               0.00    91.00    0.00  120.00     0.00  1476.00
12.30     0.99    8.25   8.25  99.00


(iostat was reporting every 2 seconds, so its totals won't match the
btt totals, but the averages should match.)
