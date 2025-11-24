Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5011096F;
	Mon, 24 Nov 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974835; cv=none; b=P1O+SxRxlCAk1Uug2+59rOukmVyEOJ8AADmEAwpzPIDSGiM86T/E6MhmkT7MAZH/TCDCf99sMILgeKOLOt/e+JgypCgHwZQuxvAzW0jsS8OWnV1562iJrgtowXYDhr5bVCRfMRzpxfPKCy6/j6pzWckuLlxsXBkpXaNF2IQgoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974835; c=relaxed/simple;
	bh=1wZ44cBGOZO5B7hRVudqOYwGtUjIMysz77RVZEDwZTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYpzenjqIoIJjRfkOMpyKiETNsl2Cc/PSIk8PMdw/h3aSDJ9e+J5lIejwNj7O4YO1sAbIRtxjaEXFidPj2o0Dn+VvAybK6UscLFP79dMSuXqGQrXftX08w2UnVgMd92aZkeZ35W/4u1UO+3qYw5SjLxGJJH79Hut8rdKvEQR4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnYLBfjz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnYLBfjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D9CC4CEF1;
	Mon, 24 Nov 2025 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763974834;
	bh=1wZ44cBGOZO5B7hRVudqOYwGtUjIMysz77RVZEDwZTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RnYLBfjz/y0aY4kKTKbU7RMEs6C73jlmACxqHAuvf9lNsTyRNZg9FWWJt5pTiU9w9
	 qyPtb/UPWG6UgbxrzjhUj/L0ecWlht0gKLVmAEHDSr/ZJ1pN/QhtiC120S6rql0ZBG
	 7D/BLOftO6eYsvkdOK2PVFku/pg52S6sjmanE2o1K5lNGZF8pgIy1/EGPhwfJVzNNh
	 Gh6pJ39fgR8mvM9HsLqMRvDm7GD7sL4uRP/xHBVv3WyR6VMve5D0MhTqSdx6CdPf5B
	 ZCUEtIkSLa9bcpGl8ulWybDSjZ/eti05hE1X/l3epJNDrntUS/J+qv7itvO3vFEBB5
	 L7xFWdIFOARIA==
Message-ID: <62285a77-2bd2-4357-b2fa-443eea262f1b@kernel.org>
Date: Mon, 24 Nov 2025 18:00:31 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 06/20] blktrace: support protocol
 version 8
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-7-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Also support protocol version 8 in conjunction with protocol version 7.

Shouldn't this go last in the series, after enabling the code that deal with
this new version ?

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  blktrace.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/blktrace.h b/blktrace.h
> index 74dfb48..3305fa0 100644
> --- a/blktrace.h
> +++ b/blktrace.h
> @@ -69,6 +69,7 @@ extern struct timespec abs_start_time;
>  
>  #define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
>  #define SUPPORTED_VERSION	(0x07)
> +#define SUPPORTED_VERSION2	(0x08)
>  
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>  #define be16_to_cpu(x)		__bswap_16(x)
> @@ -90,13 +91,17 @@ extern struct timespec abs_start_time;
>  
>  static inline int verify_trace(struct blk_io_trace *t)
>  {
> +	u8 version;
> +
>  	if (!CHECK_MAGIC(t)) {
>  		fprintf(stderr, "bad trace magic %x\n", t->magic);
>  		return 1;
>  	}
> -	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
> -		fprintf(stderr, "unsupported trace version %x\n", 
> -			t->magic & 0xff);
> +
> +	version = t->magic & 0xff;
> +	if (version != SUPPORTED_VERSION &&
> +	    version != SUPPORTED_VERSION2) {
> +		fprintf(stderr, "unsupported trace version %x\n", version);
>  		return 1;
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
