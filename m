From: Bill Broadley <bill@broadley.org>
Date: Tue, 24 May 2011 23:38:54 +0000
Subject: Seg fault in blkparse.
Message-Id: <4DDC418E.4080407@broadley.org>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


I recorded a 3 minutes of heavy IO (generated with fio) with:
blktrace -w 240 -a read -a write -a fs -I devs -o btrfs-12-blk.log

(I used 240 seconds to make sure I didn't miss any of the 180 seconds of 
I/O).

As a small aside I wasn't sure what the default filter mask was, it 
seems more correct to use:
blktrace -w 240 -A read -a write -a fs -I devs -o btrfs-12-blk.log

So set the mask to exactly (and only) read, then add write, and fs.  But 
that dies with:
    Invalid set action mask read/0x0

The above mentioned file "devs" contains /etc/sdc1 ... /dev/sdn1 (12 
devices, one per line).

It generated 16 log files (it's a dual socket x quad core/8 thread intel 
CPUs).  The logs total 15M (using du --total -h *blktrace*).

blkparse reliably seg faults at around 102 seconds into the log:
   8,209  1     5749   102.246254903  4825  U   N [(null)] 2
   8,113  4    10445   102.255427790     0  C   R 14356151 + 8 [10445]
Segmentation fault

Stderror does have some strange output:

# blkparse btrfs-12-blk.log > /dev/null
Bad magic 0
Bad magic 0
Bad magic 0
Bad magic 8
Bad magic 0
Bad magic 0
Bad magic 0
Bad magic c2d3ccfa
Segmentation fault

It generated 61,758 lines of output when it dies.

Additional information about this machine, it's an ubuntu 11.04 x86-64 
machine with:
# uname -a
Linux fb 2.6.38-8-server #42-Ubuntu SMP Mon Apr 11 03:49:04 UTC 2011 
x86_64 x86_64 x86_64 GNU/Linux
# blkparse --version
blkparse version 1.0.1
# blktrace --version
blktrace version 2.0.0

This doesn't seem like a particularly challenging log to handle.

I looked for a way to tell blkparse to use a larger buffer but I didn't 
see a way to do that with blkparse --help or the blkparse man page.

Stupid user error?  Suggestions?  I'm sending it to this list as 
directed by the man page.


