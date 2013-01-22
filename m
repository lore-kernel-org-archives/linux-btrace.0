From: Andrew Goodbody <ajg02@elfringham.co.uk>
Date: Tue, 22 Jan 2013 18:50:44 +0000
Subject: blktrace and exclusive access problem
Message-Id: <50FEDF84.6070901@elfringham.co.uk>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I am trying to blktrace a scsi scanner on /dev/sg7 but unfortunately the 
program opens that device for exclusive access so when I try and start 
blktrace I get the following
Invalid path /dev/sg7 specified: 16/Device or resource busy

This is on Debian testing, with kernel version 3.2.0-4-amd64 and no 
support for /proc/scsci.

Is there any way around this? I did try to search the list archives but 
I found nothing relevant.

Thanks,
Andrew
