Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C2144D3F
	for <linux-btrace@vger.kernel.org>; Thu, 13 Jun 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280015; cv=none; b=Z9v3eFBm0vGcRcyB7McmxYkozw/OZfTOAXXdUVwqPlsj651B2KAaMWpHfe0uMtQbkAEH3y3FffiTHJcZjLYpev80GHVEhcMbETvppyAbrmrvBslJMdbq6ahR4vkyEttsAK6SbXf3nkH2j9e1EfZAuZvPTbLyUqamPyMv7UHaOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280015; c=relaxed/simple;
	bh=hNiWzodJS0GFdkRB+qv/5NWB1PnyBmCH5rSHYK1AUAA=;
	h=Subject:From:To:Message-Id:Date; b=jctCz7IoUYaRFgnhVdBfE/PXrigyVkV/5OYTWA3obm99Rs6BV3m30OZDBUX634vG9/TOwd6YuJEnnmhFGn2gPAqAeQn0nBQew7jmdFvMsrsmnqNAUP833NWj6M1J1t4qh1JCpLtd7kubYSorSX+Mz6dv9iFolnomBJE4VjzJr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=fail smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IrHWvb0W; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IrHWvb0W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Date:Message-Id:To:From:Subject:Sender
	:Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=c/1xpEhluZ5Psufqv2BzP5BVZZk9KQ76HF1EDEmn1O4=; b=IrHWvb0W25s7uypn6JHfhRVePF
	l+gBNheOkVpSXpq9cdPIfDasENtRxTEv7tfYCa6qN5eWdxp5a0hxkBl+vT7FLirvqU2fdziclZtdE
	LOSb8zXjyQw7EApyyUnAU73Z2oEPv1YxDxrrsJr9S0ZLbN0wvJvFKfrGK41aB/c/Ah80JPyGHA6E2
	/6NbHbOTP6kJtlOR0Ic2/n57rEMqLB/7MCp0nenVCgZj+amqhlP0CAwYlGnDfj6jh2xPzPiYv6/La
	jY2ahDKr0KshvB2E14VkSoJiF4jlqO6sECmE0+QUE07NwcvNSGz7NVmAFk+f5HX2aA5MkbQwfqBPc
	1WDlmsZg==;
Received: from [96.43.243.2] (helo=kernel.dk)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHj7Z-00000003aCc-0fgl
	for linux-btrace@vger.kernel.org;
	Thu, 13 Jun 2024 12:00:06 +0000
Received: by kernel.dk (Postfix, from userid 1000)
	id 19F161BC0123; Thu, 13 Jun 2024 06:00:02 -0600 (MDT)
Subject: Recent changes (master)
From: Jens Axboe <axboe@kernel.dk>
To: <linux-btrace@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.7)
Message-Id: <20240613120002.19F161BC0123@kernel.dk>
Date: Thu, 13 Jun 2024 06:00:02 -0600 (MDT)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>

The following changes since commit b9ea6e507e8849f01d06aa48c0c59c5cee4820be:

  doc: btrace: fix wrong format on doc (2024-01-17 16:02:23 -0700)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to 1836be5d99c9362f1e2b39206c95270f19cb7faa:

  fix hang when BLKTRACESETUP fails and "-o -" is used (2024-06-12 14:45:58 -0600)

----------------------------------------------------------------
Eric Sandeen (1):
      fix hang when BLKTRACESETUP fails and "-o -" is used

 blktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

---

Diff of recent changes:

diff --git a/blktrace.c b/blktrace.c
index 3444fbb..038b2cb 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2684,8 +2684,10 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts())
+	if (setup_buts()) {
+		done = 1;
 		return 1;
+	}
 
 	if (use_tracer_devpaths()) {
 		if (setup_tracer_devpaths())
