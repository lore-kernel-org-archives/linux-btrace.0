From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Mon, 17 Jun 2019 16:56:11 +0000
Subject: Re: [PATCH V2 5/7] bcache: update cached_dev_init() with helper
Message-Id: <BYAPR04MB5749C877C444A5A2144A921886EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
 <20190617012832.4311-6-chaitanya.kulkarni@wdc.com>
 <ae48b013-6e5f-1300-557e-1dbe0f4ad31c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: Coly Li <colyli@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>

On 06/16/2019 11:54 PM, Coly Li wrote:
> On 2019/6/17 9:28 上午, Chaitanya Kulkarni wrote:
>> In the bcache when initializing the device we don't actually use any
>> sort of locking when reading the number of sectors from the part. This
>> patch updates the cached_dev_init() with newly introduced helper
>> function to read the nr_sects from block device's hd_parts with the help
>> of part_nr_sects_read().
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
> Acked-by: Coly Li <colyli@suse.de>

Thanks Coly.
>
> Thanks.
>
> Coly Li
>
>> ---
>>   drivers/md/bcache/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 1b63ac876169..6a29ba89dae1 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1263,7 +1263,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>>   			q->limits.raid_partial_stripes_expensive;
>>
>>   	ret = bcache_device_init(&dc->disk, block_size,
>> -			 dc->bdev->bd_part->nr_sects - dc->sb.data_offset);
>> +			 bdev_nr_sects(dc->bdev) - dc->sb.data_offset);
>>   	if (ret)
>>   		return ret;
>>
>>
>

