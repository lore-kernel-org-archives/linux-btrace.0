Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B349253B64;
	Fri, 19 Sep 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294790; cv=none; b=dOM8bmQgPld2icUMpLyI5VrNc6W3sxPlOREhtjHOztJ4Ty2NaSMznD+wxtJTJmeQTsiQEU7TyLGrNK7pJEs/itZo8WcgMDGxn4Bfjvq0RlpzzulwZuvIEKlDBc96itsnOc1gmdUlMCBAJpDH1naPwjaInd8lRR7CwI1Iy4Hh3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294790; c=relaxed/simple;
	bh=+W++xGFW/XkT7OUev2dqbvY4PZc3qACNWpXDuV8FA9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4oc35p/QgMMVeqtfyS602o+SQKZM8x4hbZexUgbrSc/RcB4+6YpK2xfYv6VAAwJcitjwkVttSj7HoJe7joSjGWWBhnA10mzhCHfx4Mu7+tRovdy+yqAsLCASW47DaFo9Udx3vUrWR3H2I0O+FiJE+NXHABdY6f4+Vgb8QQfakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DCF5D68AA6; Fri, 19 Sep 2025 17:13:05 +0200 (CEST)
Date: Fri, 19 Sep 2025 17:13:05 +0200
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
Subject: Re: [PATCH 12/16] blktrace: add block trace commands for zone
 operations
Message-ID: <20250919151305.GL28352@lst.de>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com> <20250909110611.75559-13-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909110611.75559-13-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 01:06:07PM +0200, Johannes Thumshirn wrote:
> Add block trace commands for zone operations. These are added as a
> separate set of 'block trace commands' shifted by 32bit so that they do
> not interfere with the old 16bit wide trace command field in 'struct
> blk_io_trace' action.

This is very confusing.  Why not havve a single enum with the actual
values with a clearly marked cutoff for v1?

