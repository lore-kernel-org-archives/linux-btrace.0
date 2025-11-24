Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CC36D501;
	Mon, 24 Nov 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974901; cv=none; b=KJ+CmyeeOGCbZ3IByVgcxRz1ZQoyQJgcqh/7/3zUzgbItb2vnlH9ZVBP2BnEGtvm9ICV5hTPeIZ3cE77b6FECpyYHegSWxkXw3DxGUc6R7MOBf7kNI9dylUqfF0Us9wRppSyRbJzh5Wutyic2KRTPRA2jJ3jIUNvR3pp8M1dp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974901; c=relaxed/simple;
	bh=HkeA7680ptRf6ed01mCDbrrt3J0/bviIxB2fFQIrWUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I69dP/4uDP5ooRRUR0mFnDw0+I2wBGT/wLG+oWNHPx+T0EhMNh3Rb51Zzm4naK4uQIh0aw4KOCa0gRFLLaZsv38jZHdtAzAjSSqmJCKamYkatHpxISRx4GzFJ/9xE0KFYEImlOwj6FxURfDD1ka3w13xu2vmxqKP/cCT/ag0rzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4wVgtLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4wVgtLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A26C4CEF1;
	Mon, 24 Nov 2025 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763974900;
	bh=HkeA7680ptRf6ed01mCDbrrt3J0/bviIxB2fFQIrWUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G4wVgtLDJhM8T9I8nUkSyeet55kmFUQY18nXVJUogjgQcQOgJ5F1zh0qgSJ2C1QVZ
	 2qpUJ8u0wXyWEaetc09Z8sSuFDexSwf86rZXFpPuQNCpFrJ/5M7vH/GMfApO9PZ0oU
	 KfpUCcOS9kIEXtg2WameVXS1wAaCTamY7/gxJzoXGG4RJiBzp1ewKerr1R5u9dWJcM
	 AhyRoQ4z8WRFh4vSQQfok4yDejfm7KuW/o0Td35bgo4J+1nRktVyg+MfR5KlmgWLiH
	 VCCz4XDFX0K0Wk+0TbyUU9xoy/sYCIQcSUOZqtDzmOYHq1aKY4wojMYmapFF3zxoCB
	 Wiz2vKfB3KHew==
Message-ID: <bc3666bc-60a7-465b-a814-e3ca3bd83f16@kernel.org>
Date: Mon, 24 Nov 2025 18:01:37 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 07/20] blkparse: pass magic to
 get_magic
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-8-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-8-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Pass the magic value to get_magic() instead of the whole 'struct
> blk_io_trace'.
> 
> This is a preparation for distinguishing between two different types of
> blktrace protocol versions in blkparse.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
