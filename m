Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59E41A571;
	Thu, 16 Jul 2026 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203457; cv=none; b=uELL2C8AZDqOJBlA9f8mTGTr7pTWFDOUXvOFJSxBBVuV60AxuSGrTLx/JVQN8hLE2Y075Di3aW2Pdo+5Tv5jI+0vidmJud/Sa9QCrNrWERfRy1bBlDPkyt8QAmKcZ7/uuBDqikLD7U5mDl7T6mr1dW3ye+zco3uu3md71gFXar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203457; c=relaxed/simple;
	bh=SUnPzaGvTEmDEPK71/CMkH9DDWL7fFRgcsBW9dnB5ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8+NcQc1Dyyc9b+7nQ7EQCu8olLOKamjwDZqossJrTuPTzZIp5IHj7juo0/jJIFZljvJg1AaRnW+n735Qnrw3aiyIoATALAHRLQjEDopNstyZStwUbaP65DTT3oro718VSRJnLTPgdFZ/fzZiRRqQj+bwzbU5aczSScEgMqx0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM/V1sHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM/V1sHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9F61F000E9;
	Thu, 16 Jul 2026 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784203456;
	bh=jy1MCEo4h+b5yrEKlZHrh6jMyJYtF+Ydb57Neu38nAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IM/V1sHb4XgZSTEToWGp/1hn1RMc7dDOLnorbrtEG8oIKZc+tKP0E7oi2XhvVqE2t
	 b8d8ElNVD4mVtnPlSa5ihyYz+4o/3JVfyNO8jDtd7MdgNQ+//R0qgu65t6BE6ZaxQq
	 Tr1w9R5ywB8lIngLScBS1nzRbmLBanIsbZbIp0G583aoehQzXozvWYbKWExb3QQrZv
	 WZ7X7IF0Vc42EmqRdoahoCaOBTki72eseADBPLkEXcSWGIiDWzXrrPFi6QBMo2JwUA
	 3t9EEx+l6efkKv5gh8n/BXAD7u0LVJvwSLvGAhjF08X8DxMtlPOUMGhbsJGXQdi6aK
	 NCLiz020k8bGg==
Message-ID: <08cefa61-185d-4ce1-b5ff-3344d0e00c65@kernel.org>
Date: Thu, 16 Jul 2026 21:04:13 +0900
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] blkrawverify: natively parse blk_io_trace2
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-6-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716110442.1291010-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 20:04, Johannes Thumshirn wrote:
> Natively parse 'struct blk_io_trace2' from a blktrace binary.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
