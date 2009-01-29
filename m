From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 29 Jan 2009 21:28:45 +0000
Subject: -b vs. -n
Message-Id: <49821F8D.4050207@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Has anybody experimented with increasing the _number_ of buffers rather
than the _size_ of the buffers when confronted with drops? I'm finding
on a large(ish) system that it is better to have lots of small buffers
handled by relay rather than fewer larger buffers. In my particular case:

16 CPUs
96 devices
running some dd's against all the devices...

-b 1024 or -b 2048 still results in drops

but:

-n 512 -b 16 allows things to run smoother.

I _think_ this may have to do with the way relay reports POLLIN: it does
it only when a buffer switch happens as opposed to when there is data
ready. Need to look at this some more, but just wondering if others out
there have found similar things in their testing...

Alan
