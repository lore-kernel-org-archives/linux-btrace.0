From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 09 Apr 2018 14:36:16 +0000
Subject: Re: [PATCH 1/2] blkparse: remove duplicated entry for flag M
Message-Id: <8ee57a6d-5519-5ca1-bfaa-abe77db865b3@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <3b4a1adbd6869ab90dd2818e0248b4a8c425c188.1523092071.git.zhangweiping@didichuxing.com>
In-Reply-To: <3b4a1adbd6869ab90dd2818e0248b4a8c425c188.1523092071.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 4/9/18 8:33 AM, Steffen Maier wrote:
> 
> On 04/07/2018 11:12 AM, Weiping Zhang wrote:
>> remove dupliated entry 'M' for man page of blkparse.
>>
>> Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
>> ---
>>   doc/blkparse.1 | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/doc/blkparse.1 b/doc/blkparse.1
>> index be9b34b..b1cb6ef 100644
>> --- a/doc/blkparse.1
>> +++ b/doc/blkparse.1
>> @@ -243,10 +243,6 @@ Same as the back merge, except this i/o ends where a previously inserted
>>   requests starts.
>>
>>   .HP 4
>> -\fBM --front or back merge\fR
>> -One of the above
>> -
>> -.HP 4
>>   \fBM -- front or back merge\fR
>>   One of the above.
>>
> 
> I also found this (and other things) and plan to submit them later.
> 
> Additionally, I had the impression that 'M' is nowadays always a "back 
> merge", not "front or back merge".

'M' is a back merge, 'F' is a front merge.

-- 
Jens Axboe

