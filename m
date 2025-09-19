Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96542238C36;
	Fri, 19 Sep 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294592; cv=none; b=uUAR3ui/Q0pdR+SXCiqi3gRANWZXfLtH/GP/8bVB0VcZUgPAmFdQ/fmTt9vQwCm09r4Dk8N51vxBPO4aLtqgLMDCqhKbGco2jm2QCf39hZCz8X3s7nJAfl3A8dqaTQKtskyXZ5ZpnjqNXyPFtgW/hxiEmCpS3demqaBvGaCdR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294592; c=relaxed/simple;
	bh=m5IfUtaogyQsMJ43kRbGQh6hRBwQNnAJfF6rNyG8HfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV5ZNLeOJYgOCuBGdqHxfBy/wWfRXKlUZgRMdZFIwixRY9xPVgSPL7VJpQLXvIQmTvxobKq+hqeRfVbMQxMgBgRrCmtElaAawFxBqI5JemaruXwPD58VfSQHDh99NcFm5KXWElmrHFJtQqt/2wRYaQYtQ/u4rL4Kba2o1IiAob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA63568AFE; Fri, 19 Sep 2025 17:09:46 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:09:46 +0200
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
Subject: Re: [PATCH 06/16] blktrace: only calculate trace length once
Message-ID: <20250919150946.GF28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-7-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-7-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 01:06:01PM +0200, Johannes Thumshirn wrote:
> De-duplicate the calculation of the trace length instead of doing the
> calculation twice, once for calling trace_buffer_lock_reserve() and once
> for calling relay_reserve().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

would be nice if these cleanups were at the beginning of the series
before adding new data structures, though.

