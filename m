Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB12561B2
	for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387579; cv=none; b=SI2mDWU/S7Uup34Z1nKOBbDqGep/h/1nm9Kq4KJmCexmI+l1plyFer+OeCdx9TuK0FmNlND9hK3t8nSFE7rUPDJqMbnCyRPJU7gK8/VsxXJ9ysRI357J0XtlDXJUEmjzVp0kZ6zyGFaBT7Y9CHMxkgNXWpc1HXryOx5J+Atkkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387579; c=relaxed/simple;
	bh=Op7Jgv0EAeJn9fox3dkIa/P6iiWflnKzT8xbPpanr0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZhVxYMGQOvEkuu9WyNmcLCRq6tznYE0JUAl/diidsRqi11G0y65DuIxpNXQnCno8BdHIytXiRLqnxgm2T8gzttkz1XplOhXYI8QtAosrOYacgJ29yMEltj6Njw6Huk3Eg0+GvoHBSx6Uu5brIx6hzcVb7LXMV2a9ThVxuAGuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wI3LdEm2; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wI3LdEm2"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso66035695ab.1
        for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742387575; x=1742992375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laVwrKchhTS7MaUVIRBDXz8QLr9XPBe9NUXsqqA2JP8=;
        b=wI3LdEm2I8wKJWBH7pziJ5T3RZgkjbmzW329YLlN9kP3OmhOuW3hVTfiAQTdjzKkrH
         VLLjU/HLoJaw5G7kpbVIrQGPVK/hkDZr+RZGZFn2SfA/p5D4l6y/paWwpD+Rmwf4B1jU
         /58oM+Vp9gIkig/k/fkhRsffx9JY0EpX9wueGRkYZ/TWt/uURLqbT3BNwBV4AAfEN5FX
         i1o/Pvf5frzv6FiJOxAD8VS5N8MQAQv1263yuwWNRQYYfO8R6QimrVRyUCm7zGbsj3Vf
         xBwLMo+Vhet5Lvj7M+ocp/46QTX9GF3Rf3NAExyrKJIUA0OdpK3nw9d4btKKtA3JA3RU
         JteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387575; x=1742992375;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laVwrKchhTS7MaUVIRBDXz8QLr9XPBe9NUXsqqA2JP8=;
        b=WgMGF3Z3uqDTEbIgXCaxAqHvE6Dj81BkszwbkkCi4iFB5mFEqWIZTcwHZowljMYCuK
         lJ6fnlz259HTxaxbNddd415ijtGvHg6vwdinIuZyjGX2FjhX8HEFA14XFqpNccwyvyIc
         BjVeXEnW8UffvgHZBViPnwk7+3fJFbjraf8izbXb28pMxU3tCkRkc+Z8QmZVQWhhvrmR
         3Jp2wq/+RzEv9i2vXKyGhE7RRt/rLl2joisKEorlMmvpcnZwHFDyRamVj98x9XAhInpw
         wvpnnhWNmYR8itj9lN0GPunsv5Bansx5PW81cuNi2JhwheXDCNyw3HnrRiIrukpiAjKM
         whAg==
X-Forwarded-Encrypted: i=1; AJvYcCWAWCZv3AVJ8Bcse5I6HvMIXYtEJYrLnS8nD0ebeRMBuo1cWZasdX1Aj+6hi5NUSMjZNQb4rLXzwPrzZ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNXkNUi+JVQzyd8d26WcsF4wg0GPRtNsA4sqRW96kHKCDhdaK
	+SXpq5J3GaBQV4IjvlJpK3hGLHyuX52YXn/3cOUO0q2o2U2b4SCGU9WBBANGuWBreoukafJnlF7
	n
X-Gm-Gg: ASbGncuuxbmetQSLxKKzk2IEok7x+FufpGDgPUCMOZSKOfjjpsBHQm1bVdhY94cvjIB
	yax4baFD/0oszXZDSzPpCmrfp1MXXfpMGPattwZoV0VjOcuCwOUphXa6c9c1BceHUl9JLkOV7cx
	JzKB9pNCw+BIYm9ztTGwSarbPIC8RNQjf95Al6ytGJ708DqsC6u2nonomzDQ0Kjnm4RHH5APfCn
	HCMqlSM1Kn4B+Zimbf+QpHyJfdBICNxoQYe8P6RDUjPjqOXrrW10UAbaezWcUpYbEOpi5AoihAy
	E4xceIYdtUASIWrhkhdBW6lBQKn10ewDAWDqXGjjRWa3Fk/xjrU5
X-Google-Smtp-Source: AGHT+IEfCixtkZ/ayRvdfINyFa+LwIw/5IMR8em83Y6ktDoSAruetjelDJy1tk3tTH/sx9OyVg9KFQ==
X-Received: by 2002:a05:6e02:1a08:b0:3d3:dfc6:bc26 with SMTP id e9e14a558f8ab-3d586be3db0mr24224015ab.22.1742387575338;
        Wed, 19 Mar 2025 05:32:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637276b6sm3243737173.74.2025.03.19.05.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 05:32:54 -0700 (PDT)
Message-ID: <600f3232-281e-4819-9ab7-f031c3b44aec@kernel.dk>
Date: Wed, 19 Mar 2025 06:32:54 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blkparse: Fix a potential coredump issue
To: 303146950@qq.com, linux-btrace@vger.kernel.org
Cc: Kou Wenqi <kouwenqi@kylinos.cn>
References: <tencent_4C259E2F20843B8474E09968258CC806EE05@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <tencent_4C259E2F20843B8474E09968258CC806EE05@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/blkparse.c b/blkparse.c
> index 9d2029a..2c459bc 100644
> --- a/blkparse.c
> +++ b/blkparse.c
> @@ -1023,6 +1023,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
>  		struct io_track_req *req;
>  
>  		req = malloc(sizeof(*req) + sizeof(*iot));
> +		memset(req, 0, sizeof(*req) + sizeof(*iot));
>  		req->ppm = find_ppm(pid);
>  		if (!req->ppm)
>  			req->ppm = add_ppm_hash(pid, "unknown");
> @@ -1107,6 +1108,7 @@ static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
>  	 */
>  	iot = find_track(pdi, t->pid, t->sector);
>  	split = malloc(sizeof(*iot));
> +	memset(split, 0, sizeof(*iot));
>  	split->req = iot->req;
>  	split->next = iot->next;
>  	iot->next = split;

Just use calloc() for these?

-- 
Jens Axboe
