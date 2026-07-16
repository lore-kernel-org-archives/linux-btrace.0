Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625233C5550;
	Thu, 16 Jul 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203702; cv=none; b=hke4Gv3J/G6tMLEKXV8+TFyUf+hgPwNiORGVpxNuSFg9xQb7ZniWyMk9rV0fsAuK35OvxORx27kOta34zlzAO7XlvffFpOu9TuFZSZRUuCbkeMZtm9Wgo4GJJ/LcA66ZJsgeoF6LYGLdVViMYdc+m43LzvAlM1AQ6HD1IkdPhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203702; c=relaxed/simple;
	bh=SUnPzaGvTEmDEPK71/CMkH9DDWL7fFRgcsBW9dnB5ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fh/Dh5pjgRGKK3N6pqmF78TZGLhjdlO1gk3ic/HzRTZwg58Hg9qSN6YkPn1m9bEaP0PP9RSQQberwHairL6+QL9qpYm/1RRgsjBXI6IewjsPFLQQkgb1uPVime4H0FkJx8lKg5ZSira+tEi3ZRuYp+7GGL2HKj9xk3OFOTl7HCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+iyl/ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+iyl/ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B34E1F000E9;
	Thu, 16 Jul 2026 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203701;
	bh=jy1MCEo4h+b5yrEKlZHrh6jMyJYtF+Ydb57Neu38nAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i+iyl/nyye1xsyGm8AQ5mD4PCPFgTS/qniWVSQZShiRT5D6g3m60t5LSNzEDd6i+u
	 l7NYbLeBmCvGArQ7Z/70R3JK5TzbJhapTeNSv2iQnkN+tHjVXVjJDGcAVMM7bJYyU6
	 IEZ+Ot8Du/nEb4rZgA09MJ+ggywMm+/vxci5LwStgGcN9SxIkx/4DVO4SBpz/z1tN9
	 R5fnwrEm3sSqv4mQ+LU3PpHj97K78CE8joU77pou8oOGOmJgrsldIeXRZpn+v7D9m1
	 j+bscYxMlBlMHC6r8v9EEjUqMqFaHHjryFHHfKifnKAN9gRVb6tFBVJtmxl0rul/qT
	 1KsFQgdSIFV9A==
Message-ID: <1d5a36cc-4d34-4933-8efd-a6e8b81eb415@kernel.org>
Date: Thu, 16 Jul 2026 21:08:18 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] iowatcher: natively parse blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-10-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-10-johannes.thumshirn@wdc.com>
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
