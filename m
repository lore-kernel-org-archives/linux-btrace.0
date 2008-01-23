From: Jan Blunck <jblunck@suse.de>
Date: Wed, 23 Jan 2008 13:27:00 +0000
Subject: Re: blktrace & btrace usability
Message-Id: <20080123132700.GI4531@hasse.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
References: <47906577.8090604@tlinx.org> <20080122164145.GB4531@hasse.suse.de> <47964B66.5020001@tlinx.org>
In-Reply-To: <47964B66.5020001@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-btrace@vger.kernel.org, Linux-Xfs <linux-xfs@oss.sgi.com>

On Tue, Jan 22, Linda Walsh wrote:

> Jan Blunck wrote:
>> blktrace is used by the preload package. The preload package is capable of
>> remapping blocks for faster booting. Therefore we need the blktrace
>> output. But we only have a remapper for ext3.
>>   
> ----
>    I wondered about that, but the blktrace package doesn't containg
> any utility for remapping blocks. The blktrace-0.99.3-12 package
> included in OSuse-10.3, I only see utilities "blkparse, blktrace, btrace,
> blkrawverify, btt, and verify_blktrace". 
>    Was it left out by accident?  ---or---

No, this is the reason why I said "blktrace is used by the preload
package". The ext3remapper is part of the preload package.

>    If the remapping is in a separate package, then shouldn't
> the blktrace package "just" do the block tracing, regardless
> of file type (i.e. in typical unix fashion, it does its part, and
> another util (a block-re-arranger) does its part...? 

Yes it is just doing that. If you only have a remapper for ext3 (I wasn't
aware of XFS) there is no point in gathering the blktrace data for other
filesystem. boot.blktrace, which is the script you are refering to is part of
the preload package. Remember that we haven't changed blktrace that it only
works for ext3 or something similar.

>    Having blktrace do it's thing no matter what filesystem
> follows might encourage or enable someone to write re-arrangers
> for other filesystems...(?)  After all, xfs already has
> one block-rearranger program (for what little it is needed)
> in "xfs_fsr".  Does ext3 have something similar now? 

Yes, the ext3remapper written by Jan Kara.
