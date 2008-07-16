From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Wed, 16 Jul 2008 14:22:30 +0000
Subject: Re: [Patch 0/3] driver data: blktrace pass-through support for device
Message-Id: <487E0426.5020107@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1216207494.26621.82.camel@kitka.ibm.com>
In-Reply-To: <1216207494.26621.82.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Martin Peschke wrote:
> Low-level device drivers might have additional data which complements
> blktrace data. For example, zfcp, a SCSI HBA driver, is capable of
> obtaining additional latency information per request from HBAs. Those
> latencies allow to further break down the overall D2C request latency
> provided by blktrace.
> 
> We propose an additional trace for blktrace, called "driver data". It is
> a sort of small binary blob, which contains a low-level driver specific
> struct. Blktrace would be able to filter this trace (-a option) and
> include it within its binary output. A small device driver specific tool
> on top of blktrace would then analyze "driver data" traces.
> 
> Patch 1/3 makes the blktrace kernel code provide blk_add_driver_data()
> for use by device drivers.
> 
> Patch 2/3 adds support for driver data traces to blktrace tools.
> 
> Patch 3/3 makes zfcp provide additional request latency and queue
> utilization data through blktrace.
> 
> 
> Patches are against scsi-misc and blktrace git.
> 
> 
> Martin

Hi Martin -

Have you thought about just using blk_add_trace_msg instead?

Alan
