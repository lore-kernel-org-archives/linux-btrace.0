From: Vikram Oberoi <voberoi@gmail.com>
Date: Sun, 31 May 2009 23:25:02 +0000
Subject: Questions about btt output
Message-Id: <d66e59810905311625j59b9fe56n8d256b38469c7772@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hey folks,

I have three specific questions about btt's output. I've searched the
list, Google, and read the user guide, but I'm still not completely
sure what the answers are. I'm finally posting my questions here, and
I hope I'm not in the wrong place or going against etiquette by doing
so! Please let me know if I am. Here are my questions:

Under "Device Merge Information", are BLKmin/BLKavg/BLKmax the
min/avg/max I/O size in *number of filesystem blocks* (in my case, 4
KB each) being *issued to the device*?

Under "Device Seek Information", is the mean seek distance *the
average number of 512 byte disk sectors* over which the disk head had
to move before beginning its next IO? Finally, are the median and mode
also *distances*? If so, I find it hard to believe that my mean seek
distance is regularly in the tens or hundreds of thousands of disk
sectors when the mode -- always 0 -- constitutes over 95% of my seek
distances. Or is there a gap in my understanding here?

Thanks,
Vikram
