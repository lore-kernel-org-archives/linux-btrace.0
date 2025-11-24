Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87C2F7AAC;
	Mon, 24 Nov 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975741; cv=none; b=uxd+6UzLkJrzTEloRHQztFK2X9zYo4NRrJR5dc5PpteGX/W8K33nOrPL0IqhC4beGs7PzoYvaH2TOiu+BXekgKA4hdyy2BIkf99G76pa4PGsbLydmwBvlCnKJYfV5uPIvkqcZT9NbCrsmcTAciK2Aimp8QL+EXFAFrgc8x/MVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975741; c=relaxed/simple;
	bh=G5lJHbzVWS4kg4Ix1bIHHP3MJPfmNEHpmd+ljiGojXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo/Nf+U64bCLFpQw0UTNWXYUK4P3Xd1u/2Ygf013eDCovtDpWDmcaPccbmTbM+ja9oZufNa50oqz4Esr4YAic4Jdl5dSSPgHEIaCpEqntpmkFii11yMH3TCViyf8JPj6kc9JjWpIjyNTRG5xHboPY5nzIWA1eNC4hYrIojl9n7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUw87ZEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUw87ZEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1BAC4CEF1;
	Mon, 24 Nov 2025 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975741;
	bh=G5lJHbzVWS4kg4Ix1bIHHP3MJPfmNEHpmd+ljiGojXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oUw87ZEimQEWKcQ9kp7GkMOQJZOCf+t2CoS4YDShU0KahTz496Gwsmk7r8tU4mqRH
	 V5IUHJyXaNky8SLtWtv07geFH5mnSZx0/iYzVhRUnw+Jui2CCpHx16h682wXnaCQUc
	 e/tTjNqahMnYVYqCexADDXsj0+wfUTZC2qBKmDHnXzeeBQ1tE1MHEKqckMk40zXpxc
	 YIQIWx+rWUuEFvcJqUZ0XSDh1hQb68sdHQUQ5OwUpWyLxPyyl8MScZCNDWa7JALPRb
	 LPYQCZKw/h6Ixb22I1m1DlQqk51ZWQmsj1x46aOPJStzN4RMhmolcJZKqbAh1pnOEv
	 gDQ5k2Eb9BpEw==
Message-ID: <2d09b087-12a5-4358-a7f3-9290053bfb64@kernel.org>
Date: Mon, 24 Nov 2025 18:15:38 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 05/20] blktrace: add definitions for
 blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-6-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Add 'struct blk_io_trace2' which represents the extended version of the
> blktrace protocol.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
