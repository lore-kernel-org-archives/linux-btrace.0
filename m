From: Nathan Zimmer <nzimmer@sgi.com>
Date: Tue, 30 Jul 2013 19:29:17 +0000
Subject: Re: [PATCH 0/5] Improve scaling and hotplugging tolerance in blktrace and friends
Message-Id: <51F8140D.3000409@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
In-Reply-To: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 04/16/2013 01:02 AM, Jens Axboe wrote:
> On Mon, Apr 15 2013, Nathan Zimmer wrote:
>> While looking for issues at 4096 cpus I noticed that blktrace was behaving
>> oddly.  Upon reviewing I discovered some parts of the code were written at at
>> time when boxes were limited to 512 and holes in cpu maps were impossible.
>>
>> This patch series should correct that.
> Thanks Nathan. I reviewed all 5 and have applied them.
>

Have you pushed the patches lately?
I checked the public branch git://git.kernel.dk/blktrace.git and I 
didn't see my changes.

Thanks,
Nate
