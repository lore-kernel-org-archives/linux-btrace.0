Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3B32E142;
	Wed, 22 Oct 2025 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136297; cv=none; b=gAY/nfv75yRjYG3nE46YytQFGU+l6QvPbqxSWBUeJky3VQC8+/xnJMTM5muD8oNPv9ersIwhTOopKNeWNihlHsNngduj9Ya0IE/KeiPrxmg0ba6Sxr5HdNwnaaYSsGuxpJnimjWuO2TriuBhbmKSkbgvgrQOE5XcTCm02QMG0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136297; c=relaxed/simple;
	bh=pNMPXPWs7eegnY7nqPZGRkQuPaLcdwIr+YGQQYhJAzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8tK7GdnI8oXQFw1rqNngkDpL977qHNQkjWQSWQmx9jLlm7x3FTh2QsAZUK7ESEU3D6+a+ndUGmbMuO2kjbdcJkQsERyk2EYm5BYV4inBNc+Wd3QVJhhAIVHsJq9xcwXRZqUd/RQBDI1txJ4pyhUw5ZNlZIibvVA1sRnNSDhKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSYiSoIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSYiSoIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B225C4CEE7;
	Wed, 22 Oct 2025 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761136297;
	bh=pNMPXPWs7eegnY7nqPZGRkQuPaLcdwIr+YGQQYhJAzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HSYiSoIjkbusGUoqYxYnpwc2eRnGbDfs792n2Pzyo4LRaJPCR6ry27kRf+9Gcdui2
	 DB/7vao2QpysvVEWImRedaO9AUZKIWYEalOVvfGjypDkAx4Z4XsrXXLyGwMCUeIUL9
	 jYbDOrTl4m5ehAl7dL2wiRIaHSJJpByQGYQmS8ZFiGm0a4AeFl7YICgIx+U5OSP/a5
	 edjH6+orS8ksF9d6bokocaqacGBC84Ke6heZuPoPpBVNv7GC2XJLVARno4Wo4VgfA0
	 wygvnLcHP9fw8ELGQwt73xw0APh1UPu03sM2oXRC6f2PSyQP4oNd756inHGVncP7at
	 h8t5eGdylBfgQ==
Message-ID: <acc7399f-8c91-4274-8f01-d3aca31395e9@kernel.org>
Date: Wed, 22 Oct 2025 21:31:35 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] blktrace: add block trace commands for zone
 operations
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: chaitanyak@nvidia.com, hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
 shinichiro.kawasaki@wdc.com
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
 <20251022114115.213865-14-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251022114115.213865-14-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 20:41, Johannes Thumshirn wrote:
> Add block trace commands for zone operations. These commands can only be
> handled with version 2 of the blktrace protocol. For version 1, warn if a
> command that does not fit into the 16 bits reserved for the command in
> this version is passed in.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
