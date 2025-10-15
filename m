Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB431C588;
	Wed, 15 Oct 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525703; cv=none; b=C1XNg8SXWTIbXA+EIHlvwLHzj8LkcMsn67SqCnWICjaAYkRVITRaIJezguo6cYlSkXKNUQt+7EUcuyT0AvW8N/C4PkyUdBum2Stt/rm3heOzgIymki2U4JHWSfapb366OmPbeKOXBA6C+rG/Q7l1/3nK/eKaiIsFF21alqyXJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525703; c=relaxed/simple;
	bh=cRZvJizN4tgFy915/GAfu4RFBsW6lFtvyycmhNBSCD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaFcPP1ZwXzj7N6g13N5TURreeKHmjMsXRGKT/7jvJEhP8edNQVA86lWxB2CDOiO7IBaobwsxYv7JbkIA3Qr9hJ7Y587gPkMHfAgfafjzvAddm8Q9L02H8VmF/XjPKvU68XgAmaVVtCsfY6Kr+F6024J7FPuVpyD/WblVbUqHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dxADJE+K; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dxADJE+K"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525701; x=1792061701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRZvJizN4tgFy915/GAfu4RFBsW6lFtvyycmhNBSCD4=;
  b=dxADJE+KO6SXhtZflzKdTYqOYp75lcD3qom700mhX8amScd6HUIttAwr
   qDlI3hD7ztqfrgaPlC0hs1OT1yktIu3sCuAjJMMSbcJ9CxLg9MyC5+5cW
   0Q0fjKU9IcASvQBBzdXhXtiLgHgJz1ARYEYz9xeNZ4zrsZ1KE9becE3sb
   e+HTVP3XW7C3mFdFNcJkTGMTxqM0ijAoXk+QY7YUl01Lm5HPazyXc6Byt
   QmpFn9xlXLAY9vW2nfRlUK2z1oQ3i5NoYWi4yPR2UrRqgi/Gc+XmaT2U7
   qHpXrd6Epj4y+baJ23XznprGSBcty1cpLsa31FOImU5wCDT5TlF+6vOVN
   A==;
X-CSE-ConnectionGUID: t9ubu4UGRiyK0tpP9Y9MRw==
X-CSE-MsgGUID: 4Y0o91TMR+G0JgsoRUYF5w==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="133261999"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:55:01 +0800
IronPort-SDR: 68ef7d85_T5iEa3Evy0tcg3xPeAQurkMsvrgTGeTtMqpVcaH8CPEGsjJ
 WyZ+93AH0mcI928MjM9w+3zR1Hv2KjW0RAVdASw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:55:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:54:56 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: chaitanyak@nvidia.com,
	dlemoal@kernel.org,
	hare@suse.de,
	hch@lst.de,
	john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naohiro.aota@wdc.com,
	rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 04/16] blktrace: untangle if/else sequence in __blk_add_trace
Date: Wed, 15 Oct 2025 12:54:23 +0200
Message-ID: <20251015105435.527088-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Untangle the if/else sequence setting the trace action in
__blk_add_trace() and turn it into a switch statement for better
extensibility.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 51745832c713..11e264f67851 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -278,10 +278,19 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	what |= MASK_TC_BIT(opf, META);
 	what |= MASK_TC_BIT(opf, PREFLUSH);
 	what |= MASK_TC_BIT(opf, FUA);
-	if (op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE)
+
+	switch (op) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
 		what |= BLK_TC_ACT(BLK_TC_DISCARD);
-	if (op == REQ_OP_FLUSH)
+		break;
+	case REQ_OP_FLUSH:
 		what |= BLK_TC_ACT(BLK_TC_FLUSH);
+		break;
+	default:
+		break;
+	}
+
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
 
-- 
2.51.0

