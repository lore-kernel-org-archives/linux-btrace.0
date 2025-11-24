Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005662F5A2E;
	Mon, 24 Nov 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975592; cv=none; b=cDBu9diX/vgnM57tSmVXUnoyqQYjCYfHXrItbyG3EGmHrUZXw7/GScM+fvL4lXBKThANhUvk4RQvruiXXqr8+oUst4jpnqBs3y3LN+zjL+mvIgU5LV3DAOSdL7fDPCCW8u2Otc9pN7hfXWHkD9QrRy4JUvEY9bj53zi/OnWpU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975592; c=relaxed/simple;
	bh=mJ5HQYf3zngSfn5xAlwaZM9A0tGQje8mDznQLogpxiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffBEbLWWk09WCJrz8ItYA/q9Y36y4z58PmMeY+oNvuRi91KjTBuzU4mEq1PZlEDR7jR0+5Ax92fGgxEqbYEdnW2BCRPCRKl/B37JuFBjZeVVjjS0jt1JAItDQ1FNRlM1D6WBjvUxkY3LntsotejwuchESt6wZ8U/iRZJ8ynCId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8U5RihN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8U5RihN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BDC4CEF1;
	Mon, 24 Nov 2025 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975591;
	bh=mJ5HQYf3zngSfn5xAlwaZM9A0tGQje8mDznQLogpxiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f8U5RihNlTefQYsu1HStqrICmyDPn/Y/2N+CReNbjlAogMK0dE0qnbhrLcJVq6FFd
	 Buv/iz/JshTDgX4G7bsqd5nvVmlJhTJ3cVowT9mrV9Be2ffLfSvaPY95VeNzBekQ9Q
	 UPtDljNDffK5fg23m6EPKlh/+D1Y4N0IwyG9ffDv5IMZNNr/Z71CpOj1kMwV3hacNn
	 KHzwToBsfrmP6JVhOM8oFF4fLdRWXoJeGe0m5FlNkgyV19aM1qpxKhZja6426N4ErN
	 eeNgJ72tsufVBsgmtkPQkWCYaQZwjHRqMNSN6bDYqSDhiMuio5SIw/8e47jKsqVhOK
	 Yha1J8kM6mjjw==
Message-ID: <3420ae6b-7649-455b-afbb-93811611bb29@kernel.org>
Date: Mon, 24 Nov 2025 18:13:09 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH blktrace v3 19/20] blkparse: add zoned commands to
 fill_rwbs()
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Niklas Cassel <cassel@kernel.org>,
 linux-btrace@vger.kernel.org
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-20-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124073739.513212-20-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/11/24 16:37, Johannes Thumshirn wrote:
> Parse zoned commands in blkparse.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
