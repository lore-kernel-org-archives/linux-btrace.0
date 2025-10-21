Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F1285C8B;
	Tue, 21 Oct 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080156; cv=none; b=S0FhHsHwu0b5jwH39+OO/ELKHxKQKR0vgA5EN0Aqq23lMyXaPdIbmp5k4hfH84fukG0h+/pY6LEdpLAJq4mtpIskgjavn+lvvweGehLEul/cuyb8/F6kwJJbwmitov6N6vhWdR/Wns77SYMi7Txz77BLPI4r9ghJmVWLrAamWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080156; c=relaxed/simple;
	bh=vOJ4YS726KatTpilkNqPrOLB8Qzw2RYPt1jTcs28P5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4lKzOBy02L6PJoAr/TCyEaDTHMjIQA3yj1n8uP/ifGhNCAUteyJxPzXt+OKyV724rnIUBRzkJjxCC29eoTUYZN0OqlS488KKnvYGjeuq8cjRvJi1gyEjunM5iuydmRuynAsh8vYs0RFF3cheGakkkwIXpdh9slX20+zlR4ocOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzXXXVdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzXXXVdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE65C116C6;
	Tue, 21 Oct 2025 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080156;
	bh=vOJ4YS726KatTpilkNqPrOLB8Qzw2RYPt1jTcs28P5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uzXXXVdxQHAjd7ctEw6bHYi5uxG4v3QofpV/8kN5x+UyvTsZS4a11tnneXJ52O8Qs
	 5i71S0rD1iQJG8YePUnr6Xlyg3PquTqM+bZkVps9kRsKAugp1jnZePjRxUey90WuUs
	 5XEIJ6hIK2Z2zW28ydkn3VqCT+95rK2o40W1FbGw71vJzRYPXnlkoA/BrRA4+/Mv5p
	 aXEMJCJHjNk0/NLxPJnrrWW5jdM7tC/g/d1fAUyx8TC/9/ES5hTPt3+MBGFZOutz6Q
	 LDI2E0CU9VEjFl0ToXmkrdfW3Do4/KFiZhi2wdSE49RZBz+qlln7LMUtO5Gj+1R2kw
	 B6wQSSU3IdseQ==
Message-ID: <0c583ebf-5529-40a4-9383-042ff5413bdf@kernel.org>
Date: Wed, 22 Oct 2025 05:55:54 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/16] blktrace: move ftrace blk_io_tracer to
 blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: chaitanyak@nvidia.com, hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
 shinichiro.kawasaki@wdc.com
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
 <20251020134123.119058-13-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251020134123.119058-13-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 22:41, Johannes Thumshirn wrote:
> Move ftrace's blk_io_tracer to the new blk_io_trace2 infrastructure.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
