From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 11 May 2007 13:43:44 +0000
Subject: Re: [PATCH btrace] Add in -r support for btrace
Message-Id: <20070511134343.GD4629@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46446DDF.7050108@pobox.com>
In-Reply-To: <46446DDF.7050108@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, May 11 2007, Alan D. Brunelle wrote:
> Using Ubuntu, debugfs is mounted on /debug instead of /sys/kernel/debug. 
> [Perhaps, we should put in blktrace a search through "common" areas 
> where debug could be mounted, and or do a simple parsing of the output 
> from a 'mount' command to /find/ the directory.]

A search would be nice, probably /debug and /sys/kernel/debug are the
only ones we are likely to see (unless the user is on an older system
and decided to put it elsewhere manually).

For now I committed the updated btrace.

-- 
Jens Axboe

