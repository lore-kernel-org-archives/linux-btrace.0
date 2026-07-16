Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77041D640;
	Thu, 16 Jul 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202852; cv=none; b=m6KnKGQuPoY67Qztl0WeCBVyOo6/CpJqMJlRZlKSQCjWDgtUEhHtWveM8isqoGjrpxyL58gmlFJgkyyYVSBao5gBOgfKot5VkGQE8NC64LCMk1cRssbuYj5EjbEnktQxO69AplrtdPY3NeJ1yE/q2s99NOUSEvoPxbycepE+Sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202852; c=relaxed/simple;
	bh=NVWbVY0GhM7YmPh6iMXINit5UKJr1QEc/cJAchbglBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekWpTsZ0iYe9YRVnnLpHc16V8mwdVUHEz1XXmQMzv49NZib7v7XonPEV3e4xiFDRf/jty1sSpsgb6+Q+aGmsoKIFV2cdSVTcB+RHEmfSvXnghklSrwfUncQGm4k12aL6NCEKmnfj9OeucdTm+zTqYpOYtVXDASQUoggYXqHjB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct2+9Db2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct2+9Db2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898C91F000E9;
	Thu, 16 Jul 2026 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202850;
	bh=onC3vG5zsKUFL1bzZTRPeiE7hGT17ByuB3hJj7IlvFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ct2+9Db2fRXc8JO9xjlGiwynaFG+lM11uG73pZjdpZWVX9LHBSiiZFWGKvfDZ6wsG
	 cfreJ+TIA3stPzqcJViqjSTUBhrM07peD2sj/5E2vfWZQ39pNozVyoXkh8b35mcrEN
	 lzJZDe5dpiibx2em8lAmxyp2jqyogkpwAd9TGej6hMlDCYnZeJ8PnsxHN+xMXvwkWN
	 dod+qP4DOBVI7r/0hlp7FdsoNWeN1LmsZC83Q2mUX7YxSxHDitL21FC2fAoRvABiGz
	 Q2di53houS2h1EF/RS3kKO+B8c14D7/WhNyNw7HPakhYMGuY6Ct1WbJCZnak47LFoj
	 H5Uanj+3YdFuQ==
Message-ID: <c0ee5837-35a2-427f-bebb-da142cf4cdbf@kernel.org>
Date: Thu, 16 Jul 2026 20:54:08 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] blktrace: add option to request a specific trace
 protocol version
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Add the '--trace-version=<1|2>' command line option to select the trace
> protocol version requested from the kernel. Requesting version 1 forces
> blktrace to use the old BLKTRACESETUP ioctl, while version 2 (the
> default) uses BLKTRACESETUP2.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  blktrace.c     | 30 ++++++++++++++++++++++++++++--
>  doc/blktrace.8 |  7 +++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/blktrace.c b/blktrace.c
> index 72562fdc9d9e..35db26fd4e23 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -283,6 +283,7 @@ static unsigned long long act_mask = ~0U;
>  static int kill_running_trace;
>  static int stop_watch;
>  static int piped_output;
> +static int v1;

bool ?

Or maybe less confusing/more scalable:

static int trace_ver = 2;

to match the default and the --trace-version option changes that to the
specified value? That simplifies the code below too.
>  static void clear_events(struct pollfd *pfd)
>  {
> @@ -2244,6 +2257,19 @@ static int handle_args(int argc, char *argv[])
>  		case 's':
>  			net_use_sendfile = 0;
>  			break;
> +		case OPT_TRACE_VERSION: {

		case OPT_TRACE_VERSION:
			trace_ver = atoi(optarg);
			if (trace_ver != 1 && trace_ver != 2) {
				show_usage(argv[0]);
				exit(1);
			}
			break;

> +			int ver = atoi(optarg);
> +
> +			if (ver == 1)
> +				v1 = 1;
> +			else if (ver == 2)
> +				v1 = 0;
> +			else {
> +				show_usage(argv[0]);
> +				exit(1);
> +			}
> +			break;
> +		}


-- 
Damien Le Moal
Western Digital Research
