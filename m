From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 07 May 2020 18:22:53 +0000
Subject: Re: [PATCH v2 0/4] Split io tracing
Message-Id: <165bfd3a-06d4-e86c-632a-15ab469984af@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 4/13/20 1:01 PM, Andreas Gruenbacher wrote:
> Hi,
> 
> here's an update of the patches posted on April 6.  We recently ran into
> bio splitting problems in the kernel.  A typical request would show up
> in the blktrace output as follows or worse:
> 
>   253,2    8       23     0.041305439  4907  Q   R 645838360 + 896 [dd]
>   253,2    8       24     0.041307791  4907  X   R 645838360 / 645838872 [dd]
>   253,2    8       25     0.041308789  4907  X   R 645838360 / 645838592 [dd]
>   253,2    8       26     0.041313578  4907  X   R 645838872 / 645839104 [dd]
>   253,2    8       27     0.041319035  4907  X   R 645838592 / 645838848 [dd]
>   [...]
>   253,2    8       68     0.051036527     0  C   R 645839104 + 152 [0]
> 
> The kernel bug leading to this kind of result (a split into
> 232-256-24-232-152 instead of 232-256-256-152) has meanwhile been fixed,
> but those kinds of traces remain difficult to read, for two reasons:
> 
>   First, the sector and length of the completion don't match the
> request.  This isn't what it says in the blkparse manual page, it's hard
> to match a request to the corresponding completion, and it causes the
> statistics to be off as well.
> 
>   Second, it's difficult to figure out which pieces a request is getting
> split into.
> 
> I don't have a good answer to the second problem, but this patch queue
> addresses the first problem by fixing up sector and length of split
> completions at least.  The last line above would turn into:
> 
>   253,2    8       68     0.051036527     0  C   R 645838360 + 896 [0]

Applied, thanks.

-- 
Jens Axboe
