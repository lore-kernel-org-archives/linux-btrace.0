Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1E2F3C3E;
	Mon, 24 Nov 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975254; cv=none; b=rCQnvQsMD1BKIFRLZvTgH/BMIgO6w+HK3jwmVXrxllI7mDgm/h46DesagVzb6MlZhbX8BG9DEhUvZ+jwVSh2ctlwJ1r/d1jgvKHv03k3dOAVFOUBLX4q8/FGVeN/0v5o9jjpQw5YkgmZ8Jy0A33AsUcTGdN67LZGElFg+9Ny4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975254; c=relaxed/simple;
	bh=PW0pM1nXfdnNB7h2aVakEamhU49bt+X/9Ma7SYDt98o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhVqu2gh99jJP2paULwBYujbYuiLVJuXd0RQ8CqcaUgMe5HqdtGK9CqrT1UY6Q8d8EYJWVjv7dVBLAJIBRoUSl2PbjBdLidvGp7BF1HXOQflWbY9K/BHxtRJrhNu6FZVJD0GiWzGFrhAv43dswYARkZuFE3Tk8oLcw96iH59b8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9fWPE8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9fWPE8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4066DC4CEF1;
	Mon, 24 Nov 2025 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975254;
	bh=PW0pM1nXfdnNB7h2aVakEamhU49bt+X/9Ma7SYDt98o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P9fWPE8buiKJZXv75N9EUqdhtz9sCNmgZ9qtY4rgdnWDH1yzKSVxxEvxDlo7cXOcA
	 H5ApC0LtzwJyXToA4YTP8yr4xfaA3hl30GporvQ/Ch2Wd4FATqn1R7/ZmOOXD7uDxw
	 Ji43iTowCRswySyIgNUXNY/L+UwnP/zqUq5GzeUYdZUF9p1iCsnu9WGX5JSmLLxrvL
	 tZEcJDyxyJnkukzQdcsWE5oDZJckeUYBduc2B2fZbRgHevlqBo1Ld4hHPfsVZJaHRU
	 zwAMmz6RV9V/4Wt9b1upvQxzxHXCCAGs9xoT1A2MKZfSTamMwcTCWha0kL/NeDJLre
	 VGGHevvhdX6fA==
Message-ID: <a014acb5-8659-42f2-8528-8e0b1ef4a9c7@kernel.org>
Date: Mon, 24 Nov 2025 18:07:31 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 13/20] blktrace: pass magic to
 CHECK_MAGIC macro
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-14-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-14-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Pass only the magic number itself to the CHECK_MAGIC() macro.
> 
> This enables support for multiple versions.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
