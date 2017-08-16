From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Date: Wed, 16 Aug 2017 02:31:37 +0000
Subject: Re: [PATCH] blkparse: man - Elaborate definitions of RWBS fields.
Message-Id: <17d078eb-e600-2277-b434-d62b74859159@suse.de>
List-Id: <linux-btrace.vger.kernel.org>
References: <20170815211752.9643-1-rgoldwyn@suse.de>
In-Reply-To: <20170815211752.9643-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org



On 08/15/2017 04:17 PM, Goldwyn Rodrigues wrote:
> The RWBS fields can output more fields, which need detailed description.
> This information is extracted from fill_rwbs() function. If there is more
> to it, I'd be happy to include it.
> 
> I did not see Barrier Operations in the fill_rwbs() function. Also,

Barrier Operations have long been removed. So, this seems correct.

-- 
Goldwyn
