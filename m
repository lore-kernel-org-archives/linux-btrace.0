From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 30 Oct 2008 14:08:00 +0000
Subject: Version 1.0.0
Message-Id: <20081030140800.GV31673@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi everyone,

I've bumped version numbers and tagged version 1.0.0 in the repo. Of
course I had to do one change before doing that, so I updated the red
black tree code to a more recent version that unifies the parent pointer
and color information, saving space in the rb_node. That's quite
important on blktrace, where we can have millions of nodes.

Anyway, enjoy :-)

-- 
Jens Axboe

