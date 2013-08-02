From: Nathan Zimmer <nzimmer@sgi.com>
Date: Fri, 02 Aug 2013 12:43:18 +0000
Subject: Re: [PATCH 0/5] Improve scaling and hotplugging tolerance in blktrace and friends
Message-Id: <51FBA966.2070501@sgi.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
In-Reply-To: <1366037616-20159-1-git-send-email-nzimmer@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

On 08/01/2013 01:11 PM, Jens Axboe wrote:
> On Thu, Aug 01 2013, Jens Axboe wrote:
>> On 07/30/2013 01:29 PM, Nathan Zimmer wrote:
>>> On 04/16/2013 01:02 AM, Jens Axboe wrote:
>>>> On Mon, Apr 15 2013, Nathan Zimmer wrote:
>>>>> While looking for issues at 4096 cpus I noticed that blktrace was
>>>>> behaving
>>>>> oddly.  Upon reviewing I discovered some parts of the code were
>>>>> written at at
>>>>> time when boxes were limited to 512 and holes in cpu maps were
>>>>> impossible.
>>>>>
>>>>> This patch series should correct that.
>>>> Thanks Nathan. I reviewed all 5 and have applied them.
>>>>
>>> Have you pushed the patches lately?
>>> I checked the public branch git://git.kernel.dk/blktrace.git and I
>>> didn't see my changes.
>> I wonder if I applied and forgot to push them out. Unfortunately my
>> workstation is in transit at the moment. But I can just re-apply here
>> and get it pushed out, sorry about that.
> Doesn't work so well for me:
>
> gcc -Wall -W -O2 -g -I. -I.. -I../btt -D_GNU_SOURCE -D_LARGEFILE_SOURCE
> -D_FILE_OFFSET_BITSd -UCOUNT_IOS -UDEBUG -DNDEBUG -c -o btreplay.o
> btreplay.c
> btreplay.c: In function ‘pin_to_cpu’:
> btreplay.c:554:2: error: request for member ‘__bits’ in something not a
> structure or union
>
>          CPU_SET_S(tip->cpu, size, &cpus);
>
> This should do it:
>
> -       CPU_ZERO_S(ncpus, &cpus);
> -       CPU_SET_S(tip->cpu, size, &cpus);
> +       CPU_ZERO_S(ncpus, cpus);
> +       CPU_SET_S(tip->cpu, size, cpus);
>
Yea that seems to.  Thanks
