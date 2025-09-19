Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE95314D26;
	Fri, 19 Sep 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294533; cv=none; b=f0nL32Z2Th/tcL5Bgw4ZneO9if6G1CE+tBboGvHCqwjGTWpu4Q6b2VAZv7hWwivSzWYR9PM3Sv3e6xkVIDaFAS06vmcR6GpdncCeqQRJ/r54fhDjSg+AjoJ9mZCXEQQXM4e5YH5ZHVmkmyaIYQveIPqoUc6nSeqkRK3BhvEaH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294533; c=relaxed/simple;
	bh=Ug2PNAo/yumD+ip27HCSYo6WYAu9naVzftUlcrjn+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV/CdG1k4YNIIyD3C7o11raoIMyTVLtUOm3dqC4BqwsLpg2rV0MPDe+Xp7t8p7rZtKK1J73XT+L6cUdA6k8dGM08dcXyLir39zYbplCH33Mjfk57MepA8X3xrywPamlplFzfMDDlx4vvmAIVrQ/ZwyXew6cf6xSM6klWZgUpl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52ED968AA6; Fri, 19 Sep 2025 17:08:47 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:08:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 04/16] blktrace: add definitions for struct
 blk_io_trace2
Message-ID: <20250919150847.GD28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-5-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-5-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 01:05:59PM +0200, Johannes Thumshirn wrote:
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
> +	/* cgroup id will be stored here if exists */
> +};

This structure is not u64-aligned, which means it will have different
sizes for x86-32 vs all other architectures, making it a pain to handle.

Also maybe add some extra padding so that we can extend this?

