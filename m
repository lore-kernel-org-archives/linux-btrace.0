From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Date: Fri, 12 Jul 2019 16:09:56 +0000
Subject: Re: [PATCH V4 1/9] block: add a helper function to read nr_setcs
Message-Id: <BYAPR04MB5749AF90A9E9C81B4A6857F386F20@BYAPR04MB5749.namprd04.prod.outlook.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
 <20190708184711.2984-2-chaitanya.kulkarni@wdc.com>
 <yq18st457yb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "colyli@suse.de" <colyli@suse.de>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "yuchao0@huawei.com" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com" <roger.pau@citrix.com>, "bvanassche@acm.org" <bvanassche@acm.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>

On 7/11/19 6:59 PM, Martin K. Petersen wrote:
> Hi Chaitanya,
>
>> +static inline sector_t bdev_nr_sects(struct block_device *bdev)
>> +{
>> +	return part_nr_sects_read(bdev->bd_part);
>> +}
> Can bdev end up being NULL in any of the call sites?
>
> Otherwise no objections.
>
Thanks for mentioning that. Initial version which was not posted had
that check.

This series just replaces the existing accesses without changing anything.

So if any of the exiting code has that bug then it will blow up nicely.

For future callers I don't mind adding a new check and resend the series.

Would you prefer adding a check  ?


