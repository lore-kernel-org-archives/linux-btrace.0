Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217232F6572;
	Thu, 16 Oct 2025 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598437; cv=none; b=WlPbgqqH4eQydA3HUv7NtYxHlwUiaYHuT1a+G+uzYLWbSYFqCSsr9nnmetpoMofA3zYbm+syaytgP7La07lgfh/0YXQFnw4I3q3TS0WkOd2Q2bh01Wxs2U0xvkj6YV0YpXO3R6f3e3RVCReorAdqySp1StsDid82Cj/EljM47hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598437; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpkbZqZTo4onQT2OOsEZ45rfJescxJHaWL7zohmDgAz4odqFkfGtqjqC+C2F6aV2FYktVKUYFPuWaANelsCMDNYb+riYyaVMHXkO36UqYaZFriTjX5ESb3jLqh/ebZwUKWoewePVompx1nBZ/Y+QgvPnnJ6+yJDOastnuHfwPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73DF2227A87; Thu, 16 Oct 2025 09:07:12 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:07:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 12/16] blktrace: move ftrace blk_io_tracer to
 blk_io_trace2
Message-ID: <20251016070712.GD1417@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-13-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-13-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

