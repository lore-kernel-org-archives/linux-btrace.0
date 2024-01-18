Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4924B4E
	for <linux-btrace@vger.kernel.org>; Thu, 18 Jan 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582819; cv=none; b=Gk20MmVN6llcVdLF0b7etg2JJUy9k6pHq363yIvs6eFXnjMRNYU2ZEjbR4i8PAkWaLOlSGcCF4bwPGwHiz8nY2EUvY0fLcYHDiEFjPfbY6UccgDAC7PsXX4YeuCE8AUMl7IUAtLfgn3NIGEiLEa8BdQSj0g8b146xq44zNrNYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582819; c=relaxed/simple;
	bh=7cPDjdce8RS1vwMNq0ypPIO15bjrUBTVBcxulKn2mME=;
	h=DKIM-Signature:Received:Received:Subject:From:To:X-Mailer:
	 Message-Id:Date; b=dNVUJ2j2lw0mnJ6OP1mj1CLLe/0iawGl77Npn5KEbWaZiDo0Hp5m3xyePTrysJPwSn1kvIkDf1BhqV9MRVboyZD9ckIUUGM7XR0U3ikMbhlWKBF3q3unr1f+DWa6i6U3zrglGE0uYkB2q8l7N3KZwy9+zdkpj/s8jEGAelr0z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=fail smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IOuPDJIp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOuPDJIp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Date:Message-Id:To:From:Subject:Sender
	:Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=goLLVd1ya8z/KXZeguvCC/L+BRHBJ65f1piXnPsxfBE=; b=IOuPDJIp0iPc+U08iu7LVjhx2g
	oW+kA7GOuuHDxnyJJ40n/OjNuMJjMkNeShDxX7KGqixZSGApQ63LbM6ID20ZBNHwGLvjBrM5MKWRn
	x8SemTKXRAlBmx0gd+wSJ4I4bDtuzZw45yRoh2V9gIxMUk4KTa+1KxJSvovRgWkIXLnMMvnUdUjRX
	8bdJgfZXVyBBmxWjQgRctjRnVguVszWETkDzTfOZeliZeQlb7Joidf2qmFA3YDTdHb2jfsHMlu5pF
	1pQEbWsF/fmSpNw1yadNssaT159TOYC+vh60s4gbqJFiYd2Jf5oVTvlshk0sdu0m0ZcP88bjSLKaS
	iXM14NfQ==;
Received: from [96.43.243.2] (helo=kernel.dk)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQS05-000000012NI-0RMp
	for linux-btrace@vger.kernel.org;
	Thu, 18 Jan 2024 13:00:05 +0000
Received: by kernel.dk (Postfix, from userid 1000)
	id 3C7E41BC0145; Thu, 18 Jan 2024 06:00:01 -0700 (MST)
Subject: Recent changes (master)
From: Jens Axboe <axboe@kernel.dk>
To: <linux-btrace@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.7)
Message-Id: <20240118130001.3C7E41BC0145@kernel.dk>
Date: Thu, 18 Jan 2024 06:00:01 -0700 (MST)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>

The following changes since commit 7f5d2c5173d72018aa29c583c9291ef10abaf8df:

  blkparse: fix incorrectly sized memset in check_cpu_map (2021-10-21 08:45:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to b9ea6e507e8849f01d06aa48c0c59c5cee4820be:

  doc: btrace: fix wrong format on doc (2024-01-17 16:02:23 -0700)

----------------------------------------------------------------
Fukui Daichi (1):
      doc: btrace: fix wrong format on doc

 doc/btrace.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/doc/btrace.8 b/doc/btrace.8
index a1f34c2..2080e6e 100644
--- a/doc/btrace.8
+++ b/doc/btrace.8
@@ -6,7 +6,7 @@ btrace \- perform live tracing for block devices
 
 
 .SH SYNOPSIS
-.B btrace [\-s] [\-t] [\-w \fIN\fN] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
+.B btrace [\-s] [\-t] [\-w \fIN\fR] [\-n \fIN\fR] [\-b \fIN\fR] [\-r \fI<dbg mnt>\fR] [\-a <\fItrace\fR>...] <\fIdev\fR>...
 .br
 
 
