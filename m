Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AC1547CC;
	Wed,  1 Oct 2025 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299930; cv=none; b=UjDS3TCqUz+WuAcQHmJ0/FRJxOPqyairMMeA7n63sO+UQ60AtZVQEMzE8+vGPMd1A+1PjeTICDvniPLZHPELfDYPdOuCfoTcWx1IrBuSQqp9c3wDgVrrdAQ0w9qX2duDcn01oxfBz78X7P+bbgxd/3HTZIoNbKk94lmAu8qMy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299930; c=relaxed/simple;
	bh=/J/2bX7aEzcIPmPq+XxSl2EF1EXZeFlQ1d6ME70Ff4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQpyjAQny5TEYr76lqUgoqQ4wOV9SMCze5wJWJuu/O/AWNoOK+8PV8MEMmbq7SR039gBY8xKbzVhLrd8yIyliFxz6OHDuY+mUvx3Qe7loZfLnZyKW+aI/jANHZCFoI7duYZ2GWeUvbIalqrYnnAVRIGSZ0DKuhwMXMfP3nl3k1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7D44XTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7D44XTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3240C4CEF4;
	Wed,  1 Oct 2025 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759299929;
	bh=/J/2bX7aEzcIPmPq+XxSl2EF1EXZeFlQ1d6ME70Ff4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F7D44XTSOEZZgbF+pNfhKskgouj8f+vvXtQJRJPIMnymnnyKDWqP1oPMjAp/iAvgA
	 gvl3ioZtbNJr9mpn+PsdUE+Pe3fLTnc5tihS3uT1AeBFbIR4s+B+PVxEeR034JW3T5
	 8kfThQOXRU6OBIaWBH0n6Cg2s+Bh5U974diLqMNqUw7cRpA2F1UkAaJgM/WeHRGThi
	 nevUK4Laon3OogpJj8Cs4Yde7w1i+l8VsZe+1Y01O+7I5HB+XKFj2Hp4X/xaz8JHSc
	 ON2MR/5ET085jfHMMjGNPfjKGC+Be0ZeEZ9TgyJyO3MT1g3qcaq9vjf1gFIqeyNpVQ
	 KJGKuFtwVHwMQ==
Message-ID: <4085c078-20a5-4ba0-9017-85051c91bf3b@kernel.org>
Date: Wed, 1 Oct 2025 15:25:22 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] blktrace: split do_blk_trace_setup into two
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
 <20250925150231.67342-7-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Split do_blk_trace_setup into two functions, this is done to prepare for
> an incoming new BLKTRACESETUP2 ioctl(2) which can receive extended
> parameters form user-space.

s/form/from

> 
> Also move the size verification logic to the callers.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


> @@ -593,17 +581,39 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	debugfs_create_file("dropped", 0444, dir, bt, &blk_dropped_fops);
>  	debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
>  
> -	bt->rchan = relay_open("trace", dir, buts->buf_size,
> -				buts->buf_nr, &blk_relay_callbacks, bt);
> +	bt->rchan = relay_open("trace", dir, buf_size, buf_nr,
> +			       &blk_relay_callbacks, bt);
>  	if (!bt->rchan)
>  		goto err;
>  
> +	blk_trace_setup_lba(bt, bdev);
> +
> +	return bt;
> +
> +err:
> +	if (ret)
> +		blk_trace_free(q, bt);

I do not think that the "if (ret)" is needed here.

> +
> +	return ERR_PTR(ret);
> +}

With that fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
