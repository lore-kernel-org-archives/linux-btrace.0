From: Gangadhar Mylapuram <gangadhar.m@gmail.com>
Date: Thu, 07 Jul 2011 09:53:51 +0000
Subject: blktrace on my block device
Message-Id: <CAKVu3COeenhpKJFomNm8J0_gtK8QkYpE3c4qTHQTgYRb5bg+CA@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4E158201.3020907@tao.ma>
In-Reply-To: <4E158201.3020907@tao.ma>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

As for my understanding I no need to handle (BLKRESTART, BLKTRACESTOP,
BLKTRACESETUP ..) in my device ioctl handling. It is block l/O layer
which intercepts the
statistics and does the job.

But for my device (not sda or hda), blktrace only show the Q events.
It is not showing even C (completed) events. Do I need to add the
support in my device ioctl handling code?

Thanks,
Gangadhar
