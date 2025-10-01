Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4C1F1538;
	Wed,  1 Oct 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304118; cv=none; b=FeuUvuphj0QXE98+l6H6w1S513gqWMRwW8ybFuOWFSxQSAApw0UToKAv7/ezwKyQlCQCTh/mQTwSU6AjJbscFkQQPjuhQXGpK4bEyZngnBb7oxJ+m4tV/D7+ItoL5ug07aTbDoQZeUr/Y8A07OgRG2waOGgZGjy6qATF/ISNsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304118; c=relaxed/simple;
	bh=K6Gczwx64pt8ByrFLS4NnTNZBEmkXcjHfCgLboOGRsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsRtjalf/VUiNjSivC+f084EKrl8tLwAl1mjm6QRDVf5j8Ee2hzAthQjfx2sQGC3pciUZQIKZiAr7rmii3pPwwHrHZR3IBCH4YS21OHp/3mndGSaS7XdCOXoHZUtQFRyTrlX256Yh5aCDo7Y6Q6ribp4dW8yZ4xtPYkqqINE/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQLJ8os6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQLJ8os6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8B2C4CEF4;
	Wed,  1 Oct 2025 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759304117;
	bh=K6Gczwx64pt8ByrFLS4NnTNZBEmkXcjHfCgLboOGRsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KQLJ8os6CnrR+Wp1r//hSBdzwsoSOHXtRfcuqr90JoFQceZRNHzDYJwjjOQYahWfx
	 gNzdPudhgv2yDl52GAgDof5I6B8+pjHNwpHpYP3PRUWGRpmmG3r6QWnX0W+L+7hC2H
	 usu71Tfb6kZ9wSd7df0fZyqKQu5b271dS9tfjjmoC7xwAGnw8BSwqBu+1/Jdwdg2jn
	 bE1HubKxzm9YiTwftFuKquvNZCLvpo8llEmEkBXEBAd5NpNdqtTj4sfgQ2NX0pXeU9
	 1VbnHIoLrLOOkKTlx+XidW0yW2zSiWeE4TDaRIRhI7oYMmOO2Jo8y69NvBfZFZ6gYn
	 AGXnpSn1xmGPg==
Message-ID: <394d53e6-c8d3-46c1-b4f4-25bf82541e7a@kernel.org>
Date: Wed, 1 Oct 2025 16:35:07 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] blktrace: handle BLKTRACESETUP2 ioctl
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
 <20250925150231.67342-16-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-16-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Handle the BLKTRACESETUP2 ioctl, requesting an extended version of the
> blktrace protocol from user-space.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
