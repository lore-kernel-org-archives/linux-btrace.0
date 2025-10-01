Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7151547CC;
	Wed,  1 Oct 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300069; cv=none; b=kCF7ki4cg1hUDIpq94ckYJWpnzFGIpEbKhCU5xbrNgrJj6iATR7OaB5LJf6q1G/uWYOBqPV34f31DWSRnXFgIj8ZqQr0L96Gkq99x6gi8bBxid6XNwvfxHbREDKvRzMPttuZRNf6tI3DFizwCUrJUYcrSXEQnk/sIE/kSgbBDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300069; c=relaxed/simple;
	bh=8aZ/div0so9M8dRzkUeXF6GkwZRki2wXu0Nf15+OxTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF1/693Vit4/BLZoaNLZGpjZPPfzhr5uyOom09cljQ4QrMulR6XbABeNsd+vMtJGPmD2ixacAub+rvvraOCeiheeMZb0SwPBzEq1etKiVGA6lR4Y92YqQgaXJ5XlMGIRIWgZxlaeNm2XkClmzZm1NNxMUqCEHq5Svnb1u+Q/y38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUCWumRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUCWumRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E5DC4CEF4;
	Wed,  1 Oct 2025 06:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759300066;
	bh=8aZ/div0so9M8dRzkUeXF6GkwZRki2wXu0Nf15+OxTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DUCWumRqqcWHMqbAab5KksftXQvC/vh2NEcKaMWZKR8g0FK+L0QwRczbscgf7jRKZ
	 EKXP1FfIAx4/0ZuUmodRnF2wQHg/pbV9bIHm2PHelI8NGhItIhaQ5+ESwVwYuUVhgx
	 lpF03rUGGUR+ILkOTEx6jGneIRH4wvllnjOPbpB9bKcIRw4dEH+VxrxIMBY+kZEluU
	 uHNodtoIi1SioWhKLaH2j0LWFbdmuGu5gufKXJGZ+JWJZYqMgBSES4mq06trcnnV/5
	 chPDD6g2ceuHtQDTBpmyQPAzdpnxEbsS1zaWQcNDMX3qxI7h9tBmiTI1hyr5wxSRri
	 JMRd3gPI1jtKw==
Message-ID: <f06f85a6-60a0-445a-8728-f8f37a28b5b5@kernel.org>
Date: Wed, 1 Oct 2025 15:27:38 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] blktrace: add definitions for
 blk_user_trace_setup2
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
 <20250925150231.67342-8-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-8-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Add definitions for a version 2 of the blk_user_trace_setup ioctl. This
> new will enable a different struct layout of the binary data passed to

/s/This new/This new ioctl ?

> user-space when using a new version of the blktrace utility requesting the
> new struct layout.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
