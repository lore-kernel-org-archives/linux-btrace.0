Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568F338F48;
	Tue,  9 Sep 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416114; cv=none; b=PQ25JQISpQ3Z/TJEirnaoMvnnHvoH0VdkzSO7mIyGFfsPlW+hRP2POqLbFgG0F3BfwodY9INrusJ9flZfl962Dn+OJZkmL1BAZcS8GZl3IeZZgiETctWp4r2qvCAivMiMvb0zmz/rYxhBKylKhAim+P0MOxcaavXLenrsO9j8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416114; c=relaxed/simple;
	bh=nRZnhyBd/qziiI41VmsqQR87WLp9tku/9fGsw/Z/SJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krZHphDcBFwrNdx1h4zW4HhFr82mU9S25wOqQWF3nMaF8IJ4oA/ma3gCURS9mBR7vMZAEVVvetdlleUAUAI47pEaphoOxoA91U+TX5YpCZefo69eIVg3uLEwu4QZTtOw5hb058vHzjB/Qbi6xv6XuuKQpvUyv4yi6qBbWRqbrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K8LxRydm; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K8LxRydm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416112; x=1788952112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRZnhyBd/qziiI41VmsqQR87WLp9tku/9fGsw/Z/SJc=;
  b=K8LxRydmx3GhWvyDARdFmpvOHYg5a286KMaKteT7DtMjWVU/uUKmZrXM
   ppKVYXU9Naf/10/liGhPwfFzS78MQN9AImGd1P8gbseKcuj3vLpSfGnoh
   InfCXeON2DIlVE0Q2qbm/B5yyzGYKu3LP+3oh/r83MIdkwI7wN468djG4
   OTVYrWbIQeY70mR0NqffsA/Lkrv0/5YqfxVq+Ii8qNkA/+G9K0vFdP772
   dYWVy55qZOASuqwtZBO2ar/YZqlserDGVSSCW8nFOQmGLHv1bmFZItWqZ
   wr1ynLMYZ7ILZ+k3lEEhqE/Hw5rExVBRJ90iA2ins6rHS1i7ccMAZMFzd
   A==;
X-CSE-ConnectionGUID: mvtZUHIRRiKlM7b5I5mA3w==
X-CSE-MsgGUID: qatcUp6+S3u3J7WgHsT6bA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810751"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:32 +0800
IronPort-SDR: 68c00ab0_yFGfdWBLoT5xo8Zqj4hgIi+EUr3Qd+7uwshHVVZ7/BbMNEV
 22+eNfTdVB5jNGV+rEXth5YGcPafk0l1bNTF+4A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:32 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:28 -0700
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
Subject: [PATCH 14/21] blktrace: pass magic to verify_trace
Date: Tue,  9 Sep 2025 13:07:16 +0200
Message-Id: <20250909110723.75676-15-johannes.thumshirn@wdc.com>
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

Pass magic to verify_trace(), this will enable verification of multiple
supported versions.

Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkiomon.c | 2 +-
 blkparse.c | 4 ++--
 blktrace.h | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/blkiomon.c b/blkiomon.c
index 05f2d00..373947e 100644
--- a/blkiomon.c
+++ b/blkiomon.c
@@ -488,7 +488,7 @@ static int blkiomon_do_fifo(void)
 
 		/* endianess */
 		trace_to_cpu(bit);
-		if (verify_trace(bit)) {
+		if (verify_trace(bit->magic)) {
 			fprintf(stderr, "blkiomon: bad trace\n");
 			break;
 		}
diff --git a/blkparse.c b/blkparse.c
index 3609ca9..cc62dcf 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2509,7 +2509,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 				continue;
 			}
 
-			if (verify_trace(bit)) {
+			if (verify_trace(bit->magic)) {
 				bit_free(bit);
 				bit = NULL;
 				continue;
@@ -2649,7 +2649,7 @@ static int ms_prime(struct ms_stream *msp)
 			if (ret)
 				goto err;
 
-			if (verify_trace(bit))
+			if (verify_trace(bit->magic))
 				goto err;
 
 			if (bit->cpu != pci->cpu) {
diff --git a/blktrace.h b/blktrace.h
index 81a5b51..68c67f2 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -89,16 +89,16 @@ extern struct timespec abs_start_time;
 #error "Bad arch"
 #endif
 
-static inline int verify_trace(struct blk_io_trace *t)
+static inline int verify_trace(__u32 magic)
 {
 	u8 version;
 
-	if (!CHECK_MAGIC(t->magic)) {
-		fprintf(stderr, "bad trace magic %x\n", t->magic);
+	if (!CHECK_MAGIC(magic)) {
+		fprintf(stderr, "bad trace magic %x\n", magic);
 		return 1;
 	}
 
-	version = t->magic & 0xff;
+	version = magic & 0xff;
 	if (version != SUPPORTED_VERSION &&
 	    version != SUPPORTED_VERSION2) {
 		fprintf(stderr, "unsupported trace version %x\n", version);
-- 
2.51.0

