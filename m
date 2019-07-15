From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Date: Mon, 15 Jul 2019 10:36:40 +0000
Subject: Re: [PATCH V4 9/9] xen/blkback: use helper in vbd_sz()
Message-Id: <20190715103640.i6gwasdjdkltm47n@MacBook-Air-de-Roger.local>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
 <20190708184711.2984-10-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20190708184711.2984-10-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-block@vger.kernel.org, colyli@suse.de, linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org, xen-devel@lists.xenproject.org, kent.overstreet@gmail.com, yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com, konrad.wilk@oracle.com, bvanassche@acm.org, linux-scsi@vger.kernel.org

On Mon, Jul 08, 2019 at 11:47:11AM -0700, Chaitanya Kulkarni wrote:
> This patch updates the vbd_sz() macro with newly introduced helper
> function to read the nr_sects from block device's hd_parts with the
> help of part_nr_sects_read().
>=20
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Acked-by: Roger Pau Monn=E9 <roger.pau@citrix.com>

Thanks, Roger.
