From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Wed, 03 Jul 2019 05:25:28 +0000
Subject: Re: [PATCH V3 4/9] blk-zoned: update blkdev_reset_zones() with helper
Message-Id: <20190703052528.GB21258@minwoo-desktop>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
 <20190702174236.3332-5-chaitanya.kulkarni@wdc.com>
 <20190703002347.GE15705@minwoo-desktop>
 <DM6PR04MB5754D27FC41D86E2D419DD6C86FB0@DM6PR04MB5754.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB5754D27FC41D86E2D419DD6C86FB0@DM6PR04MB5754.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "colyli@suse.de" <colyli@suse.de>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "yuchao0@huawei.com" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com" <roger.pau@citrix.com>, "bvanassche@acm.org" <bvanassche@acm.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>

On 19-07-03 02:29:33, Chaitanya Kulkarni wrote:
> On 7/2/19 5:23 PM, Minwoo Im wrote:
> > On 19-07-02 10:42:30, Chaitanya Kulkarni wrote:
> >> This patch updates the blkdev_reset_zones() with newly introduced
> >> helper function to read the nr_sects from block device's hd_parts with
> >> the help of part_nr_sects_read().
> > Chaitanya,
> >
> > Are the first three patches split for a special reason?  IMHO, it could
> > be squashed into a single one.
> >
> > It looks good to me, by the way.
> 
> In the blk-zoned.c in this way it is easier to bisect if/when the problem
> 
> comes.

Oh okay.  That makes sense.

Thanks, Chaitanya.
