Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600432BDC0F
	for <linux-btrace@vger.kernel.org>; Thu, 11 Dec 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765436141; cv=none; b=ZdX8Ndb/q3H7pgOps2Fm6j1VlLSMXGMNtBsIzCCRXelMFrq0W+GQSqOTykvLEWW81l2Oj2H6Yiazv9H2DJnUASSy6gDKA1UX7DqS0ZkoMQUAcozM654t7oM9QNRmp7Ctr0t8Ke1Ga9w7qJrjvw5Tl6CpvZqaV07l5RW0zwBF/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765436141; c=relaxed/simple;
	bh=7fOMZWpqXC+kMdKkfgZWudYMG0UI77944jyl1GXS7Ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QY3HwPMrVM289TfsmNK9SYL0GtBPWxKwob3XZSn7BD5ykA2Z3Wwve/amgOAE4OYnw8JGD2vGzG8SkhB5JFgO6GB71ob74PhDFLqlRBt+nAw+UmZEehpUIvoZLaIXP8uzN+Uya8qjZ/hwuITDC+uA1cdTbo2GkI00bZbYoMuljV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hFXvkqGB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hFXvkqGB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so731474b3a.2
        for <linux-btrace@vger.kernel.org>; Wed, 10 Dec 2025 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765436137; x=1766040937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t10daDk4s6MyC0x15QD6gZ8aKnvB29UsDlKWTG/k/E=;
        b=hFXvkqGBiBUrZybaMnV+2TUApt/lSyhI9Yl/bluropq7SAMeE4i6pMj91bY514EEOj
         bHOjiULr7buMK7lfIWFZAcYHtT08wxOgMVQ/Q20y4AJ1z+VB6OZMHhRqLUrlFxrtHDxR
         ag2nzagRpxxm9J93Ai/uXnLCzWpE/0DnGbT8+IGInVuXN940ylsUnBiy9MrFZp76ixRV
         eD5azTVPeNM1HSRC/iIEdYTSDRW4elFBPBlhQ0BA8rrskGwqvDa7lgFHdm0vXXajkh3E
         Stp9yD6nxHc190DfY9WkQvS/iFyBDbH1H0mHovqnGiazdQZnf/mzOY5bVLjYIJz/6RB5
         RNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765436137; x=1766040937;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6t10daDk4s6MyC0x15QD6gZ8aKnvB29UsDlKWTG/k/E=;
        b=mBZ8btagPF/2VyERkCE32VOhskv8L5QduaXFp+pxMI97qtF4MFoKqpn4Cxpa83Yd2R
         om0tlorfUsPa5VbRFBaA1qcncVXtr0OYU9t0lIr5tZ2Au6Qkwn/xul5BYhijP/cgZsG6
         bhVxm1RZ9H1UMRM3Ag8nLyiAUTGG/XaNhdITKC3rN1Z97gee+UyDfNQQ2cZc4s9xjrg7
         f7Kp/GdrNqsjUZJrY5QU5yS9IYfpiBN0Ia3UatlkE2FvwmurGerxRcMEDhYNFwnsXq3c
         ZC+mDk91u0U96lKH+umQC5x3UWuGHHx29jAsrLhpi5977loE1Zi7diTw04wQy1nDp5wQ
         tOBw==
X-Forwarded-Encrypted: i=1; AJvYcCXcZvbBRkax3tUdQq+ZDCo0u1cgGZ1rYb9GoWcLbbenuHIsOJEF2RcvpvQ+ADZ55VJF0Gbstl0cqNAnfM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsy184PEU6bWA5ItHxGpHvVoCjKV8orTN1y37HOIFfQNBk9vnU
	4DCI0ylVRp9u11AUl6HvKVXYBtaM0Ce0qV2tUn8NYPBT2epO7zj24ZTWHlyHRvRooloeSjgb9b6
	EPi1qgN4uKw==
X-Gm-Gg: AY/fxX5jQS9SGgsJqnahh4wTt4eFkFbU1VBVjJVlcnjyQcUmY/jS/d94aC5N5Z1eYBe
	0plVxPsRb22vXQH0ZHvC4sOwp9phVII63MikpSaizDzR17m9uL89CUp8mQiZFXuSPKi3MEGZ7Oi
	A83n/qTaYgF031ihMRjRZI6Rj1soCWuezQIj9WZZ3ritSAYliVbRfb703WTljMgtjZOLebat84K
	y6d+F0pwMLcrGlzwcJcFn+pq2tsdw/G6DICX3ULhCaMAUj83DzGrN08ro1QuqqO5EJ2Y+U672GJ
	qF/dwr/93pruirOUdXeJV61YJwUhWIUC5GvKVj6mNGI9JTwEIMhJoH8u8fuwhdCbHOuxhUriPFE
	EvMDnxAnarepM8JEijF8HtgeZ2fUHklHqtKZR7zQCqEhYk3/vYDOMEk4dO6/JyQS9DbcItP5aWG
	CUBjqwSConFWTYeUdnTDVlEuXY+CC2Vt84mjulwYXuIIsBdg==
