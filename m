From: Linda Walsh <lkml@tlinx.org>
Date: Fri, 18 Jan 2008 08:38:15 +0000
Subject: blktrace & btrace usability
Message-Id: <47906577.8090604@tlinx.org>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I was examining the SuSE10.3 boot process and noted
it is setup to start & stop blktrace while the system
is booting.  Odd think is that it checks to verify that
the root file system is of type "ext3". 

Is that a "SuSEism" or is there some reason why it wouldn't
work with any file system?

linda

