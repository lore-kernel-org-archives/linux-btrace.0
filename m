Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A0280025;
	Tue, 21 Oct 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080118; cv=none; b=c/ENWkJXQCCTQB/avG0bGSCLPIbp8b87OHF3q6RCPOUoy5t7fIXSSP2zTkpx3v3hhY67Eh83/4x0XOPQ9QR0PYjzICz5rgdTGzaAisGA/IB4ye+KvmuLZ7jwOkUbLyfGpO1nBVENeTBGxyVjw1zOeMHgIIzt8Dg9boEsuUUymxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080118; c=relaxed/simple;
	bh=KvcJ8v+MYQpRSJRhDd6jVTSkhViBZso+Ry1H57i33cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1g2tj29KlkKqSyasE7rRbNLZbCbzsTB6SB4T6yB8bW8vT8QbLE1FbbwzTQsnXFMsHw3f1TFTRh7TdgVITzlt7AqE8VNkgCToGYWaKjvT4SiAB7roLpVS5ljEqXXs4ikLjJe988wBpeDTsSOjk3Xr+scAN4BmnSKvsvo37xeyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2uDPgXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2uDPgXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F93BC4CEF1;
	Tue, 21 Oct 2025 20:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080117;
	bh=KvcJ8v+MYQpRSJRhDd6jVTSkhViBZso+Ry1H57i33cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L2uDPgXyFWbtaMbbAljIdhnQqAsbjfnHaQd+5LVLVpoGoCeJ8uCxFdJ3Coi3pWPh3
	 fXY2Mqy7+6Ttzc+CQQ/yWpZ4gn2uVLh+nuFXXkLdVcrdUgoCjoqUz2LtT3TVYD8sCB
	 C/+Nital56t7n9WfNlGXUWHnsWNba8oAU2hGFZdxeH2Cj6bMK6x6wMH5ayLWdrtgyq
	 fC6e/tESzn3mJgl2qZDUeZmJoXJURc1f17B4Hr5YdEqLXnaJ1OFq+t1rhES61V1Kpy
	 TqICw7TXVevPzufNkueVhnMsVrSZC4C6TR+VM8477f6sKCbxNL6qJGVtULuk39vrak
	 fANM7XoECG6Yw==
Message-ID: <bf2b9e08-aa5c-42f1-8c02-8f5a1b3f3e63@kernel.org>
Date: Wed, 22 Oct 2025 05:55:16 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/16] blktrace: move trace_note to blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: chaitanyak@nvidia.com, hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
 shinichiro.kawasaki@wdc.com
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
 <20251020134123.119058-12-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251020134123.119058-12-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 22:41, Johannes Thumshirn wrote:
> Move trace_note() to the new blk_io_trace2 infrastructure.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
