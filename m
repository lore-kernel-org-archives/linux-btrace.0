From: Adam Crume <adamcrume@gmail.com>
Date: Tue, 26 Nov 2013 21:21:32 +0000
Subject: Tracing software RAID devices
Message-Id: <CAFu9Dv0BVF4wDd-M9CLNh1FyceGwFhHSys3akKLRXY9oF3EELQ@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I created a software RAID device with mdadm and traced a workload.  I
seem to capture all of the Q events, but nothing else.  I tried
running blktrace again but including the individual drives as well as
the RAID device, and I got a few C events, but only a small fraction.
What could cause this?  How do I fix it?

Thanks,
Adam
