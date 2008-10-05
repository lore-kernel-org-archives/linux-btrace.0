From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Sun, 05 Oct 2008 13:07:05 +0000
Subject: [Patch 0/3] driver data: blktrace pass-through support for device
Message-Id: <1223212025.4591.22.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207494.26621.82.camel@kitka.ibm.com>
In-Reply-To: <1216207494.26621.82.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-s390@vger.kernel.org

Hi Jens,
may I ask what you think about this approach? Would you consider
including the following patch series in blktrace?

Here is a discussion dating back to the first time I have posted these
patches:
http://marc.info/?l=linux-btrace&m1620751101386&w=2


Thanks,
Martin




Low-level device drivers might have additional data which complements
blktrace data. For example, zfcp, a SCSI HBA driver, is capable of
obtaining additional latency information per request from HBAs. Those
latencies allow to further break down the overall D2C request latency
provided by blktrace.

We propose an additional trace for blktrace, called "driver data". It is
a sort of small binary blob, which contains a low-level driver specific
struct. Blktrace would be able to filter this trace (-a option) and
include it within its binary output. A small device driver specific tool
on top of blktrace would then analyze "driver data" traces.

Patch 1/3 makes the blktrace kernel code provide blk_add_driver_data()
for use by device drivers.

Patch 2/3 adds support for driver data traces to blktrace tools.

Patch 3/3 makes zfcp provide additional request latency and queue
utilization data through blktrace.


Patches are against scsi-misc and blktrace git.


