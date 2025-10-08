Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E51E25F9;
	Wed,  8 Oct 2025 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759963292; cv=none; b=lUBFDb8VoqwZlLeIFbZdj4HAm1Dv90qButtbIss6GUW6PWZsr6o0wjILTcxdPDppUP/Hw35aRbRLqOyN/8KcpGGzsz5+eBuie8P+1dwF1HCOmgABSOZNbnc7I2wE6OM9P5VSj0JibEuqe6BdncExCwIFONqwjlt6q6gOwjsCDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759963292; c=relaxed/simple;
	bh=BmE5hJ8rbuCDGFjo8CBQ1PvsWoi7WyWjZG/68v+d69M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNP5qc4+vJawxTqelxySOHW4BwNhuWW7VKFzWMbLJmATIrHMJpJUITQjcGeKNvgeFQQsHpltWem1K7Hii7q8WDsiggLxKDexwQZ1K7pn4VKCS76gV3MQrRSNxk4tGEEE0HYkjAMT6gYUeWCLK0k1hH47QgO2EJ9b3Qan63qhwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf3+5pqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf3+5pqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407ACC4CEE7;
	Wed,  8 Oct 2025 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759963291;
	bh=BmE5hJ8rbuCDGFjo8CBQ1PvsWoi7WyWjZG/68v+d69M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xf3+5pqOvOpZP8s+tB3IRecNIw27RavRuHuU+RdeEQaju8YVWm8lHYhQLtU3Z4L6i
	 z7vl5lXvSEvnUTRgDegnaJrduiieZBYOlXuwn3xP/STiYJIHstJBhrXEWQsDuaSRNM
	 x5KvkO1dDXZHLRwIJ0rViUti64MS4zaMs2k2WJZ9ULIqTOz1iVv15A28mC58/XOREK
	 e1UWCQ3McNK9mYwPVjFnKWV9h8MCKik3JKlNAtUqLtpNlYBgGOrFRmIEwVmoSlf4Pv
	 aUKmAizrHh/gc62IAIr/ZZJYKvl8ZVOgcLAUuKcUIRYirgg+3J1bECWH4PaITN6VBb
	 7UOJAHyNHkmYw==
Message-ID: <45f8532e-5aa2-4b32-ae53-bdf588133a3e@kernel.org>
Date: Thu, 9 Oct 2025 07:41:22 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] blktrace: trace zone management operations
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-14-johannes.thumshirn@wdc.com>
 <f5a5bc62-093b-4d4a-91ba-a7ec5718609f@kernel.org>
 <057c7e5f-6079-4451-829d-40c73c88fb60@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <057c7e5f-6079-4451-829d-40c73c88fb60@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/25 22:29, Johannes Thumshirn wrote:
> I'm not sure if it makes sense to do completion tracing here. At least 
> we cannot do it in the endio handler as usual.
> 
> One thing to get the error and the duration would be the following:
> 
> int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>                       sector_t sector, sector_t nr_sectors)
> {
> 
>          /* [...] */
> 
>          trace_blkdev_zone_mgmt(bio, nr_sectors);
>          ret = submit_bio_wait(bio);
> 
> +     trace_blkdev_zone_mgmt_completion(bio, nr_sectors, bio->bi_error);
>          bio_put(bio);

That does seem OK to me. Maybe try and see how it looks ?
Though the request alloc, insert, dispatch and completion for this BIO will
still be traced, right ? If these events show correctly that this is a zone
management command (and which one it is), then we should not need the above.


-- 
Damien Le Moal
Western Digital Research
