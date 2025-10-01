Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5117B506;
	Wed,  1 Oct 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304521; cv=none; b=eNg3vuHS8ad7+iuYNeGtI5jZYATXmMiCpxvtcrcU5sxFtEe1CYkBJl3bgDRSuGRe5U28OL8BjjoemmoxSiAUlk6G2rI+yp/vlGw9uSLlwnDIWHxKABVo4D0ruThpe6MKrI6BJmbHzjpcDCgdDrI/2xXj48lhnW3aiWbBo9VPVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304521; c=relaxed/simple;
	bh=SYDSKRKZnqGTnhIPZnlUtf0WBgSetRvC9aAqfYjzmwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc3rromZnZ3tsUJUDYw1459B+5XOzhNIWLw+OiYAJg7Pb5evdW9olCH3yXP4CgZ1evE587pUOvNNeJvtHzUym1ziW06lBiSu4lorIyFih0/khHa3LuxcQRt/zZhOWAG3jjTwfLXUcAhPWsuaoaosFqVb+n/TF/Pmh/kSHFRw/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLtDwVyf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLtDwVyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25293C4CEF4;
	Wed,  1 Oct 2025 07:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759304521;
	bh=SYDSKRKZnqGTnhIPZnlUtf0WBgSetRvC9aAqfYjzmwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLtDwVyfJGTQ2D038WVA/hz0GdLaxyjVOLnMD/Uny8eQrz7BE9dWNdmrXx6Ak/Yz1
	 DJaQTxxoXz0gbaBH7pSc1n1t1xRsBO+gwVeZIokUOZpW2lnVmQv/SeWWXAvHMDehaC
	 PpkECmfYAS/zHLX7twjIB51zYVtPC3kZRfAIlnOlzKVanGp+iXAYA5jPWxYcyauieY
	 cb/OEddfqIWTumLVIpSkz8viMkRVpqghsucGxw8AeV9vekZs32srFLSoQiofhYnKKr
	 PX2rd7WKmy+uMN5DuDwcK3doAhoWERF52QCPdRdzttI4Xd0P2amhYxkmQzGTxejcGq
	 x2bPLob/uYVwg==
Message-ID: <8a367090-a15b-4b4d-a0f5-525e04a5f27d@kernel.org>
Date: Wed, 1 Oct 2025 16:41:50 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktrace v2 01/22] blktrace: fix comment for struct
 blk_trace_setup:
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
 <20250925150427.67394-2-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150427.67394-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:04, Johannes Thumshirn wrote:
> Fix a comment misnaming the ioctl(2) passing struct blk_trace_setup.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
