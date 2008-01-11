From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 Jan 2008 09:10:35 +0000
Subject: Re: [patch 0/2] blkparse extensions for PC requests
Message-Id: <20080111091035.GK6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080107075057.066746000@de.ibm.com>
In-Reply-To: <20080107075057.066746000@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Mon, Jan 07 2008, Christof Schmitt wrote:
> As a follow-up to the blktrace extension for SCSI generic device
> files, here are two patches that extend the tracing of PC requests in
> blkparse. When tracing I/O to SCSI tape drives, the I/O trace only
> contains PC requests. These extensions allow to get some more data
> from these traces.

Patches look fine, however should it just not default do this
accounting? But only print the status fields, if we actually saw a PC
request.

-- 
Jens Axboe

