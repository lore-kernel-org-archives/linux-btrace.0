Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984623CE;
	Fri,  3 Oct 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476784; cv=none; b=XhS1ZcFvvH9AkIilF2URlmiaenVLpAp+0kIT3i4w/KZo4w1c8JN+klG2fD7TvZriq5mYNDtWZoVoFhzemlR0Tiahp8YDH5+a/mgZRF2rOFaOwYbOncl49sGmXYfqtc21D/JKjpd1IekwS97UxGn1kqcHnI1441TjBH+sXyi8tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476784; c=relaxed/simple;
	bh=MJvD+K3ZXIUT//34aWAh28eSQpuVBCKAdoGGE8pze9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lummWGSsRKlhcSAYz9zC6bjGP+aV/MQtHxV0j+zbBOChMS0IB86e2UOYNWI5KI4M/Fwg/sbMZ9H7v0zHmyyMCF2m+abuBGn6u0+VlZmm6KuX39M2fp6FZXwvV6OCGAs1QITM5vrOOz3+abByWoUlnmSAYWoG3tUqoiAAEsUDFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B7BE227AB2; Fri,  3 Oct 2025 09:32:57 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:32:57 +0200
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
Subject: Re: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
Message-ID: <20251003073257.GE12624@lst.de>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com> <20250925150231.67342-12-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925150231.67342-12-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 25, 2025 at 05:02:27PM +0200, Johannes Thumshirn wrote:
> Add block trace commands for zone operations. These are added as a
> separate set of 'block trace commands' shifted by 32bit so that they do
> not interfere with the old 16bit wide trace command field in 'struct
> blk_io_trace' action.

Can you explain how the commands are handled for old/new here?

Because I'd still much prefer to sort things out so that they make
sense for the new code if possible.  i.e. have a 32-bit command
and 32 bit flags, and use sensible encoding for the new one, and
remap the supported once to the old organically grown one.

