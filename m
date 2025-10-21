Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680B245014;
	Tue, 21 Oct 2025 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080055; cv=none; b=aEAsClcdwqLDQWk6x7yAgnEiFKYltP+erO4JfaqR+PTl/nnIDdcTVpl+5AnxbwyCbogUelTDNdmJxkz0oPLjVKgrLMRKE3f1FZWy7IQiH+zsODQ+keIHBh8N3+lsB573+ySz9t5Ii3dp/Oe9jqxuviPkwj8HffUL4uQcHgbvTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080055; c=relaxed/simple;
	bh=dRiFpxTJbkAWY2xShml44h/se09s+hdG//dKBrBp1W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8tcrJEoW3YY3BnNw79ys3XPFvoxOTE9GA3U2xfPq90T9Xpu5ak8adSeKn1tLLAStMCBh1ujyQ/tCZ+pF/pLd8hdmuil72wwtn/niebFg/eW0NMg5TifFN361Uk/0mUmXnqItdmWCKsrPiIhp/tZuOkJUuFOc0/yjKiDn/MF1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnoNEZk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnoNEZk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B89C4CEF1;
	Tue, 21 Oct 2025 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080055;
	bh=dRiFpxTJbkAWY2xShml44h/se09s+hdG//dKBrBp1W8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cnoNEZk+xG2YhvWPZ/O2tCFpBmF1eyA4Rk67SR12ZWhqZb3VGuaPWO2wBVGREfT09
	 0wgVSbQhcqaBJvDHjxSRApqpPBd3mbjElAQwk/Zt2TnuYlhrMhsRvJzpCs+qr+BetO
	 y+ku9sM9FFhAOZIt9U8pl3/H52+q/akkg+DRai5Nhm2ncxsK9lvikjeErLsxaaBbPg
	 RPTOaQ/mXKI5uaVdqcMRJl7vFq9LeATS0FkvPBSDus9quczmf0d3f4cCSbLTPiwALE
	 C6AfBJo8tr4b+OVgT2Pk/l1YHlAzm2DUTQ/H/SOiL2wjT1+itWn7Uf53iV/cLoBRmw
	 B8mkGOJ9e8Ygw==
Message-ID: <7a366bbf-49e9-4b53-bbd4-4a28454f8f90@kernel.org>
Date: Wed, 22 Oct 2025 05:54:13 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/16] blktrace: differentiate between blk_io_trace
 versions
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: chaitanyak@nvidia.com, hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
 shinichiro.kawasaki@wdc.com
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
 <20251020134123.119058-11-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251020134123.119058-11-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 22:41, Johannes Thumshirn wrote:
> Differentiate between blk_io_trace and blk_io_trace2 when relaying to
> user-space depending on which version has been requested by the blktrace
> utility.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

One nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -146,8 +202,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
>  	if (!bt->rchan)
>  		return;
>  
> -	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
> -			     cgid_len, (void *)data, len);
> +	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid, cgid_len,
> +			     (void *)data, len);

You are not changing anything here, so this is just churn...
Not a huge problem, but not needed.

>  }
>  
>  /*


-- 
Damien Le Moal
Western Digital Research
