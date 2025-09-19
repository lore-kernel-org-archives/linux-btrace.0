Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723661C862E;
	Fri, 19 Sep 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294380; cv=none; b=TgkxLl0f4pBfEvq/KTi+pB2NwT0wE0YFxXIxLNTvAVTDaV/XjNmfNwlyIkLCoCDphiFqmFuEa2Byazt0egZr84pkDnGzoj3ZtTr2SCNAbjlacbVh204K+8NeLrgiOw/GIP3HxfEJHrbNFHSF62EQchT+CoRMSxnBSHtvjd4pFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294380; c=relaxed/simple;
	bh=lFkMcErzDuaSt+XCth850wHsBdhid4N4T9XXbi6rOR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPynBShgutKSFZTU+Wq5tX8kdaWAsQYflqpfmMZ0bdBqJW2GJ3E+J889zt1Kr2ghA4A5cqWxlYquO9jToB9FCH3Ecx8tUjuzrP1lyGgTyN3il/VT+pvc4fObQ9iryJ8VmKLMlEFCeYRqU0lVXLBPXVaHVr+yj5AppMCgZYx9iRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC03368AFE; Fri, 19 Sep 2025 17:06:12 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:06:12 +0200
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
Subject: Re: [PATCH 01/16] blktrace: split do_blk_trace_setup into two
 functions
Message-ID: <20250919150612.GA28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 01:05:56PM +0200, Johannes Thumshirn wrote:
> Split do_blk_trace_setup into two functions, this is done to prepare for
> an incoming new BLKTRACESETUP2 ioctl(2) which can receive extended
> parameters form user-space.

This not just splits the function, but also moves some of the logic
to the caller.  Which looks fine, but should be documented here or
even better split out into a separate patch.
