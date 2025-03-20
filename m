Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275771581F0
	for <linux-btrace@vger.kernel.org>; Thu, 20 Mar 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468855; cv=none; b=VgdlUbXrhOsh1yxwO5EAubYdSn0hLu7PmnbECRKnyHpSp1uMoTjBLYuhhIAQDxTR3dK9pNWISR9+IKCdx7j+DDcljm8i6QusbMqq3Wrs1arEJro49G0EnJ0ly5UKzfXuq+e3OeXN5CsUP7SxtHKRo5FcPaVXAdhkWNf11SmlNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468855; c=relaxed/simple;
	bh=0iCxPuquqYrspKdpsVHqHuKRy+QRQUe3aEJRDNFEigA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DiNw1vxCc1zlgCXdsTG7ZpbG0E8vAGfexGpT0qiSzxO6Zeg1h/FJFKmWsBD191FIIPW7wCRkM7TynHCZ4Imxn5yLO7dVMKA5aGM/sBykgmfyPo1tRau/h35ppyrmo8SuuMZH0JrnikN1IRQV7dWYiXzmI9+8PwOPmYSH85o/ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQUGtm1R; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQUGtm1R"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b5e49615aso63690739f.1
        for <linux-btrace@vger.kernel.org>; Thu, 20 Mar 2025 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742468850; x=1743073650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41S9iqQTNLVP1qUQ5O6yX/Z/fN2HNulwaPQics5WIDY=;
        b=pQUGtm1RKK1rdAbXhq8EiHVETuhdYg0B+huBaaJAKPjOTNSBB6fN0IkXIE4WDn7QrZ
         DQ4tQM2gFQ45TrMEM/pFPdzFcCmBYWLks8ZaqxPlgkhy0DIt7672r60UCXmG0UwpMkWg
         qLVcbA6nw2p6xnEXd4DbPiglaEkx4BWtUwfK1PulNh4+fmS1KGeVqw0lT5itFVQU73M+
         ujcYRAl3ccO1B4YHlIhmy/I0r5NfmD7zt/iL19hV7Ch++Bo0bHrqUNbVoB+2mJ5gI1P6
         EO+Ko1Gq1aM9WzDE6kWf8XxfHw4fitf0e0ZYBXYv4UhDczu4mccf4MfP8cshG+FlLhgy
         ccsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468850; x=1743073650;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41S9iqQTNLVP1qUQ5O6yX/Z/fN2HNulwaPQics5WIDY=;
        b=v+NS5VfY6ABfKPAqt9cuEA793dSSqUmjHKs1TuHoo5eudwZe1wCp5EnZR0sVtD/ggr
         LwQ2y+hrLDhTKcbbftmASzGvmGcmb8+fo9lUJnlnMJLj8+Of5rlc5T/wwegNoX2caqer
         I8X3/buFnmbUnREW2dIrZsAGSQgdsG9Mgilb31NuC/jb0lNm7Czw7p7iGiVJPvJ+dQqg
         R8SC9YjlcT8uqv7TMITlETC/u6Fj0oypJQYwY3g1TU9zCpxTbYDEPNBWVWUi2D55YSYK
         ramlWVMCVNR9QukY9Bx7YCOqpFoQnqrlGFRbzXAz1xNaV7EDcp7mCtco8BRDwlvrNNEJ
         qmAw==
X-Gm-Message-State: AOJu0Yxxj2EU93dZ5R80fniwvhQS4Ayh8afyIR6G5/A8xq23nW8uwYCn
	Jz3WYOffqu/p86F4IFs8wmZ1iIjaWpUfMqI/cVZIOgAY5ZTgWEV1VTNCZpMS9W4=
