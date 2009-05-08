From: Eric Sandeen <sandeen@redhat.com>
Date: Fri, 08 May 2009 16:22:09 +0000
Subject: Re: [PATCH] blkiomon: fix unaligned accesses on ia64
Message-Id: <4A045C31.9080205@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <4A0205FD.7070004@redhat.com>
In-Reply-To: <4A0205FD.7070004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Martin Peschke wrote:
> Eric,
> I think you have got a valid point. But I would like to make two small
> changes to you patch:
> 
> A new blkiomon version number is needed then. Not a perfect solution for
> reflecting this change, but good enough at least for our tool that
> consumes blkiomon data through a message queue.
> 
> Moving the __u32 device member instead of a new padding field should be
> fine.
> 
> I have tested the patch below. If it's fine with you, please just push
> it upstream through Jens.
> 
> Thanks,
> Martin
> 
>
> 
> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Thanks Martin -

Sure, that way looks fine to me too.  I suppose adding the explicit pad
doesn't actually change anything on most architectures, so maybe that's
a little safer without the version bump, but probably best to be
explicit about it as you have done.

Jens, want to pick up this patch instead, then?

Thanks,
-Eric


> ---
>  blkiomon.c |    2 +-
>  blkiomon.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/blkiomon.h
> +++ b/blkiomon.h
> @@ -34,6 +34,7 @@ struct blkiomon_stat {
>  	__u64 time;
>  	__u32 size_hist[BLKIOMON_SIZE_BUCKETS];
>  	__u32 d2c_hist[BLKIOMON_D2C_BUCKETS];
> +	__u32 device;
>  	struct minmax size_r;
>  	struct minmax size_w;
>  	struct minmax d2c_r;
> @@ -41,8 +42,7 @@ struct blkiomon_stat {
>  	struct minmax thrput_r;
>  	struct minmax thrput_w;
>  	__u64 bidir;
> -	__u32 device;
> -} __attribute__ ((packed));
> +};
>  
>  static struct histlog2 size_hist = {
>  	.first = 0,
> --- a/blkiomon.c
> +++ b/blkiomon.c
> @@ -71,7 +71,7 @@ struct output {
>  	int pipe;
>  };
>  
> -static char blkiomon_version[] = "0.2";
> +static char blkiomon_version[] = "0.3";
>  
>  static FILE *ifp;
>  static int interval = -1;
> 
> 
> 
> 
> On Wed, 2009-05-06 at 16:49 -0500, Eric Sandeen wrote: 
>> commit 7aa3ebcec011bfe9cc60d6476252c03376a37551 packed
>> the blkiomon_stat structure so that traces from one 
>> arch could be analyzed on another (in truth only x86
>> is different, at least from x86_64/ia64/ppc/ppc64/s390/s390x)
>>
>> Rather than packing it, which generates unaligned access
>> warnings on ia64, just pad the structure out so that it's
>> naturally aligned on all arches.
>>
>> Martin, care to test this to be sure it still works for
>> you?  (I'm not sure if we might also need a 4 byte pad on 
>> the end of the structure to align the containing structure...)
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/blkiomon.h b/blkiomon.h
>> index 2e430a6..ae48b4c 100644
>> --- a/blkiomon.h
>> +++ b/blkiomon.h
>> @@ -34,6 +34,7 @@ struct blkiomon_stat {
>>  	__u64 time;
>>  	__u32 size_hist[BLKIOMON_SIZE_BUCKETS];
>>  	__u32 d2c_hist[BLKIOMON_D2C_BUCKETS];
>> +	__u32 pad; /* Align the structure */
>>  	struct minmax size_r;
>>  	struct minmax size_w;
>>  	struct minmax d2c_r;
>> @@ -42,7 +43,7 @@ struct blkiomon_stat {
>>  	struct minmax thrput_w;
>>  	__u64 bidir;
>>  	__u32 device;
>> -} __attribute__ ((packed));
>> +};
>>
>>  static struct histlog2 size_hist = {
>>  	.first = 0,
>>
> 

