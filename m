Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E629D292;
	Wed,  8 Oct 2025 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904057; cv=none; b=BqxSn11QM7pn8ZK+8gVtiGGZFpWqIUHJDo+Yf/ajMKT+G7oTXOdlWk/7gkpnjq7/dbtimAXcd3tSNH9RVRge87oCLWSpc8c2OGpJIJydZvv5nDcpMn4tgHgD6IuKx6WfFnySI4yBaCTf7Dp6b5RxKPsRj1C+f/ZmUZYvYRoLRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904057; c=relaxed/simple;
	bh=WswQbeUWBAMV25CA4i+SPcySveFy4PoQ1NaxzzlS4Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2jbHiwmJQRpW0Xj1Y/a9Nfv26ojY42J5fJi79r8Fj7veLkhDLhRGY+DfGb+MNavL2taX12qASvnMpeWNjzea6bndaEwYNNZrXrsFe/i8R6N8u7TN3UnC5xSC5i9yBhpfOSDdol4ZxH029WfeofLMZ36LZPOHf9+dUtXGNtzyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35396227AAE; Wed,  8 Oct 2025 08:14:04 +0200 (CEST)
Date: Wed, 8 Oct 2025 08:14:04 +0200
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
Message-ID: <20251008061403.GA13979@lst.de>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com> <20250925150231.67342-12-johannes.thumshirn@wdc.com> <20251003073257.GE12624@lst.de> <4638c185-ac5c-41e3-8c79-5c995228ec0e@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4638c185-ac5c-41e3-8c79-5c995228ec0e@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 07, 2025 at 01:08:00PM +0000, Johannes Thumshirn wrote:
> Sure for the old commands everything is still in the lower 32bits, this 
> has the nice property that we don't need to duplicate all the code for 
> v1 and v2.

I don't think you need to duplicate anything, just have a little
function that maps from the free-form v2 commands and flags to the
v1 field.  Preferably including a mapping of all unsupported ones to
a catchall unsupported command and flag each to indicate that the
trace includes something only visible with v2.

