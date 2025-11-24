Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878F7260D;
	Mon, 24 Nov 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975068; cv=none; b=Cp3QrN1+J4wDQ2IuREKW0ZXCGZQlp8miAD5WX7l86vpN+CF4NHpXHVagyn0+vtKkc4+5XSEMtcH6LLgOUVAH080dbyjWz4hPHDAKKzfHlo1yU/Jxt1PjsEzKyPPU+mavsHhcLNOZ90aEJeSVIrKEu0SI9ckyNB/bDRIAlNJKnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975068; c=relaxed/simple;
	bh=j/eVnKK7h7cf9L4AoSjFlfI5aoPzDCssBVfCrkZ96lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn3EyiVBZU+OxqrjS17J2kXd2hSgF0XSf+DGAyXBmdBTF+yGip3JjKPRgwNHEvDPsDWvWXHcHlzAQcId3+txO7vnzodOKln6xQRmiaAKaJ3MCqhcq/n1ZwSAP0cGjlzhRLeEC9VVBt/BajO180+MyrxjaNHSfXPO+DLcQ78/fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ywt0PS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ywt0PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B916DC4CEF1;
	Mon, 24 Nov 2025 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975068;
	bh=j/eVnKK7h7cf9L4AoSjFlfI5aoPzDCssBVfCrkZ96lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D/ywt0PSYsvEsgEDqLy5MqkaoZ93mlVA5DDyUVFvfjiPFkiR3IkCORpecI/lVEaJO
	 2utVI/DQwNiwxIlcUAt2TX7k/v+svt6dGFi13zR8tQu+6hptpeZp+alDeL9Yw1RYzc
	 8NSIDXqqc92MZ7sCTn9jmlPLq8Gyp3olfEwZxqNLOcBmIGyvFV4WRLUNSUIW530IMP
	 A6GUYWYkcR8DrNOrJf5riWyuEer4XRGmSicW6aOEl4/g7/ND8XIIHmW6i3gL0Mgbh/
	 y4FG/dNs+7lQCYPEiPdCbffgxhM+yS4ppwm/imT93w0kWswAFomiHT0xWfZ03Zpnnp
	 vz4peIQjGIvfQ==
Message-ID: <a75ad1df-e1c6-4f49-b552-8c5c03f215c0@kernel.org>
Date: Mon, 24 Nov 2025 18:04:25 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 09/20] blkparse: factor out reading of
 a singe blk_io_trace event
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-10-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-10-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Factor out reading a single blk_io_trace event. This de-duplicates code
> and also prepares for expansion with new trace protocol versions.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
