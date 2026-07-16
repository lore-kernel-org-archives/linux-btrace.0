Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781530BF67;
	Thu, 16 Jul 2026 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202210; cv=none; b=oPmlZ/avQHFqiwPrYnG5r58JFtsi/xsv0XffTveGeKVm/y/+kV76c5YD8rlxXkAs+ibcXJHHkjKMy+kgY6pk0Jk3jWqUePRlVhUKlL8radj1z1vc4AYY1Jd21GvVOmq0ldKscM0hmsIbJeM2X6Ppz+jj/MMT/Qp+9z9cnHyASag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202210; c=relaxed/simple;
	bh=RM2T1tIgX+nfwzlYdSEBns1PfkMLd7vc0mKQ2THHt6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0Tu2GDqUbBxlUGMonplJ8bijae9GRYanAZ1XRFulkm0MWlwXLob2M5GeiX64leFMSxv4C/irUqIK/Ke5hZjzZV1sSIcvtgOPg4g4n+2rim2djbzwrNNBhLYWRZkhuGl4NuwjFBAaDuKCF9R9LvKaMeIfxuatBgGWsPoDX9oC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF4C4BZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF4C4BZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7171F000E9;
	Thu, 16 Jul 2026 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202209;
	bh=jrUAAEooszY38D0ua770HyQOK37zAohD29U93zHXEnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nF4C4BZYTiEnBlWJw/knysSqmIynCvTsQCzD14L8Z4rOQ3UjA3GJrr6CcpZBs3/xx
	 t0u4I+EQgdaYhgFNbUaMKUAuuFsPxdSoQjFHRxDZediz2f37LiSI1GASzoEmBMO/5H
	 BE8uUkluK/EoX2jiIBqZ6QPlPIqDHFKRRvGNzTdguY4zgcojJE9kRA3+G3lhoICkZP
	 qg7NV9Qp3+Kz3i2JKIcMExhSdEedKnuw90Gw5Z8v3cG+bMqKVHOX7CbleUc0cXxtfC
	 AGTpr02TotSCb25rSsQpOvxLaBCmolpen3aLCkW3tfHSoj2ac5HvNxTq/mZDblysGF
	 DBCahn7N/AjCg==
Message-ID: <649c6e1b-5177-4616-8888-b533bae1e267@kernel.org>
Date: Thu, 16 Jul 2026 20:43:26 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] btt: use blk_io_trace2 internally
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Use 'struct blk_io_trace2' as internal representation for a captured
> blktrace.
> 
> This implies the conversion of 'struct blk_io_trace' into 'struct
> blk_io_trace2' when reading the trace from the binary file.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
