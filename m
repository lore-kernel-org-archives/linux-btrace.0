Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B041B8D7;
	Thu, 16 Jul 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203793; cv=none; b=bBrV5248E9mccLhUM0p0iZbMXogWaHsSgkc+6/KUTBvvk56kxmO2n4a/KNTP5YOMpbZB0h9sYZJ0+JsreD5uut1Ik8pxbLdNrrFFGgngKu9ch0zz0vAYggh4dN96kV2bVp2Nq3KOYJoLICt0U5Amd0rnVcErp3OnnAAcQyKeTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203793; c=relaxed/simple;
	bh=tuwq/NBNavKEBkjakyXd4kLO4go8VWi2TfrQxfetDCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiCIWsU1nVwNGyQUgSLaJ8Ez73UMaL6uNkPsNOV9tgi6KGFDD2EvFY6naH1YSMCWdQNqa/MrKMixxxxlCzc/YZ4OBzObRmK3fZicEC3Gex/yZh4l5wZk7JX/0aRDff6OMJsIgL7eB5JGnlxUFfaisKJaf79NFg91SmmTv/LXGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lty5zN+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lty5zN+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C001F00A3E;
	Thu, 16 Jul 2026 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203792;
	bh=qe5me+OJ2VgoCgpfQaQqLYZc0wvHM36C3dX+D8Zds6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lty5zN+TKpD8QAzGer+pLtKzYcdY4R+4r5/HGAeJz4/+mH6TAFDhx2Ksg3JtQURNa
	 1lcF02GghVA2abXoP/sAlilWgsn7hWIoi1LBaCMy7T+fTbEocPcOmDv/0EvgEb6Bow
	 ebJRMwAblNR4hXNcA5nxZFd6xti2KzH5WDpZjXoQd1NV+/ey7Q/WUx6xuCdOQ+twVs
	 32P2+E2TcxyK8Gh3uRvYkinLycM6PtL+zq3wwR4LhRXNPOTpmL6sXaqDXpN9HofNDH
	 Fc8moksf1i/mnAjn2uzMq30VjAk/hrD9o7jLCd1aaQVX1fV3hLpXGcOR2Xl69sqp5c
	 sWHAKNayBi6Gg==
Message-ID: <04c7f5cd-21f8-4fad-9aa6-009a74538a7e@kernel.org>
Date: Thu, 16 Jul 2026 21:09:49 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] btreplay: support blk_io_trace2 in btrecord
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-11-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-11-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Read the 'magic' portion of the trace first and then parse either 'struct
> blk_io_trace' or 'struct blk_io_trace2' depending on the protocol version
> of the trace, so btrecord can process both trace file versions.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
