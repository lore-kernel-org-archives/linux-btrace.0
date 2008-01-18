From: Jens Axboe <jens.axboe@oracle.com>
Date: Fri, 18 Jan 2008 09:08:08 +0000
Subject: Re: blktrace & btrace usability
Message-Id: <20080118090808.GN6258@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <47906577.8090604@tlinx.org>
In-Reply-To: <47906577.8090604@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Jan 18 2008, Linda Walsh wrote:
> I was examining the SuSE10.3 boot process and noted
> it is setup to start & stop blktrace while the system
> is booting.  Odd think is that it checks to verify that
> the root file system is of type "ext3". 
> 
> Is that a "SuSEism" or is there some reason why it wouldn't
> work with any file system?

Interesting, I never noticed that before. Don't know why they check for
ext3, perhaps their post processing tools map blocks to files and only
works for ext3?

-- 
Jens Axboe

