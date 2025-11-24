Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D262F49E9;
	Mon, 24 Nov 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975435; cv=none; b=TsM6U33hs9fc4i+1vc/sUCcbc4uk96RYz4ujJ5bjuoo57lFjW/eD2QQ7+5AFB3Qju2nUgFT/Mkj1jhpYi2AiGWXQQDX8i0KGvTvJCWuPX0CTPh5NXr86ik0S0PL0sn4jhQm+OI7TszFY7+g6ISSJo379L7iZU4BIwh6jT+Wc988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975435; c=relaxed/simple;
	bh=2wsJVJUn1v0PNZeTL6AJmzy3CAYOKJ9P+uNOJUoUaco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+maPNqgPSL7/EUcZpPwr4WrDQmrfGX2VnDyUEvzS76b4g4NmOBDQnJtyIlGxPTEHJYbt0zcP6n1/Odu23Zq26mhRauDR1OfFO2KzT5Wkpxwoui53owou/+iky/c3EYvyBzHDWNgOXBl+6GmvwA6PqLXXc9kYdxaJIRuFqlqd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXUgGPrn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXUgGPrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0405C4CEF1;
	Mon, 24 Nov 2025 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975435;
	bh=2wsJVJUn1v0PNZeTL6AJmzy3CAYOKJ9P+uNOJUoUaco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RXUgGPrnlOzuUELT41AfNJpD1gbWJtX5IOWcRcuUMLZwZRsJ/rEpNRdwTGdP7wmGb
	 IUw/NaXCTW/NzYKolwentwIs4WTxwig1oKVqFDn0J7uZzy/T51FSoFmvR3v8xI8zPG
	 luerwOLyE60WsWz+94fiJ+F3PEZU9GJIGpxttdGd1PDatdn3WIemEy0yq/O9JJ+5Wi
	 zjmnCDxwUwAbKSAnj96VdQuKhFlzzAv0W6md+r6szBTxgdpc9vZhrkANvpcqO1uBhq
	 1vq/NZ5oaltAD0LgKVQWrQaE/5nL9ZF959yx0BizhOED5Mp0TLafsBRWLNE8u9P95N
	 XQpZdQP7Zhk3A==
Message-ID: <34fa7634-81bf-4658-a528-8d823bb6888e@kernel.org>
Date: Mon, 24 Nov 2025 18:10:32 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 16/20] blkparse: use blk_io_trace2
 internally
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-17-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-17-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Use 'struct blk_io_trace2' as internal representation for a captured
> blktrace.
> 
> This implies the conversion of 'struct blk_io_trace' into 'struct
> blk_io_trace2' when reading the trace from the binary file.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
