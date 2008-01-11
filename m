From: nigel@suspend2.net
Date: Fri, 11 Jan 2008 09:28:38 +0000
Subject: Re: CONFIG_NO_HZ breaks blktrace timestamps
Message-Id: <478736C6.3080802@suspend2.net>
List-Id: <linux-btrace.vger.kernel.org>
References: <1199918912.8388.13.camel@lap75545.ornl.gov> <1199996752.9159.46.camel@lap75545.ornl.gov> <20080110234438.4826f658@inria.fr> <1200020661.5099.3.camel@obelisk.thedillows.org> <20080111090723.GI6258@kernel.dk>
In-Reply-To: <20080111090723.GI6258@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <jens.axboe@oracle.com>
Cc: David Dillow <dillowda@ornl.gov>, Guillaume Chazarain <guichaz@yahoo.fr>, linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

Hi.

Jens Axboe wrote:
> On Thu, Jan 10 2008, David Dillow wrote:
>> On Thu, 2008-01-10 at 23:44 +0100, Guillaume Chazarain wrote:
>>> David Dillow <dillowda@ornl.gov> wrote:
>>>
>>>> At the moment, I'm not sure how to track this farther, or how to fix it
>>>> properly. Any advice would be appreciated.
>>> Just out of curiosity, could you try the appended cumulative patch and
>>> report .clock_warps, .clock_overflows and .clock_underflows as you did.
>> With those patches, CONFIG_NO_HZ works just fine.

Could these patches also help with hibernation issues? I'm trying
x86_64+NO_HZ, and seeing activity delayed during the atomic copy and
afterwards until I manually generate interrupts (by pressing keys).

Regards,

Nigel

