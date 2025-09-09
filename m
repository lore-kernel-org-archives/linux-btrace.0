Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CEB322A09;
	Tue,  9 Sep 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416105; cv=none; b=MOMQlv2P5Z6EBeUGhMNal7Yn+soEjg0Jd9Vebm6Yc5J+eCeW0eVcl56QZ93aTsgiH9tkNn3Hoi9t9wRjnv0oeSsp2cNtV8iUeQw1t7KAVZum63RH9BhzPbo+7P348NV2bYgeCys2pu39KHF5PxOd0N+07IMuMwwzvFufgEH4GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416105; c=relaxed/simple;
	bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjK7LlZFXiMBqkYHYxb7jLZRKNMerQw4m/5zP95J8yhMbJipjrnsJUfziWInYUqbLijc3i9kWTu888QGH+KpKlB0zPL0OQxuhlypKe1TlZLM8hSmbFjgHzUgx996G66a1c95o4AUYIX4eF+UnMmMnbrXrIjRhKwTifqD5mTZcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EEJ8kQi9; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EEJ8kQi9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416104; x=1788952104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
  b=EEJ8kQi9wDYRnz+4lvNWqviHZQi+FZHqsj7F7vsM3XTssIs7wmT71YpF
   XyVwP4NhVNA/G5oZMB+yL/LzTjaxtcxcGEN19c/FQ6zrszvvhS4NS24RW
   9/LF6CiRfBQof6SG/cf/EG5g1nGwkRgq1VOo63Do/K3TRxDVoT9Un/R0h
   3AIAGhfFElHglp1ypl0ubgeUQ1xXbkNCDCgm4GOKuuPqG5vosdq+YhSHT
   LQeLxAC8ljul/0UZBv9zykYyFjfbIOhwoqP+vrgCkxfzdR8GoZeQCMfV2
   bezvMjCGn0B5dfmgHYc+s9pYmJSXr2V+n+jzmCPLBpPPea9r1NGvyF1qJ
   w==;
X-CSE-ConnectionGUID: oiYHrXUYTUujMcq1tmraaw==
X-CSE-MsgGUID: RQVxc5hXQ4+PVMVro1PBgg==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810740"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:23 +0800
IronPort-SDR: 68c00aa7_oJoHIW38v9jfTnRZD5eOKcOzHxDxgkn76XgdGBW7Ex2ajYC
 r2pUqfZ/EC69asZSxFHsvZXo+ck0n3oOBmiLZ2g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:24 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:19 -0700
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
Subject: [PATCH 12/21] blkiomon: read 'magic' first
Date: Tue,  9 Sep 2025 13:07:14 +0200
Message-Id: <20250909110723.75676-13-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to blkparse, read the 'magic' portion of 'struct blk_io_trace'
first when reading the trace.

This is a preparation of supporting multiple trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/blkiomon.c b/blkiomon.c
index f8b0c9d..05f2d00 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -460,19 +460,28 @@ static int blkiomon_do_fifo(void)
 	bit = &t->bit;
 
 	while (up) {
+		__u32 magic;
+
+		if (fread(&magic, sizeof(magic), 1, ifp) != 1) {
+			if (!feof(ifp))
+				fprintf(stderr,
+					"blkiomon: could not read trace");
+			break;
+		}
 		if (fread(bit, sizeof(*bit), 1, ifp) != 1) {
 			if (!feof(ifp))
 				fprintf(stderr,
 					"blkiomon: could not read trace");
 			break;
 		}
+		bit->magic = magic;
 		if (ferror(ifp)) {
 			clearerr(ifp);
 			fprintf(stderr, "blkiomon: error while reading trace");
 			break;
 		}
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic)) {
+		if (data_is_native == -1 && check_data_endianness(magic)) {
 			fprintf(stderr, "blkiomon: endianess problem\n");
 			break;
 		}
-- 
2.51.0

