Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F5406282;
	Mon, 20 Jul 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548357; cv=none; b=YD+6CBf5jBuIA3O3UKLznZ5jHUlcB/Cze8A9E41ODZss4Qh9plR/35Rn47FEQvXhntWgoQkwPl3kcJlHJwLrXON8vzP1S4dFzkJeeXBsJ0EWXgkQ27pYnQFevyvjRMl+AsJtwHuUAX73tznuz5wr7GYpO7QbJmz5g5+lYUb8ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548357; c=relaxed/simple;
	bh=PpH+5fY+4323irqY1gykaXdwT881QpyGDXPXr2t21H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHNqf03qFi8gW8Qxws7ijauJ8oSmKQ7EFGxzg4tFYHa1l4WBAU3EmwAaJaCB4Wwf0sNJ95pJz5THdPuq3fmIeAZ4wnM5f0oHP7/k4edlGWwEmIUIJfvmsx+kOfGQNTQQJGyaF90lP/PAc+q/xCsnpht5btwF46UCa9dOFmITabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFcYv8Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFcYv8Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F92B1F00A3A;
	Mon, 20 Jul 2026 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784548356;
	bh=75db/Pxe130MZgAHRQTXZM3LbZlh1K3KqrJDGZ8M+0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GFcYv8KdiBFgMUDqCfYBsquy3UILHqthwBbX7kyvg+eGF6O6p3dpWwRfuLDdIMXsD
	 l59vtwW/lzOWvwwL4E/zh9HHa7CW7qiJOdtt9BSB07GMPKJ/8J9TKCSnjRYdqDgOAY
	 cXFBM9KMz5T6/lNWs9idqJ743EuEoxnRtw9Y6nIpWVf4pDPf7T/BRvVh44/iu+6Uxu
	 997M38t6jjvD+Caz0cvaekOzUAZ2/lfacCPMw6czIAylVGaaZxioSP806g6ANldrI1
	 qeddxCepmGXW6WLJ4bflmSKqXRoPWOaPp98N1iKmF/ZlKof7RUErbNS4+xqfc0SVxe
	 spXL/MyE4VPQw==
Message-ID: <2ba7a6fd-895b-468f-ab33-67dfd8803451@kernel.org>
Date: Mon, 20 Jul 2026 20:52:33 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] blktrace: add option to request a specific trace
 protocol version
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
 <20260720111417.1658507-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260720111417.1658507-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 20:14, Johannes Thumshirn wrote:
> Add the '--trace-version=<1|2>' command line option to select the trace
> protocol version requested from the kernel. Requesting version 1 forces
> blktrace to use the old BLKTRACESETUP ioctl, while version 2 (the
> default) uses BLKTRACESETUP2.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
