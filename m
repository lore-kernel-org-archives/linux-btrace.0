Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3D2F5A08;
	Mon, 24 Nov 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975792; cv=none; b=ce5HlrfeYveOyc97YCgAqth5fUDaJxDnbQ3EOE3St5bcfqlZGbOGwSfg+PN5kk5WNupSgsZ5lc1BAVdVVldXETXvMtj5Wk0pI3HYgLXPdTD4gnFzZWI4Op8qB02FiillMhz2FVPwYskn75A4tMfVfV2h6rI2uDUNDHzpwhy6jFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975792; c=relaxed/simple;
	bh=J0iBnxDkNEw8DMK+3bMwLraArfMJiNHKKuHOKI9bszo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTfqJlhTO6y5+L8cRmLbWEubslMH5CIi3+Y1iNnHFMq1Ie7kR1H0BIuXjLuTNpqDLqoIMRHNsAusH2vTYAIkfAPKul4dJWnbDcC41AjV/SONBfbZR37wn6wlbLMa3R4cf9wsTgk7mSCQpvzuBwY3CRJy1+k9Sxoq0EXLt96Ewks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6RovyS0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6RovyS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C533C4CEF1;
	Mon, 24 Nov 2025 09:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975791;
	bh=J0iBnxDkNEw8DMK+3bMwLraArfMJiNHKKuHOKI9bszo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o6RovyS0W285zaKlYginA5pncxXr/pIW0Y9bTWq5wdkFIDSozxCJ28GANdzx3lBXh
	 SeVrDRB9t9ZbI0tE7wIwhPNCt3zNeYHaGGTAPR4Kszbgacc4q0DMGfAELL4AZS/3ld
	 5IAPGA0xOoyF833XYFwh5h5dISsOLdCfWTY5unQyQ7e8wbK5zhUH9nmP5hRjwxMslk
	 TgraZ8nNtUk43pBOyx/1KiYb8p37aH9+W7WgtYE0MwStH1Qx1omzvT+U4rLh/DAUob
	 JWv7fNP8QcfXCQ8qSlAHqckkdn3QFP11Nwgdn6wZq89OtBal4z+LEOdKKC40Qau72X
	 bmnu6aqW2DR8w==
Message-ID: <b38be523-6913-4c54-9f8a-da8b22221a31@kernel.org>
Date: Mon, 24 Nov 2025 18:16:28 +0900
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
