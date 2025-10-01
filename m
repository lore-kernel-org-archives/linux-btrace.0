Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721B22126D;
	Wed,  1 Oct 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305084; cv=none; b=GbzZEUZEkToV4/SFyMkvOMxp5+j/j/s/QAS7m+EfTQ5o9kLOPk0UIAQddbiss9p+QhGRKGq2tU5pckDkUYzDSNOFCLB1fwqhNmdnr50/v+NjrG9keF488KycWBwSwlUT322yaZXyoC7hydV4WzrNorctr4QAQoer21zQmn/58Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305084; c=relaxed/simple;
	bh=HPlNQpm3q59ud1FcRXdqzcKTsXSJCFFLkoeCUZee9M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB//RMClVUBBDHdKWY1Lw0xJRv6NtteuAJIFO5z2m8G01InMuTzB3LyKLVWvKyWFJ9sIFoyevO1P+cfkbZLSJt2o5JRNwNz/CtP8tDgr9hfrZ4l4HcV9G332kdDyqul6MP3hIrEXzbhAFrm2XlDS8xlvViPE/gkYxGlxDEC5Xts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi0UWxq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi0UWxq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A709DC4CEF4;
	Wed,  1 Oct 2025 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759305084;
	bh=HPlNQpm3q59ud1FcRXdqzcKTsXSJCFFLkoeCUZee9M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pi0UWxq2tg9tD/tqPWO8M+KlKHMdA5YKNkSV3BTmvoyxi7IJ/RblZrRRAlxUV6jXU
	 no/Sn4gdBdxZq5JWXgJvXytpcs8Pr/YaHE0xmurpKrDxqio88mVxhh3Esv2Ts7wWcl
	 k6zDrqzHR7W5xgiRK4crA/s4wAHQWf+SZUGszs4MiAVsg2Q3xSBK6stgWMBFEktgMV
	 tBKhbsNYlODqX7685K6Cdt59XRAdMRF2soqbKSLJGYt/uUTLuijbJF2gQqhnJN8fm3
	 gss7PViT2cZzOrSnioukfacPKQO+wGaHiLk0bRe4Fy7aIZrTfjH3xQBzgEpIRxtyKs
	 OSK1TDFt/Na2g==
Message-ID: <5f8bb74c-46c6-4462-86fe-4defe25328f0@kernel.org>
Date: Wed, 1 Oct 2025 16:51:15 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktrace v2 04/22] blktrace: change size of action to 64
 bits
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
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
 <20250925150427.67394-5-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150427.67394-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:04, Johannes Thumshirn wrote:
> In order to add the zoned commands to blktrace's actions, the storage size
> needs to be increased to 64bits.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below.

> @@ -52,13 +53,13 @@ int add_format_spec(char *option)
>  
>  static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
>  {
> -	int w = t->action & BLK_TC_ACT(BLK_TC_WRITE);
> -	int a = t->action & BLK_TC_ACT(BLK_TC_AHEAD);
> -	int s = t->action & BLK_TC_ACT(BLK_TC_SYNC);
> -	int m = t->action & BLK_TC_ACT(BLK_TC_META);
> -	int d = t->action & BLK_TC_ACT(BLK_TC_DISCARD);
> -	int f = t->action & BLK_TC_ACT(BLK_TC_FLUSH);
> -	int u = t->action & BLK_TC_ACT(BLK_TC_FUA);
> +	bool w = !!(t->action & BLK_TC_ACT(BLK_TC_WRITE));
> +	bool a = !!(t->action & BLK_TC_ACT(BLK_TC_AHEAD));
> +	bool s = !!(t->action & BLK_TC_ACT(BLK_TC_SYNC));
> +	bool m = !!(t->action & BLK_TC_ACT(BLK_TC_META));
> +	bool d = !!(t->action & BLK_TC_ACT(BLK_TC_DISCARD));
> +	bool f = !!(t->action & BLK_TC_ACT(BLK_TC_FLUSH));
> +	bool u = !!(t->action & BLK_TC_ACT(BLK_TC_FUA));
>  	int i = 0;

It looks like this should be a different patch. Also, I do not think that the
!!() is needed.


-- 
Damien Le Moal
Western Digital Research
