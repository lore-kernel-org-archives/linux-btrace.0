From: Jan Blunck <jblunck@suse.de>
Date: Tue, 22 Jan 2008 16:41:45 +0000
Subject: Re: blktrace & btrace usability
Message-Id: <20080122164145.GB4531@hasse.suse.de>
List-Id: <linux-btrace.vger.kernel.org>
References: <47906577.8090604@tlinx.org>
In-Reply-To: <47906577.8090604@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Fri, Jan 18, Linda Walsh wrote:

> I was examining the SuSE10.3 boot process and noted
> it is setup to start & stop blktrace while the system
> is booting.  Odd think is that it checks to verify that
> the root file system is of type "ext3". 
> Is that a "SuSEism" or is there some reason why it wouldn't
> work with any file system?

Maybe I can help here.

blktrace is used by the preload package. The preload package is capable of
remapping blocks for faster booting. Therefore we need the blktrace
output. But we only have a remapper for ext3.

Hope that helps,
Jan
