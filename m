Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71B2D481F;
	Thu, 16 Oct 2025 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598369; cv=none; b=oYDTAxCsNO3lJXwOJDs2/xc5jKsfmJ8iWvqlAm44tbdhSg1GGLFcvADVadSLGTl/oMAeeJsAB59vFBoQrBFQv0PiAitS6EEam0BZ4EeUoAP+ZEx/O3fM7srn5v4uvZrIl8BzVG/u15i0D4i1+P9sdQIDJdVeF8YiCTy4PSwD+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598369; c=relaxed/simple;
	bh=LreS2SkYvYCKQ/TfWQ6EXAWNOaYHc/xF5fK9w3V30Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHA33xzFtVq9F4pboP3j8Z0cCgMj99Q5GE8zSCXjOHTjSiX1reY8whduYCDttuQQPRg4r5r656JzVh5vlrUEaN+YX9iouX/957p5p/XHbGY1Al7GHVZR8tNQ7U9mkmWo1DQE/t3hvjTHBSehpGUHnCEiR4kdNBJTefWARAq+yEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F45D227A87; Thu, 16 Oct 2025 09:06:03 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:06:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 09/16] blktrace: add definitions for struct
 blk_io_trace2
Message-ID: <20251016070603.GB1417@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-10-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-10-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 15, 2025 at 12:54:28PM +0200, Johannes Thumshirn wrote:
> Add definitions for the extended version of the blktrace protocol using a
> wider action type to be able to record new actions in the kernel.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

