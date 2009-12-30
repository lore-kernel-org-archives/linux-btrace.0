From: Simon Kirby <sim@hostway.ca>
Date: Wed, 30 Dec 2009 01:41:02 +0000
Subject: Oops on blktrace
Message-Id: <20091230014102.GA7296@hostway.ca>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello,

I just experienced an Oops while running blktrace on a 2.6.30.9 kernel
(production system).  There was no camera handy and no serial console
or crash dump log, so all we could get remotely was a function backtrace
copied by hand:

  memset_c
  relay_open_buf
  relay_open
  do_blk_trace_setup
  blk_trace_setup
  disk_name | HEX/HEX
  blk_trace_ioctl
  find_get_page
  blkdev_ioctrl
  filemap_fault
  unlock_page
  __do_fault
  block_ioctl
  vfs_ioctl
  do_vfs_ioctl
  sys_ioctl
  system_call_fastpath

At the time I had just run "blktrace /dev/etherd/e10.1" (an AOE device),
having recently run "btrace -t /dev/etherd/e10.1" and similar with no
problem.  I've since tried to reproduce this crash to no avail.  Have
there been any similar experiences or related fixes since 2.6.30.9?

Cheers,

Simon-
