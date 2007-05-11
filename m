From: Vasily Tarasov <vtaras@sw.ru>
Date: Fri, 11 May 2007 15:39:36 +0000
Subject: [blktrace] unplug queue trace action is missed at some places
Message-Id: <1178897976.3335.20.camel@dhcp0-54.sw.ru>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello all,

The function blk_start_queueing() calls __generic_unplug_device()
function directly without tracing BLK_TA_UNPLUG_IO action. So I have an
odd output of blktrace, when requests go through the plugged queue. I
suppose it's a BUG, or do I miss something?

Thanks,
Vasily

