Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E741736D;
	Thu, 16 Jul 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203629; cv=none; b=bstMu9fEM4ZbzWnXDwy4zGohf+se6TLojsKvYSEheRYL0ONTP82Ku5HMPHXJ+TU0Ri37cXaSemFqgpBIa1H5nrtEjCr32y/s+wwwn2dnaVNsedktV8WxC1nY822s3DTXKqZ3cvVN9EaOnVRBDjLm8BzGHWrLCjr+s9bH+3GvGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203629; c=relaxed/simple;
	bh=aPZhX3BQKknR4SA7WPaK9h4or7vPdiorZpQsWQiTJUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0/bmNSVWxOKEaHHjG7qwjzSfarU4TutJYa/Dr3lGl47wjZiMOB1qEl4V4Fqt8P4XZMpF+QXmh2ySukWEDgHT7nQYEPZpt1bEiFGsqQWFJmWQrqpQHBMcpzUiX9Xmialw7dSZCuXsnOEjgTbMihtEfjBpYcX6DoZTYbRZhsZnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESqKfCqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESqKfCqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30321F000E9;
	Thu, 16 Jul 2026 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203627;
	bh=wI14ge0hUZuODDmuPIoCPFS9qDIKL1a4SO0oH7TmJfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ESqKfCqPr+Erp1eQt5k50lukAm25OPQbHneOAQ3TSAw2nArJb7oZh44z9qPXhr/xC
	 fsNJLmteyK+LGY97jIV6nnt+c9OZ/UxfvtEhUdiZzeO3hel5JjiuVMVGVbnBubEjkF
	 EG8X/61Q0dnVagwXMH66qbwqLVtvnUHgh0+x8ai1Ke4Fed8vT4QBtqRGrSxWsKQbzl
	 KeBnqrml17r5DE37QW/CVN/HyoG5CRURXueYfYZ7z7teHwigSEdPZZ2h9yXbA97s3H
	 iYQZAIfshWEXcnqyD7bF26EK1wGFvNE/nUHLgipqRviyZSaWKOeFqsdBgDx6+3qqrR
	 VOhKZo+B+c++A==
Message-ID: <ab65cea3-e4e8-4422-9cd4-b68b55543a35@kernel.org>
Date: Thu, 16 Jul 2026 21:07:05 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] iowatcher: use blk_io_trace2 internally
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-9-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-9-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Use 'struct blk_io_trace2' as internal representation for a captured
> blktrace.
> 
> This implies the conversion of 'struct blk_io_trace' into 'struct
> blk_io_trace2' when reading the trace from the binary file.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
