Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB143144
	for <linux-btrace@vger.kernel.org>; Wed, 12 Jun 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225175; cv=none; b=hO7TvgSR0Tuny46co4J1gWuX5c6tGFtzGQfdfyaOmKA1dX4+Q+uuMQ1YclfcTyJ11uHFDGJh3N0vveQETwr64f/X0Y7MF3i5FPVYwqPbtXfS1LfrDhqHW30IDCoYruousHYa4ESGbRNpeBEmhiGpqAKEKqiEw17tuLCA66uzjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225175; c=relaxed/simple;
	bh=ZV9sixeVQgzQr5s3Z98ZYzt76+B3v82cR4fBYwZ8rig=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CD4Gem/K5dgoWtB9iMQ+to82ysOWqw5HR0rogYH17Rj0lBu74xy2cPwn+dIRvvVVRuMKYnaumdyQ9YET9dB1Kl8Mt65t7ADxxURpfrqZHW5TmgW/huesq7qb/tzr4H3eiU0cn1F9XMViIEFq1JbetlNDwkE7rGSFJfRVafMRwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RgUrcg9s; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RgUrcg9s"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4c043d2f6so277425ad.2
        for <linux-btrace@vger.kernel.org>; Wed, 12 Jun 2024 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718225171; x=1718829971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNEMaaxBCuk2GOH/9uJ3tXMim0wZYvxundcHMAAnmOM=;
        b=RgUrcg9srto/xofqIBjmrZHXONfMXZSp7vQjuIUQ8sCMEAQb8iPERY8XL6Is7qwJ8w
         G8vhZ+2SU/aaSD3zgi9e5+RbZAbnwmDI8CAjNu2t8GnlModoZ6/VZcdPRymsSjvuiuu3
         KDfemLKOC94FOY56bIJGHjGDkk3BXwyLSmma/89adwoPvQIPa+CmVGDy0de2adlZqBp2
         qt/tj5GDxgvdnjQwRyW6LSZjQhErJOEoniDN1tSv1AHxz0Ubkb7z0hiXgBYJtnwJeq4g
         EMia55tEg215ucxib3aiXni8rMSQL1OkkVlfq2SlFbqOfvXuO8ZomajTAOWGXMEgmWPe
         jTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225171; x=1718829971;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNEMaaxBCuk2GOH/9uJ3tXMim0wZYvxundcHMAAnmOM=;
        b=B62JgeAMZNRnalkV2WmtIrqEknbrxLPQ/AXdpyfe8s4bTpqTL69RfD36tIOypCFNjz
         6qXDdhHMXXzdCbOHP1Eu1pjBvOq7ur0pjZElum7P58Mi+ckkWy+vu/jLngC35n2m52Av
         jIofJCUXxC3whvM+G2NPWn9D6N/IOZh7vSZkaPsMxkJ1hhMinQjOMqAJhu9I0YDTPqvR
         mD9k3gZT/mn5wyxgmaHGXKbx1J9gO5i2J81GoWM3ZoAQnsntwOnoeJgDV3ni1ugQOy3E
         3SAscoEzKkVdO/0RZ60ENK8CKpVLl+EFRl6YasfK0ZNJDWViZLE8+SR/8zwLq1YMz+Ye
         OfBg==
X-Gm-Message-State: AOJu0Yx3hCH7ayQQu3xesFIMaktRxZhh1GSWm7VCw54UTg3ueMKm2oTX
	MFjkeC3bC8WlH9v244HXQ9FG+omnubHVR5U8kuGVd0UKH2OlnPgh56HGTdikURE=
X-Google-Smtp-Source: AGHT+IFbktS1VkgFmetrdRUtqYrAczvjKhGFP/1TrSaS09CRmWcRSPMSbNvtZmuAWoxEcYarCbRAVg==
X-Received: by 2002:a17:902:f54c:b0:1f7:1687:3037 with SMTP id d9443c01a7336-1f83b769f6cmr32966395ad.4.1718225171378;
        Wed, 12 Jun 2024 13:46:11 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:728])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e1d5asm127375745ad.217.2024.06.12.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:46:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrace@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com>
References: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com>
Subject: Re: [PATCH] fix hang when BLKTRACESETUP fails and "-o -" is used
Message-Id: <171822517047.127275.12759676507781703230.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 14:46:10 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 05 Jun 2024 23:07:27 -0500, Eric Sandeen wrote:
> # blktrace -o - /dev/sda /dev/sdb /dev/sdc
> 
> has to be SIGKILLed if BLKTRACESETUP fails for any or all of the devices
> listed. (I simulated this by just catching one of the devices in
> setup_buts(), skipping the ioctl, and doing ret++).
> 
> This seems to be because with "-o -" on the command line, use_tracer_devpaths()
> sees piped_output set, so we call process_trace_bufs which ends up waiting on
> (!done) and "done" is never set. i.e.
> 
> [...]

Applied, thanks!

[1/1] fix hang when BLKTRACESETUP fails and "-o -" is used
      commit: 1836be5d99c9362f1e2b39206c95270f19cb7faa

Best regards,
-- 
Jens Axboe



