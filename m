Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F31234964;
	Wed,  1 Oct 2025 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299168; cv=none; b=LB9ZXQYNux2HeJ7IJEm9ubBJ7ekCSLlPqz4nnIGX8D+n8+5Z8GyCEGEAjdQKXn9WCiq0yew7eS8IugqjvGBaYVJSSHTZAvadCybKo6uQe51CpbxV5n+a0cs8jKABlOvtPgjuEZuM0KYMQJ4SEIQfsgCQVuwg7vm+II9VNA7kPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299168; c=relaxed/simple;
	bh=0NkqnWA2gnuNS3Z+dXQyRJktMjrjg9exYNHx9RAs/Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BT2qbtw4TtS8LKXo0Of70KwDOUL7krAzXn5wZ7Q00f7y2VnWbkVBske5sxEXaRaAKAueILfV4eQQ1rae6eh9RCA3uRQjAWw91YcrolRMcX5sR3JvFUbSN4CcY2Ru+p9c8EAC+P+6g80vAxHiA7Cn6+163TbjTF5RVPcwNQ+wf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDPekD+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDPekD+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19DC4CEF4;
	Wed,  1 Oct 2025 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759299168;
	bh=0NkqnWA2gnuNS3Z+dXQyRJktMjrjg9exYNHx9RAs/Ns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jDPekD+oSIHYglKUV40Sas9Nc38YGV4JdDq6xfoV+48J32tCwPRUGPC0gb0GIY8im
	 ABCb4lrAU7XN8lpCi5SgWngFgzXTmwzKkn7Kh+ierZSNrnss+6jbgBVKEX6Kay7UGU
	 OySb0XiWuRY/s/eVxjSvBcsI4nuhtp2ERAtfX6tQv1lKd7aB+j/FGqV+b9VhTbo5Mt
	 BtzlITQGRADc5Axwoz7CYSdZmQEtkBEqtypu4lYkPraQA+gyNY8h36pCIcYE8qy4mV
	 bS5IFEPdY2D0Ej7oLTZuB2YLYzQVCsy244angK3amueoETWzLKM51DXtXKiSg+DUaW
	 s+DalWq88p2qw==
Message-ID: <6a485ace-be08-4d52-bdf5-7f5be2f58418@kernel.org>
Date: Wed, 1 Oct 2025 15:12:40 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] blktrace: only calculate trace length once
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
 <20250925150231.67342-2-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> De-duplicate the calculation of the trace length instead of doing the
> calculation twice, once for calling trace_buffer_lock_reserve() and once
> for calling relay_reserve().
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
