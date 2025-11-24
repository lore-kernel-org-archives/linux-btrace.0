Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C52F531C;
	Mon, 24 Nov 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975556; cv=none; b=FhXRXOQfeBhGsWxIfZcBRkVEIkd6Q7wffAqGDmtRxIzxRrrKkqyU9Ei88wn3XjMplNBL9t99aw9u0qTbAmMQSKLxZLSr2oSf9+rk4rJvDX8SQ7Cqm0RmqUNgqMEP8/AEygiIBthgI97eBnzm+Ewp9J6NzRG20IXQiybc+pHUmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975556; c=relaxed/simple;
	bh=1Lgve3Zf3Fw+sAkRcgkhnYwmEu5qAkOrjsuMxoN2UiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMrFEvu8CEyNHuWdC9oPpeIf8ohk5UalP7bpdkt4DhSllXOSQMZWiAU/Xahfim+rWEmhdT0Yy5cxSgS7nlibPO1kIUjh4a8ZaaTHOLFEOmx/S7xufpcY0q4gvI/hVRSfL0/FmTpkfyUChVuHvx9TBvH6hjOwOCQS3XxJkXeEuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JinFJDY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JinFJDY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39254C4CEF1;
	Mon, 24 Nov 2025 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975555;
	bh=1Lgve3Zf3Fw+sAkRcgkhnYwmEu5qAkOrjsuMxoN2UiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JinFJDY2Fy9OJ+8V3/DU4VdgqcnRZuR+hwFYyaiQH5MBWiZemW5pAEyKoSmYPeGwh
	 2nKyaPaq0PrHLr3/P8myUYxfMU5ki/uvZUZD0C7QLuFjwNEFpqdDXJl9JLy6ijLft3
	 zZCyVTj4seRlIruAaVnlJljtl0Pw9T/vS57e+Ml7BF+xQ5FKXcZgyqxjCVSGl/sB4O
	 z4Ta4N6I/USifU8tfRxzDmBmIkque3afFqDXcitDWHLYaUtrQQGMBnUOudYnJWT7qK
	 6sQMvNZRIjJ1EFR9gm883TmSRY7eZEuDYpYOG0FVtrEYVK8UvYGsWwv+7Tk6bjsMYl
	 pJ6quuO3glmVA==
Message-ID: <0b559629-d5b1-436c-bf3b-8a67afa2a6de@kernel.org>
Date: Mon, 24 Nov 2025 18:12:32 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 18/20] blkparse: parse zone (un)plug
 actions
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-19-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-19-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Parse Zone Write Plugging plug and unplug actions in blkparse.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
