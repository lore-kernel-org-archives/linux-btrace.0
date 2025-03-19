Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024835963
	for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389863; cv=none; b=KPLK1ES0pTklrufWaNbD/ttc/3t0jYKH0TZTL5bcYhyrW9Lee+V4hqtJz5NGrD3UJ7I8a+jcbw0yL+Hza405pLlAl/Yo0Lr+SU5YjBgCpEoa3IfSRKH06yR1JXX9LKZzfM29ADZKfHpg1W/JN2DKz+mYzT13u4cNvlRC6h5nIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389863; c=relaxed/simple;
	bh=tKxLOjMGSOFW5Rt4gJYR5HZu1qdjxvpwX0bLL6+rBOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAwWH/nhXrWysOJQDHxu9Tr4F9zSzJ7QAxAIAqoUT+0XHUaYBHVHMNrs86zPtLux972FVuoT4lCT3mKWxGH1vmoWayuttt4/0XuWdkSDYpc65z5XAbqIbvmws82BS/QNccYlvyYchh9nAMHCt9yK3nS/9XcVH9Hj6/RUAim/V0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bd3Ku9so; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bd3Ku9so"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ad83ba141so717267339f.2
        for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742389860; x=1742994660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFIvL9G0oZKU88XNJN89GusYqC6GJ4sBAXG629kSi0E=;
        b=bd3Ku9soZiqOCBTs5ugrfZBPMsl9CiEcXfzVia0ocxIRmuOqifbhR0FI6SShsCn8zQ
         JPBX+gsvd5CB/+Mu7VtIItxdQZfMstU9pIOlK7cUEbetq2QM7avyirJKkYhvYDYsmj5z
         LkPkwUrharPI5WOmI5W39Hzp8gFpP5m0MUruNzam+MH6UK6R39BQw1ZLgpZWNw1Gwo6H
         AM3wDXuLcaO79ToOodfZwyGyGODqStMOcUNUVUxYIj6E0cxd2krkIqZIHOLL+9EXAGsY
         gKWEq+fSRgeqearRmvikPqZxBx4n13LlYENzwQYC2AshxDhhoKAJMaYEnACXl+sWzd2U
         Iy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389860; x=1742994660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFIvL9G0oZKU88XNJN89GusYqC6GJ4sBAXG629kSi0E=;
        b=a9sSthG+zSHaDVG67UJhgJkO7dtM+T2+KPMUJaxahj30U4MwkLyudHFsQv3YrLrXui
         kQcgoelVyXygOTCTf38O7L9Lww+YRdrKQcBfJryntlrZC++bQICO8ygAld8H9aaNciIf
         cW9XScvWBVVlVV81J9dr5Y22JjlSXqBjthTGrdGdbfpD7stpMKNNj/hTOGpVWprpZXi5
         JF8pWwwoYoEmbA6WsmAct1EP7KTzOHYcOiqLoUM4RUKFHq9joa9w/+QJk3w51dSQulF+
         UMgxVFxwZMd+l2X7z9GhwlnH7PZT8VlbfKiDNn/K4J4HB1aK34JyLYt30z5JEweIOJeH
         cihA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAk/QyMvSJ7fetHPpNj0e3ash5qEqpEtKODbf/G7Qh00tu61AbFf4zCBpLStbnpsdPxQgynoquR2Q5RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpsEdwMPmKoWkco9tRQMT1Cp75tpSCqu28/7m+7C00WAVu9+2W
	oVu9lEVMxV/CsTj27oZDJSjLSM8RrFItcGTDoKG6Hdfoft2rDsLzQbJvZ7OnbLVM7pxzIGrQ6kL
	T
X-Gm-Gg: ASbGncss0lKg903nVbr1XpMUEs+XEntbxRTglVs83zvF0gpC+P0l9ZKMg5tpqZGJTTO
	THuiKQkFAAmPj+mIdNAgeygzY1QmLLiKPEl7s3enJjb6Z/5G3kgBvAgt8gRorg6yCpiO7ZMUuLq
	dbVTwJFDCkwRQfxzkPUrT4jQomEedvhUDM7so1/oCl6e4WwJfmdNwL7MpOOLBQicr0qiUPPLCuc
	JMUTC+Ky6GJPuziIj9xOz/QBRDzsckhhVUXSkgfxO9VzLAXiYpC5Ih9e/yYr/oSZAkz4EQQiCz0
	jq8NasjnTXNEcqhm5D6fuM6sH+X7mK4GdtrbF8Ur
X-Google-Smtp-Source: AGHT+IFbGYA0bhQrdWOwxMn4VNHL36Iil5eFnV3jMKZFwaHmtIrxC+wUry2H8R7QC2/b8x5LNsKAgw==
X-Received: by 2002:a05:6602:368d:b0:85a:efae:2f15 with SMTP id ca18e2360f4ac-85e1377d86dmr324572439f.1.1742389859605;
        Wed, 19 Mar 2025 06:10:59 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db8745189sm301072539f.7.2025.03.19.06.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 06:10:59 -0700 (PDT)
Message-ID: <1962cea3-e413-441c-b98a-ded4a6a4fe68@kernel.dk>
Date: Wed, 19 Mar 2025 07:10:58 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blkparse: Fix a potential coredump issue
To: 303146950@qq.com, linux-btrace@vger.kernel.org
Cc: Kou Wenqi <kouwenqi@kylinos.cn>
References: <tencent_DE806EEE1852F9E79115172254B8A2789207@qq.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_DE806EEE1852F9E79115172254B8A2789207@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 7:02 AM, 303146950@qq.com wrote:
> diff --git a/blkparse.c b/blkparse.c
> index 9d2029a..d6aaa8b 100644
> --- a/blkparse.c
> +++ b/blkparse.c
> @@ -1022,7 +1022,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
>  	if (!iot) {
>  		struct io_track_req *req;
>  
> -		req = malloc(sizeof(*req) + sizeof(*iot));
> +		req = calloc(1, sizeof(*req) + sizeof(*iot));
>  		req->ppm = find_ppm(pid);
>  		if (!req->ppm)
>  			req->ppm = add_ppm_hash(pid, "unknown");
> @@ -1106,7 +1106,7 @@ static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
>  	 * parts.
>  	 */
>  	iot = find_track(pdi, t->pid, t->sector);
> -	split = malloc(sizeof(*iot));
> +	split = calloc(1, sizeof(*iot));
>  	split->req = iot->req;
>  	split->next = iot->next;
>  	iot->next = split;

Nit picking, but the idiomatic way would be to make it calloc(size, 1)
not the other way around. The first one is the size, the 2nd one is the
number of them.

-- 
Jens Axboe
