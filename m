Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAA2701B6;
	Wed,  1 Oct 2025 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304900; cv=none; b=E5C7wp0BvXA4BzxZEThw6XVLGHVYJdMshTo3+c3zAhgB3/O0bIoG/o/hzy3YU2+g9D0L29OMnvq9GsD6eWsxXz2xwRfynBsEeoYIX5RslpzVRfqGONSEWfDGEK4Mia17Aa5yiBxLBtyFAy5mpnFOkl0nno25zUIC5x47uao7/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304900; c=relaxed/simple;
	bh=rWPGsQN+XNq2hfe7G3UjPeCAighM6a5T/THiWLH/wVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAk05/dW3Fst80PX8L45lyyDp8nz85Ac+FUzgHJbRqVGn/vgvUOrOAq7kM2bf5XeipKy34fRHPOhDEyOH1E4CAAo2KSFyUCh4HNECWFT87EZ4EAf61rW8V82sIwNXdvjoJ5u2VvnRyHQhAW3HqnLeHTKX67KtZJAtPiK++r5974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+C8Rr4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+C8Rr4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEBC4CEF4;
	Wed,  1 Oct 2025 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759304898;
	bh=rWPGsQN+XNq2hfe7G3UjPeCAighM6a5T/THiWLH/wVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+C8Rr4ZbzOuqCKBO54f2SxgEjjfGFF8Dnz5M51GzJYh27lleyo7vGlaHklFCl3wo
	 n1+tnjKYzd3v99oL9a1SbSpvr4YgtL9IFrQL++YimIAsY/MYR5FVu/XoZVmxeGzGcr
	 /J6HKb1yLbdoRi5j2jyEoI7zUUHHjiDpR/DRupiqncLLjtuOi8ML+tPR7pLKp/2EmS
	 FYFdF7iGAzqiVEc62vWQornfH2251xcBW7H3CPGg4j70W2v1NuHgtVRogsGcV+Seap
	 3P7spLgEDxZW1TkuA75yao8i1U3cB1wo1uiBojfgShoe9UhvdTP9HT4cgalPE/91+U
	 i0oh1pCQwBVWA==
Message-ID: <fb62594c-d881-4f06-9cf0-ca44968e5d3b@kernel.org>
Date: Wed, 1 Oct 2025 16:48:10 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktrace v2 03/22] blktrace: add definitions for
 BLKTRACESETUP2
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
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
 <20250925150427.67394-4-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150427.67394-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:04, Johannes Thumshirn wrote:
> Add definitions for a new BLKTRACESETUP2 ioctl(2).
> 
> This new ioctl(2) will request a new, updated structure layout from the
> kernel which enhances the storage size of the 'action' field in order to
> store additional tracepoints.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  blktrace_api.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/blktrace_api.h b/blktrace_api.h
> index 172b4c2..9f435a5 100644
> --- a/blktrace_api.h
> +++ b/blktrace_api.h
> @@ -139,9 +139,24 @@ struct blk_user_trace_setup {
>  	__u32 pid;
>  };
>  
> +/*
> + * User setup structure passed with BLKTRACESETUP2
> + */
> +struct blk_user_trace_setup2 {
> +	char name[32];			/* output */
> +	__u64 act_mask;			/* input */
> +	__u32 buf_size;			/* input */
> +	__u32 buf_nr;			/* input */
> +	__u64 start_lba;
> +	__u64 end_lba;
> +	__u32 pid;
> +	__u32 reserved;			/* for futute use */
> +};

Kernel side defined:

+struct blk_user_trace_setup2 {
+	char name[32];		/* output */
+	__u64 act_mask;		/* input */
+	__u32 buf_size;		/* input */
+	__u32 buf_nr;		/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;		/* currently unused */
+	__u64 reserved[7];
+};

So not the same struct fields and size...

Why not use the definition in include/uapi/linux/blktrace_api.h ?

> +
>  #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
>  #define BLKTRACESTART _IO(0x12,116)
>  #define BLKTRACESTOP _IO(0x12,117)
>  #define BLKTRACETEARDOWN _IO(0x12,118)
> +#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)

Same here. This is in include/uapi/linux/fs.h, so why duplicate it ?

>  
>  #endif


-- 
Damien Le Moal
Western Digital Research
