Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226332277B;
	Tue,  9 Sep 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416096; cv=none; b=VzeYxBTbK85oPgRI0ifHZXqHTN8LOovK1ugbH8r7Rv2dTZtR6o+4tCi6Tph6kR1GOdiztJTnf0Umrzr/eVbcMwCjCkey1xJhyzdaNYEvg/zLBB29M3kUzCDmL0RI7sUnvaHAbupGEffNb2hmj68ZaTKRuHAlcaC9Ydjq/PZAcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416096; c=relaxed/simple;
	bh=WD43JFS2ah5FUpMh882JigJ3lZCVegi0OGYqc9+sTMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ExXxOWmcBv8CV1Y8Q24oM8/RN3Fp6pc8IpcMbPH8ayqdHQujJex8mzPmOUHPDaX+pzHVrJI606ZN5ZQGjL5utHFIlIgo/KzbAvCv1v+biygjFl58qQmbBWf5Df+EzIHLKcs0boWYX6op2djNdxrWnb8zBzvhjCXu8I2iIAWsKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UWg4VIiq; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UWg4VIiq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416095; x=1788952095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WD43JFS2ah5FUpMh882JigJ3lZCVegi0OGYqc9+sTMk=;
  b=UWg4VIiq+/DrxlUvLn0sLJzpRYUesb3lCRkpqpVwHtLcNU51jUGijMPX
   YptQzv8D2hPZ9B3sfys1uswIpiTIh7glBJzUnTY4ZR8/hTAZbPx1VHnsJ
   g7fYzJQzSwm/KOZ+CNcMZ/QZho0uBZFC5SvfZ2m00PZtUDbLMtcuHJjT7
   7pleqlZ58Tw5eQ9aM1HbpFas7MI5uQj8dPI8rLiU/S41W7CNQ2BUDDxAa
   ZZMXZed39xvVFJXdcl5fJVgeV04jkV7gvcZeyKEnPOIJTim1fuVCO5xOM
   iorJjc72VlGtSzfzWvb6qljlnwwUed2H3eVwQLnI+rJKqlrPN1j1KVz2Z
   g==;
X-CSE-ConnectionGUID: 5b3b7m0HTqGUaoWKz61ckA==
X-CSE-MsgGUID: 0lMDT4oDQlScS57VYUPVrQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810723"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:15 +0800
IronPort-SDR: 68c00a9e_qJypKtHc6qrLOft0Q58GttWUVa8fVxEhSHj6S6qpx88EdZT
 ASckAlFQhaa/xnkr7zNf3Q7HeFo2XzmUeZc2ftA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:15 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:10 -0700
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
Subject: [PATCH 10/21] blkparse: skip unsupported protocol versions
Date: Tue,  9 Sep 2025 13:07:12 +0200
Message-Id: <20250909110723.75676-11-johannes.thumshirn@wdc.com>
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

Skip unsupported protocol versions for now.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 136 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 76 insertions(+), 60 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 5d5cd48..0873c13 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2462,10 +2462,10 @@ static int read_events(int fd, int always_block, int *fdblock)
 	unsigned int events = 0;
 
 	while (!is_done() && events < rb_batch) {
-		struct blk_io_trace *bit;
 		struct trace *t;
 		int should_block, ret;
 		__u32 magic;
+		u8 version;
 
 		should_block = !events || always_block;
 
@@ -2489,42 +2489,50 @@ static int read_events(int fd, int always_block, int *fdblock)
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
 		}
+		version = magic & 0xff;
+		if (version == SUPPORTED_VERSION) {
+			struct blk_io_trace *bit;
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		bit = bit_alloc();
-		bit->magic = magic;
+			ret = read_one_bit(fd, bit, 1, fdblock);
+			if (ret)
+				break;
 
-		ret = read_one_bit(fd, bit, 1, fdblock);
-		if (ret)
-			break;
+			/*
+			 * not a real trace, so grab and handle it here
+			 */
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				continue;
+			}
 
-		if (verify_trace(bit)) {
-			bit_free(bit);
-			bit = NULL;
-			continue;
-		}
+			if (verify_trace(bit)) {
+				bit_free(bit);
+				bit = NULL;
+				continue;
+			}
 
-		/*
-		 * not a real trace, so grab and handle it here
-		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
-			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-			continue;
-		}
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+			t->read_sequence = read_sequence;
 
-		t = t_alloc();
-		memset(t, 0, sizeof(*t));
-		t->bit = bit;
-		t->read_sequence = read_sequence;
+			t->next = trace_list;
+			trace_list = t;
 
-		t->next = trace_list;
-		trace_list = t;
+			if (!pdi || pdi->dev != bit->device)
+				pdi = get_dev_info(bit->device);
 
-		if (!pdi || pdi->dev != bit->device)
-			pdi = get_dev_info(bit->device);
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+		} else {
+			fprintf(stderr, "unsupported version %d\n", version);
+			continue;
+		}
 
-		if (bit->time > pdi->last_read_time)
-			pdi->last_read_time = bit->time;
 
 		events++;
 	}
@@ -2616,6 +2624,7 @@ static int ms_prime(struct ms_stream *msp)
 	int ret, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
+		u8 version;
 
 		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
 				&pci->fdblock);
@@ -2631,46 +2640,53 @@ static int ms_prime(struct ms_stream *msp)
 			goto err;
 
 		}
-		bit = bit_alloc();
-		bit->magic = magic;
+		version = magic & 0xff;
+		if (version == SUPPORTED_VERSION) {
+			bit = bit_alloc();
+			bit->magic = magic;
 
-		ret = read_one_bit(pci->fd, bit, 1, &pci->fdblock);
-		if (ret)
-			goto err;
+			ret = read_one_bit(pci->fd, bit, 1, &pci->fdblock);
+			if (ret)
+				goto err;
 
-		if (verify_trace(bit))
-			goto err;
+			if (verify_trace(bit))
+				goto err;
 
-		if (bit->cpu != pci->cpu) {
-			fprintf(stderr, "cpu %d trace info has error cpu %d\n",
-				pci->cpu, bit->cpu);
-			continue;
-		}
+			if (bit->cpu != pci->cpu) {
+				fprintf(stderr,
+					"cpu %d trace info has error cpu %d\n",
+					pci->cpu, bit->cpu);
+				continue;
+			}
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
-			handle_notify(bit);
-			output_binary(bit, sizeof(*bit) + bit->pdu_len);
-			bit_free(bit);
-			bit = NULL;
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				bit_free(bit);
+				bit = NULL;
 
-			i -= 1;
-			continue;
-		}
+				i -= 1;
+				continue;
+			}
 
-		if (bit->time > pdi->last_read_time)
-			pdi->last_read_time = bit->time;
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
 
-		t = t_alloc();
-		memset(t, 0, sizeof(*t));
-		t->bit = bit;
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
 
-		if (msp->first == NULL)
-			msp->first = msp->last = t;
-		else {
-			msp->last->next = t;
-			msp->last = t;
+			if (msp->first == NULL)
+				msp->first = msp->last = t;
+			else {
+				msp->last->next = t;
+				msp->last = t;
+			}
+		} else {
+			fprintf(stderr, "unsupported version %d\n", version);
+			continue;
 		}
-
 		ndone++;
 		bit = NULL;
 	}
-- 
2.51.0

