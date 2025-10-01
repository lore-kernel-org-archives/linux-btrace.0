Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81902032D;
	Wed,  1 Oct 2025 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303302; cv=none; b=H+8qgMgjH/8bI0x89pExDmt6cgZB1GWXervpDIwrdFT9SULn59EboE4iUYEKSRvj5Ww05k5nymYS/X8GgSc8zzX8s0gsKMkb0fSeWk3zWzdKQe5G7J/rno3ecBWHaVGfJ3+5FqCa7UUdKE2AWYDzTVBcWUeiYgYY4x8Yf+euK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303302; c=relaxed/simple;
	bh=pVCkq0cOU9uMswaWSGzBbKzSOe8kNSiOJonYeo+DTcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XX6w6MBTReMW3eJ3ExBPTLG64ath3lMyDLei8Ehk31qLw4MpHZqIiDfa47hO+gzS0P9rsyPnOjykS3c9G7d1HOeCaq+7rGCRFvEXInLzLXySQN77922f41mWRrLQXMqN/Wrg1+aZeon1mHRTuYiuZwZd3l0Q/RKy5VL9SYly2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NskOD8Cl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NskOD8Cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C1CC4CEF4;
	Wed,  1 Oct 2025 07:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759303302;
	bh=pVCkq0cOU9uMswaWSGzBbKzSOe8kNSiOJonYeo+DTcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NskOD8ClyhTNSVxRWvQvv+1tM6GrmwchY1xUsazScQx3IoP8YeGetatku2o20fjXK
	 6hUnRnGmTudS0Ie6TE/+symbedE9jCnDgcYcFxZ7TJiFh/iRAlFrg1vFRtipY2zyon
	 pQWiILo9NIXL9idVLJyV0WUoIoWbd57e6zXSLz2BsGSNVg9nPxu2WGegzq61dxo6VN
	 edDKYMQx/iJdLyk8okRlw7/x261PtKzrqL3kxdjLYjOOYyoNF81eJDE4+3us7aS+/H
	 7UWnK2wSCCRKvRRvT9X8b48iVKcsNhEi3KgDYLLqThILMNzikWuq1LOqsKq9Ee5U0a
	 HgO60cDmS+Cqw==
Message-ID: <16684b73-7659-49e9-82db-cdd54bf0d2cd@kernel.org>
Date: Wed, 1 Oct 2025 16:21:34 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] blktrace: differentiate between blk_io_trace
 versions
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
 <20250925150231.67342-11-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-11-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Differentiate between blk_io_trace and blk_io_trace2 when relaying to
> user-space depending on which version has been requested by the blktrace
> utility.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  kernel/trace/blktrace.c | 62 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 9cd8eb9e7b4b..82ad626d6202 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -91,6 +91,29 @@ static void record_blktrace_event(struct blk_io_trace *t, pid_t pid, int cpu,
>  		memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
>  }
>  
> +static void record_blktrace_event2(struct blk_io_trace2 *t2, pid_t pid, int cpu,
> +				   sector_t sector, int bytes, u64 what,
> +				   dev_t dev, int error, u64 cgid,
> +				   ssize_t cgid_len, void *pdu_data,
> +				   int pdu_len)
> +

Extra blank line not needed.

> +{
> +	t2->pid = pid;
> +	t2->cpu = cpu;
> +
> +	t2->sector = sector;
> +	t2->bytes = bytes;
> +	t2->action = what;
> +	t2->device = dev;
> +	t2->error = error;
> +	t2->pdu_len = pdu_len + cgid_len;
> +
> +	if (cgid_len)
> +		memcpy((void *)t2 + sizeof(*t2), &cgid, cgid_len);
> +	if (pdu_len)
> +		memcpy((void *)t2 + sizeof(*t2) + cgid_len, pdu_data, pdu_len);
> +}
> +
>  static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
>  				 pid_t pid, int cpu, sector_t sector, int bytes,
>  				 u32 what, int error, u64 cgid,
> @@ -111,6 +134,26 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
>  			      cgid, cgid_len, pdu_data, pdu_len);
>  }
>  
> +static void relay_blktrace_event2(struct blk_trace *bt, unsigned long sequence,
> +				  pid_t pid, int cpu, sector_t sector,
> +				  int bytes, u64 what, int error, u64 cgid,
> +				  ssize_t cgid_len, void *pdu_data, int pdu_len)
> +{
> +	struct blk_io_trace2 *t;
> +	size_t trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
> +
> +	t = relay_reserve(bt->rchan, trace_len);
> +	if (!t)
> +		return;
> +
> +	t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE2_VERSION;
> +	t->sequence = sequence;
> +	t->time = ktime_to_ns(ktime_get());
> +
> +	record_blktrace_event2(t, pid, cpu, sector, bytes, what, bt->dev, error,
> +			       cgid, cgid_len, pdu_data, pdu_len);
> +}

See below.

> +
>  /*
>   * Send out a notify message.
>   */
> @@ -146,8 +189,12 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
>  	if (!bt->rchan)
>  		return;
>  
> -	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
> -			     cgid_len, (void *)data, len);
> +	if (bt->version == 1)
> +		relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
> +				     cgid_len, (void *)data, len);
> +	else
> +		relay_blktrace_event2(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
> +				      cgid_len, (void *)data, len);

Since you pass bt pointer to the relay function, the version is known in that
function and this could be done inside it, no ?
That would avoid this if repetition.

>  }
>  
>  /*
> @@ -329,9 +376,14 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>  	local_irq_save(flags);
>  	sequence = per_cpu_ptr(bt->sequence, cpu);
>  	(*sequence)++;
> -	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
> -			     lower_32_bits(what), error, cgid, cgid_len,
> -			     pdu_data, pdu_len);
> +	if (bt->version == 1)
> +		relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
> +				     lower_32_bits(what), error, cgid,
> +				     cgid_len, pdu_data, pdu_len);
> +	else
> +		relay_blktrace_event2(bt, *sequence, pid, cpu, sector, bytes,
> +				      what, error, cgid, cgid_len, pdu_data,
> +				      pdu_len);
>  	local_irq_restore(flags);
>  }
>  


-- 
Damien Le Moal
Western Digital Research
