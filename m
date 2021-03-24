From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 24 Mar 2021 14:10:00 +0000
Subject: [bug report] OOM caused by mlock() during exiting blktrace
Message-Id: <CACVXFVNdtEwvMRNi=QcXVaoMfSYu98j+2CuZg+AL4L2bALdWjQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hello Guys,

It is observed that nr_cpu * mlock(128M) is called when exiting
'blktrace -b 8192 -d $DEV'. And OOM is easily triggered when the
machine has lots of CPU cores.

So can we figure out one way to not lock big buffer for avoiding
OOM?

-- 
Ming Lei
