From: Paul P Komkoff Jr <i@stingr.net>
Date: Thu, 26 Jul 2007 19:39:52 +0000
Subject: Blkparse weirdness with "A" (remap) action
Message-Id: <20070726193952.GN32546@stingr.net>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi!

I'm having a little problem here. I have a setup with md over some
disks, and I'm running blktrace /dev/md? /dev/sd?, then doing blkparse
*.blktrace.*, I'm getting this kind of stuff:

 40,131071  1       67     3.043450168   420  A   W 4274944 + 8 <- (253,0) 4275328
 40,131071  1       67     3.043450168   420  A   W 4274944 + 8 <- (253,0) 4275328

The target device on the left is supposed to be 9,1 because dm0  is
mapped to a md1 (which is raid10). But in reality target device
major/minor is gibberish.

I also observe same behavior with raid0 - when requests get remapped
by raid0.

Is it known behavior or I'm doing something wrong? I'm x86_64, and
tried this on a 2.6.18-ancient and 2.6.21 fedora kernel.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
