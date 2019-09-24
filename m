From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 24 Sep 2019 21:29:22 +0000
Subject: Re: [PATCH] blkparse: man: add absolute timestamp printing option
Message-Id: <e93a8981-b440-8613-919a-3ad7a91dbfec@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190920050336.16191-1-hmihara@redhat.com>
In-Reply-To: <20190920050336.16191-1-hmihara@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 9/19/19 11:03 PM, Hiroaki Mihara wrote:
> The functionality of printing out absolute timestamps has been
> implemented in code but not documented in man pages.
> 
> When comparing the timings of related events with block I/O traces,
> the absolute timestams play a key role.  I think that the
> documentation of this might be beneficial to blktrace users.
> 
> The related commit was done in 2006 as follows,
> 
>> commit 7bd4fd0a4fca645bb50a641afac1e460a4e32dfd
>> Author: Olaf Kirch <okir@lst.de>
>> Date:   Fri Dec 1 10:34:11 2006 +0100
>>
>>      [PATCH] Add timestamp support
>>
>>      Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
>>
> 
> URL of the above patch,
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git/commit/?id{d4fd0a4fca645bb50a641afac1e460a4e32dfd

I guess after 13 years it's about time to document it! Thanks, applied.

-- 
Jens Axboe
