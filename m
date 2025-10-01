Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822022248A3;
	Wed,  1 Oct 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303407; cv=none; b=NC+beHCiBW7br06j7YAXvxa7dJCLt5xvTPLrpEUU9TsoKH2WUWc5JM2ptt1luMig8b7VqYfwlJ/QVGiZ7sGLP1GRMwf1uTX8XsHijijK3EYVvn1xHSdT5Eom6eVQ/0DMOZjBBoGuy0hidHFLj7UAue2bcoj/SDapUJml78kM8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303407; c=relaxed/simple;
	bh=hvGpjZm97tlkMuk6Dt7F+H1s4PMc95QaRw/zyQL4Hpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZVy5yJz54xPjyEjVLDhyxk+3OLUBGRVjT8fi7AtxtvBKovDso9z50JevCiks41xJm6L8ftZ985WO+4fIjijUXZEPK/9yNJHEKLijkaB18eHUgV35zhM6/F1kFd7ER95SGKFKiMlgHm+cJE5S6RCD9pCK/T4d3/XvNEi1h5KVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQZiw6BR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQZiw6BR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84E4C4CEF4;
	Wed,  1 Oct 2025 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759303407;
	bh=hvGpjZm97tlkMuk6Dt7F+H1s4PMc95QaRw/zyQL4Hpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hQZiw6BR+iRKPps6hJ1CD6i+ykm4T+hdOj1TcjI0YRbmPpKcs1aZULd7UA+JtPVHJ
	 zzS0EDWB+Luk5Z8DuCcBKkPlRA7J5Elsd0/rxbpcdIj97mHx9jtEGJFsAPDz6fnnG8
	 5MxCiGai+TXPA67pHlMLQei8y77hDAbW+APMUGOJIsvaQHhd9/X8cex4JneTu+NxCw
	 +8TdgTpJiNnbPvDRZEdInAuaYwIXxkDiiTA45SbG/wRUe6fQEpRznpuIumiukXCiYw
	 3c7Lh7AjbHhD2NQnGXd3AvPEjalHYkYqrv/RZtU2LygiihlZU0cbXjXX02YIW18DW4
	 Hny4YyCfYYDLQ==
Message-ID: <671c3ce5-3ada-4a7b-aa70-ecbeae992010@kernel.org>
Date: Wed, 1 Oct 2025 16:23:19 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
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
 <20250925150231.67342-12-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250925150231.67342-12-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 00:02, Johannes Thumshirn wrote:
> Add block trace commands for zone operations. These are added as a
> separate set of 'block trace commands' shifted by 32bit so that they do
> not interfere with the old 16bit wide trace command field in 'struct
> blk_io_trace' action.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  include/uapi/linux/blktrace_api.h | 13 ++++++++++++-
>  kernel/trace/blktrace.c           | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> index d58ef484de49..0f336140ce4e 100644
> --- a/include/uapi/linux/blktrace_api.h
> +++ b/include/uapi/linux/blktrace_api.h
> @@ -26,11 +26,22 @@ enum blktrace_cat {
>  	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
>  	BLK_TC_FUA	= 1 << 15,	/* fua requests */
>  
> -	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
> +	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
> +
> +	BLK_TC_ZONE_APPEND	= 1 << 16ull,  	/* zone append */
> +	BLK_TC_ZONE_RESET	= 1 << 17ull,	/* zone reset */
> +	BLK_TC_ZONE_RESET_ALL	= 1 << 18ull,	/* zone reset all */
> +	BLK_TC_ZONE_FINISH	= 1 << 19ull,	/* zone finish */
> +	BLK_TC_ZONE_OPEN	= 1 << 20ull,	/* zone open */
> +	BLK_TC_ZONE_CLOSE	= 1 << 21ull,	/* zone close */

Isn't it more common/correct to do "1ULL << 21" ?



-- 
Damien Le Moal
Western Digital Research
