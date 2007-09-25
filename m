From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Tue, 25 Sep 2007 14:58:33 +0000
Subject: Re: Linux Kernel Markers - performance characterization with large
Message-Id: <46F92219.9020406@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: btrace <linux-btrace@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Taking Linux 2.6.23-rc6 + 2.6.23-rc6-mm1 as a basis, I took some sample 
runs of the following on both it and after applying Mathieu Desnoyers 
11-patch sequence (19 September 2007).

    * 32-way IA64 + 132GiB + 10 FC adapters + 10 HP MSA 1000s (one 72GiB
      volume per MSA used)

    * 10 runs with each configuration, averages shown below
          o 2.6.23-rc6 + 2.6.23-rc6-mm1 without blktrace running
          o 2.6.23-rc6 + 2.6.23-rc6-mm1 with blktrace running
          o 2.6.23-rc6 + 2.6.23-rc6-mm1 + markers without blktrace running
          o 2.6.23-rc6 + 2.6.23-rc6-mm1 + markers with blktrace running

    * A run consists of doing the following in parallel:
          o Make an ext3 FS on each of the 10 volumes
          o Mount & unmount each volume
                + The unmounting generates a tremendous amount of writes
                  to the disks - thus stressing the intended storage
                  devices (10 volumes) plus the separate volume for all
                  the blktrace data (when blk tracing is enabled).
                + Note the times reported below only cover the
                  make/mount/unmount time - the actual blktrace runs
                  extended beyond the times measured (took quite a while
                  for the blk trace data to be output). We're only
                  concerned with the impact on the "application"
                  performance in this instance.

Results are:

Kernel                                 w/out BT   STDDEV     w/ BT    STDDEV
-------------------------------------  ---------  ------   ---------  ------
2.6.23-rc6 + 2.6.23-rc6-mm1            14.679982    0.34   27.754796    2.09
2.6.23-rc6 + 2.6.23-rc6-mm1 + markers  14.993041    0.59   26.694993    3.23

It looks to be about 2.1% increase in time to do the make/mount/unmount 
operations with the marker patches in place and no blktrace operations. 
With the blktrace operations in place we see about a 3.8% decrease in 
time to do the same ops.

When our Oracle benchmarking machine frees up, and when the 
marker/blktrace patches are more stable, we'll try to get some "real" 
Oracle benchmark runs done to gage the impact of the markers changes to 
performance...

Alan D. Brunelle
Hewlett-Packard / Open Source and Linux Organization / Scalability and 
Performance Group

