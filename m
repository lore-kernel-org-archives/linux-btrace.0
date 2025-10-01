Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87B274641;
	Wed,  1 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304602; cv=none; b=q43Y8vfbJ9cE94Bh/OJZO2qi7GJrg/1BybxSxrH6XH+4VkMLfwms0BWpsYhnahxvctN1V68PvLIaq2YxXleeyY3YHDvVgGCu2I4KITywVxSbs9kTtFlNC8j98v3B2sSfT0Y5qZYVln95xR1C64PZTIsKLEW/m4oGF1oZuSH9FxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304602; c=relaxed/simple;
	bh=cfZ7p+/7eGMo3PeLFhhrLfU/Op7FeF3y5mHLShzI7YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsva487+ZZ7i8U1EpBnlZbDHsIoFIJH+mCmZe/ohp6jUwVS3wKh9S/knvBQh5oJnJnZfjB/r+eG+Jr12dDIaRvvKy8GDaqwwkRCarOcJZewI4KVWeXGrmP6Mjn8akLQohPXdbLT+X64VrW3FotYjM86pxHfklTwgRr+ZzHVEgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKqRPDt4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKqRPDt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839BFC4CEF4;
	Wed,  1 Oct 2025 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759304601;
	bh=cfZ7p+/7eGMo3PeLFhhrLfU/Op7FeF3y5mHLShzI7YA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lKqRPDt4XYVblxd7JBoQqHkc8JJbketQswX43yH8SKngcctJ1c9KmtnmPibx3sOrl
	 V1SG1tr6pWiPCvZTL+QrQQOwyZko0OARespj0TOfZlYheRHP/xBOZxc7K9E+LY4AK2
	 N3pOukUxLfcEzztnuyw4XrBwUE+jxDsO9Aue8ieji8cS8tMdcLVkerZJmsDZf3iyJj
	 Q3UH5SHgo31ixjFSSMQRuoasmyLFOyo5nv4/7Kf9amxOT0BgMAGjwWhkJADga/n1x4
	 itoOMZUAjHWhT3atTL5pAK7jO++s6dc8kxrMZIbxtgGcPeM+UhAZQHaoyBISXF3tkc
	 Xr462EfS6eGAg==
Message-ID: <6eb2eab1-7a9c-4c07-a9b1-be6557247a4c@kernel.org>
Date: Wed, 1 Oct 2025 16:43:11 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktrace v2 02/22] blkparse: fix compiler warning
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
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
 <20250925150427.67394-3-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150427.67394-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/26/25 00:04, Johannes Thumshirn wrote:
> GCC (15.2.1) warns on about the following string truncation in blkparse.c
> 
> gcc -o blkparse.o -c -Wall -O2 -g -W -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 blkparse.c
> blkparse.c: In function ‘main’:
> blkparse.c:2103:68: warning: ‘):’ directive output may be truncated writing 2 bytes into a region of size between 1 and 41 [-Wformat-truncation=]
>  2103 |                         snprintf(line, sizeof(line) - 1, "CPU%d (%s):",
>       |                                                                    ^~
> In function ‘show_device_and_cpu_stats’,
>     inlined from ‘show_stats’ at blkparse.c:3064:3,
>     inlined from ‘main’ at blkparse.c:3386:3:
> blkparse.c:2103:25: note: ‘snprintf’ output between 9 and 49 bytes into a destination of size 47
>  2103 |                         snprintf(line, sizeof(line) - 1, "CPU%d (%s):",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2104 |                                  j, get_dev_name(pdi, name, sizeof(name)));
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> gcc -Wall -O2 -g -W -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -o blkparse blkparse.o blkparse_fmt.o rbtree.o act_mask.o
> 
> Add two more bytes to the string in order to mitigate the compiler warning.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
