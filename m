Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5670242D7F;
	Wed,  1 Oct 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305216; cv=none; b=cAleO+eV/M4MPNYYMPWVGNQyZQBYtjYUMl3Y5eIpCfoeVglOBapj0fLxY92L71YXs+lzr1zs1g0NAI++fMfG5rnKPucWCe59lDqhzP3r9Pf/kdWXK04In2GHxIydwC6uGb66lpuQrlOFzYcaYqAQf3ZlODQBltLnhQf85qEK+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305216; c=relaxed/simple;
	bh=FCMadiI0uHR2AaZ8Z2Dp/2aibszSzG+1JACxleaZXg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbb9fXG4T5I7wYuHg2WSvnZe5SkCZXEw6OaerZhRPZr4khPPZivRsHDF6kTu4fx80zUZzkKwHbG5i/PZ1fWklvwlEgVgthqyzKP10USqW0h4K1EBI0RajX4W+Op3TZ64s7LHWGzq+UPOyZMCrPzmYs5MNCXQ//Km5vpn6v9qkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtX0AlKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtX0AlKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013C3C4CEF4;
	Wed,  1 Oct 2025 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759305216;
	bh=FCMadiI0uHR2AaZ8Z2Dp/2aibszSzG+1JACxleaZXg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GtX0AlKctWJcfDCoeVJuC9CphzvQp3D7s22QDgM9l16BOugVgyK39zoe9gfF6GSeS
	 kgQ6GC5ULq0cRdSFTz8DJiw+u1iM0D10WwVFbTepEUH3z+zOWVfB4MFzt3MiksUiCS
	 YA2WfHIWL3scn+9d+Pi3zbo+EBDamyCsZ8x5VAV4wwUjdy70CUl2niHl2z4qHKrJEk
	 sCfuhRuBlD8M5RyySnHlf7EjG7n/yUTlNjb/jj+fTaDoC/YerUOhF+/7tzvqGptfNu
	 3QlvLSviOnpxvPqCDl8FVo32/rgnNraP2m2w7gNiddqI6Zo8QVGBOBAOrB51mEPOXD
	 g+SCVCbOknHrQ==
Message-ID: <e0f057f8-9e39-4d41-a338-37c4793c6ab9@kernel.org>
Date: Wed, 1 Oct 2025 16:53:28 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktrace v2 05/22] blktrace: add definitions for
 blk_io_trace2
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
 <20250925150427.67394-6-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150427.67394-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:04, Johannes Thumshirn wrote:
> Add 'struct blk_io_trace2' which represents the extended version of the
> blktrace protocol.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  blktrace_api.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/blktrace_api.h b/blktrace_api.h
> index 9f435a5..bbf075f 100644
> --- a/blktrace_api.h
> +++ b/blktrace_api.h
> @@ -27,8 +27,19 @@ enum {
>  	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
>  };
>  
> +enum blktrace_cat2 {
> +	BLK_TC_ZONE_APPEND      = 1 << 1ull,    /* zone append */

Kernel side starts this at 1ULL << 16. SO I think you are out of sync with the
kernel side with these user patches...


> +	BLK_TC_ZONE_RESET       = 1 << 2ull,    /* zone reset */
> +	BLK_TC_ZONE_RESET_ALL   = 1 << 3ull,    /* zone reset all */
> +	BLK_TC_ZONE_FINISH      = 1 << 4ull,    /* zone finish */
> +	BLK_TC_ZONE_OPEN        = 1 << 5ull,    /* zone open */
> +	BLK_TC_ZONE_CLOSE       = 1 << 6ull,    /* zone close */
> +};

-- 
Damien Le Moal
Western Digital Research
