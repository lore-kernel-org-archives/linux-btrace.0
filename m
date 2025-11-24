Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745692FABEB;
	Mon, 24 Nov 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975511; cv=none; b=AFQ+hJZo55jBOYGfZVDYAQASm4pVV1+/lgtqjR1gc5gDZmLPu2iuLH0nAKRGmcLSmSdRm0TOUIUu/z++YiXK9tBUM9KOzzTlyDYr2G5t+EaGONHaUdms7pZiZ5MFtccrwyRU4o0NrRqmTDQop45m2FM217dLHsY+jWMzarpE60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975511; c=relaxed/simple;
	bh=OFhwtkaxZbrTmSQx5GyqDVgd6bkgbuOCx1fn7zcxq8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwE2slY9vaDHQimgFOuVoNkcCyk2Ze+/QinaZ9Wg9m6nIs1sS+IULUQ9J1XOFUHtmDkQpAox0sgpfAoV1fjX7WdsBaZGiXq2HMbD9GhckhDgKgF4qPlAsRZ9p/Evao8CKVaNJ3XOP4ZW/6cBUR9KCjD1EwKqA+DMDMKzM68HNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+5zMG/i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+5zMG/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E7C4CEF1;
	Mon, 24 Nov 2025 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975511;
	bh=OFhwtkaxZbrTmSQx5GyqDVgd6bkgbuOCx1fn7zcxq8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+5zMG/i5EqDDNGDKEFI1m9EgXQknClWQLSax0IgJSRweSvOH+ZfPz1htlyvMrced
	 h4/BrPxBKdBj9Q1e+0FGY3/nWneokGhLUiJBF/X5NwwB0ThuVBNQwqS4qo2LGYO0GX
	 aUm0F38rQ6G2B6vJ0PiArkC/pzPW1SgZjW17nNPbVrdGzuTopU0B2uVbp+x9gNhsB2
	 kQQNLpfzqBHgct8V0HVfNfcsQhajbATGr+m2GC4sKXrJqNJRxHd2+bXFi7MwZRuE1v
	 2gkWO+zathlifkg1EP6t3U7bFuPEjIueghixapVV9uQAOXlE15hocnlR8yVTKfXdz7
	 ZJXRofhnUtVOw==
Message-ID: <dcd0de68-0d6f-475d-9d49-5b641dfe3378@kernel.org>
Date: Mon, 24 Nov 2025 18:11:48 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 17/20] blkparse: natively parse
 blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-18-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-18-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Natively parse 'struct blk_io_trace2' from a blktrace binary.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
