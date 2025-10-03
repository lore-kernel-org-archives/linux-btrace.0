Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636823D7E4;
	Fri,  3 Oct 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476871; cv=none; b=MEvM/ABfsW3XUrRgwmuL0MTi3DyFPC77/ZXsIrgtf0pd7NFaaJ2lHQOqgRBHbsxnvscgtodEkMWvcvmqGEabWa4/MUY4A97+GNQfymfRJVk8JFtP+gvKvfPkYYgB5jUoJyYr8nAIRH71Slb1LX0ZxoYbaTGlLAFDC/aC14Ql11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476871; c=relaxed/simple;
	bh=wiRbWWPoccuzvAkr6r3pQqRCKqdskqnouKGdtWYbgbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoRb9ouLz2oqIm3mDzWMQm6VzuRf9j1S5CGzLzo0CRI+Rk7D46aSzgEe/f1iO5mwxkPexozS/O4WQXo5/oRuiI60xxmEjk3boa1HnfiFzG/pUk++0QULUEzVJubNEKhcUGHvymdbbR53UJbCxWqiHuYIWk3+b9Zgyg4N2VSNaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 599FD227AAC; Fri,  3 Oct 2025 09:27:52 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:27:52 +0200
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
Subject: Re: [PATCH v2 06/15] blktrace: split do_blk_trace_setup into two
 functions
Message-ID: <20251003072752.GB12624@lst.de>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com> <20250925150231.67342-7-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925150231.67342-7-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 25, 2025 at 05:02:22PM +0200, Johannes Thumshirn wrote:
> Split do_blk_trace_setup into two functions, this is done to prepare for
> an incoming new BLKTRACESETUP2 ioctl(2) which can receive extended
> parameters form user-space.
> 
> Also move the size verification logic to the callers.

Can you add a why for that move?

Otherwise this looks sane.

