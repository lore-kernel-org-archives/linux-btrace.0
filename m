From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Mon, 07 Jan 2008 07:50:57 +0000
Subject: [patch 0/2] blkparse extensions for PC requests
Message-Id: <20080107075057.066746000@de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

As a follow-up to the blktrace extension for SCSI generic device files, here
are two patches that extend the tracing of PC requests in blkparse. When
tracing I/O to SCSI tape drives, the I/O trace only contains PC requests. These
extensions allow to get some more data from these traces.

-- 
Christof Schmitt
