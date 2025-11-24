Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233C2F12B2;
	Mon, 24 Nov 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974666; cv=none; b=je43V7ep1IRUMaZckXXTFUwmMpB36kdAmReHDVOy3jrJojIgyJXPiA037rVe0gCSRDc6VQaWz+z1ILFu35pU8HxxFd9i7s3n0jUdmye4t6mdBzVIlbaEwdLiwZx8aVdKsKN3COYK+HqAo+fgxEYAh2MHbVBLoG9+ep2mssSviUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974666; c=relaxed/simple;
	bh=QegpaO11GCZwLyZUCLWpPq4lqTvaN3NAgvqh9JCiPAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTx8Qizxu8HLniHVMednpCOph6hxdrdgemtXYERMtGalnwN+nQLeSBlUAFQN6NXM+vPVaaySu8+txBDsrAKtHkVxZZyclcmd85WS2pRsnAZ5EFCE9FwuqN5tHRcxaKo3MP0KS6R1dV5IwmJLrvdDNPxx8hUSo2LFLNelTxAr9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6/GBmOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6/GBmOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C7CC4CEF1;
	Mon, 24 Nov 2025 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763974665;
	bh=QegpaO11GCZwLyZUCLWpPq4lqTvaN3NAgvqh9JCiPAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N6/GBmOzkkwJr8NviB2gRdtRZU+EGGIPsnZiAITn1Z5Brsjb4MPZKsGOnGasIHEkj
	 EZE4u6WndqnR6Qws7wD3MJXmYu1fJ5FWuWlyeeFYGUmm3nT01ZK80QnVJe9ZeNQ824
	 lrDC2qJ203CpW5QtzKPx8DEk10nGkUae1eDyjny8l68iDFMTIhUgH0QFQPBdVxpRdZ
	 6+KiasxPe+MCwA0B4uj9DZY+6UgtrLiHbBKwzhwfB9gQ09TJCGyCLi8rTu5IV5uL5P
	 T9aJfgiJ4TFvEDGxVH51Dzhgw1dGUNe+hzi4os05Tnh5krz5MWsV0LtAXDLksmzK5+
	 qcapMl2y+CB2w==
Message-ID: <daa2dfb3-91f6-413e-af38-2998d3a96806@kernel.org>
Date: Mon, 24 Nov 2025 17:57:42 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 03/20] blktrace: add definitions for
 BLKTRACESETUP2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-4-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Add definitions for a new BLKTRACESETUP2 ioctl(2).
> 
> This new ioctl(2) will request a new, updated structure layout from the
> kernel which enhances the storage size of the 'action' field in order to
> store additional tracepoints.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  blktrace_api.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/blktrace_api.h b/blktrace_api.h
> index 172b4c2..ecffe6e 100644
> --- a/blktrace_api.h
> +++ b/blktrace_api.h
> @@ -139,9 +139,25 @@ struct blk_user_trace_setup {
>  	__u32 pid;
>  };
>  
> +/*
> + * User setup structure passed with BLKTRACESETUP2
> + */
> +struct blk_user_trace_setup2 {
> +	char name[64];			/* output */
> +	__u64 act_mask;			/* input */
> +	__u32 buf_size;			/* input */
> +	__u32 buf_nr;			/* input */
> +	__u64 start_lba;
> +	__u64 end_lba;
> +	__u32 pid;
> +	__u32 flags;			/* currently unused */
> +	__u64 reserved[11];
> +};

Any particular reason to go for 192B ? Why not 128B with a __u64 reserved[3] at
the end ? Not enough to future proof it ?

> +
>  #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
>  #define BLKTRACESTART _IO(0x12,116)
>  #define BLKTRACESTOP _IO(0x12,117)
>  #define BLKTRACETEARDOWN _IO(0x12,118)
> +#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
>  
>  #endif


-- 
Damien Le Moal
Western Digital Research
