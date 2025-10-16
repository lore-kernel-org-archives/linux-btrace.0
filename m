Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD02FC88E;
	Thu, 16 Oct 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598580; cv=none; b=Qrmco0SboRcA5erH58ErbatbrAqvO44qt9SYqGMmeaLK/gTybBiCcmvWauhRixsHL2s2DRbrh8vPSVsallWSp0/8ZSkFiWJwQHKxB+sG8moe2xFiAhp/rMq+yfmFuqY2Y6yjFSDIgsZPk2/wsdYvC5yb3nKcm7OnsORa/1pTuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598580; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMQUw6uaIlJBT7C3Q9xa9cwLOoSdTmdIED1D6/NEu3Kh+mjenioZ7GSxjrxwd2NIvDTel//gC0BOQUonNiilGhiLxs+Cnf8zV4fCl+dyWyFwjJ+up4qaKvV1wRYP5RxGzLOD+ZpAcExJwiKwZAG79zAVgGFKJGcMlLNy7Q31O0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49E35227A88; Thu, 16 Oct 2025 09:09:35 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:09:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 15/16] blktrace: trace zone write plugging operations
Message-ID: <20251016070934.GG1417@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-16-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-16-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

