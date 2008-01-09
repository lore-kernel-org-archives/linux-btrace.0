From: David Dillow <dillowda@ornl.gov>
Date: Wed, 09 Jan 2008 22:48:32 +0000
Subject: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <1199918912.8388.13.camel@lap75545.ornl.gov>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

While trying to gain some insight into a disk issue, I found that
blktrace/blkparse was giving me bogus traces -- I was seeing requests
complete before they were even dispatched or queued even! I had thought
that maybe this was an issue with SMP on the box, but when running with
'maxcpus=1', it told me that my 53 second test run only took 3.5
seconds.

I started tracking this down, and upon looking at cpu_clock(), and found
that it uses sched_clock(), which is based on jiffies. At this point I
had an ahah! moment and remembered that I had NO_HZ enabled.

Turning that off got blktrace to report the proper time for the test
run.

I'm not sure of the proper fix, nor am I sure I'm going to have much
time to track this down at the momenet, but I thought someone should
know.

-- 
Dave Dillow
National Center for Computational Science
Oak Ridge National Laboratory
(865) 241-6602 office


