Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F6537E9;
	Wed,  1 Oct 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303700; cv=none; b=QLQbyD8SRArJEKRdK/WaRKzvU2vz7Vc8Un5oSUflBig4VXoWdCmu7Qr6rPCgXCu6P2PbPloS8PeYkfzYzBqosOnJGpUSPd0gV65E6TZB7F187D6kmcHrSrpOyvPdmeAnS/v1l1ELho0HvDvN/NpTpPazq5ixhLKbeC14Hr7Rh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303700; c=relaxed/simple;
	bh=8cp6oO64kLabsVM8vZT5ZgINgHloK8gIrBnrdoicDeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKKX+/2MoxmWkQNOCmg7s3FzBJTQ46Z8zJWFwUxAO/herl7m5EjMQlTg7YooKPZHzWFxe4npzU4BeAyqstXWCk8VOqFBst7EFvb8zcuM0cbr1Adko3FdXCBv39QK0nsCBTyP72WJPZOJPXLWTIpd7Jxl5F6KR0u7NvWS5L2AQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR2q9Bge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR2q9Bge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CD5C4CEF4;
	Wed,  1 Oct 2025 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759303700;
	bh=8cp6oO64kLabsVM8vZT5ZgINgHloK8gIrBnrdoicDeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YR2q9Bge0oD6j5WSs3jtZ8Niwz7Z+M6i5iNGjNRvnUM1CKBtNC/ckOj7+rnIb+TMe
	 Oe/OPhnxdBBB+FwXrFxOh3XBWzilerpW33fppqMbqJUJNEZDx6WVm+ECxwPYcL/Xjs
	 ohlpxwWHxPTaSQROoyCpqGmIQ9DodNSuEGWrrWJqmAfvNMxvDRRcOo6KOtK5s3yP4u
	 DQ9NYa6cO/rdgvpievtjHnTtIZk1PXfQPgZZgyLLtIMHhiwuh8dxhFTh9LWJeWO694
	 tiN4nF5r4k7UyhdXlXMKFV2N95UpX7Q4RjEIpQPWUI4VMT/Hn2Yq5Wpac8KWaki0b+
	 YXT95UshLGe3w==
Message-ID: <bf4e4215-941d-4fe2-91b7-9f5b2316a24f@kernel.org>
Date: Wed, 1 Oct 2025 16:28:11 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] blktrace: expose ZONE APPEND completions to
 blktrace
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-13-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-13-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Expose ZONE APPEND completions as a block trace completion action to
> blktrace.
> 
> As tracing of zoned block commands needs the upper 32bit of the widened
> 64bit action, only add traces to blktrace if user-space has requested
> version 2 of the blktrace protocol.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
