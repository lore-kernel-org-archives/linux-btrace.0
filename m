From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 17 Jul 2019 02:28:30 +0000
Subject: Re: [PATCH V4 1/9] block: add a helper function to read nr_setcs
Message-Id: <yq1sgr5z969.fsf@oracle.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190708184711.2984-1-chaitanya.kulkarni@wdc.com>
        <20190708184711.2984-2-chaitanya.kulkarni@wdc.com>
        <yq18st457yb.fsf@oracle.com>
        <BYAPR04MB5749AF90A9E9C81B4A6857F386F20@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749AF90A9E9C81B4A6857F386F20@BYAPR04MB5749.namprd04.prod.outlook.com>
        (Chaitanya Kulkarni's message of "Fri, 12 Jul 2019 16:09:56 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "colyli@suse.de" <colyli@suse.de>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>, "yuchao0@huawei.com" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com" <roger.pau@citrix.com>, "bvanassche@acm.org" <bvanassche@acm.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>


Chaitanya,

> This series just replaces the existing accesses without changing
> anything.
>
> So if any of the exiting code has that bug then it will blow up
> nicely.
>
> For future callers I don't mind adding a new check and resend the
> series.
>
> Would you prefer adding a check ?

I checked your call sites and they look fine. Also, I don't think
returning a capacity of 0 on error is going to help us much.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
