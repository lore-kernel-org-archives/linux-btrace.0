Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C828C5DB
	for <linux-btrace@vger.kernel.org>; Wed, 23 Apr 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439283; cv=none; b=ZrUKnxPjlkicrQABpnEy1tjweG6RweWGqtyhQhqMYaDaTIZHETyRhHjcdriL2UXETfXH3WRIstT/d31+mn87DCkClt2UWnaomF1GME+KgkScZHGuvVFLRuogxDwUrZbUWkUnTSHp0sCg8y+XR9h1TUH02zfxzn1cX7tyRC0AvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439283; c=relaxed/simple;
	bh=DS3dRfQyJTaAQalriDArLERdhXrxwQmhx0/F0rldKf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L6s2sTbaPn43HS1YLXSC7G+9Uu/scuOfuaUD/mmb45ZvMZv2n5cNTOJ31UKC/wbzuzjnePb7VSAjGt8K6RgKb4efrPrYU2CPrJSzFiq1XjOxTdH9LyS+QLLx/nhbYvvN+57eHEC12J/xZX/VlGhlGpZoMFfEo5XplS3q5C3gDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hlaRK4Ni; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hlaRK4Ni"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85da5a3667bso10662639f.1
        for <linux-btrace@vger.kernel.org>; Wed, 23 Apr 2025 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745439280; x=1746044080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNFI/ZpBeKbn9CVYGtNmKGTEw1IARbb1bVJxLvIvzXg=;
        b=hlaRK4NiqW4WHhUNucKUFtcA7c4c2n739AXD+uIFGUovpNKojBTVGD9EaHed63icc/
         9MFO89rOUmR9hiehTtd/L0SfmgZ24KG6VsO3vkjYiuiblpGpyLvOE/dV5/wjCaFzJSas
         V7apoqk8yAr4ms7mG6omsmpZIayOwm8/Dcg5/VUYIZLh5MuaGbTCr6Pg5VMPOtqKhXpq
         3vnJbS04lwIyljYYthsIMdqU94MvueaIIyN8O/AX7zAad7GBpC+dHN2X+sjzWYHcTJ3C
         Y0fStrBSyPkl8Ub6vMlvdK56qpjYOhLcr8A5EPXANBWoUjn+UlV2dmLmS2jgzR1puk30
         AVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439280; x=1746044080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNFI/ZpBeKbn9CVYGtNmKGTEw1IARbb1bVJxLvIvzXg=;
        b=ljn2Nn24OsI5UtD+YCKIRQ1xnIUTNwEJOlWvjWe9bm37CCYoRWXYlxKykMBYn3axu4
         9+/wGxMNGBgJpoNqO7XyVO+hwpHUqtJ4EeYR9idWLTLrFCVEeZDgx1UjLSBXpSV1D9Oz
         NG16Mmf0uroOB+HY/8Gc8coIBOzUTjclYqfvR5rp4hGnVn7iVHZJZ4w45XdnV0RMJ3Y4
         ydapjFfc5ITPxgqGuY5BoWR1v4yVObNCuzzZmTKIp25kDlPpvvTpJ9r2l7DpQNn/bWvq
         RDOBV6suowHey8UbsU0rVOd5ES6BSc7ybv1v5jOj2uIIem7dxQRJruvxY8qRdNZ93ryE
         sysQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAyqq0DeatxZBZSZmZQR7Gjgkae7YibfIFMjOu9HwqcLdRYLWPnZZJPD49OzWlq6kuAooJvtO4ZpR/kdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUGf+1pmx7Cb1AkYvf4eida+xT/y34wMHB5mTCAc5M6jt1u9F
	0Uw3jpw6oP/imk86POs+gFvIzB+9OXqAYgC54r1SuMqH1DKqJNd/R9VzqYS2xlGENwiSVvMZIvX
	e
X-Gm-Gg: ASbGnct7AQbuJvBZeVob3cUgb2Cmgjd0aX5/R9b7uPMLrJ2pkiAa2O3QLiuF6up19/u
	g4kPOZz267koqk7dEt91dXaOPc7G1dGqK7H2MuyBXgsSSNsoOXdmBt99Ck6F23nuhxsr6mCyZeQ
	G6T3fvFSXL4gST2R8fHWimTQghRpWCXGWnwBg1n0OcuMxWN2r1p6F8AX0ndKnqmMSpUNxa6TGO8
	LpbSa862NZt1wzsBglzAjEkLIurAsYqTZPx14dedPJL0C7J1imtLxlgZhBZkvsJVc9yCU4tzTig
	fBUoINRzqEStS0WNRiK8P9fVVii2EM2aiV7d
X-Google-Smtp-Source: AGHT+IHcAwoV/Xk1Csabzuse23MyL+xUVpziubfs/+LSvyDmWLnIPhaLqfAOH4CMFTaOcRTZq3heXA==
X-Received: by 2002:a05:6e02:1fc9:b0:3d5:8937:f419 with SMTP id e9e14a558f8ab-3d9303b356bmr97825ab.13.1745439279869;
        Wed, 23 Apr 2025 13:14:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d92759b775sm5222945ab.23.2025.04.23.13.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 13:14:39 -0700 (PDT)
Message-ID: <686a96ef-4fa8-4a0e-af9f-f33bff60071b@kernel.dk>
Date: Wed, 23 Apr 2025 14:14:38 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btt: use millisecond output latency time
To: Fanhui Meng <mengfanhui@kylinos.cn>, linux-btrace@vger.kernel.org
References: <20250423082729.520799-1-mengfanhui@kylinos.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250423082729.520799-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 2:27 AM, Fanhui Meng wrote:
> Output latency time in milliseconds to increase readability.
> as the normal time for IO requests is usually a few milliseconds.
> 
> q2c.dat test output result:
> 1.725317 0.292148
> 1.725275 0.337183
> 1.725326 0.288462
> 1.725334 0.282350
> 1.725342 0.276609
> 2.039203 0.217158
> 2.039463 0.123061
> 2.039715 0.173856
> 2.040144 0.184456

This will potentially break tooling. Maybe add a switch to change
it to msec instead?

-- 
Jens Axboe

