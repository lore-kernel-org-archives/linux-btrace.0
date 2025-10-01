Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0C1E9905;
	Wed,  1 Oct 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303816; cv=none; b=mrh4z/XCxWLZzIXpd6J6d8cUNsxDZCl7fMrdmB9zGy+4w3BH5k7Z71oQMU5uZB+9SMKY/0XZ4MzFkUh5xkp9oyvjC6tEOr6Wecj79nUhoagBrWxJbLvisjHNNNsbSDD7MPZfw9AC5extY3h69V6cU5VM1aM5Pla3PZVkCHVvRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303816; c=relaxed/simple;
	bh=G1+r1MUyJ8CtJMeY8XfSQ2Cj1+4kVMQcCRRjJg+V11Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGnzYIwZZWRzvEGkZPJgUHJI9NpAgOwKA0ydeaxV36R+mLEyfImlPNbt88iX/H9oVw6G6LS9dxaFf44dzzQ+hTWZ0YnN0traMkFIB1anFNzLwU7/EoVlW/tQQCtCOk3rbFoyF/p6UbYVhZnB0IFuq5GVgW9gqesEBQquWK4ExkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiB3o7Rg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiB3o7Rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A72C4CEF4;
	Wed,  1 Oct 2025 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759303815;
	bh=G1+r1MUyJ8CtJMeY8XfSQ2Cj1+4kVMQcCRRjJg+V11Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PiB3o7Rgn+q7IRNN0Qfpgmwq9UPMbIQem6DdjHxqBiEhxQVuXZjUab5DAMKzPYP0i
	 I166NsbaAHhxeYw4JHfx8vd5ALs9KB5Qlw8AZJiutd6ZkKS86OdWX1MgToxby+uEAD
	 QEo3QtqulL8noP2QMWtueQ8eyfZJMir1TJVGukciOPIWHBEDNh1WWTfNDm6Lo43ASJ
	 wMsUo5/6Cc3r0HViW+7Krd19Lva+b4WhzuhATxPmbelm43hSlaLt1/kFg1SQyAIdzy
	 Znuxu/mgdQw6J0S9tbwPouszNQWSTdBHSL0Omyos/yfanae//2fuPRb1HeFOnWsgA0
	 sbr46hKCEk+ZQ==
Message-ID: <f5a5bc62-093b-4d4a-91ba-a7ec5718609f@kernel.org>
Date: Wed, 1 Oct 2025 16:30:07 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] blktrace: trace zone management operations
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
 <20250925150231.67342-14-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-14-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Trace zone management operations on block devices.
> 
> As tracing of zoned block commands needs the upper 32bit of the widened
> 64bit action, only add traces to blktrace if user-space has requested
> version 2 of the blktrace protocol.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: Are the zone management command completion traced ? I do not see a patch
for that...


-- 
Damien Le Moal
Western Digital Research
