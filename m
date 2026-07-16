Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5E2EA154;
	Thu, 16 Jul 2026 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202934; cv=none; b=Kpc6f9SUt9JjOTfKLyhJPOj8WwsYSV26YX4AY8D9jRfK5uoT6Yjs4/855I/2sa9UUroqkSrQMxnODpoj6fRz+QNpiCZ56cVmW3o/Z+C443+lu0mpQVMhEHUqzug0lL4Tkr2DjdpZfumOeBWMS8R8luw/izrXo9XygDxYK8ZSOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202934; c=relaxed/simple;
	bh=aPZhX3BQKknR4SA7WPaK9h4or7vPdiorZpQsWQiTJUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvUyCCtIqAUwhnjOxz9hr4FZLUZzz7tp6CcrQKPQSbe0ZRw7fPgptaGs//qxnjSJR5v3+iqAT8UJNMx9FBwAETcrYk5bdMytC9f2MnGgNRBT2/LsX3kKA8WdY5jlmEmX8S51mtmGhxnkNOxQ5NTPGk7NX2bz5aLzO/EIlL5ejRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0KTl9Mg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0KTl9Mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C141F00A3F;
	Thu, 16 Jul 2026 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202933;
	bh=wI14ge0hUZuODDmuPIoCPFS9qDIKL1a4SO0oH7TmJfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P0KTl9MgmZvkGJteYQgCKoRl+B0mGICTv25pWPq81QFlnPC9uARcWte2nqfyprF28
	 6RxO+uEsaU5AK4TSluQYdODNFBvka/lH3/K1Vr2IzLW+9MnCy1n7SUemGjydq4/+D0
	 rBSoV7CwSl2Frt5CQ6yayORuVi8sFP+eNUoPQJHrmfYQBn4qy12FF6Kzuu8vPs2s1G
	 2MTCuX23lWCbO67kpV4ddDlgbUci3hXZtcRPoqg0BfN7KM9C0/WQ0yzI40p++ZsD0W
	 dh//bbp09vhuMydztgiu35NWlw38viSQw5JhShiEXLVc29d5mTLEdNwTLY33X9lLsS
	 wQot8TjxkTHFA==
Message-ID: <cb7172f0-2d6b-4bfb-835f-f71f1437124e@kernel.org>
Date: Thu, 16 Jul 2026 20:55:30 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] blkrawverify: use blk_io_trace2 internally
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-5-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-5-johannes.thumshirn@wdc.com>
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
