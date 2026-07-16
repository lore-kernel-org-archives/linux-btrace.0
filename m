Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DA41D4F8;
	Thu, 16 Jul 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202473; cv=none; b=lsjsHpArIx3zFyUDbs+Z1B55wvVOWyNjOypFma91S0ohMxWeOCNlSeyXAQ75yBSYva+0Phey2DFTH24mwPJfln4S0fvxSmLIMj2aTeRLu6It7MoSaxil+4lmHbEk/wAB0C9QaEvZjtlfO7AG1hRZfJRuPoOpW0DnFm5nfObfZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202473; c=relaxed/simple;
	bh=9QRCfYkzht12mdiblKojDfej/9sy1DI3+51+w91ZtJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsFjLvafT1l2BRXe36bjHP+TikqBrgBBhtGyRujh5lOV9+ASIwTR+Rk7wE65K8aONj1KpRjJ/AP7I6/6/RnFwfLCv31oCIDirUnCNhpJIkeDVvnfzVK5vLL5XVyqhjyUDVviF+Lm6sT/YOc3o1+bYHoqhZrPBKfbAU1yVCpybLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTEwlyIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTEwlyIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4161F000E9;
	Thu, 16 Jul 2026 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202472;
	bh=EEYqXTjzN1uR2FE+Gg83FcwObV+X/Ba0l5YOjDokvEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OTEwlyINyv1jExyGs2ZJ5TW3a9qDqacP0GvbgRIuIZwhjGyoq/Pv4yemd81bSwhzb
	 dd6oQjXbjWrrY90Vt993gv4dNsoHP6P+FGOeNxLHGhrCxU9JcerBxMZTUU1otgJ9+m
	 js7gHGBwD35CQmkheJwSdeaLcfc+Ww2l3fDazgodSD8cnUJWp/STbyne9OWa8ECyXq
	 QGYP4YYJBU54Dg/Kj0XTagavDB1tXj1W9pmv6UG0/cQJadJNYOvuQoiRoHd8bmu9oC
	 d1mV6e5bO8lCwb3ERy7KILYeYgdbN1k+QnoK1Y1Sd2jnuAvFPhzeaygNnzDAaFW4V5
	 5E6ju3530z1Yg==
Message-ID: <bd114a8a-4135-4583-a76d-f50a9a8abec7@kernel.org>
Date: Thu, 16 Jul 2026 20:47:50 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] btt: natively parse blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-3-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Natively parse 'struct blk_io_trace2' from a blktrace binary.
> 
> Detect the layout by parsing the input as both 'struct blk_io_trace' and

s/both/either ?

Otherwise this is unclear as one input cannot have both formats :)

> 'struct blk_io_trace2' and using whichever interprets the trace stream
> cleanly.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Other than the nit above, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
