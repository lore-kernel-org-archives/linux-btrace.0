Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11A2405E3;
	Wed,  1 Oct 2025 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299554; cv=none; b=YZiaT15VdI655yI55Cl63kb4hqTGxT/8mO8X2mauRNOflvEm2/FMvHqF5sq9+dylV+MDqxxjZYVBxU5kY+wlYQQRQ/NGS6ZTPvTRkMJehEd08Ae4bIAw1ut/nWZfgrmYJHuW96Po/wz2SLGUgjaItCKQUY3lW72fXn9oD3JXlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299554; c=relaxed/simple;
	bh=vGoNSaKouqF0DmdtOE+YsWzH9vurYXHj5mwYZnXoP4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MU4lfWSSuRSrheGRawqE8mhm3SVH65oemjHh0C0Adi92M7y3mS8xlT0BdMf8VfLld8ASJCAG/FfKLsObbLDHeNI0Pe/k05CLFHOWdMUsecqba1/30QAKrUDRJqgLkwQZmesoyvv6E0snhYPrgP2u+Ay0iAEn2ue6h+68e/3bC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY7PtjwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY7PtjwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C95C4CEF4;
	Wed,  1 Oct 2025 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759299554;
	bh=vGoNSaKouqF0DmdtOE+YsWzH9vurYXHj5mwYZnXoP4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JY7PtjwUokXr3FyxZ0x2Fg2GvvHstL2N5dmwwI3PSz/wfrlkDGkKzKU5zV3SujQqD
	 wsYYALS/PP8IMCa9ICxucBvB3ZjVYb670moZfeRSGv5U9piel47l/iWuZbSqb2uWb4
	 J3hHhjQo/a1RRid3F2QYS+HcO1h4/0Lo3z5X/MjVJPq/88RQoVPYfAepc+X6BVkV1+
	 8/T5l0eZ09gau1kVCiyqjGvnEKiG3sQg6cGHfD4XmZ+AxE1MHSFfbTPeQJTsAuRsrv
	 zOA/AZuWZbYCHtAC9iC4zgCV5pyamZU4+VV5UNNdEMFiO68bNDT/UmVXouyrMk7hJI
	 ATDHnkiRMkcVQ==
Message-ID: <255669b4-05fe-421c-898d-9649cf637187@kernel.org>
Date: Wed, 1 Oct 2025 15:19:04 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] blktrace: split out relaying a blktrace event
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
 <20250925150231.67342-4-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Split out the code relaying a blktrace event to user-space using relayfs.
> 
> This enables adding a second version supporting a new version of the
> protocol.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
