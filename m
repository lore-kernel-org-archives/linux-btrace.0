Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208741DE1D;
	Thu, 16 Jul 2026 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203510; cv=none; b=Q4CG4RY5N1vgkmVc52GmpR7Fn/aiAdyUDGU4Cextgv50UJBxtY7DyMvd3tyNknMZdGtP0QypgiCaV34BhPZ0GCBBT0GVlh7NQMQlnb9aSd+B7CnAynEDcb+b0vPinXRqHIlQzeBnVDxgTJ/LXMBEBw7KI9m8AJWkbdD4Bj9On2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203510; c=relaxed/simple;
	bh=RM2T1tIgX+nfwzlYdSEBns1PfkMLd7vc0mKQ2THHt6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHs/G/syUaKcUaYqiT6TTUPdpRUwQJDHH0U8VGyb/s/rsPwHbKUWmwMY7KfoAlOh+uX+LtYHTdYEk1rUHhpc6k3msPje8waprafNcNrt2nDMdNIWxhMbUg8oT97IGu2Q2bsuFGglvvQGVGWkQ3DQLmSpOhkeEtW7GMAQnQ70bDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQZ9KHqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQZ9KHqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF601F000E9;
	Thu, 16 Jul 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203506;
	bh=jrUAAEooszY38D0ua770HyQOK37zAohD29U93zHXEnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UQZ9KHqood3iSmm774ruVKt2U6lT4vAgIMTIzrW4D7zO3puj5HdnrTpwji8A6TKp9
	 8ymgJ0OJuMwB29czC3zPNYo13LUQBSC0rOddGYs7d/qd5KCqEtuSJMzfBlPi6tJM22
	 1S1U5soPaKkgdKcyASbOrbUyca3nBw1QwUtHESJrA0ksDs1rN0KhfbRvrZnD8a/2/E
	 /9CoxLNv77BPOcURfTPdZATZmZ+1E2darqqGvhcXyD3/JarDWV6xv5ptwcehE/k2Gv
	 mhFzrAL0bkdUa/fJGktJp+wrOSLXRPV1Ph+kLdk0plbq/fuVTg1fDVSLFbq6qoqCk2
	 tamOmw43bWDVQ==
Message-ID: <19f1ab3d-89e9-42dc-b3c9-db9ca4cd4450@kernel.org>
Date: Thu, 16 Jul 2026 21:05:04 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] blkiomon: use blk_io_trace2 internally
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-7-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-7-johannes.thumshirn@wdc.com>
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
