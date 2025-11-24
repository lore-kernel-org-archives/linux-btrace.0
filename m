Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B662253944;
	Mon, 24 Nov 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975662; cv=none; b=mj6yTpdEQ2YOTTO+utIOAYlyFoRdNIOUH5vFkXuVkfv+965am3uAZ2VLkk5+3DosCJCttKd3/cH6MEVyuRNtpAwdSfNDxJBqqpgwO1W32o+z0VPQvD/lJugzFTTLDurexz13ZfOAaFav/psyCUYHeGp+0EcdqpqEAUN95GZqx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975662; c=relaxed/simple;
	bh=e8h2KDaYIEKSty4Lur3lG5o+cAAp4Eye0HLWIZYYNy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF2zGOJCSDoQncwD8ysfcEuGc6ys6uDq7io+RDTVvGUFM/p2bMq5kkqgLD4gN3vmh6y9+Cx9mrLRwfbCDcqHIqPCoFgAvFHzJslJHqkCieL6MSusWJ5NSCd6DFf7MjTQDGkmc4maQmEfBMdvXAe3+yASwWs+oUBNltll/jjDJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPeekyhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPeekyhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61594C4CEF1;
	Mon, 24 Nov 2025 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975661;
	bh=e8h2KDaYIEKSty4Lur3lG5o+cAAp4Eye0HLWIZYYNy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPeekyhK2unHD4K7oa1ZZWY98g93A5LC6mULk1TMwIBWLkcmpAp1m7eg9Q6Jtcy5Q
	 devzoVxwPV1cEe7y2WXq91hVWu5Q9BA7Jwo477lImGi4ETmeGMbgdZNViygXQnpade
	 ZOlno6A188RmZMyvOkqOa903U2Tcg3mYS06Wn+a8yd/thRSgNZ3hlMgsd3XVnqLxoD
	 1ohrvFgDKiCV1dYXHbOozX1IIstZQapRvpXOGFms2gamyxF+og6GGwGoXlbhIU68iN
	 IkQ+H8ceCINdZeuO+WxFZg9dLUIyOj2rPod2MmD8cs2YCcs2oAOL/IcAOAt3aVJE5g
	 xdHUaMjhNMzOA==
Message-ID: <a916f157-970c-49d3-a787-0ae27852d8e4@kernel.org>
Date: Mon, 24 Nov 2025 18:14:19 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 20/20] blktrace: call BLKTRACESETUP2
 ioctl per default to setup a trace
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-21-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-21-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Call BLKTRACESETUP2 ioctl per default and if the kernel does not support
> this ioctl because it is too old, fall back to calling BLKTRACESETUP.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
