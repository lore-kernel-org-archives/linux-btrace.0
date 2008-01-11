From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 09:11:42 +0000
Subject: Re: [patch 1/1] blktrace: Add blktrace ioctls to SCSI generic devices
Message-Id: <20080111091142.GL6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080107074556.114594000@de.ibm.com> <20080107074647.784615000@de.ibm.com>
In-Reply-To: <20080107074647.784615000@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christof Schmitt <christof.schmitt@de.ibm.com>
Cc: linux-btrace@vger.kernel.org, linux-scsi@vger.kernel.org

On Mon, Jan 07 2008, Christof Schmitt wrote:
> From: Christof Schmitt <christof.schmitt@de.ibm.com>
> 
> Since the SCSI layer uses the request queues from the block layer, blktrace can
> also be used to trace the requests to all SCSI devices (like SCSI tape drives),
> not only disks. The only missing part is the ioctl interface to start and stop
> tracing.
> 
> This patch adds the SETUP, START, STOP and TEARDOWN ioctls from blktrace to the
> sg device files. With this change, blktrace can be used for SCSI devices like
> for disks, e.g.: blktrace -d /dev/sg1 -o - | blkparse -i -
> 
> Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>

Looks fine to me, queued up for 2.6.25.


-- 
Jens Axboe