X-Google-Smtp-Source: AGHT+IHUHHFmshekCKPGJ1PiCPmkblP2Uul/oBOBJ3dIy7RP641lQaQQSNppajm1f8fUHk1ABBOK0A==
X-Received: by 2002:a05:6a00:983:b0:7e8:450c:61be with SMTP id d2e1a72fcca58-7f22fed7cd4mr4627077b3a.46.1765436137376;
        Wed, 10 Dec 2025 22:55:37 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2d4c2eesm1455791b3a.29.2025.12.10.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 22:55:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 00/20] blktrace: Add user-space support for zoned
 command tracing
Message-Id: <176543613568.585204.16743933013509349658.b4-ty@kernel.dk>
Date: Wed, 10 Dec 2025 23:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 24 Nov 2025 23:51:46 -0800, Johannes Thumshirn wrote:
> [ Aplogies if you recieve this series twice, my ISP effed up badly ]
> 
> This patch series extends the user-space blktrace tools to support the new
> trace events for zoned block device commands introduced in the corresponding
> kernel patch series.
> 
> The updates include:
> 
> [...]

Applied, thanks!

[01/20] blktrace: fix comment for struct blk_trace_setup:
        commit: 7d93035f63e95a9ff211689a5ee5a9647fe4539d
[02/20] blkparse: fix compiler warning
        commit: ab25c60d012adc83a21e2ba9f5b7fe977aed5a3a
[03/20] blktrace: add definitions for BLKTRACESETUP2
        commit: de46aab777ceb75c9742a09f687e27c602f588c4
[04/20] blktrace: change size of action to 64 bits
        commit: de7027a4c293112b58f27681d3aa2c1706f760ad
[05/20] blktrace: add definitions for blk_io_trace2
        commit: 26281f82c94178e4cd776cfd83b7f6aae61323c0
[06/20] blkparse: pass magic to get_magic
        commit: a40c8fb0d1a56b0fb9bea1c45dfefb3d8376807f
[07/20] blkparse: read 'magic' first
        commit: 43da1fe08510a1c12c15b7a5829e62cf5a1186f4
[08/20] blkparse: factor out reading of a singe blk_io_trace event
        commit: d627b9fd563dbee65a56745b27cd94ba2a5d89cd
[09/20] blkparse: skip unsupported protocol versions
        commit: c1b026f5a0d9f0a537f0e9bbc727893046515334
[10/20] blkparse: make get_pdulen() take the pdu_len
        commit: 5653f26bba9e4969d59907a03853bac6ad29bb18
[11/20] blkiomon: read 'magic' first
        commit: b86ecea48bcb71406df046a1ad2f07a202ac0498
[12/20] blktrace: pass magic to CHECK_MAGIC macro
        commit: 5a4b378ef389584299664ead32185cc42e7eaeb2
[13/20] blktrace: pass magic to verify_trace
        commit: 4475f0f7212d543e54515acb1227504887ebc296
[14/20] blktrace: rename trace_to_cpu to bit_trace_to_cpu
        commit: c79c9cbe395891c64dbfd3c8814144e44058ef90
[15/20] blkparse: use blk_io_trace2 internally
        commit: 7e0e7630d31925f412bf653112de4a3ebef4f169
[16/20] blkparse: natively parse blk_io_trace2
        commit: 294b572943f6cfb355ea941af159fb1e8be5d503
[17/20] blkparse: parse zone (un)plug actions
        commit: d302cb7c8cfcbd9599ec266b68cbfdc5f755e646
[18/20] blkparse: add zoned commands to fill_rwbs()
        commit: 614c58fc23934c77f6c54522a329637e00e72212
[19/20] blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace
        commit: a7cd5b1b05e790c93894a4f00c548d214602d9e7
[20/20] blktrace: support protocol version 8
        commit: ece6cc27ec8b809a0227a9b2aa3ab229883793a2

Best regards,
-- 
Jens Axboe



