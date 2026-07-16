Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7A3D5679;
	Thu, 16 Jul 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203985; cv=none; b=aPoCcBOrJMi3suuj3RFiKZZkhIdycWbo7oaxN0OKku22jh3L22dqtIjU0MEd6u3Jb1pgcInjyuHcwisjKC+8rSCmM7/9I3b1mVaR4/ZflgrXkQRXzs5bHoMhGEW4S2ONkNR5+xC6nOIdQ5RHIY7qFQq/P1a4rW8L/9OXZ/9yQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203985; c=relaxed/simple;
	bh=Ckb0eONmkNlU/06GqrCD0O5Olje0Wl8rMWUeXqtqEl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTnHShM03xSlvl+ajb0uwc978IoJYCCv7f+GUJH22BwcpUMMbfaAZE2vsE49Yusa2246Jpml92Vd/RZa2c6J+J/DzE3JbYQX/DddUzxcvI169SGwzOc/e7mKLHoKsP1BufoD7Tla+sW98kSrRy1RgYQaLgz6L9JLyEpDF3wQbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf6kGPkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf6kGPkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D63C1F000E9;
	Thu, 16 Jul 2026 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203984;
	bh=f6q6s46vHorcCHv+FM4Ui1x5CWUjeSHX8auGSmpNtG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nf6kGPkV1vFC4KHAbJ2YSz+z33XG40bzUkBFpMFi/vlbIzPU2lrxeNoyo0m7WR1Ln
	 mjZBB1JQuCqWxc5qP6xL0ZTqP7xnSeYRA+FyOgVMYrq+vV3yWqxdWDG6yLldy/HMVV
	 AGxpk/hH1HdsfcGy0IcwPoA3yJUDtWKC8Y2qYMjaM6kH/vXoQKMUGmZkmvAtLmgxRH
	 TfuRpjgSjnETo3g1NTMbJUZoNQO33rA1PiMd1rAXlvarX12l2R5JdVZfmEieSTalaI
	 LHfXmIfsEd+g5s5pkHx72ADwol1XSMPmWt/oygk5MIHl7tLKHH+aD0y8vlr0gQcsA0
	 B4MaZCDtXCmNQ==
Message-ID: <5932975c-39db-44a7-8fe1-5ae6cad22946@kernel.org>
Date: Thu, 16 Jul 2026 21:13:01 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] blkparse: add option to emit a specific trace
 protocol version
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-12-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-12-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Add the '--trace-version=<1|2>' command line option to select the trace
> protocol version of the binary output file. Requesting version 1 emits
> the legacy 'struct blk_io_trace', while version 2 (the default) emits
> 'struct blk_io_trace2'.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me, modulo the nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -3298,6 +3337,17 @@ int main(int argc, char *argv[])
>  		case 'M':
>  			bin_output_msgs = 0;
>  			break;
> +		case OPT_TRACE_VERSION: {

		case OPT_TRACE_VERSION:
			dump_trace_version = atoi(optarg);
			if (dump_trace_version != 1 &&
			    dump_trace_version != 2) {
				usage(argv[0]);
				return 1;
			}

Is a lot simpler I think.

> +			int ver = atoi(optarg);
> +
> +			if (ver == 1 || ver == 2)
> +				dump_trace_version = ver;
> +			else {
> +				usage(argv[0]);
> +				return 1;
> +			}
> +			break;
> +		}
>  		default:
>  			usage(argv[0]);
>  			return 1;

-- 
Damien Le Moal
Western Digital Research
