From: Chris Mason <clm@fb.com>
Date: Fri, 31 Aug 2018 20:59:11 +0000
Subject: Re: [patch] iowatcher: spwan NPROCESSORS_ONLN rsvg-convert-s
Message-Id: <B939EB8B-FF1A-4150-BE6A-B7A10A4FDA24@fb.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49pnxywbj5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 31 Aug 2018, at 16:56, Jeff Moyer wrote:

> Jeff Moyer <jmoyer@redhat.com> writes:
>
>> iowatcher currently always spawns 8 rsvg-convert processes, no matter
>> how many CPUs a system has.  I did some limited testing of different
>> numbers of rsvg-convert processes.  Here are the results:
>
> I forgot to mention that my system has 20 hyperthreads.
>
> Jens, can you also fix the spwan typo in the subject when you commit
> this?

Reviewed-by: Chris Mason <clm@fb.com> but only if the typo stays.

-chris
