Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4242FFFBC;
	Thu, 25 Sep 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812729; cv=none; b=lDGcWDLMWBBU2sZ/jRmK23/bnpAHKdjiWKrjSpuCkC2P9mkUKE3Y3s+KtbUh4viLa1CebQkVIIJ2XJNJoc8NUsS0NtE2kP2FovbVYKMEWQhnzQsUcb1DmK+q5sQu6KDUC3VxgniaS8zDMEIvfatQ9ueys2WyBmEmhfH9uwaKg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812729; c=relaxed/simple;
	bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur54r5J0CsCF2m8Avchroof/lPANlflUlbcTf9zbziVjwsVmn/kM9S1StJ1vTY2gxGvHfoEOGyG+yWQcY4AheZrR7I+WurMa11Bt3OJ4vhm67eJUmNHK6tJb7iVDamT0Tyclv90MPVBVDDxcw0snPPHOQzsnPCuPWqI9NnUQaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=igTyGsoY; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="igTyGsoY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812727; x=1790348727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7x/8BV1VwYtiCopSTQrOJDK3TC6H2EX5xtil7lp16lM=;
  b=igTyGsoYDoN868rBu06/wgziuyPtFGnCL0H6UJtmshcS5Ts65AWHRqAn
   u5EwLLTD9dkA3XnL2PM+MfriAhdnGcMhH98ivFhO7azDFeexSbolq629v
   9Xmk2UTaGJjLbVDreFP4HJIG/XKY+r2kWngX8XAowar0onelX520Of1KM
   sdpIxUZHd3Tp9DNH0Lq0rKcbSbndGNUtM3U1bLK3tPWolusVpZy//+8B6
   02c51U8u1IQex54lHWsAjlnBHh7FUsCiCFLv9cSkJPLKAJPgQjaod9vqu
   It4rVssrN0K9oTLbeKb7D1U0Gabx2xeogs/r5Kp18OUkVj8LJopWrQUFN
   A==;
X-CSE-ConnectionGUID: mlemonTpSIqBVji+7tT3Cw==
X-CSE-MsgGUID: 9TqwqN/uSOyNq1T4JmBnIA==
X-Ironport-Invalid-End-Of-Message: True
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349156"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:24 +0800
IronPort-SDR: 68d55a34_myXyFOCM/XMWb8kc68vzIKEPH3ww/JX5k7+Xsed9AQryGT2
 +8uAnEvFL1tKaeqgZHxf7apfTBKcjR12vNSu3Mg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:25 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:21 -0700
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
Subject: [PATCH blktrace v2 12/22] blkiomon: read 'magic' first
Date: Thu, 25 Sep 2025 17:04:17 +0200
Message-ID: <20250925150427.67394-13-johannes.thumshirn@wdc.com>
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

