Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19051125A3
	for <linux-btrace@vger.kernel.org>; Wed, 17 Jan 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480634; cv=none; b=XKyIuLu16U/J/IsPPQISpX8g4sY+486/bmVifmcYUSuhhnK9jMpsK+r1/DJWf+YlOOZCIk+uhgcHdbbENFdLwYE3DHEtmIsRY/niLLlReLn1IxRh1b958D6zTSD6IYDE/8GLr5qkfiryIN3fF0TEkNa3Y3VjUWHP+Kw5xJNdqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480634; c=relaxed/simple;
	bh=SS+TAcyo/MgIu5butqYqrBlfI0hmx7zcKOLux0DM/rs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=jLh9mchByOMDaEXdVC1FfTT7vLm08IKGxYhNhbuvULwKQyrFt6awC1TV05FMEQapOI+Pxk7z5OOUbcPppB2QDshy75FXPcyqmBC5fRe+6AptJOtpZN4CzcSqodqnb7qLXp0S1NDqafnQq8XBd2uaMXMbnYAAmP1Z10KgilsPLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=akane.waseda.jp; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOfHSTMa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=akane.waseda.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOfHSTMa"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b23698c0so777194b3a.0
        for <linux-btrace@vger.kernel.org>; Wed, 17 Jan 2024 00:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705480631; x=1706085431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vy1c44NWsuctT6RA7K6rypvctiqHAULnEsO4QKFeBs=;
        b=HOfHSTMazBl0IO+RNhcvJGdRfmwMG641n8ulPoMCpmOYh73wQhEPIWhVy8poCPWGQb
         W1Z0iLv80ZjA1nKi2FEYCS8LuOGA4YLPXNDcAGRfQExlBePybx2HdowmiU77Z8LUBRcI
         ORIj+sOhP7vXaA0hWtBYZRDgoyfX5Rz6NB9vjW7k2BvK/GLnxvJsEyS811PAOjcO4Cz8
         Q/XMGQ0funQixVquFL6YJ4Tfk2LfEm3Le3k5Z2ahtjKBDAicwj5aFnQOhWvBQ4Mrik1l
         HnMvmGVfc6hTEIfNePX3+Ub95XatYOqRNz3wx/1ud8AT1U4vAjuxi2V8W11CnlbLYQkJ
         I9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705480631; x=1706085431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vy1c44NWsuctT6RA7K6rypvctiqHAULnEsO4QKFeBs=;
        b=cxmqIIMIhoRafP1ca4xtxyUhL2WwpuOcb9JtVdRHIoN8z/zfIRGwj++4ybxgkbWDcz
         Lr6Mj1qeOuYPibYOgacem4GrXhuH/vM9EHsGi9J6L/mCpgFSQzHV7XeEc6lfpCG/f18x
         bjRjfmYfKpMYJNmiBJqum52X9F1s/xR0L09sCM64nOTs2r+jJULyiAvt8Bo6feAAhgI4
         yfSSa3y433IlXUrCzyzdr5WKeyurNj+BQzOrekMWpiVbJje9OgDhcYyzV/CTEFTwhbED
         rAUc18Os2ZWMEB1/9BEaGrNnvxC1iKYaOcHwjOEWuv6GqCQVF0u64XykbWPunhq1aRNe
         WFsA==
X-Gm-Message-State: AOJu0YwIiwySYE5WtHrnLjxmb3OYn3YvrmfGO9W0PcH2K/R8I1UqpHlT
	pXDjqLiueiPLAUewUBCYXujE334RetTLyQ==
X-Google-Smtp-Source: AGHT+IEjA4u3vfhmHs++AL4+aSyd7x3OYlgHX8LulgWXzWk7JiOB7HAiglkCZ48EiNLX2A9jS/hH9w==
X-Received: by 2002:a05:6a00:939d:b0:6da:83a2:1d9a with SMTP id ka29-20020a056a00939d00b006da83a21d9amr18364101pfb.1.1705480631069;
        Wed, 17 Jan 2024 00:37:11 -0800 (PST)
Received: from localhost.localdomain (M106072130065.v4.enabler.ne.jp. [106.72.130.65])
        by smtp.googlemail.com with ESMTPSA id h20-20020a62b414000000b006d9a9727a8esm893699pfn.178.2024.01.17.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 00:37:10 -0800 (PST)
Sender: Daichi Fukui <when.a.cat.sits.beside.you@gmail.com>
From: Fukui Daichi <a.dog.will.talk@akane.waseda.jp>
To: linux-btrace@vger.kernel.org
Cc: when.a.cat.sits.beside.you@gmail.com,
	Fukui Daichi <a.dog.will.talk@akane.waseda.jp>
Subject: [PATCH] doc: btrace: fix wrong format on doc
Date: Wed, 17 Jan 2024 08:36:51 +0000
Message-ID: <20240117083651.954-1-a.dog.will.talk@akane.waseda.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The synopsis part of the btrace documentation gets highlighted with
wrong format. Let's fix the format. There is no change to the contents.

Signed-off-by: Fukui Daichi <a.dog.will.talk@akane.waseda.jp>
---
 doc/btrace.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/btrace.8 b/doc/btrace.8
index a1f34c2..2080e6e 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -6,7 +6,7 @@ btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-w \fIN\fR] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
-- 
2.43.0

