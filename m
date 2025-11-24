Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0412F7ADF;
	Mon, 24 Nov 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975818; cv=none; b=ZoDjN1nH1o9ULZ09goZmAZPfg0XSBW3fH7RRh3JXauSz6SXxKunE1ghBzm223IEYXLjUACIkCOjAfx0nDtJKuCDwjtOj/t2shWCoepB9VA8R07UDcPlZLwQ3iXUupjQsHWU3xJOJFr87ZLZehjU2pmv8A2TsZdhpsMbIRBvA1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975818; c=relaxed/simple;
	bh=5P2TQLAYV363WQtgmrtb6urmY5ssI6czeBLs1wqRU0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwYnfRVALBdPMD/V9rZMF+he1ZNG7a0GLUWjO+QERhmskuXk4MjnZzI0Jf9fPFJ1f8TqDUV2X5GJV8ORQKQnuvnkViQEEN/q50+Xx8vZwGYZyDHDu0qoI/GyzYiDqoWMa5ApR09xmTilLPLHj9qwul3GiwzB40nVi0gfNvH8Bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOKo+I7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOKo+I7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBECC116D0;
	Mon, 24 Nov 2025 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975818;
	bh=5P2TQLAYV363WQtgmrtb6urmY5ssI6czeBLs1wqRU0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gOKo+I7EmaxGQcGzciaP98jQBS+rRqfJKQlRdNxR9yrNnPItpGbPb3VVpRX8qAAeg
	 nkMdS67KtccuxGrEjc1ztxBO06MR+q4HVVO7TRE9YS0QHfig4h3dK0PROZCBaK4Q8N
	 7uHHbN0q2i4QcJQYA24K700IsaPzGUUGamBB68gVytMyqzCXAiy4prnfAkSC7DaJc4
	 ZRo6mnTvmeAgCFMyE9JL7aEPUFv2OCI5uYSr3Xw/aOPrYK4Eu5oq1CLBjZdSCXESko
	 BpEcrMJrSu9SY4NWo8jyd9BIMFQL+eZv/ZGnHidOSIpdM1zuk6ucjoCeE2Wc9RwcHk
	 eRe7DwyUrMwYw==
Message-ID: <108c976b-0415-4e52-8748-a3b51ff4360b@kernel.org>
Date: Mon, 24 Nov 2025 18:16:56 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 06/20] blktrace: support protocol
 version 8
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, hch <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-7-johannes.thumshirn@wdc.com>
 <62285a77-2bd2-4357-b2fa-443eea262f1b@kernel.org>
 <65d00bb5-8fe3-49a2-8477-20687183d0ac@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <65d00bb5-8fe3-49a2-8477-20687183d0ac@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 18:04, Johannes Thumshirn wrote:
> On 11/24/25 10:00 AM, Damien Le Moal wrote:
>> Shouldn't this go last in the series, after enabling the code that deal with
>> this new version ?
> 
> Right, will move
> 

Feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

When you do.

-- 
Damien Le Moal
Western Digital Research
