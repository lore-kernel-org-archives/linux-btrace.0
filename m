From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 29 Oct 2007 19:48:53 +0000
Subject: Re: [PATCH] blktrace: Make sure BLKTRACETEARDOWN does the full cleanup.
Message-Id: <20071029194852.GC7499@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1193572155-11126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1193572155-11126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Oct 28 2007, Aneesh Kumar K.V wrote:
> if blktrace program segfault it will not be able
> to call BLKTRACETEARDOWN. Now if we run the blktrace
> again that would result in a failure to create the
> block/<device> debugfs directory.This will result
> in blk_remove_root() to be called which will set
> blk_tree_root to NULL. But the  debugfs block dir
> still exist because it contain subdirectory.
> 
> Now if we try to fix it using BLKTRACETEARDOWN
> it won't work because blk_tree_root is NULL.
> 
> Fix the same.
> 
> Tested as below

Looks good, will apply tomorrow after some brief testing.

-- 
Jens Axboe

