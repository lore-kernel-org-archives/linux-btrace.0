From: "M. Edward (Ed) Borasky" <znmeb@cesmail.net>
Date: Sun, 18 May 2008 02:54:53 +0000
Subject: segfault in "blkparse -s"?
Message-Id: <482F9A7D.3060001@cesmail.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Environment: Gentoo Linux 2.6.25 kernel, AMD Athlon64 X2 dual core, 4 GB 
of RAM, single disk drive sda, reiserfs filesystems.

I started up blktrace with "blktrace -d /dev/sda". Version is
$ blktrace -V
blktrace version 0.99.3

Then I recompiled php to generate some I/O. Then I stopped blktrace and 
ran blkparse. Version is
$ blkparse -V
blkparse version 0.99.3

Both "blkparse sda" and "blkparse -t sda" run fine, but "blkparse -s 
sda" segfaults:

$ blkparse -s sda > blkparse.out
Segmentation fault

It generates partial output before crashing.

I'm planning to try this again under gdb to get a traceback. The Gentoo 
"btrace" package is sys-block/btrace-0.0.20071210202527 -- if this is 
too old, let me know and I'll install something more recent from the 
repositories.