X-Gm-Gg: ASbGncvjuy75J0PCb9pflEXfFDAHwIEHgVDRLVgRzx+WBlBVkh8X0VG8N0vxsNVwtKJ
	amrA7HyW+qOkWtuxUoby7WYlGZqTDWneVjR18oIPZiF4qlBfN0nVjEoVsnjWWPWTHX+73V5qpiv
	EHxpq7phbTMenSUwdbLxoCx5PkQmA7wHc7VMmzwr6igqgL4hDQ0zR+ptJegMJjleYtfA2lfCH3F
	eVDn1r91eS6qj3ZzLYPIdy1x4vdTUfeYvF6Qo7khYxU3UGvLHl08qJxxnBhxEeIns+rJ+WCLt/a
	WyRab5W7fhYS861tn+AywihOWcd/uvAZIjiy
X-Google-Smtp-Source: AGHT+IGAgsP+iyHQ+KOZVTh93k6IjGrPDFWevP0B5SpVO7+Vygw6IKtopyMKSYegNl2CwEUxDjFNOg==
X-Received: by 2002:a05:6602:6a8b:b0:85b:46d7:1899 with SMTP id ca18e2360f4ac-85e138473d6mr638614039f.9.1742468850239;
        Thu, 20 Mar 2025 04:07:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db8745189sm339197739f.7.2025.03.20.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:07:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrace@vger.kernel.org, 303146950@qq.com
Cc: Kou Wenqi <kouwenqi@kylinos.cn>
In-Reply-To: <tencent_DE806EEE1852F9E79115172254B8A2789207@qq.com>
References: <tencent_DE806EEE1852F9E79115172254B8A2789207@qq.com>
Subject: Re: [PATCH v3] blkparse: Fix a potential coredump issue
Message-Id: <174246884926.141685.16632673075725802151.b4-ty@kernel.dk>
Date: Thu, 20 Mar 2025 05:07:29 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 19 Mar 2025 21:02:49 +0800, 303146950@qq.com wrote:
> Executing "blkparse -t" may cause coredump due to
> accessing uninitialized memory.
> 
> 8,16   0     6092     1.436280373 20685  Q   W 15356912 + 4096 [kworker/u256:2]
> 8,16   0     6093     1.436282093 20685  X   W 15356912 / 15357936 [kworker/u256:2]
> 8,16   0     6094     1.436282735 20685  G   W 15356912 + 1024 [kworker/u256:2]
> 8,16   0     6099     1.436358617 20685  X   W 15357936 / 15358960 [kworker/u256:2]
> 8,16   0     6100     1.436359418 20685  G   W 15357936 + 1024 [kworker/u256:2]
> 8,16   0     6102     1.436359931 20685  I   W 15356912 + 1024 [kworker/u256:2]
> 8,16   0     6103     1.436360874 20685  D   W 15356912 + 1024 [kworker/u256:2]
> 8,16   0     6105     1.436436572 20685  X   W 15358960 / 15359984 [kworker/u256:2]
> 8,16   0     6106     1.436437679 20685  G   W 15358960 + 1024 [kworker/u256:2]
> 8,16   0     6108     1.436438205 20685  I   W 15357936 + 1024 [kworker/u256:2]
> 8,16   0     6109     1.436439368 20685  D   W 15357936 + 1024 [kworker/u256:2]
> 8,16   0     6111     1.436530404 20685  G   W 15359984 + 1024 [kworker/u256:2]
> 8,16   0     6113     1.436530842 20685  I   W 15358960 + 1024 [kworker/u256:2]
> 8,16   0     6114     1.436531748 20685  D   W 15358960 + 1024 [kworker/u256:2]
> 8,16   0     6120     1.436755261 20685  I   W 15359984 + 1024 [kworker/u256:2]
> 8,16   0     6121     1.436756476 20685  D   W 15359984 + 1024 [kworker/u256:2]
> 8,16   0     6128     1.437120354     0  C   W 15356912 + 1024 [0]
> 8,16   0     6129     1.437121875     0  C   W 15356912 + 2048 [0]
> 
> [...]

Applied, thanks!

[1/1] blkparse: Fix a potential coredump issue
      commit: f9bd00dfbd67ce62ca6df6f55d6275b523cd0b39

Best regards,
-- 
Jens Axboe



