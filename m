From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Mon, 20 Sep 2010 14:35:21 +0000
Subject: Re: [PATCH] blktrace: disallow -o when using multiple devices
Message-Id: <4C977129.2020904@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4C9227C3.7000404@netezza.com>
In-Reply-To: <4C9227C3.7000404@netezza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/16/2010 05:17 PM, Brett Russ wrote:
> On 09/16/2010 10:20 AM, Brett Russ wrote:
>> -Wouldn't it be a good idea to just add<prefix> before the filename(s)
>> that would have been created in either the single or multiple device
>> case? I.e. in the multiple device case, how about
>> "<prefix>.<device>.blktrace.<cpu>"? That way the program always does
>> what the user wants, no special case documentation required.
>
> I just now read in full your second email on the original thread where
> you mentioned doing this solution, sorry for the redundancy. You
> expressed reservations about it, wondering what else it might break. I'd
> suggest we make the change and test it, rather than having a "-o" option
> with limited utility? I imagine the biggest question mark is how
> blkparse handles it.
>
> -Brett

I'm not so sure about this Brett - people may have scripts out there 
that depend on the current semantics. I'd be OK with doing it if Jens 
thought this was a minor concern...

Regards,
Alan
