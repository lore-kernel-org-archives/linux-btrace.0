Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7D1096F;
	Mon, 24 Nov 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974985; cv=none; b=DYscVbo53YgxcN92Civo1vskGWhbAQ8swuTvpii0D6H9QY2Cs7UtLKERHfjidMsfXT8uchM4tMScmmUI8cPwNwCm3hNfeVpHSvJ69HEN56nvClDXzyMs4Wo7DZeWJjh+ICGSQpZKBrhLdxOe1tkFQ0yAMsL4ltieCW/w+16h6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974985; c=relaxed/simple;
	bh=lsZiMNMSbwlETr8Y5BGgn0grKyfvV7GlURdzVmKDHzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2yCipTXLtPwzgZKv0hL3xApPmYZ5m+iSsp7glpg47EGApLvPWWfUFGmcGgcublVRXZMg4XqB94z0HpZsU5End7wMPvwOYZAkqXrDaF6eoRtQgPJ2cPQx0M9rlqlsoPzCh/MRSVZUfQC+B5Dj8maJDGMT+W79m83Mx3Uu0xlVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yea+jZhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yea+jZhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E1AC4CEF1;
	Mon, 24 Nov 2025 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763974984;
	bh=lsZiMNMSbwlETr8Y5BGgn0grKyfvV7GlURdzVmKDHzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yea+jZhcAVDbnfdC8k7IHcAPK16C3BzJeuN9Ng7+EdB2I8sfBTzt571klqg+03ARb
	 9QaEBhdC1vhQ39nD88HYch6SRBOCx3UHYIEHoCytPOh0E6f12pnHUq0in5LmlS4LnF
	 d7ubder5mOMJSu7vcXutFq/eNLqqWLktmIhM3uJX302syMG/moEm2vXzcU4+4y5Kf3
	 7wypwnuw/0FXA4raw4833PvhImiZKMqK6Zv4mePScuhj1c8nmWi5LfkI891Jxw61Xx
	 rBdUa5dvxUXETMGTQw4/d1uKo3m/QT+EsbqOu4liZ81ltomJak481S9CBPEKTBrDDH
	 /8mVsdqpFxlDA==
Message-ID: <0e9f40a5-c566-4b8e-a9b2-7511578cff2a@kernel.org>
Date: Mon, 24 Nov 2025 18:03:02 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 08/20] blkparse: read 'magic' first
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-9-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-9-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Read the 'magic' portion of 'struct blk_io_trace' first when reading the
> tracefile and only if all magic checks succeed, read the rest of the
> trace.
> 
> This is a preparation of supporting multiple trace protocol versions.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
