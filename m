From: George Shuklin <george.shuklin@gmail.com>
Date: Thu, 09 May 2019 12:57:06 +0000
Subject: blktrace failed if any CPU is made offline
Message-Id: <ffb4a080-879f-a526-6d66-78c04e48f3bc@gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Step sto reproduce:

1. Boot a multi-core machine
2. Disable second (#1) core (# echo 0 > /sys/devices/system/cpu/cpu1/online)
3. Run blktrace on any device

Expected behaviour: a little less log files

Actual behaviour: FAILED to start thread on CPU 1: 22/Invalid argument
