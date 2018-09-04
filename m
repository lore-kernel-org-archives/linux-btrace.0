From: Jeff Moyer <jmoyer@redhat.com>
Date: Tue, 04 Sep 2018 10:42:26 +0000
Subject: Re: [patch] iowatcher: spwan NPROCESSORS_ONLN rsvg-convert-s
Message-Id: <x49o9ddfsrx.fsf@segfault.boston.devel.redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 8/31/18 2:59 PM, Chris Mason wrote:
>> On 31 Aug 2018, at 16:56, Jeff Moyer wrote:
>> 
>>> Jeff Moyer <jmoyer@redhat.com> writes:
>>>
>>>> iowatcher currently always spawns 8 rsvg-convert processes, no matter
>>>> how many CPUs a system has.  I did some limited testing of different
>>>> numbers of rsvg-convert processes.  Here are the results:
>>>
>>> I forgot to mention that my system has 20 hyperthreads.
>>>
>>> Jens, can you also fix the spwan typo in the subject when you commit
>>> this?
>> 
>> Reviewed-by: Chris Mason <clm@fb.com> but only if the typo stays.
>
> Haha damn, well I guess that worked out, since I committed it 5 min
> ago, without the reviewed-by, but with typo fixed :-)

You guys crack me up.

Jeff
