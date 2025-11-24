Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D452F3C12;
	Mon, 24 Nov 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975221; cv=none; b=BvxsJsMm2JsXj+thJhb1T02vxO13Ah5aPl2qhsYlcXStfqc28hZksY82mgkMlcycZ7r3+Z5YAJqoJ4ayAtN/F8vjbi4R4VU6S6Z/fz+nbDYpDP1jB/3MTpvxubLJp4H8t1dKrz7KFvNrY1MYwUg8CCuyerv2yF8NhORbOeChzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975221; c=relaxed/simple;
	bh=ZREoBBevmdNrqQdvtHWxz4C81p2cI8gYZisidm2bbrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szU4nSNhHnhWgEBH1iY2X1RPLES51IosQ8qXe01Ihs9X47/1Vq3DVuxGSuU0gpEYEGlPLAgLCXyuEoaZ62cEASa46Q4KitGHx5pz+Dvn2GZ6FJjcb/QigCni+R6GAzhEQESVnqNQVNpiZY3yKtp07JVszGdtZWPMXXMpy6v2sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ6jENLz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ6jENLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8C9C4CEF1;
	Mon, 24 Nov 2025 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975221;
	bh=ZREoBBevmdNrqQdvtHWxz4C81p2cI8gYZisidm2bbrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LZ6jENLzlWPPFX4Dj+M/Do+mywrrv8OQRi3Tsi1aBu990LVQHZZt0OPOySDwtT4fR
	 JMjZ+hlo2aON/l+z4VqsOlrDWOlVH0Cr+dCeYATSnXpoBj0kvhR0rHjlU01gzZCTaq
	 u9Jm/OITc8W017AB6Brr4JywUdtEoTTpMQupT1rGMHq0HhPtGNt8IOtXHBXGS+2C6/
	 Lqp1SD7t3ikx9zH5pVHyiZb+l1ZjFK3TX5b0yGCUP2i3r+UnwFQLpWHJzdIzO2UNc6
	 xHjod1mhonAWmYgMEFLWjfTVCNvf8gRiAUZ7yd1n7j6iixJsYZHgjgC8DJy8lcY7/U
	 MNn1WuRMqGaew==
Message-ID: <59b94214-e790-4de4-94b2-8848909ffd4b@kernel.org>
Date: Mon, 24 Nov 2025 18:06:58 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 12/20] blkiomon: read 'magic' first
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-13-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-13-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Similar to blkparse, read the 'magic' portion of 'struct blk_io_trace'
> first when reading the trace.
> 
> This is a preparation of supporting multiple trace protocol versions.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
