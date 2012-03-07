From: Josh Hunt <joshhunt00@gmail.com>
Date: Wed, 07 Mar 2012 15:06:07 +0000
Subject: blkparse unplug question
Message-Id: <CAKA=qzaR2FryEq6uG299SzH14=BQVShnRvDSie0XRpwijBFsRg@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

I am trying to debug a stall I am seeing with CFQ and in the
blktrace/blkparse output I see unplugging lines like the following:

8,3    1     7809  1532.225997730   168  U   N [sync_supers] 31

My question is what does the value after the process name represent? I
see this value increasing from 1, I believe, and then eventually the
value appears to get reset.

I was also wondering if it is possible to translate the block
information provided in blktrace to the corresponding inode?

Thanks for your help!
Josh
