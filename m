Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF624167F;
	Wed,  1 Oct 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300451; cv=none; b=bAZ0lbQwtkcvTkESmhMKdylw3NOl7Af8RTyjI5O5l9wz0rNz1NerEWkwmTZ2G/jNzXHQ+fS/LowLvK4yuiAOCQyF4Ws7pJteQSCy4z8+kgUeCEz7E+/B59zid17MsSoi/TarU7eSHxkOX7Z5CCre/82gTk1Pqcv9TK1CpSDpsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300451; c=relaxed/simple;
	bh=doL4hlKEEJBH/OIEfDpzlTKt1iwH4N4QUC4nzD6TOB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzEmywgpyod263HnotLDDEKWE3NrLfELvk2vsCHn9UInA8t4cq+DBwn/l8/kTFgzgiObgVXdfOpCOscgruFsLbLvdwM+KepAj9nQw7HbCRra+R5KdEeVoc2URXFqKU5/ATd9xCKVJmgKUiezeC1IWfnlUY1ynk1sRYEKk30jAAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHIYwXza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHIYwXza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07075C4CEF4;
	Wed,  1 Oct 2025 06:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759300450;
	bh=doL4hlKEEJBH/OIEfDpzlTKt1iwH4N4QUC4nzD6TOB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LHIYwXzaIMpTCPguBQSwYDe7HYi99HLeijDmb/jk2IJEInmnFg2d7UbC5RMmb6nsg
	 PIXj/i0GIfGTD0tiRiWNjoBgtHxZn1qdj2QBFeQ3EbGlPpJygcnTca1iIyEtMUYZ+K
	 uO4n+U49ukHYgJ0yHmZq9al52DXdP+zkKgAoqFOT82mb9FtTFrB3uVVr2t4VwS35Nr
	 XlqmPL8VXe7xzSNWEsafBAhP7UrUfMnLJHo/PTF6jCU0eRCmJJoTmOIqej64L/eb7q
	 pDuaI2KZapqK3to5+Fwd/N8ZMauJiageKASuXuHHC3S8cJ50aBRcf72yd43rBwhlnQ
	 4HdoMKtNpKgqw==
Message-ID: <468e3652-2540-42ec-bd2a-af76bbbc5684@kernel.org>
Date: Wed, 1 Oct 2025 15:34:02 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] blktrace: pass blk_user_trace2 to setup
 functions
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-9-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-9-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Pass struct blk_user_trace_setup2 to blktrace_setup_finalize(). This
> prepares for the incoming extension of the blktrace protocol with a 64bit
> act_mask.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below.

> @@ -649,7 +659,9 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  		mutex_unlock(&q->debugfs_mutex);
>  		return PTR_ERR(bt);
>  	}
> -	blk_trace_setup_finalize(q, name, bt, &buts);
> +	bt->version = 1;
> +	blk_trace_setup_finalize(q, name, bt, &buts2);

I wonder if it may not be cleaner to pass the version number to
blk_trace_setup_finalize() and have that function do "bt->version = version;" ?


> +	strcpy(buts.name, buts2.name);
>  	mutex_unlock(&q->debugfs_mutex);
>  
>  	if (copy_to_user(arg, &buts, sizeof(buts))) {
> @@ -665,7 +677,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
>  				  dev_t dev, struct block_device *bdev,
>  				  char __user *arg)
>  {
> -	struct blk_user_trace_setup buts;
> +	struct blk_user_trace_setup2 buts2;
>  	struct compat_blk_user_trace_setup cbuts;
>  	struct blk_trace *bt;
>  
> @@ -675,7 +687,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
>  	if (!cbuts.buf_size || !cbuts.buf_nr)
>  		return -EINVAL;
>  
> -	buts = (struct blk_user_trace_setup) {
> +	buts2 = (struct blk_user_trace_setup2) {
>  		.act_mask = cbuts.act_mask,
>  		.buf_size = cbuts.buf_size,
>  		.buf_nr = cbuts.buf_nr,
> @@ -685,16 +697,17 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
>  	};
>  
>  	mutex_lock(&q->debugfs_mutex);
> -	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
> +	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
>  				     bdev);
>  	if (IS_ERR(bt)) {
>  		mutex_unlock(&q->debugfs_mutex);
>  		return PTR_ERR(bt);
>  	}
> -	blk_trace_setup_finalize(q, name, bt, &buts);
> +	bt->version = 1;
> +	blk_trace_setup_finalize(q, name, bt, &buts2);
>  	mutex_unlock(&q->debugfs_mutex);
>  
> -	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
> +	if (copy_to_user(arg, &buts2.name, ARRAY_SIZE(buts2.name))) {
>  		blk_trace_remove(q);
>  		return -EFAULT;
>  	}


-- 
Damien Le Moal
Western Digital Research
