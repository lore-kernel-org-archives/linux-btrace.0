From: nigel@suspend2.net
Date: Sun, 13 Jan 2008 22:54:50 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <478A96BA.3040503@suspend2.net>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk> <478736C6.3080802@suspend2.net> <20080111093211.GC8143@elte.hu>
In-Reply-To: <20080111093211.GC8143@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <jens.axboe@oracle.com>, David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

Hi.

Ingo Molnar wrote:
> * nigel@suspend2.net <nigel@suspend2.net> wrote:
> 
>>>>> Just out of curiosity, could you try the appended cumulative patch 
>>>>> and report .clock_warps, .clock_overflows and .clock_underflows as 
>>>>> you did.
>>>> With those patches, CONFIG_NO_HZ works just fine.
>> Could these patches also help with hibernation issues? I'm trying 
>> x86_64+NO_HZ, and seeing activity delayed during the atomic copy and 
>> afterwards until I manually generate interrupts (by pressing keys).
> 
> i dont think that should be related to cpu_clock() use. Does the patch 
> below make any difference? (or could you try x86.git to get the whole 
> stack of x86 changes that we have at the moment.) Here's the coordinates 
> for x86.git:

Sorry for the delay in replying. Something seems to help, but I haven't
managed to identify what yet. I don't think it was the patch appended
because I'm on UP. If you care, I'll see if I can find the time to look
more carefully.

Nigel

