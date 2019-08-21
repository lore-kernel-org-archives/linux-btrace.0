From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 21 Aug 2019 15:18:29 +0000
Subject: Re: [PATCH V5 1/9] block: add a helper function to read nr_setcs
Message-Id: <3e0917fc-290e-d1e6-3ba9-936accda0a2b@acm.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190821061423.3408-1-chaitanya.kulkarni@wdc.com>
 <20190821061423.3408-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190821061423.3408-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-block@vger.kernel.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, linux-scsi@vger.kernel.org

On 8/20/19 11:14 PM, Chaitanya Kulkarni wrote:
> This patch introduces helper function to read the number of sectors
> from struct block_device->bd_part member. For more details Please refer
> to the comment in the include/linux/genhd.h for part_nr_sects_read().
> 
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@xxxxxxxxxx>
                                                    ^^^^^^^^^^
This looks weird.
