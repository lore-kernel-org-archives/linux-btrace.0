Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF82701D9;
	Tue, 25 Nov 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056304; cv=none; b=TMPeyZSmL3PvuivG3oqV2YjTsAraFLhYkHwMwhsykGACmNQFAFQpgrs7Lrd4bfBq6qJM7u4CHWpflJGalWnOhc0UIcFBJ8MICZUzHoMu8ELoHy4WjkVIZyquctQH2so/9bCpS0Ql7d1sxG594jJ2toM0+h+CRq7hfLJCB5DhHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056304; c=relaxed/simple;
	bh=8McdkRqxeeYXNUIsIlauh97SMadvf1GTfMnRSRXlTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi+KLcyKtqJIt9ARv9s0ZcCF0TgF02BkIzFrtedbJmGKc0Z7dQd+crnz8hrg+iGzynlpgmqfDyqksP5PIO8CL6aXJy8dHzMH6hc0zrmLXvTQ8A1q0H87NFQA9f23usZ5mP2pwCVNmY52jazs93dghOA5XoRyOAFJpyUFGnVk87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AuPbelo8; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AuPbelo8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764056302; x=1795592302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8McdkRqxeeYXNUIsIlauh97SMadvf1GTfMnRSRXlTU0=;
  b=AuPbelo8YbI9TNZi0YVgb4kIy9F+2ofrgvIHy+ln46rmYZ+gMNIiS9UO
   4L+3/NmtZg7SzNMeUqy748QLplHjIMvlDvRWtMjeDgfHPggrw9erHBjuO
   3l8w+QrN06U8iutrTOLoaH/I1chLTGp/teqk6bI8RKh4UIs8/T3Yz7sgf
   8HYuXLXZC6+I6aD5i/nkK19rVytzy6Jg4OmPGfftC6F2TmIQQdHXa4JVP
   sMBwRJDEQBvtvBGXWj31bSLR8gBuLJ3JnwpqTLbQjSHezGTokJ091RE9N
   NQzuvoQO227uLmCUgAkw+RFuVJyf5hsyQbVs9mYHqnCWuwV8EO2znQ0mD
   A==;
X-CSE-ConnectionGUID: puSJ7gHoRZy2w19bY/N5cQ==
X-CSE-MsgGUID: 6JXvp8AATLSWVLNnJYftPQ==
X-IronPort-AV: E=Sophos;i="6.20,224,1758556800"; 
   d="scan'208";a="132688751"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2025 15:38:22 +0800
IronPort-SDR: 69255ced_/P1AspMrNlCdFkyj2kK16/fEfo2J5YI1lVog8w31U5XSqYt
 yCmBBKMlZB9JysnR2GZhNqQ488NIZCLeqxZ8d6g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 23:38:22 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Nov 2025 23:38:18 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-btrace@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 14/20] blktrace: rename trace_to_cpu to bit_trace_to_cpu
Date: Tue, 25 Nov 2025 08:38:00 +0100
Message-ID: <20251125073806.50762-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
References: <20251125073806.50762-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename trace_to_cpu to bit_trace_to_cpu, as bit_trace_to_cpu operates on
'struct blk_io_trace' not on 'struct blk_io_trace2'.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c     | 2 +-
 blkparse.c     | 2 +-
 blkrawverify.c | 2 +-
 blktrace.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 373947e..9defa2c 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -487,7 +487,7 @@ static int blkiomon_do_fifo(void)
 		}
 
 		/* endianess */
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
diff --git a/blkparse.c b/blkparse.c
index 9065330..6396611 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2451,7 +2451,7 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 		bit = ptr;
 	}
 
-	trace_to_cpu(bit);
+	bit_trace_to_cpu(bit);
 
 	return 0;
 }
diff --git a/blkrawverify.c b/blkrawverify.c
index cc5b06e..8e863cb 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -181,7 +181,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 		if (data_is_native == -1)
 			check_data_endianness(bit->magic);
 
-		trace_to_cpu(bit);
+		bit_trace_to_cpu(bit);
 
 		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
diff --git a/blktrace.h b/blktrace.h
index bdea438..00edf92 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -106,7 +106,7 @@ static inline int verify_trace(__u32 magic)
 	return 0;
 }
 
-static inline void trace_to_cpu(struct blk_io_trace *t)
+static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
 		return;
-- 
2.51.1

