Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC92F3C12;
	Mon, 24 Nov 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975176; cv=none; b=U8GGzmfZhZzImKdCw1WCyM/Wsg/JOjyNlrr0BySgGFuOJiUwU9GPJI6Ubs3ptK2RlayKrSMaVKcqMeJ6UtNJJ7wDdTE1Y3YZ+1Yqmypyc7rFw+R25XzY7hMIw467etZcp3hCvn3TBZxhTA2AVdYJaNnW2SxHPpRZEqfsF1tIU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975176; c=relaxed/simple;
	bh=oimNe2QnNMbXX4jqE94vNV1+jPBl73oj6d9pqCUEZfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+uFG8re5B0sil1Pp0D24O0UHwCzLrfbqLCy0NZgk+444/ySNP/eoY60Nwp17o5Xf1AzCxr+071p6Q3Jiq4w3mF7UQx+3NChPZNnQ74vI/BWEpajHpNz8Nfepl++C/5UVEf3omVYyFJTyUrk16XyQrN17uuhSsrf3Cml/G3En20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKeX3BEk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKeX3BEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06F2C4CEF1;
	Mon, 24 Nov 2025 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975176;
	bh=oimNe2QnNMbXX4jqE94vNV1+jPBl73oj6d9pqCUEZfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pKeX3BEkz4U+MyJVMHVVDTZ6P28cIO2dr2+pNA0j2/yM1OIS7lY15i/eqmfoZlaDm
	 Pb/3cgREti7qE3+bJgOL7FOpyBgGaueOjoVh69frSoYkXibbdmIg2WJRRMJd8kXNbr
	 mX4x2wpfBDJtzheMdfMMe2C9IwGZzb7T/eq/NWorojzdujXG+0GkmlxgYcjF3fRrRq
	 q8QUwrQxPZ7YiEJxHCV2yxaEgLuBHJWlj5ze0fq0ZegMcIgaIPu3ILq2r4DruBz4np
	 /Yqnm+5oV0ujrpM2PBjMYo67uCc+w8hGhh6eMlgeHMVcTFC10XLSuHPhvuS7YNZqkS
	 HA2MHoGGVVYwA==
Message-ID: <ae6709c2-fb54-44f3-a1bf-24730b0c057c@kernel.org>
Date: Mon, 24 Nov 2025 18:06:13 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 11/20] blkparse: make get_pdulen() take
 the pdu_len
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-12-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-12-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Directly pass in the pdu_len into get_pdulen() and only care about the
> byte swapping in get_pdulen().
> 
> This enables us to use the function for different versions of the
> protocol.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
