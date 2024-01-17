Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE828DA7
	for <linux-btrace@vger.kernel.org>; Wed, 17 Jan 2024 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532581; cv=none; b=ZAP9y2inp48mlxxWpIqXARzUFuP/ksi7JnMkikcj6BqVn0zdtoQi5A2N30OqwS6dyxuYc+5WdHVTt+Hb8SwfvYShGXl4N3UNnDwaXzOtFFz9vqGzJ52D8xgIksE1yyeKHCatzRRx4J2mRff8j8Kpq0OK2eR72xOG/cWpjWUiaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532581; c=relaxed/simple;
	bh=7Nrw6iw/ABNB6L36giGtcZh1VaAZLpEVCwAo7+eaa/c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=tnj2X/DpF27pAW3BZg/QPqnPTQaZp33k2Z0vrAjhDekNnlyaXSku1TRAsjgsPL5pUIHxTgoxyVJWydyQqTHk4pgM+ego5NQGY+cCFU88UI2ExDybiJvQuL2lv2FUYWPEsRPYhpTVGPTPsXUA1sgY1jqhxObo6ONEial9foriayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WHxhW/Nn; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WHxhW/Nn"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so59592739f.0
        for <linux-btrace@vger.kernel.org>; Wed, 17 Jan 2024 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705532577; x=1706137377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/dsZxsf+Ng8auhlEwlFXiCZObxUFDD85a15F5BIADc=;
        b=WHxhW/Nnn3hKLYbbwLh+RJOomS3/BpiIDUtU770ZqgEkFIsqRe7VlbLD2xXnhnqwhO
         SDE4gIHll5XBvh17JzIF/QCC3AOt2DB7+FSdmNvqkpEK8TeLNj5HRzfawqTt7ptcjqVo
         NzzCertWj9lpkafX5/+WvAAte6FzTlDEEkyQj9xRr5KLdSZt+zgiTWxIGkVscf9W6J/X
         8yNCkKm9LEnsAP4U2xuFXHTad02J6hwwVgbqGnMnYNCcLgBUNjk4NTj0zbk7ko1S0ff4
         4Z7I81nU+Hypjx02IQDz2vlTx9D7xmNDdjdxJbYWoOcF0lBk/KP4LK0c+YCrAgvFImEE
         xz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532577; x=1706137377;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/dsZxsf+Ng8auhlEwlFXiCZObxUFDD85a15F5BIADc=;
        b=OZpoVDJWh0R5cQRBdBY48wOFBPFK0I2uxoXOLAH3m2Wp7+L5ZVV7aboaioHBZSwiod
         XaKBXPn+mhc6THsmYNGt+MlGZegtG7tsU2NR7lBfOGhB5EqHe+hPZ6ho7X516zVdin5m
         bYJvJhap7Y6Wj3/UccLjU+9JCs+RwkO+XTXc+YZgGm/r+VKlbM8Up0iFke0LEdAxBsEb
         WA9YNF41JLmq1iMJ1hZdBzE4x7e/g2tJqlvVYuVEKdWwBfJbM9yBi90Hcxom64DLBTDb
         IXFrrKYJAs6OnbjLbNqigGjAqvzcNkHehYOyRkBvtv9+4p/mq0t10j9ptfD3MBoBOU6/
         JVXQ==
X-Gm-Message-State: AOJu0YwoMAEtywmwAVchyxjm2kJS4er0Gqck02F6znSG1R0caYlMSFpw
	Fo0MRLYAMhPJITUP8EI2A2mxqL+9Ui9lOrKLR4RoP/8/FcuSZoiYVhEIEz6wQyc3LG3qMjiUTXQ
	zfIw=
X-Google-Smtp-Source: AGHT+IHHyR0qXB8cpD3sXIik6S2uKNAVrwbeTztW1dzXJSfcYXNHfYooIkST+bzcQ1Yag32nzrnHKQ==
X-Received: by 2002:a5e:da4c:0:b0:7bf:3651:4c6d with SMTP id o12-20020a5eda4c000000b007bf36514c6dmr74383iop.2.1705532577363;
        Wed, 17 Jan 2024 15:02:57 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm660238jab.40.2024.01.17.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 15:02:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrace@vger.kernel.org, 
 Fukui Daichi <a.dog.will.talk@akane.waseda.jp>
Cc: when.a.cat.sits.beside.you@gmail.com
In-Reply-To: <20240117083651.954-1-a.dog.will.talk@akane.waseda.jp>
References: <20240117083651.954-1-a.dog.will.talk@akane.waseda.jp>
Subject: Re: [PATCH] doc: btrace: fix wrong format on doc
Message-Id: <170553257653.797202.12304676152267000923.b4-ty@kernel.dk>
Date: Wed, 17 Jan 2024 16:02:56 -0700
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 17 Jan 2024 08:36:51 +0000, Fukui Daichi wrote:
> The synopsis part of the btrace documentation gets highlighted with
> wrong format. Let's fix the format. There is no change to the contents.
> 
> 

Applied, thanks!

[1/1] doc: btrace: fix wrong format on doc
      commit: b9ea6e507e8849f01d06aa48c0c59c5cee4820be

Best regards,
-- 
Jens Axboe



