Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850222DC5D
	for <linux-btrace@vger.kernel.org>; Tue, 14 Jan 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847302; cv=none; b=b1aaElHEDR40Wgyf40N+YbT2j6nb6MTaNjmEFErJwG9TtfXpbkch4em4knL9a/3x5UnS7PCEK1unXqdK6q6KmGH1BprUXJnQhViZIkWQ6Oshy5miuWWx5zGY4Ncek4bBTeBoaZHvZgqlYdpZN+OtBgS+1bC/aR+ME7dK+//8faY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847302; c=relaxed/simple;
	bh=JtQ8cjMN0SoFjGVqS+zX2hFnQaqLeQrkjm0cFjOzpNQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ISZYDrdBXNMKerZ7qbr+nNV78UueVfRLW2DuOWJPQBu5dDB7dyD7XRKJd0CGogTGMIl5z+Kom06xX/v+gt5PxHOfWdR8NY0J1jDaEWCZt631j9cXgxWZBe2O5oOwqeDDv/ocBiV4kDEU0vdXsIJ6KESPtS/PTpn8Ce4AvVKUCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjslkXP5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjslkXP5"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3c3e38d0so686105e87.3
        for <linux-btrace@vger.kernel.org>; Tue, 14 Jan 2025 01:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736847298; x=1737452098; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JtQ8cjMN0SoFjGVqS+zX2hFnQaqLeQrkjm0cFjOzpNQ=;
        b=SjslkXP5mOylW8QDPAeLQeyVd6aLgx9PdkY2pPK3J330wo5cRohduDasgqASH/BBfT
         R25q/FBbCMsBexyqf3NZEVUvvTzXQOTKQ+qQTN5xwVWvoN1yvkTzBccZNFOEEf7pN6pY
         32YAwB8fNsF7xwZR4UcgciP84JRMoKSXVO2LXY1NNQ0x7OZJ89NMvK/5y0sbdKAWuh/8
         KA2cGOjGPqSqBr4oLt/KknW05tTz93H7wRVbeNqfETCBY1vqb9RD+6ptCwXNlHh3H6wn
         clhFoU7cHxh44o875UOkGzhIrpVQlYmtBWKKrpeZKAUNrH3ACF7wkueQQt1TbeOwgER+
         XBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847298; x=1737452098;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtQ8cjMN0SoFjGVqS+zX2hFnQaqLeQrkjm0cFjOzpNQ=;
        b=MG9/qkuO//dFK6y+GRWVogdXrllEiMLpXq3IHCUSgrb6BrKqLPrxnNZd5d+joGuov2
         aXi2jQU6C5kFmVBt/LuKoR7nM5ms/lTC0Q+2Jml3XxeD9ab+VXizKKMsmFgp/1oivzto
         faP7KBRwxkDCslEEf1HYUEidu18veEHLDB0L2q5ISVNEjgoZppDBT8s9LOCe+JyQXBj6
         84HAX5JNdKWCj5hKjW1AefBx8/cbvS6X+bqSqGTNn3JAGFUd9cKhiQUHUfu2EIte78le
         WiVZH5BnmiKPrVwu8oF9P1gVv6f2ADUNyYgjapY1ekLXWDjZey4NtZEQU4sy+CcEcRUr
         Sm+g==
X-Gm-Message-State: AOJu0YzRTmfxCG4/HFE6EfcG/8fxqk3Gj/rpKzn0YjhX0VEHbnkAaPtM
	FAJQf5SQ6S8nOKmgpA2kc28b4S8OjivoNKpH5l+XIMvww/fvOvBKEStr7CEUqdcXki0WUZsy+ED
	MLoNoYlIL8Yw7qP8qZPJAc30VSoU1zwZ2bd0=
X-Gm-Gg: ASbGncumo/iwZiQeKoQNU8B5VQh2tof5F9roLkseIAqkTCELfMdeSjLAg+MF5qNjq53
	ZysUsTYwR73/latrhE0GXS6X+Xy8p//2Z/G6ZLQ==
X-Google-Smtp-Source: AGHT+IFMWrW6iNRTieLQSwxMlM5ewAGuswGE4wwQjXFXcTCVicWMOQAjWbL0q9oyCqQ5OYTTpypRHF+v8Ux9ypJtV2M=
X-Received: by 2002:a05:651c:19a9:b0:302:289f:3c5f with SMTP id
 38308e7fff4ca-305f45d4a09mr26547391fa.8.1736847298085; Tue, 14 Jan 2025
 01:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: user Freshmaker <freshmakeruser@gmail.com>
Date: Tue, 14 Jan 2025 17:34:47 +0800
X-Gm-Features: AbW1kvYmK-hEw6rbBAlBXyqMs0dVyt57dy1JHLNCjL4Zn4yp21_X8hw5rH7m0CA
Message-ID: <CAPVOfWc8iz_Q4HE08pmDMTUvD7zvaTn=DNFLdTn750ph3VxgQw@mail.gmail.com>
Subject: blktrace: why it has not provided Q2X, X2G stats
To: linux-btrace@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have a question about blktrace, currently blktrace has provided
X=EF=BC=88Split=EF=BC=89 event capture, but why it has not provided Q2X, X2=
G stats, is
it not necessary or something else?
Any information is appreciated.
