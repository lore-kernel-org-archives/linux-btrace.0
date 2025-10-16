Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6F2F99A6;
	Thu, 16 Oct 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598680; cv=none; b=nbPf7O38El+9lP5/3gSpRCTFiwVRQ151Zyc2mLts3UhLb3JvzNi4+yFEMGYzwVHv8HyOXpxB0ooWeS5mYrSRFQVD9mN6A7A9J3Bhg62J3NWIz2qDUA+U9xZwBknHL+bfZ6JM9P/yznye1kSQLZLnHuQ5oMAj7RP1v6BDguKgItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598680; c=relaxed/simple;
	bh=g749GOFcAzGtuaoUmGpwn4g/dk+RBhS0iy5fb8BNR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCt8dd3MovMr89JqF7dKYGqFuJ80cddNU9hHtep+BN9Chg7FSTWUdLeqfKtR66H9EYEJV3O+dcuX88MO9JWeU9p+3bK+T2LDLErAvUkzidbkWttzjRDCAV7JaAgOh2Ckx9BI8x/8cAfTfFfX08A8/YVuOJyNuCw2qSHZJ87kHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4E05227A87; Thu, 16 Oct 2025 09:11:15 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:11:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 16/16] blktrace: handle BLKTRACESETUP2 ioctl
Message-ID: <20251016071115.GH1417@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-17-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-17-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
> +			    struct block_device *bdev, char __user *arg)
> +{
> +	struct blk_user_trace_setup2 buts2;
> +	struct blk_trace *bt;
> +	int ret;
> +
> +	ret = copy_from_user(&buts2, arg, sizeof(buts2));
> +	if (ret)
> +		return -EFAULT;

You can simplify this to the more usual:

	if (copy_from_user(&buts2, arg, sizeof(buts2)))
		return -EFAULT;

> +
> +	if (!buts2.buf_size || !buts2.buf_nr)
> +		return -EINVAL;

This should probably also check that nothing is set in the flags field
so that it can be used for backwards compatible extensions?

