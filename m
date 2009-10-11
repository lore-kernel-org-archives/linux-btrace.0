From: Simon Kirby <sim@hostway.ca>
Date: Sun, 11 Oct 2009 16:44:24 +0000
Subject: Re: lots of unplugged by timer normal or abnormal?
Message-Id: <20091011164424.GA22670@hostway.ca>
List-Id: <linux-btrace.vger.kernel.org>
References: <20091006185337.GF26949@hostway.ca>
In-Reply-To: <20091006185337.GF26949@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Tue, Oct 06, 2009 at 04:20:32PM -0400, Alan D. Brunelle wrote:

> Coincidentally I was investigating something similar w/ RHEL 5.4 at this
> very moment - just wanted to know if that was a common denominator.
> 
> Could you run the attached SystemTap script and send out the output?
> [You may have to get `systemtap' though...]

Thanks for the excuse to try SystemTap. :)  I have some traces, but I
don't think the UT case is abnormal.  On my desktop at home, I can see
btraces such as this, which seem to show it happening often:

# btrace /dev/md0
  9,0    2        1     0.000000000 11679  P   N [flush-9:0]
  9,0    2        2     0.000006301 11679  Q   W 103873856 + 8 [flush-9:0]
  9,0    2        3     0.001946762     0 UT   N [swapper] 0
  9,0    2        4     0.001964494   290  U   N [kblockd/2] 0
  9,0    2        5     4.625939573 13087  Q   W 103899840 + 8 [firefox-bin]
  9,0    2        6     4.635987726 13087  P   N [firefox-bin]
  9,0    2        7     4.637612451 13087 UT   N [firefox-bin] 0
  9,0    2        8     4.637670985   290  U   N [kblockd/2] 0
  9,0    0        1     4.996817219 11679  Q   W 85739464 + 8 [flush-9:0]
  9,0    0        2     5.005772973 11679  P   N [flush-9:0]
  9,0    0        3     5.005789934 11679  Q   W 92127240 + 8 [flush-9:0]
  9,0    0        4     5.012468560     4 UT   N [ksoftirqd/0] 0
  9,0    0        5     5.012482690   288  U   N [kblockd/0] 0
  9,0    2        9     6.829559401 13087  Q   W 103907504 + 8 [firefox-bin]
  9,0    2       10     6.838558733 13087  P   N [firefox-bin]
  9,0    2       11     6.838560239 13087  Q   W 103907512 + 8 [firefox-bin]
  9,0    2       12     6.838561798 13087  Q   W 103907528 + 8 [firefox-bin]
  9,0    2       13     6.838563499 13087  Q   W 103907624 + 8 [firefox-bin]
  9,0    2       14     6.838564916 13087  Q   W 103907664 + 8 [firefox-bin]
  9,0    2       15     6.838566357 13087  Q   W 103907672 + 8 [firefox-bin]
  9,0    2       16     6.841928170     0 UT   N [swapper] 0
  9,0    2       17     6.841934150   290  U   N [kblockd/2] 0
^CCPU0 (9,0):
 Reads Queued:           0,        0KiB  Writes Queued:           2,        8KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:        0,        0KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 Read depth:             0               Write depth:             0
 IO unplugs:             1               Timer unplugs:           1
CPU2 (9,0):
 Reads Queued:           0,        0KiB  Writes Queued:           8,       32KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:        0,        0KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 Read depth:             0               Write depth:             0
 IO unplugs:             3               Timer unplugs:           3

Total (9,0):
 Reads Queued:           0,        0KiB  Writes Queued:          10,       40KiB
 Read Dispatches:        0,        0KiB  Write Dispatches:        0,        0KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:        0,        0KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 IO unplugs:             4               Timer unplugs:           4

Throughput (R/W): 0KiB/s / 0KiB/s
Events (9,0): 22 entries
Skips: 0 forward (0 -   0.0%)

This is on ext3 via MD raid 1, 0eca52a92735f43462165efe00a7e394345fb38e
kernel version aka "2.6.32rc3".

Simon-
