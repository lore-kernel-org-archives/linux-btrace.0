From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Fri, 29 Feb 2008 11:59:36 +0000
Subject: [patch 0/2] Resend of blkparse extensions for PC requests
Message-Id: <20080229115936.338333000@de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I am resending the blkparse extensions for PC requests from last
month. They add accounting for PC requests and also use PC requests
while tracking the queue depth.

The patches apply cleanly to the code in the git repository.

-- 
Christof Schmitt
