Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F941BA76;
	Thu, 16 Jul 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203567; cv=none; b=Rfx8+QkULuKZC5fiAI3Dh65w9ZNzbE+ewJdSTy1de2LFbtyw8+DmNWCxUm/MlZEeKwDN0KCHi3Q2xyXkPYJIUAilXIXeNdJ/Ea+2/4jI+FfN1XoZA3NN1abRjAE63AWZTopLXnyY6SFkIFlvS8zLtD2jyBfPg318mbPZT2jDwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203567; c=relaxed/simple;
	bh=SUnPzaGvTEmDEPK71/CMkH9DDWL7fFRgcsBW9dnB5ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLaKxShfApi7Dqb7x+1SzxASMLfUZ0Yg2h5vbOpXTUI8f6hcG08WGH/KJtu3Ek9vx89S2outJxdUt0vMVjJjTxHVUAVRBbPgSQkBVWEszjnMOHeXV0Y5Fyz1idiOudMe4QIzPG1YM2arBv2IAWjjdCpvDNMEfm09x/Y7/KL8SrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROV7H71m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROV7H71m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657091F000E9;
	Thu, 16 Jul 2026 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203565;
	bh=jy1MCEo4h+b5yrEKlZHrh6jMyJYtF+Ydb57Neu38nAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ROV7H71mRkGfnaZhW3SP03YAuX7J2ynYFKWbfo84SaTlaIW59dNv2uSjSXhTu+F0I
	 WldAo6FPJah6d63zivZcqfCfW2ZHNmd+fhcO/bfgz4vNgSN13ZAqlGaUCBVxTW5Fo2
	 3cOdcOPFXZtFjdvh2bO257xzpZsDDQZauUSP+VBYAkd7/5ByBCVTj/0rHG8PLaUVAi
	 VpQtjMG29JA/1MJjGd/UXedoP6OyRScVvidHJ7b9yUv2DGEcvv4/xlywhNo8ssOKes
	 3xiG7Z2jfS+1mA1pD0cZz1aAOwwH17jMnwLdtPqS+5aGHKjgKymmpqCqTTdxRH4yvx
	 dpCjaxo2irVgw==
Message-ID: <fbc0a993-8cf8-47d4-b792-226299abbc95@kernel.org>
Date: Thu, 16 Jul 2026 21:06:03 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] blkiomon: natively parse blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-8-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-8-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Natively parse 'struct blk_io_trace2' from a blktrace binary.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
