From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Wed, 03 Jul 2019 00:19:04 +0000
Subject: Re: [PATCH V3 1/9] block: add a helper function to read nr_setcs
Message-Id: <20190703001904.GB15705@minwoo-desktop>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
 <20190702174236.3332-2-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190702174236.3332-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-block@vger.kernel.org, colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>

On 19-07-02 10:42:27, Chaitanya Kulkarni wrote:
> This patch introduces helper function to read the number of sectors
> from struct block_device->bd_part member. For more details Please refer
> to the comment in the include/linux/genhd.h for part_nr_sects_read().

Without bd_mutex locked, this helper seems useful to have.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
