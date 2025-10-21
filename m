Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B402848A0;
	Tue, 21 Oct 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080280; cv=none; b=G1XcxRAAZM3b1GbSGpsuVYLM5L05JbTpH44NopB7uebT1EAgr7h1HfvOcT9SRqekmOhegz9LWmF1HNTK0eEaFMI0eu2EyImdPAsXYYf1VrSuiQkrg/MzIJ+yKq5tSLBfGIO8eTRpZxGk45ffQ4N1FVxOqAC1xfWES+NsoglRrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080280; c=relaxed/simple;
	bh=Vhn4F7seFPjyyQ1YTdO1XOJMZPnKBBBpIfyFDjuBGPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUHrFYE9ufw1dhQKpZuOVQNagBnpn0pDgt7li3ns1luM0r2eyEuM1IzCwKLmFVT+b+GWfAvmNQFaKmN8gHLBSbUn1USnjXNqzCav8aIomd/9Jhd6C3AZ6gMrvzh9oSp+4xROYvjuEyrfss00LDy95mJvZ0gjd8tx+S0/TqtaFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+mP1zT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+mP1zT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25ABC4CEF7;
	Tue, 21 Oct 2025 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080280;
	bh=Vhn4F7seFPjyyQ1YTdO1XOJMZPnKBBBpIfyFDjuBGPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a+mP1zT9T4vUkaMyA3dfabnk54wBMqRK+xfwukEKC4AjoWuE+oczt7MF7k4PAYokg
	 loBSw05Bb+x7+FwAM6tLwjea8mPpOTs6an5oIXAFyowTU4g26yUSsjMxCuh99iGy+U
	 dT1RJx7EMqUiSFHn1q/mOlXz8YY6EKazYP37CsmLw4x4LyIyF7KnQnFsYaZ0rD33TW
	 FwsyIgLsEC3Q5L7UVvufnTo/crTjQhzB9MskkRsY5xyxTNUdVGEEua0R1XNIDkkoob
	 ly7D+TGj1vQofN7D3MjPWCSVuD43aAJE3WyZDpGLPYCWHraSvrm+awt/6A4S3vYCIX
	 U8EKyVBl87IOA==
Message-ID: <cc2b4fda-9e7c-4b97-b83b-1297ea931aea@kernel.org>
Date: Wed, 22 Oct 2025 05:57:59 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] blktrace: add block trace commands for zone
 operations
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: chaitanyak@nvidia.com, hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
 shinichiro.kawasaki@wdc.com
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
 <20251020134123.119058-14-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251020134123.119058-14-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 22:41, Johannes Thumshirn wrote:
> Add block trace commands for zone operations. These commands can only be
> handled with version 2 of the blktrace protocol. For version 1, warn if a
> command that does not fit into the 16 bits reserved for the command in
> this version is passed in.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  include/uapi/linux/blktrace_api.h | 13 +++++++++++--
>  kernel/trace/blktrace.c           | 28 ++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 6 deletions(-)
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
> +	BLK_TC_ZONE_RESET	= 1ull << 17,	/* zone reset */
> +	BLK_TC_ZONE_RESET_ALL	= 1ull << 18,	/* zone reset all */
> +	BLK_TC_ZONE_FINISH	= 1ull << 19,	/* zone finish */
> +	BLK_TC_ZONE_OPEN	= 1ull << 20,	/* zone open */
> +	BLK_TC_ZONE_CLOSE	= 1ull << 21,	/* zone close */
> +
> +	BLK_TC_END_V2		= 1ull << 21,
>  };
>  
>  #define BLK_TC_SHIFT		(16)
> -#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
> +#define BLK_TC_ACT(act)		((u64)(act) << BLK_TC_SHIFT)
>  
>  /*
>   * Basic trace actions
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8ffb218e9fb7..e8effb6cb393 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -163,8 +163,8 @@ static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
>  					     bytes, what, error, cgid, cgid_len,
>  					     pdu_data, pdu_len);
>  	return relay_blktrace_event1(bt, sequence, pid, cpu, sector, bytes,
> -				     lower_32_bits(what), error, cgid, cgid_len,
> -				     pdu_data, pdu_len);
> +				     what, error, cgid, cgid_len, pdu_data,
> +				     pdu_len);
>  }
>  
>  /*
> @@ -342,10 +342,31 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>  	case REQ_OP_FLUSH:
>  		what |= BLK_TC_ACT(BLK_TC_FLUSH);
>  		break;
> +	case REQ_OP_ZONE_APPEND:
> +		what |= BLK_TC_ACT(BLK_TC_ZONE_APPEND);
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		what |= BLK_TC_ACT(BLK_TC_ZONE_RESET);
> +		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		what |= BLK_TC_ACT(BLK_TC_ZONE_RESET_ALL);
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		what |= BLK_TC_ACT(BLK_TC_ZONE_FINISH);
> +		break;
> +	case REQ_OP_ZONE_OPEN:
> +		what |= BLK_TC_ACT(BLK_TC_ZONE_OPEN);
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		what |= BLK_TC_ACT(BLK_TC_ZONE_CLOSE);
> +		break;
>  	default:
>  		break;
>  	}
>  
> +	WARN_ON_ONCE(bt->version == 1 &&
> +		     (what >> BLK_TC_SHIFT) > BLK_TC_END_V1);

Shouldn't this be a "if (WARN_ON_ONCE())" and return doing nothing if true ?

> +
>  	if (cgid)
>  		what |= __BLK_TA_CGROUP;
>  
> @@ -386,8 +407,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>  	sequence = per_cpu_ptr(bt->sequence, cpu);
>  	(*sequence)++;
>  	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
> -			     lower_32_bits(what), error, cgid, cgid_len,
> -			     pdu_data, pdu_len);
> +			     what, error, cgid, cgid_len, pdu_data, pdu_len);
>  	local_irq_restore(flags);
>  }
>  


-- 
Damien Le Moal
Western Digital Research
