Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C813311C1E;
	Thu, 25 Sep 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812709; cv=none; b=ZTu8Na+Wwmp4klI0JuU5fvjgKBKqQ4a69doH0PWDwub4WTpaI5wOTnlbBw+2j0adeXKoBBt61s0L4KdVyNQJrb7xgEwoX3rQm8Ds2a6aelgXZ8RarFkhlN9eM14LmzTdb7bEXaZiwJpIIcycWyn6nxEgKJq5o6IGaDADJNe+I4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812709; c=relaxed/simple;
	bh=FTAoOSz6/+aBx9BQg8CKa15JSKRi7Q8RjuynnHXeh2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7rEq/2Dm0CeeZX/y33YWGASdZ7N8L3sm/jWCpPeR86Rat7Ct0MQws4dWGfNX4lc+KQxA/GpQKGx/QzMPvs/7DJATuzkO19WJBNLv1Js5mO0UXmqUB3VT+llNnactGXzHuq+LebZCE+zn7QUPoRLkNNUoumAJIS8C4Fo6i3X4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rLyGVv7H; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rLyGVv7H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812708; x=1790348708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTAoOSz6/+aBx9BQg8CKa15JSKRi7Q8RjuynnHXeh2U=;
  b=rLyGVv7HIlqdZXwHoWGS/FR6g0sKPli1/cLHWn28wTD6ZIg49oLxFUW5
   zCm+prTjOrUC8QTKMX3661EM/5pOblOjZ0k8+zG8PvoZMY9rXzY8oYW/A
   fY13f41Zdbr/GOGoTzmb2KoWJ80xeUG2gyqG72E1O9wG++xKpHdLUffjh
   cTzu1fNzXj1tVRFNHATZ+9R+OQFoP8IZNiNsJhczdw8J7URiSUizAHkv1
   8KUUC3rBs/8kOmOeCDAKZ1m/tApY//ndvsuFra3MhZ/Me1Pw2m9A2o4mO
   O9YF0AYXp7hP4slxp42lQaY+ieFO9pcG6t8AkTjVEQMYo652z6IJu8Ep6
   g==;
X-CSE-ConnectionGUID: 3eTEnP0CRGW/rz0uVbzxZA==
X-CSE-MsgGUID: Opv3JocjSJi3YRceP2gcTw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348926"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:07 +0800
IronPort-SDR: 68d55a23_vOQv7dDegYlAhaEu4pAjpea1Omv3IoIjcIf6bY0e5hn1GU2
 fEHGoxcgUoTU4wcY8+6xwCizyfsvg5gsG8AFm1A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:08 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:05 -0700
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
Subject: [PATCH blktrace v2 08/22] blkparse: read 'magic' first
Date: Thu, 25 Sep 2025 17:04:13 +0200
Message-ID: <20250925150427.67394-9-johannes.thumshirn@wdc.com>
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

Read the 'magic' portion of 'struct blk_io_trace' first when reading the
tracefile and only if all magic checks succeed, read the rest of the
trace.

This is a preparation of supporting multiple trace protocol versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index d58322c..5645c31 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2438,14 +2438,13 @@ static int read_events(int fd, int always_block, int *fdblock)
 		struct trace *t;
 		int pdu_len, should_block, ret;
 		__u32 magic;
-
-		bit = bit_alloc();
+		void *p;
 
 		should_block = !events || always_block;
 
-		ret = read_data(fd, bit, sizeof(*bit), should_block, fdblock);
+		ret = read_data(fd, &magic, sizeof(magic), should_block,
+				fdblock);
 		if (ret) {
-			bit_free(bit);
 			if (!events && ret < 0)
 				events = ret;
 			break;
@@ -2455,15 +2454,28 @@ static int read_events(int fd, int always_block, int *fdblock)
 		 * look at first trace to check whether we need to convert
 		 * data in the future
 		 */
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			break;
 
-		magic = get_magic(bit->magic);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			break;
 		}
 
+		bit = bit_alloc();
+		bit->magic = magic;
+		p = (void *) ((u8 *)bit + sizeof(magic));
+
+		ret = read_data(fd, p, sizeof(*bit) - sizeof(magic),
+				should_block, fdblock);
+		if (ret) {
+			bit_free(bit);
+			if (!events && ret < 0)
+				events = ret;
+			break;
+		}
+
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
 			void *ptr = realloc(bit, sizeof(*bit) + pdu_len);
@@ -2596,20 +2608,30 @@ static int ms_prime(struct ms_stream *msp)
 	int ret, pdu_len, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
-		bit = bit_alloc();
-		ret = read_data(pci->fd, bit, sizeof(*bit), 1, &pci->fdblock);
+		void *p;
+
+		ret = read_data(pci->fd, &magic, sizeof(magic), 1,
+				&pci->fdblock);
 		if (ret)
 			goto err;
 
-		if (data_is_native == -1 && check_data_endianness(bit->magic))
+		if (data_is_native == -1 && check_data_endianness(magic))
 			goto err;
 
-		magic = get_magic(bit->magic);
+		magic = get_magic(magic);
 		if ((magic & 0xffffff00) != BLK_IO_TRACE_MAGIC) {
 			fprintf(stderr, "Bad magic %x\n", magic);
 			goto err;
 
 		}
+		bit = bit_alloc();
+		bit->magic = magic;
+		p = (void *) ((u8 *)bit + sizeof(magic));
+
+		ret = read_data(pci->fd, p, sizeof(*bit) - sizeof(magic), 1,
+				&pci->fdblock);
+		if (ret)
+			goto err;
 
 		pdu_len = get_pdulen(bit);
 		if (pdu_len) {
@@ -2639,6 +2661,7 @@ static int ms_prime(struct ms_stream *msp)
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
+			bit = NULL;
 
 			i -= 1;
 			continue;
@@ -2659,6 +2682,7 @@ static int ms_prime(struct ms_stream *msp)
 		}
 
 		ndone++;
+		bit = NULL;
 	}
 
 	return ndone;
-- 
2.51.0

