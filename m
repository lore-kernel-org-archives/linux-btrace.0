Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDD2EAB8D;
	Mon, 24 Nov 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975277; cv=none; b=YBrZmPQuvox8gExyMOO8R8SQnjhbADWYLWlS4HNM2ZAaISvJzHXKSPLDk/J49bjX9PbQcpIYuSMNEU3ejyC++HoklS1HQBl4JHFkpJ3nLqKb51fmmIKtcB6mLXGYjYTsiYU7rx7EUVj2kBBHbGBqsokGzll8+a59UxTYV13B3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975277; c=relaxed/simple;
	bh=OZmijKzMu5S68ta3dOxXg8GkTf/Ehe4fjTdg27vvMCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W773nyPMSJJmpXonRg+sWTzEgrRgvXgoouAld97O2n4FwesMUlVDMCxiNQ3FJiInjAg8lpcJRapuwzpDQTQySgLCYpH1KyMwjxgiRsgguC6eiNFeVd1AzJU4SCnAC7LVBQA0DvlClFADnjxW1E0OdZ4zZEIkGdrrLPR+tqczM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLPfhu3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLPfhu3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B9CC4CEF1;
	Mon, 24 Nov 2025 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975277;
	bh=OZmijKzMu5S68ta3dOxXg8GkTf/Ehe4fjTdg27vvMCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jLPfhu3vSgnquJ2GAqvxRXJ46OtHiALWAnMnofAiKM4y23lpHWiKsf0D5kOZxc/6Z
	 hkUQhFEeY1y1ol86KYfqhxVM5yM1YZ1eRgbgiMuApVrNg4Pdqdol4C3wMblqxCAF80
	 BDF0mry8LL29I7VkZbRoeZtYoU5qhXz+fTUmsvyGS9mYoI9ffBxgVTPU1vwhnJyOS3
	 EmykxCHKnIQdyg/QD5pqqomivBjKvsbEa3Mt7fAk3+4/PEuOM0Ji6/AFNUt2aorNUg
	 4JhVir4Yp8DE6LfJpfpnUYvmU5IJGqNur6H96d1HccTv1QEOsJ8TlsJVzUeu/RAU9c
	 xiF1QSo5XnirA==
Message-ID: <c759af2b-dc17-42c2-a6c7-e2d0d8fc05d5@kernel.org>
Date: Mon, 24 Nov 2025 18:07:54 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 14/20] blktrace: pass magic to
 verify_trace
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-15-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-15-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Pass magic to verify_trace(), this will enable verification of multiple
> supported versions.
> 
> Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
