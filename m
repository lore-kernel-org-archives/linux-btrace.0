Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C3274650;
	Fri, 10 Oct 2025 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081579; cv=none; b=TOBg/H1hnmo8t4UvSkiyjFYOJVax2ADAlfcyJLvrcb8AfleZh5G6gdbgBNrB9zI0ClyER1JTYcb3GfNuppO/+aLZDJOqUNl1seTuPKRsgadX1aVRb1/hRJcn4m8zi6hVAGtgPBKRD/AzI27V08tCqzQElzHSqdUI3CHF+dAhgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081579; c=relaxed/simple;
	bh=nofhwUUz64GodE7x24JZ6dCxrChQBdDGUxwWpDaEuMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UakwaJi/istg0Yn++60bnIKczddPlbxbG463WmaZ0ZIl9g7R5JUuNnQI8ybw2iX+61IQwNyQ+puWkyFIC04J4WmCOiA7xcm6CNTRVbT2rkz/oHBhKhtfUmwuWPEsskaR3pXk9zizDHkZwIOBwSw3dkdpLX3kZCi3weaz9KBIDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2D4F227AAA; Fri, 10 Oct 2025 09:32:52 +0200 (CEST)
Date: Fri, 10 Oct 2025 09:32:52 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
Message-ID: <20251010073252.GA17940@lst.de>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com> <20250925150231.67342-12-johannes.thumshirn@wdc.com> <20251003073257.GE12624@lst.de> <4638c185-ac5c-41e3-8c79-5c995228ec0e@wdc.com> <20251008061403.GA13979@lst.de> <99edea66-957c-4804-97e3-c88b615e54f0@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99edea66-957c-4804-97e3-c88b615e54f0@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 09, 2025 at 11:17:21AM +0000, Johannes Thumshirn wrote:
> On 10/8/25 8:14 AM, hch wrote:
> > On Tue, Oct 07, 2025 at 01:08:00PM +0000, Johannes Thumshirn wrote:
> >> Sure for the old commands everything is still in the lower 32bits, this
> >> has the nice property that we don't need to duplicate all the code for
> >> v1 and v2.
> > I don't think you need to duplicate anything, just have a little
> > function that maps from the free-form v2 commands and flags to the
> > v1 field.  Preferably including a mapping of all unsupported ones to
> > a catchall unsupported command and flag each to indicate that the
> > trace includes something only visible with v2.
> 
> So I've tried making a translation function (which is the trivial part) 
> but then it's a game of whack-a-mole to unbreak compilation, ftrace, etc..

What's the problem?

> I think it's not really worth the effort.

Why?  We really want a clean slate going forward.  Creating a permanent
split into legacy vs new commands seems very unfortunate.

