Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0223ABA0;
	Thu, 16 Oct 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598533; cv=none; b=hHvu1FP4V5TxYmBJLvwnHoxaankD0PuFm1G5z47ESnUhPZGdODoE5JGn5IwF1TPBfEeNPwGo5sLh2Ci3xzPssH8xN1fHXjpicyYYV8ajEx0VxCuV77Y1pdHCcYWB8RyazXUMkwF4S2qT9+4o74Ic7E1HTgcItZ3kKz0ikll7rwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598533; c=relaxed/simple;
	bh=mPIXYbGYdsIFGjTqdXiki5vuwIuAYUlrF0tSYv8UWGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9KdPdTk5QM762ctv/PtJCdqzWFpKl3cls/NpGMBInOI+Rgk9CIsFdRYaOHMfKsbSeNNnMHmzbh0NEmxhF7hViVV0z7Il4Ih5ru86nYyshSpqMXOX3urgJbuOeLDAg2luZ6t5qj8l2sOsXLih72sYcwCIAuu3d3O35dGYCqoqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08440227A87; Thu, 16 Oct 2025 09:08:48 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:08:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 13/16] blktrace: add block trace commands for zone
 operations
Message-ID: <20251016070847.GE1417@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-14-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-14-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 15, 2025 at 12:54:32PM +0200, Johannes Thumshirn wrote:
> Add block trace commands for zone operations.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  include/uapi/linux/blktrace_api.h | 13 +++++++++++--
>  kernel/trace/blktrace.c           | 25 +++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> index 3a771b9802aa..925f78af939e 100644
> --- a/include/uapi/linux/blktrace_api.h
> +++ b/include/uapi/linux/blktrace_api.h
> @@ -26,11 +26,20 @@ enum blktrace_cat {
>  	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
>  	BLK_TC_FUA	= 1 << 15,	/* fua requests */
>  
> -	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
> +	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
> +
> +	BLK_TC_ZONE_APPEND	= 1ull << 16,  	/* zone append */

Should BLK_TC_ZONE_APPEND be BLK_TC_END_V1?  Or is BLK_TC_END_V1 going
ot be used as the catchall for everything not reported in v1?

