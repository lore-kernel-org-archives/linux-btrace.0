From: Brett Russ <bruss@netezza.com>
Date: Thu, 16 Sep 2010 21:17:29 +0000
Subject: Re: [PATCH] blktrace: disallow -o when using multiple devices
Message-Id: <4C928969.3090001@netezza.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4C9227C3.7000404@netezza.com>
In-Reply-To: <4C9227C3.7000404@netezza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/16/2010 10:20 AM, Brett Russ wrote:
> -Wouldn't it be a good idea to just add<prefix>  before the filename(s)
> that would have been created in either the single or multiple device
> case?  I.e. in the multiple device case, how about
> "<prefix>.<device>.blktrace.<cpu>"?  That way the program always does
> what the user wants, no special case documentation required.

I just now read in full your second email on the original thread where 
you mentioned doing this solution, sorry for the redundancy.  You 
expressed reservations about it, wondering what else it might break. 
I'd suggest we make the change and test it, rather than having a "-o" 
option with limited utility?  I imagine the biggest question mark is how 
blkparse handles it.

-Brett
