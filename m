From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 24 Sep 2014 19:57:17 +0000
Subject: Re: [GIT PULL] merge iowatcher under blktrace repo
Message-Id: <5423221D.8090202@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <54231E9E.5000004@fb.com>
In-Reply-To: <54231E9E.5000004@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/24/2014 01:42 PM, Chris Mason wrote:
> Hi everyone,
> 
> iowatcher is a program I use to generate graphs and animations from
> blktrace results.  It can also generate basic bandwidth numbers from fio
> runs.
> 
> You can see basic usage instructions and a few examples here:
> 
> http://masoncoding.com/iowatcher/
> 
> The general idea is that iowatcher is a lot like seekwatcher was, but
> instead of using python and matplotlib, I generate svg files directly
> from C.  This means it has no dependencies and is much faster.  I've
> been maintaining it in a separate repo, but it's small enough to toss
> into blktrace.
> 
> I rewrote the iowatcher repo to place it under blktrace, and it's
> available for pulling here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mason/blktrace.git master
> 
> You can see from the stats below that I've had some help on iowatcher.
> Many thanks to Andrew Price for working on packages, documentation, fixes
> and usability.  Jan Kara also spent a bunch of time porting his
> per-process IO graphing over from seekwatcher.

This has now been pulled in, and I've bumped the package version from
1.0.5 to 1.1.0 to signify that people should update their distro packages.

-- 
Jens Axboe

