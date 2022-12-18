From: Stephen Bates <sbates@raithlin.com>
Date: Sun, 18 Dec 2022 18:59:32 +0000
Subject: Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad address
Message-Id: <Y59jFMeWCxLYpQ0v@bunbeg>
List-Id: <linux-btrace.vger.kernel.org>
References: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
In-Reply-To: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi All

I am trying to get iowatcher up and running on a VM and I seem to be
hitting an issue reading the debugfs trace files. When I run on the VM
I continually get messages of the form. This is not specific to
iowatcher in that if I run blktrace directly I get something similar:

$ blktrace -b 8192 -a queue -a complete -a issue -a notify -o ./trace -D . -d /dev/nvme0n1
<snip>
setup_mmap: mmap: Invalid argument
Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad address

This is on a generic Ubuntu 22.04 install.

$ uname -r
5.15.0-57-generic

Now if I run similar commands on an AWS instance things work as
expected. AND if I directly pipe the output of blktrace into blkparse
it seems to work as expected too, even on the VM.

Does anyone have any ideas? Is there a kernel config I am missing that
is corrected on the AWS kernel? I assume the fact the NVMe SSD on my
VM in emulated via QEMU has no impact on this.

BTW this is all because I am working on an updated version of
iowatcher that ties into Prometheus so I can track disk access
patterns across a fleet of servers [1].

[1]. https://github.com/sbates130272/iowatcher-ng

-- 

Cheers

Stephen Bates, PhD.
