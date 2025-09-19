Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889726056E;
	Fri, 19 Sep 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294613; cv=none; b=K3PmyjtNlsAt7vhwG1++8LAqhbMXGIYyNqo7rruqTRBfVVrjj5COZclSAZzKTh2Zn/im6jY2hJPASzCaWdUXgeIc9ZRnBoXnyuINGYM4cif719sSwY5y5BnII5YZ0TMIf+3/7i2ZJA+LzgqNZbPkcOmgKui5RfxSOW1hA9HfYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294613; c=relaxed/simple;
	bh=XXTPOvIUIuPAj+/e9/XGGSEtPNwzjqc9jiBMg/QJ69Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0eePJImm4iKbu5IM45WB8cWBQCta82SrBip1HlB/G+sq8VIlWhVwy+RGtnwV8/vgHqDkf49pF3v3RXMuyNKv6AvV8yWlPt8VYdWdnUF8+VVEbkTmg6KGBXupt7mVudNrKZU4c7eLlcffPsU+Vj0NOiXNcxjNATS1OGkCTlEbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BDFC68AFE; Fri, 19 Sep 2025 17:10:08 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:10:08 +0200
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
Subject: Re: [PATCH 07/16] blktrace: split out relaying a blktrace event
Message-ID: <20250919151008.GG28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-8-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-8-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 01:06:02PM +0200, Johannes Thumshirn wrote:
> Split out the code relaying a blktrace event to user-space using relayfs.
> 
> This enables adding a second version supporting a new version of the
> protocol.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

