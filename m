Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7351239E67;
	Fri,  3 Oct 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476554; cv=none; b=t3SIisr3KktL22f0bJJny63dTFj3C2Z9HZTtTWI6TL9ZM/W6ZEoPHE5WMRYe/zgtdB5VCYts3txLBClVwPiuvLtygBlGFx8U6x+CPREHpdcR5l5b5x5HWGSvWjgVPu1gxVLOcrl042Lcpx113Ka0lZgj0RCIZrIZzf9K30KdtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476554; c=relaxed/simple;
	bh=bl1jRVoGSDpZtB8COcjqPGx5tLsBwXYpBWri+Bzff8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtKxfiWJqJIvgcr4OnHDvqI8EW1miUpbuwdpR8HyW0Mx+1n9MWBToGSH2e//EdB5e8+XktMxxZzXoxwDBObwhxXeMLLJ+iIBAgnaxywhH3OgmGjifd/5OoIZClkwU82tsuKiTf4DQjHTlz+RxNnta/PFE18GS1e3A2O/b3/xi/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CB09227AB1; Fri,  3 Oct 2025 09:29:09 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:29:09 +0200
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
Subject: Re: [PATCH v2 07/15] blktrace: add definitions for
 blk_user_trace_setup2
Message-ID: <20251003072909.GC12624@lst.de>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com> <20250925150231.67342-8-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925150231.67342-8-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 25, 2025 at 05:02:23PM +0200, Johannes Thumshirn wrote:
> +struct blk_user_trace_setup2 {
> +	char name[32];		/* output */

Is 32 still a good size limit?  Or would this be a time to
allow for more?

Otherwise this looks fine.
