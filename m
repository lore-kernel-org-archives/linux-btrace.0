Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBE27E040;
	Tue, 21 Oct 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079876; cv=none; b=MrCnmD/oAcsoB6I5EtVvce+HFRJqDFlE6Pw1+RKqxxOQ0f0433nXfjvPUhdIXlqVB9701bgkdgsQJb2e4vMJg4cghYen3m4U0lsV0Id3Whga00Lk7HXgIor5XIoxo2NI3sFVSlZhKaFSWstrx2vtpAU2OMDvgUwg4yMmPZL/mWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079876; c=relaxed/simple;
	bh=tcKgVYi+JkrBHTZfuTpoZTFhcnJv4sLOVDYhhdI7Mso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jj/H4ocC5ACctGzA4aEhMWDUPfcfYVSNZq9PGuT8aQ3UdRSE7OgdgCo+fRZkF2UU5tgfAIu863vrsJ/y456/Nhxaloh18Z53cH9GUTiEgIdjs5N5Wb63u6F7uEkNr34SxJzU6kKys73AJ/HahAcKyxmKcRq64ZF1QClwRaNx9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDXrMr3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDXrMr3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33E5C4CEF1;
	Tue, 21 Oct 2025 20:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761079874;
	bh=tcKgVYi+JkrBHTZfuTpoZTFhcnJv4sLOVDYhhdI7Mso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rDXrMr3S50AWMwya7X/+lk4qEknEZPerM0I0y9e9rxB+6uEuGEGlXWX0sSb0oa0RP
	 gB5EiwzVMJjf7YUNBOnE3ZkJZtf6uiESIllPNvPlERiYY/FyxIXsGSAUuk7bEplO5+
	 L9xAWEJewk/12gNrY4Ok+zKMYx7wGUARQaFKBsLAIGZSwbCnelwTv4TVRDVjXp/cXD
	 KaebvpsEnnwrvxrWGIR8c4UC24f1nB/zgmTaYauJVEUD/3cBhfdSPYbyo6A46zmRQg
	 O9RBW3LcGkg3XzD1qESXnmvBgdTt4LQdNz9WAhMFTkKW5UuWrBiNvPy6OyvAiFLZPI
	 fkdAlj0R0YBUg==
Message-ID: <d703eb46-55a1-4e0a-9658-b1fce9111d04@kernel.org>
Date: Wed, 22 Oct 2025 05:51:12 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/16] blktrace: add definitions for struct
 blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, axboe@kernel.dk
Cc: chaitanyak@nvidia.com, hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
 shinichiro.kawasaki@wdc.com
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
 <20251020134123.119058-10-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251020134123.119058-10-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 22:41, Johannes Thumshirn wrote:
> Add definitions for the extended version of the blktrace protocol using a
> wider action type to be able to record new actions in the kernel.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

One nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> +struct blk_io_trace2 {
> +	__u32 magic;		/* MAGIC << 8 | BLK_IO_TRACE2_VERSION */
> +	__u32 sequence;		/* event number */
> +	__u64 time;		/* in nanoseconds */
> +	__u64 sector;		/* disk offset */
> +	__u32 bytes;		/* transfer length */
> +	__u32 pid;		/* who did it */
> +	__u64 action;		/* what happened */
> +	__u32 device;		/* device number */
> +	__u32 cpu;		/* on what cpu did it happen */
> +	__u16 error;		/* completion error */
> +	__u16 pdu_len;		/* length of data after this trace */
> +	__u8 pad[12];
> +	/* cgroup id will be stored here if exists */

s/if exists/if it exists

-- 
Damien Le Moal
Western Digital Research
