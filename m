Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260281684B0;
	Sun, 14 Sep 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757841516; cv=none; b=XVdFRp95duoYfxf8LMF5ZaZ/oJBIHGpIo+ksfweZN9HNXkH+/retKVGt//iX80dSHXEsLbhmFaTf1+IbT/O8924Dx8i9sZFJhgNFacbVrCdHPsS4KTKpcIUYzlVarxNB4vNOuyFHas1exu4nMpg/vYc8hQWcf2h5z2Wzd3nJP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757841516; c=relaxed/simple;
	bh=q3IoJvqx4JW9jNqkMbSKv/nFIhhDIdi2nZRgRhdwL+8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=apVpxgwZXK2Fsyu2LK5NHsXuGThnN0mQkt97E/KgLnsjDyVxWxLHAXMz/I1muCEGiGo4h4NPmo7k55dxeSYFfwK/uLR3Rhm15XWnHO5CUFdd99F4+LFRwqbh9E5XjI0TSjFlYAsJuXDjga0D5zJZUXrXvDbonsw2PEAfSBvEql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M58e0Ex+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M58e0Ex+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D59FC4CEF5;
	Sun, 14 Sep 2025 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757841515;
	bh=q3IoJvqx4JW9jNqkMbSKv/nFIhhDIdi2nZRgRhdwL+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M58e0Ex+WdT9CBB/uNZqIdhWAc8Dqwb7Ez1AldGs7Nl6ZWV3WPv5ojEU/RvvuzGXA
	 aDO265BmZo7ElcIKe1D5LCTIojm4JDKaFhBJPXuxQ+7bYoGMFi+W6m5QJnV81AdyU/
	 eWYg12V+O3iFc4G4hXbqvpLhFEQYuDrA5xKz5w0TXjvGEaHZhUSz/8Rj5soJDolhqm
	 PK6M768IE4KgIR9DvkvxavnSd4hT376jTc2ilY3t8C6Cm3SRKs4ZaTijq9Hd2IrGw2
	 ux9IKRa78FX25ReaHEBuPtt6HlYaWzDt06EB1MoVpC3luf3JKM5KL4ocywf7TlRQGR
	 j4t1wvR6piiyg==
Date: Sun, 14 Sep 2025 18:18:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-btrace@vger.kernel.org, John Garry <john.g.garry@oracle.com>, Hannes
 Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 00/21] blktrace: Add user-space support for zoned
 command tracing
Message-Id: <20250914181823.a17382ac3a039dc4a8257578@kernel.org>
In-Reply-To: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Johannes,

On Tue,  9 Sep 2025 13:07:02 +0200
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> This patch series extends the user-space blktrace tools to support the new
> trace events for zoned block device commands introduced in the corresponding
> kernel patch series.

I guess this series are patches against for user-space blktrace tool

https://git.kernel.dk/?p=blktrace.git

And the updates depends on the kernel side update of your series;

https://lore.kernel.org/all/20250909110611.75559-1-johannes.thumshirn@wdc.com/

Right?
I'm not sure how the blktrace tool development is managed, but please make
sure this series is not for the kernel. (ah, both has blktrace: tag, hmmm)

Thank you,

> 
> The updates include:
> 
> - Introduction of a new ioctl requesting the v2 version of the trace
> - Definitions for new zoned operation trace events.
> - Parsing support in blkparse for these events.
> - Display of the new events with clear labeling (e.g., ZO, ZA, ZR).
> - Backward-compatible changes that do not affect existing functionality.
> 
> These changes complement the kernel patches and allow full visibility into
> zone management commands in blktrace output, enabling better analysis and
> debugging of zoned storage workloads.
> 
> The updated blktrace utility will first issue the BLKTRACESETUP2 ioctl and if
> it fails transpartently fall back to BLKTRACESETUP allowing backwards
> compatibility.
> 
> Feedback and testing on additional device types are appreciated.
> 
> Johannes Thumshirn (21):
>   fix comment for struct blk_trace_setup:
>   add definitions for BLKTRACESETUP2
>   call BLKTRACESETUP2 ioctl per default to setup a trace
>   blktrace: change size of action to 64 bits
>   blktrace: add definitions for blk_io_trace2
>   blktrace: support protocol version 8
>   blkparse: pass magic to get_magic
>   blkparse: read 'magic' first
>   blkparse: factor out reading of a singe blk_io_trace event
>   blkparse: skip unsupported protocol versions
>   blkparse: make get_pdulen() take the pdu_len
>   blkiomon: read 'magic' first
>   blktrace: pass magic to CHECK_MAGIC macro
>   blktrace: pass magic to verify_trace
>   blktrace: rename trace_to_cpu to bit_trace_to_cpu
>   blkparse: use blk_io_trace2 internally
>   blkparse: natively parse blk_io_trace2
>   blkparse: parse zone (un)plug actions
>   blkparse: add zoned commands to fill_rwbs()
>   blkparse: parse zone management commands
>   blkparse: parse zone append completions
> 
>  act_mask.c     |   4 +-
>  blkiomon.c     |  15 +-
>  blkparse.c     | 450 ++++++++++++++++++++++++++++++++++---------------
>  blkparse_fmt.c | 105 +++++++++---
>  blkrawverify.c |  14 +-
>  blktrace.c     |  40 ++++-
>  blktrace.h     |  64 +++++--
>  blktrace_api.h |  54 +++++-
>  8 files changed, 560 insertions(+), 186 deletions(-)
> 
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
