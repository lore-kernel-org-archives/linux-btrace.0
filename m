Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743123CE;
	Fri,  3 Oct 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476681; cv=none; b=rGBBFid0EBz6EWnRRjVoR3cyZl4ctkJZMZsuKSmA3yZZWrRljEA8dQuLZXd1zuvLFAcjzS/pkh9ITd3VG6VTb1H7IymKMdJ3EUA8KEiWgal6eZn0t5fRx11cReRYNzYctjUL2JEzU5xMtwUNrrt4AWH4BJB5/o6ofP+Ybu54PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476681; c=relaxed/simple;
	bh=a1Hm3SSWUXs5riwm3GB24CMlwbUS7Q1n2lrwSfHnSnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHxRM/aEH0m4v8XPyq4t0ULQXkybpjILs8GJSmCfdQNKLe2fig6K77lbEgk1SCa8Z4SSgHRfHmO9j9c+az0o5KqWs0ZAh5T+lPv/aeA1pw0bQ1AmjscPTHEVsH0RpJKt8F8krZlu4Z8MEqkYlAVJsQ5mkfVkIbqM7YeylzElsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B5F6227AB1; Fri,  3 Oct 2025 09:31:12 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:31:11 +0200
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
Subject: Re: [PATCH v2 09/15] blktrace: add definitions for struct
 blk_io_trace2
Message-ID: <20251003073111.GD12624@lst.de>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com> <20250925150231.67342-10-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925150231.67342-10-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 25, 2025 at 05:02:25PM +0200, Johannes Thumshirn wrote:
> Add definitions for the extended version of the blktrace protocol using a
> wider action type to be able to record new actions in the kernel.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  include/uapi/linux/blktrace_api.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> index a3b1f35ac026..d58ef484de49 100644
> --- a/include/uapi/linux/blktrace_api.h
> +++ b/include/uapi/linux/blktrace_api.h
> @@ -94,6 +94,7 @@ enum blktrace_notify {
>  
>  #define BLK_IO_TRACE_MAGIC	0x65617400
>  #define BLK_IO_TRACE_VERSION	0x07
> +#define BLK_IO_TRACE2_VERSION	0x08
>  
>  /*
>   * The trace itself
> @@ -113,6 +114,21 @@ struct blk_io_trace {
>  	/* cgroup id will be stored here if exists */
>  };
>  
> +struct blk_io_trace2 {
> +	__u32 magic;		/* MAGIC << 8 | BLK_IO_TRACE2_VERSION */
> +	__u32 sequence;		/* event number */
> +	__u64 time;		/* in nanoseconds */
> +	__u64 sector;		/* disk offset */
> +	__u32 bytes;		/* transfer length */
> +	__u32 pid;		/* who did it */
> +	__u64 action;		/* what happened */
> +	__u32 device;		/* device number */
> +	__u32 cpu;		/* on what cpu did it happen */
> +	__u16 error;		/* completion error */
> +	__u16 pdu_len;		/* length of data after this trace */
> +	__u8 pad[8];

This will cause mismatching sizes between x86_32 and other
architectures because the size is not 8-byte aligned.  You'll need
to add or remove 4 bytes of padding to ensure that.

I really wish we could have good helpers to check for that.

