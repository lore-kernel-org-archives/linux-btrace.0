Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29967260D;
	Mon, 24 Nov 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975148; cv=none; b=oIfgQqNQTivhfLa2v6fkA2oDnYuJQ5h+F2k3z+Gtw8f2LyaOtwC/3hkq4nLCvR1ggfO4G0+MZbPQeyFiwfrrILDnbiJUujFJerteEagQ68yosnCMbD156/5FV7FF7M9tRWZw/SjeQWAPZwETR7/e+QGeV1lztSJ/OSkLg3y60F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975148; c=relaxed/simple;
	bh=AK76nE90dSO0iHGuan8JBKTy30j793qgrKQnd92RYd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8eYwdv2D3K6MrSLzttaU9KQ5HbOdQCeCXj9RCu4K1SxiAeB7ZiS+4duHVtvs0fF/iE0Q2LYkEgmhC9nngK0GqEfOqUtSNpCrmAC2QsLVYweaWVTmHMLOigyTcXGdVFSb52M/8STZRPIOYnF8NNxCtAVe9pTkAq0wV3HQvJgun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8L6nh8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8L6nh8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187A4C4CEF1;
	Mon, 24 Nov 2025 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975148;
	bh=AK76nE90dSO0iHGuan8JBKTy30j793qgrKQnd92RYd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q8L6nh8GSIHxc40G6YjJc267+RI+Vi2nSF0fhCSr0ZDSck0OzOSCh1/+dgzdDVD86
	 HxqPbmEKX48zhSuqFQr4NRODLAbFrQ3LAIvt1ETb5iPTznD0dfp5L3pH8NoYGbahrL
	 +xwxxXauleedYiP6CYsoUFhVHWTui67KwQFZhXNtQCB+UVVabZs3/Rb7rwjOtKTA2U
	 KWg8HY1hXT3vtlsQxQnf1qvZh58jzZ9NODgr+4gM0kKRs/j3iDC41B+IcYZxExu5JF
	 02pykSEMUpIzRchQoSGINTOx7wftYdinhcUMzVHJlvSsVV8Eqy18hBnap6J+N68aZz
	 kOfjc3mt+Y0QA==
Message-ID: <2f7c7ab9-35ba-4266-895b-cf24d3f8210c@kernel.org>
Date: Mon, 24 Nov 2025 18:05:45 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 10/20] blkparse: skip unsupported
 protocol versions
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-11-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-11-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Skip unsupported protocol versions for now.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
