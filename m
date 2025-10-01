Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F326CE02;
	Wed,  1 Oct 2025 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299303; cv=none; b=dBuGfy9/lPAJmK3iqQ1PDiB6RxNcYXrEjYFtERF94Gbg398RMoHNu9T2u3lVeA5k/KptR04ZOE0iqWI5C3e1Lw268a0CDd1PdHxKqAiH55qWp0s/FrvV09o1/XppV9YQPBdStc4/xq+2cld0gFtxzAJs7VX+akDQKJM6WB9Opbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299303; c=relaxed/simple;
	bh=9ZDMSC873QT0CDff1i24+4PxdMyp/7cnQB9lFOm+bFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ9VT5IYbTpkloOncni7nbGunTcrgzB4AUOOc1QEbfIYpTN+gn0wv8n1bxKvnbFPf/MiidQqDJuv5iQNN5G9olNWVGQ4FGD//hIRZTQPoyyE8EeUlcNfHG8vgtG6GL5TPdh1503Yk+8TOj6xqOSv0ZwcpfdT83Bke71cTOg+ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoMhpyYG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoMhpyYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36D3C4CEF4;
	Wed,  1 Oct 2025 06:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759299301;
	bh=9ZDMSC873QT0CDff1i24+4PxdMyp/7cnQB9lFOm+bFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EoMhpyYGTUwG36BRukIRXYdDTD59O0fOa2JhjuEhGGmxBmdxj1+FNPVFhfzxfbWNH
	 Bt8koKkMqHcXSkOQSfoKxPyGwHrBH/2zgpXVQ1j270WBwNxAn3PR/Ahuzc4O8SXodV
	 brCX/G+oFyfrJNHKTffIckESuNIw9orBSaDX/I7MzOdn9IcM71KqVsDRh8CnP/gIYm
	 dH2hUsHEbyIKSczTdWfSSZ9AXaM60++kkaUlTw/sex0pt8yKmtrEuNZxyl2mnD8aeC
	 5t8XLRgVLBImevNqzMQq6gZyT9iEVfTfOCjRYuNAvkfLKdq0thjRRE+72UCf9oWtSK
	 CMf5+NBfViIbQ==
Message-ID: <e7f1e975-fe23-4ea1-9e59-c085d6dfd297@kernel.org>
Date: Wed, 1 Oct 2025 15:14:51 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] blktrace: factor out recording a blktrace event
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
 <20250925150231.67342-3-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Factor out the recording of a blktrace event into its own function,
> deduplicating the code.
> 
> This also enables recording different versions of the blktrace protocol
> later on.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
