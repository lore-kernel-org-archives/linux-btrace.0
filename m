Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575E1581F0
	for <linux-btrace@vger.kernel.org>; Thu, 20 Mar 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468845; cv=none; b=hvDHyfl9KxYeOydFtvMYskXf06JuPgqhPvZWZ7Mkc0+VnrGodloPclSla+1+PSuzh/efp/qfncHW5Q/+PXYsmXNoMMZ4KNrFPTU3in5YrSuTisMVvH0u4ZP9Xv4f8lHtYWX+6ygsBqvjIlYQermTMozuF/yBd7vqQ/IccGVY3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468845; c=relaxed/simple;
	bh=KQ7QAF5DveOQazL7T0UABe0HOvl0xN7mFDv8P/6HYv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbcyWZeROj8HDc0j7Tpr8ccmAV+GIbTYOMflluAGAvphcYv1Z/TUldOUHhuuLFFXjBuKe2aKNvytGolflek/JVX173Yg7T1zKmPdtEHplCdI/xFZYE5s15GekvJV9/xXe+VuyuTr1gDC2C0tcOGqDR5hJukbJFutkL4LvnAuvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EL/9hVsj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EL/9hVsj"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso54051639f.0
        for <linux-btrace@vger.kernel.org>; Thu, 20 Mar 2025 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742468840; x=1743073640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkhh3feniAVRmUHJAQ5Cm1CRWXxXz8UliIL9uwrI0UI=;
        b=EL/9hVsjXiM+oI9uoxAV6T4eSSyIm+Oe4P8kvmB9ws29L0gFVlx/d30g1WYSf3AVqR
         rSOXef2VZBvdIvijnDDnGsGkdRA8KVORwsuDILSfJ1e0jBpxuhA/bBB+XLbvuvvyc39n
         7s87kELKQVOQAR7L0B9eyp+2eli6mRP+SsIOgctpH1rBbI8XsG+IPLoTRuGjZkEH1vn/
         xBnoLIgPf5ZWABuECp4dx18jdS+KLzBlAIzkPGDgPRFAKHRuM0HktyG7Wy8ou67IVkQs
         8C2qeXLtRXEo7kpM71msd0ih4GoMCwDgY/c6vvyt1sIN/+95uACVFBKIxg3KsPX4Ldsl
         oG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468840; x=1743073640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkhh3feniAVRmUHJAQ5Cm1CRWXxXz8UliIL9uwrI0UI=;
        b=wSTNdYgz32MMlDmJAI9P+ztMElxmEzTdmZR4p+czGeeRsa4O54om0KF/nP5vB57RjT
         LERg6pFgtu5TdKFADbuPqDdsBUZYVpvreNh6RJPDXo75y2Lk0SBW9ItxWG6ybJQgmrCL
         45y8UKy0sJQ6wF2WcQI3v6eeE3qZdl5EDZJBn3U4NULeKmF6VfBvjIsc+5hT75MEZP8g
         wnnU5IBLZD1SCEL3kpmrXHbUKSCjQlgjj4A04VR8kJhxMvj4UXwvWuEUYiqGjfmefk6U
         rYYXU3vt7GOc3LeC43VuqgHBOFX6NNMwMdEaZ7KlH4V8oDRCpOUD6d2H19L5cYdFsAhO
         16+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSQ2NepN/1DYoiJeup/zaobRgCGGeOJ5IhhhtpFeqHoZzzsaoAU/B9e5RrchyZ4FOKwwwQXefjClotC2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpaXJ63ZdxU+qdtJioEA1vpzri7ksCq5YDBQ8++BekEnI+xRZ
	am5LPMu3FxqPqzufy21OXPo7rnSSKS/RnBFss+pyfWtNHPfEFHBLuUTwDESIJUccL7VJqwN4O1C
	R
X-Gm-Gg: ASbGncuoNI0QeUK6gasfIADqx5y3ENGAM+iB7SrcnNosHADYFDHZoyKrHwvcW1/1uZX
	My88ggIfSI1k+VWUlb5Dl0aVEBVZy0bXnuDeGC05Yq1geSABLOnKvbzEUOZOhWEXlIN7L4J47yk
	1AfeQA3HXEKHNLek9gXKU2AwriQWffX6/BE2v9hBjVBbeYRAix6BkAaGgQEHQ0Rg2jkFqGwUOFT
	MguRsRkwziTYmIYQ0PnYDli0twbxKF27KXmGUogk3hgl83zFzuFOaUGZY/Kv6Eh+ZvJ0UbhTAyO
	DuyDE9ieM25GJo1HGm3JjcSTZ8XObkJnE4RiRNTSiA==
X-Google-Smtp-Source: AGHT+IEcsLN2Xfw69Ug2GuQ3dh5dDX8wqhLu8iLCcjA6dA0x6KLB/P8vzyUjl86G1tLHplwbPAiPuw==
X-Received: by 2002:a05:6e02:12e8:b0:3d4:6e2f:b493 with SMTP id e9e14a558f8ab-3d586b3d0fdmr51365575ab.11.1742468840239;
        Thu, 20 Mar 2025 04:07:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6691d1sm43914005ab.27.2025.03.20.04.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:07:19 -0700 (PDT)
Message-ID: <329d38f9-3853-4228-a2d7-44c2078dd859@kernel.dk>
Date: Thu, 20 Mar 2025 05:07:18 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blkparse: Fix a potential coredump issue
To: 303146950@qq.com
Cc: kouwenqi@kylinos.cn, linux-btrace@vger.kernel.org
References: <1962cea3-e413-441c-b98a-ded4a6a4fe68@kernel.dk>
 <tencent_D844947035F128017DDC0AA43ECF482BA808@qq.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_D844947035F128017DDC0AA43ECF482BA808@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/25 7:49 PM, 303146950@qq.com wrote:
> From: Kou Wenqi <kouwenqi@kylinos.cn>
> 
> On 3/19/25 7:10 AM, axboe@kernel.dk wrote:
>> Nit picking, but the idiomatic way would be to make it calloc(size, 1)
>> not the other way around. The first one is the size, the 2nd one is the
>> number of them.
> 
> Thank you for reviewing the patch!
> I wanted to double-check the calloc usage
> to ensure alignment with the project's conventions. 
> The man page defines calloc as:
> void *calloc(size_t nmemb, size_t size); 
> where nmemb is the number of elements, and size is the size of each element.
> In the submitted code, 
> split = calloc(1, sizeof(*iot)) follows this order: nmemb=1 and size=sizeof(...). 
> I also reviewed existing code in blktrace and saw consistent usage like calloc(1, size), 
> which matches the man page’s parameter order.
> Could you clarify if there’s a specific reason or project-specific idiom
> for reversing the parameters (e.g., calloc(size, 1) instead)?
> I’m happy to adjust it if there’s a stylistic preference or guideline I’ve overlooked.
> Thanks again for your guidance!

You are right, I was apparently smoking crack there for a second!

-- 
Jens Axboe

