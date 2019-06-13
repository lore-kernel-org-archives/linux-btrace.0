From: Douglas Gilbert <dgilbert@interlog.com>
Date: Thu, 13 Jun 2019 16:07:09 +0000
Subject: Re: [PATCH 1/8] block: add a helper function to read nr_setcs
Message-Id: <f8ab9587-309b-79a0-e6fc-f6683176f498@interlog.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190613145955.4813-1-chaitanya.kulkarni@wdc.com>
 <20190613145955.4813-2-chaitanya.kulkarni@wdc.com>
 <9abfc2b8-4496-db7a-fcbb-b52102a67f8e@acm.org>
In-Reply-To: <9abfc2b8-4496-db7a-fcbb-b52102a67f8e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bart Van Assche <bvanassche@acm.org>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-scsi@vger.kernel.org, linux-btrace@vger.kernel.org, kent.overstreet@gmail.com, jaegeuk@kernel.org, damien.lemoal@wdc.com

On 2019-06-13 11:31 a.m., Bart Van Assche wrote:
> On 6/13/19 7:59 AM, Chaitanya Kulkarni wrote:
>> This patch introduces helper function to read the number of sectors
>> from struct block_device->bd_part member. For more details Please refer
>> to the comment in the include/linux/genhd.h for part_nr_sects_read().
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>   include/linux/blkdev.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 592669bcc536..1ae65107182a 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1475,6 +1475,18 @@ static inline void put_dev_sector(Sector p)
>>       put_page(p.v);
>>   }
>> +/* Helper function to read the bdev->bd_part->nr_sects */
>> +static inline sector_t bdev_nr_sects(struct block_device *bdev)
>> +{
>> +    sector_t nr_sects;
>> +
>> +    rcu_read_lock();
>> +    nr_sects = part_nr_sects_read(bdev->bd_part);
>> +    rcu_read_unlock();
>> +
>> +    return nr_sects;
>> +}
>> +
>>   int kblockd_schedule_work(struct work_struct *work);
>>   int kblockd_schedule_work_on(int cpu, struct work_struct *work);
>>   int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, 
>> unsigned long delay);
>>
> 
> Please explain what makes you think that part_nr_sects_read() must be protected 
> by an RCU read lock.

Dear reviewer,
Please rephrase the above sentence without the accusative tone.
Specifically, please do not use the phrase "what makes you think"
in this or any other code review. For example: "I believe that..."
is more accurate and less provocative.


Observation: as a Canadian citizen when crossing the US border I
believe contradicting a US border official with the phrase "what
makes you think ..." could lead to a rather bad outcome :-)
Please make review comments with that in mind.

Thanks.

Doug Gilbert

P.S. Do we have any Linux code-of-conduct for reviewers?
