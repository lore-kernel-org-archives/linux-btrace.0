Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A78F2EAB8D;
	Mon, 24 Nov 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975332; cv=none; b=fPH9/iEPrCeOdaf/gKmODwqVG5BPsZzbfpJ+pH89ReyOU17+QdiK0G021Fzo8dVBVqj/RGR4kC1FF7tO6hbkd+6lw/2sLSmQN5yoCa3sGQEUrOco+6wl/QN4BTbjq+wVW++uLUnPR6EB5CsKyosLoptlduhu4dcGoON/Yz+0fL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975332; c=relaxed/simple;
	bh=8pA2HwF8iQxu+hVGNiFseKz22OJWpdEVqICuyZxpRLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjfiSIPJiNDX6ZX1muAAvvTR1ID8FGSJvPul1t/tcSWZdLGoHuoUr4TviPdRxTrnMEUlaeVfylmjhSeOvAW3nE5mdJSUB5VwkwUFO0bmaSmpjGAQs7DYvJMZPaCITkVb1t9DcU+toTplqIt316BLflN3NdOGtOD5T//ZriB4Eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbLftUYj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbLftUYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F6C116D0;
	Mon, 24 Nov 2025 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975332;
	bh=8pA2HwF8iQxu+hVGNiFseKz22OJWpdEVqICuyZxpRLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NbLftUYjElCLwj96djZF2Fvxg+HwltRQwKVqpB1QMJxBb0AabiH7Jn9v3JpeUOicb
	 YDg3cDi4jkzEQJZc4khEfgC1m6hGrmOjvkWgNSdMiKK8fOo9kKiYc3LLK+oMcjlx1P
	 0Tn/tMibCUcCZyREGCCUkxBTUIeqo9Bp/g9YWpDDq20LpmL75NwVRZDtgAVXXW2udI
	 J+qqa/rHQSB9ZKA2btTm1tp+5bETrxHUNFPEDIQRogCbif+0ryPCla5wkzgXcwtyEu
	 Hj6kIK6NDf1Svb9wNvjwlde8LbclAISEz2H+bHx4mEqEXaxHGvBGLLcw024sKZC/01
	 b2YXFbHQmcBbg==
Message-ID: <978bdc07-d476-4e32-b784-00a4e6afd984@kernel.org>
Date: Mon, 24 Nov 2025 18:08:49 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 15/20] blktrace: rename trace_to_cpu to
 bit_trace_to_cpu
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-16-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-16-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Not a big fan of empty commit messages, even if the content endup being trivial.
Nevertheless,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
