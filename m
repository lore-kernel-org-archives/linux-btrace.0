From: Christof Schmitt <christof.schmitt@de.ibm.com>
Date: Mon, 14 Jan 2008 07:40:06 +0000
Subject: [patch 0/2] updated blkparse extensions for PC requests
Message-Id: <20080114074006.156933000@de.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Here is an updated version of the PC requests patches for blkparse.

The first patch (add PC requests to queue depth accounting) only has
some white space cleanups compared to the last version.

The second patch (account PC requests) no longer introduces the --pc
flag on the command line. Instead, the PC summary data is printed,
whenever a PC event was encountered. I also added accounting the PC
requeue and PC completion events.

-- 
Christof Schmitt
