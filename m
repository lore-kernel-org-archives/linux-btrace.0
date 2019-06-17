From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Mon, 17 Jun 2019 16:55:43 +0000
Subject: Re: [PATCH V2 1/7] block: add a helper function to read nr_setcs
Message-Id: <BYAPR04MB5749AC0801F021068F84F81186EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
 <20190617012832.4311-2-chaitanya.kulkarni@wdc.com>
 <67bcc55e-a674-7a71-7ce3-3a6745977740@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "colyli@suse.de" <colyli@suse.de>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>

On 06/17/2019 08:47 AM, Bart Van Assche wrote:
> On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
>> This patch introduces helper function to read the number of sectors
>> from struct block_device->bd_part member. For more details Please refer
>> to the comment in the include/linux/genhd.h for part_nr_sects_read().
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>    include/linux/blkdev.h | 10 ++++++++++
>>    1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 592669bcc536..2ef1de20fd22 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1475,6 +1475,16 @@ static inline void put_dev_sector(Sector p)
>>    	put_page(p.v);
>>    }
>>
>> +/* Helper function to read the bdev->bd_part->nr_sects */
>> +static inline sector_t bdev_nr_sects(struct block_device *bdev)
>> +{
>> +	sector_t nr_sects;
>> +
>> +	nr_sects = part_nr_sects_read(bdev->bd_part);
>> +
>> +	return nr_sects;
>> +}
>
> Although this looks fine to me, is there any reason why the body of that
> function has not been written as follows?
>
> static inline sector_t bdev_nr_sects(struct block_device *bdev)
> {
> 	return part_nr_sects_read(bdev->bd_part);
> }
This perfectly make sense, thanks for the suggestion, will add it in a 
next version.
>
> Thanks,
>
> Bart.
>

