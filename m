From: Adam Crume <adamcrume@gmail.com>
Date: Tue, 10 May 2011 05:18:29 +0000
Subject: Device IO dump
Message-Id: <BANLkTikPh_t9H2WGF5+UjeJrWXco+yUk1w@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I'm trying to use blktrace to capture IOs sent to the drive so I can
model a physical device.  In the end, I'd like to have a file with
each physical IO on a line, containing the issue time (D), complete
time (C), read/write flag, start block, and block count.  I could
almost get this from btt with the --per-io-dump option (with some
post-processing), but it doesn't seem to specify whether the IO is a
read or a write.  I tried --dump-blocknos since it separates reads and
writes, and I could theoretically use that to augment the data from
the per IO dump, but it seems to duplicate events sometimes.  What's
the best way to do this?
