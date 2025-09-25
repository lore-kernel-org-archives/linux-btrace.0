Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203273128B8;
	Thu, 25 Sep 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812705; cv=none; b=B/VK4qamV385BlNFoAI1pZw0W6y/sMUUQgw7hnB/CKZ9kY/sRtsQ8cKq0+WjdJTtP4/ijVq1/m+VsCktZd47etu1lVx9WyNN2rCjEozHALDZL6qwrSS4fhHiuzhScto1kgt5Xa3pQOFBJEGH8t4BWO6OVBGNf9lclmbyen5rH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812705; c=relaxed/simple;
	bh=oyYrdXwqykM5wRW6N9yWSSyE3TZgc1QhkApGxvOpN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwAR7/mxp9YVdWQsOE1SDK/orY5C7gajbIlOgOzkJbmtEjo4BoTVfR0NDFVa5O+Fx0/liNnDuLCD6bYiGJBk8hu5qQcR7xZJE+lssAJ28Et5sas6D2yA5F81MRfrGjg+EG0oygAiNjRhZSD+now1SJzHG3s7LGfC7HsYy22g88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c4DE0UhJ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c4DE0UhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812703; x=1790348703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyYrdXwqykM5wRW6N9yWSSyE3TZgc1QhkApGxvOpN8Q=;
  b=c4DE0UhJXmsb+xO2UkUG4QCVvPn4BzyJvBsXE0Xe8alCGVupCdtexBwK
   n+vk2EDZX3uR5SFur7omveTyi/iz4KOv8aIj57ML9O1vBglMnQph7D3uW
   onehyfeXIIGSuMadD3Igei6cmHaDWvjq/9r5AwcRq1Omp8EIrbqG8xmHw
   87N/tU0DXge7g50hCaU3ILQepjQDZ76H6b2T/g9ZePVT3JnXX0NxRUAja
   YEJyQbQZGKWNF+ZT/OW1kn4TH/MOULmUoldcZtrxHAnHHJMGRp4WVtM5C
   vFm6ELlu5E+wlJ0vvadZjnviIYwVDzniQ8OHi+PMYHejeI/R+/jji4sW2
   A==;
X-CSE-ConnectionGUID: +Vg0IXEpTYy24ueJqSveQw==
X-CSE-MsgGUID: XxL2Hd8dTPma7DD/A+N9Ag==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348899"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:03 +0800
IronPort-SDR: 68d55a1f_2wtJ6b+NwQ54VI/Is/D/LdGMQp0dqeFyLnLV1UbcIoDZrey
 jOC9W0b+ngpcjwKaBn3FoQVH/PiLaHDkiCRDhzA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:04 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:00 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v2 07/22] blkparse: pass magic to get_magic
Date: Thu, 25 Sep 2025 17:04:12 +0200
Message-ID: <20250925150427.67394-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the magic value to get_magic() instead of the whole 'struct
blk_io_trace'.

This is a preparation for distinguishing between two different types of
blktrace protocol versions in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 512a2d2..d58322c 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2420,12 +2420,12 @@ static inline __u16 get_pdulen(struct blk_io_trace *bit)
 	return __bswap_16(bit->pdu_len);
 }
 
-static inline __u32 get_magic(struct blk_io_trace *bit)
+static inline __u32 get_magic(__u32 magic)
 {
 	if (data_is_native)
-		return bit->magic;
+		return magic;
 
-	return __bswap_32(bit->magic);
+	return __bswap_32(magic);
 }
 
 static int read_events(int fd, int always_block, int *fdblock)
@@ -2458,7 +2458,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		if (data_is_native == -1 && check_data_endianness(bit->magic))
 			break;
 
-		magic = get_magic(bit);
+		magic = get_magic(bit->magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
@@ -2604,7 +2604,7 @@ static int ms_prime(struct ms_stream *msp)
 		if (data_is_native == -1 && check_data_endianness(bit->magic))
 			goto err;
 
-		magic = get_magic(bit);
+		magic = get_magic(bit->magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			goto err;
-- 
2.51.0

