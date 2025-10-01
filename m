Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060D258ED2;
	Wed,  1 Oct 2025 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300637; cv=none; b=KMaUhivQYSKBFak139dPjqYcM9/SHX6azAa+naWRB+4PJlqmLfIR0Sa0+stCJxB7g7HYhzcAH/G7htrLlRbRV4t1BDa3lig3gWtPbCk2nyfTK+cC6+CvLspD8lbKK/AXTfjPdvW0SH0jGOS8jcrmIKCLyHlExEoR1XfD4zGyUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300637; c=relaxed/simple;
	bh=MFt/DOSbolMTzbPZDX6+CtzfqaXSvRmbS6OfTX0PMhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTmQvUlqnkVUUDonuuYsK+XVhfBD4OsHn7IitfkrhGT8y8CAycOP6ArjsJP5/JLj44ACieoWo0zWvPFVL4ZnBLlZtiyo2Aw+K1vR8p1aHNyeQw4MOS+eYsORhlL6wNl58Pm/aCPpcfE4nq1wy1ni1Fd/7vzE7hW5sN1Vq/gQqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlLDobO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlLDobO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFBEC4CEF4;
	Wed,  1 Oct 2025 06:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759300636;
	bh=MFt/DOSbolMTzbPZDX6+CtzfqaXSvRmbS6OfTX0PMhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZlLDobO16k9jgOQPGvnroZDaSJV7m+bdNHF5dT24W846vxI/aQWNQmEQHNqOvu3Vo
	 4GqPW8eFbdf5YPoOBENzK2E6P177a998kwMQLJwlcAMooR1mmiYZ7JwnPh72IQxgtT
	 TYPc+LXrcAdpL1Y1rWSGePxRHA0LE7BJMIDPJ49RXvz259FZUaDdTAriXNGt+vKhxF
	 YpTgS5wtB7KfDkoT6Y0aVeBgprzqjx/ZTHRMPZzi9yoBIIp4gAz1makUTQtLb++udx
	 /QY//AgqDwz2irshY+gHM0lYz/qvI0xBCbNXVMgwyGWIbi1UNILwLY0dl0sJ8HkX23
	 kQ6vPap13hVaw==
Message-ID: <92fc6fcb-3604-43b2-b66a-7f2a9edc16b4@kernel.org>
Date: Wed, 1 Oct 2025 15:37:08 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] blktrace: add definitions for struct
 blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-btrace@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-10-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-10-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
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

Why 8 ? that makes the structure 4B 60 B. Padding to 12 would make it nicely
aligned to 64B...

> +	/* cgroup id will be stored here if exists */
> +};
>  /*
>   * The remap event
>   */


-- 
Damien Le Moal
Western Digital Research
