From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Date: Fri, 16 May 2008 17:17:42 +0000
Subject: [RFC Patch 0/5] Modifying blktrace to use 'trace' infrastructure
Message-Id: <op.ua9a3sz103j166@prasadkr_t60p.in.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel list <linux-kernel@vger.kernel.org>
Cc: dwilder@us.ibm.com, axboe@kernel.dk, linux-btrace@vger.kernel.org, akpm@linux-foundation.org, prasad@linux.vnet.ibm.com

Hi All,
	Please review the following set of patches which modify blktrace
to use trace_dump() function provided as a part of 'trace'
infrastructure.

This change brings amount huge amount of code savings i.e. ~130 lines of
code reduced in blktrace.c while retaining all existing functionality
provided by the blktrace application. This change in the kernel requires
no user-space code changes.

The patchset is based upon 2.6.25-mm1 and has been tested on an i386
machine.

The patchset contains five patches, most of which remove the code in
blktrace.c that have become redundant due to use of 'trace_dump()'.

Thanks,
K.Prasad

