Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D831D362B
	for <linux-btrace@vger.kernel.org>; Tue,  8 Oct 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394857; cv=none; b=DYRilyf4XD/dTdrA7Z6SpxKGRu+29PeTRSgsYDJIayydxzrMU7pEFGEQ7Pswqn1JrL/IyNewoLzm5FdoPtLuj3WikaEaMEbhSAdN0ToG5HnYChzvtNaradGsQ5KQ6MB0uqIdVQZwLqLadRPuPk6HS3yIN+clbAENp50wiOgl/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394857; c=relaxed/simple;
	bh=J5Vtkp4Cfamy6bw15tJK8yRCcIMkMIluHcX5RsVIIj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L9SRV4gc85kchiJ7+1a6mQNdLWtAE6Obzht9gz7nw7LomA5x/zDC08Y2JMfb1TkkXmPT4ajnotagqHO4EgWRf1nTDNaV3O+m4WyLfb3p083LTR8f59N5mM9DGxcWT30YlCYUepBuo97cgs/mB1Kn+IWQ8Z/Q8IQTziFdi1Z1tsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JnhnR5RU; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JnhnR5RU"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-832525e7449so408445439f.2
        for <linux-btrace@vger.kernel.org>; Tue, 08 Oct 2024 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728394853; x=1728999653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YnFhZcDMHfrRvWhnd39EGiAlzXAXX+zsY3SpupBNqY=;
        b=JnhnR5RUlp2yKi4IMECOYssk6Y/qlEP94BoseiGch8Xe4W+hDRz0leexujCS+nN0s0
         FbTK1BkKE0rESE2YS/JXpNfq/ShNHkjB07hv1WGoPh5hpktQJv7dk39Zv8+usPRXA+c2
         gUBMCJV6WrhhxoKfxGl4gTwBQ9zMzEY5sy5z2jXvJNpgoNHe9EQcjsaKb/hBQcdFvOBZ
         d0/xKP19jayJUHEpxsE/+CmM3LLEXPNBJu4T4ltzlqWQfsVWhCZpePh6LjVwNv7nPSw5
         b/he2GMXa5GF9n4pFT5znVhe17jknQk1wB8Ff0pMaH7nYCYK0OmaLNaonUIEYw6m1tGU
         XEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394853; x=1728999653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YnFhZcDMHfrRvWhnd39EGiAlzXAXX+zsY3SpupBNqY=;
        b=hyc3Mz5P+D4asC35DSVbHbGZJT+XcuiyWc9Mc1BPEkQiTrWxjw4oZdIKCS/OR6MdC4
         hjf+jyZ5R0TMLrG6Qu1eaVsyLduGpm82/buwq8VY82P80rpK2EmuLWmoHtzgX8NK/Cdc
         aStnSG91xcfPgruXQualj1FBEnJ0AFAkwAQo0fpN6PJHjBzbP+v7JtyHhNWMCLT7yoHd
         KTRTTJ7sXV6KXXOKasNvcsEObIuXr2GbvJgi+VlAlTUfQ2lZQugPwXEdiBES6VwLRfks
         UvsXVyRNGllDfbf92dfjvp8tqY8tNqOToJgcGE+XyrQkmfZ3NoH9jZ8aeAKXd3Js1A8r
         K1Rw==
X-Gm-Message-State: AOJu0YzlFvuKJO3LavkJ6KpTuvtaqugJcU8FkBOA8PQtPh2HCmM8njcq
	BwveHWRHLXyE7c2nNvTCuoQu+MJ/Oe6PbKPkw8JMI1dS4kCf7s0NQNa7atcu8Xj5sFUMphwBJmM
	/d4w=
X-Google-Smtp-Source: AGHT+IFMmgRGTaE5vVO1Z34IjMMMnFzKPMbLWXDEmj4Lmk+GKxv/bBysWcWxoKEa/wcnWjJBSfDTJQ==
X-Received: by 2002:a05:6602:13ca:b0:82c:fd75:813a with SMTP id ca18e2360f4ac-834f7c596f7mr1406506839f.1.1728394852658;
        Tue, 08 Oct 2024 06:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db9c9edd81sm90744173.79.2024.10.08.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:40:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-btrace@vger.kernel.org
In-Reply-To: <20241007211243.1351143-1-ipylypiv@google.com>
References: <20241007211243.1351143-1-ipylypiv@google.com>
Subject: Re: [PATCH] iowatcher: Calculate ios_in_flight per trace
Message-Id: <172839485187.8538.8017309803826696470.b4-ty@kernel.dk>
Date: Tue, 08 Oct 2024 07:40:51 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 21:12:43 +0000, Igor Pylypiv wrote:
> When multiple trace files are passed, the generated queue depth graph
> ends up adding queue depths from previous traces.
> 
> iowatcher -t blktrace1 -t blktrace2
> 
> Assuming blktrace1 has a queue depth of 8 and blktrace2 has a queue depth
> of 32, the resulting graph will display blktrace1 with a queue depth of 8
> and blktrace2 with a queue depth of 40 instead of 32.
> 
> [...]

Applied, thanks!

[1/1] iowatcher: Calculate ios_in_flight per trace
      commit: f49e7ded6405bcecd10846a614f40061ca6301c8

Best regards,
-- 
Jens Axboe



