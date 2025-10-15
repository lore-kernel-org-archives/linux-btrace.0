Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7C31D753;
	Wed, 15 Oct 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525864; cv=none; b=GHabqlqQ7WlMrgENvRYqGxoUE1kwor1TOmlne4Pw2GYNRbF0NHezc/KKG9Q6PSAKsIbH8jRsD/Ydxbcz3TlrH7lMIe4cnUoaYQr9hlSdd8yabWwb0uAgJIv/TCLNDuO+5z8Dh6qqkW9w1233wSs5VRCwGVK3cq/G3d26XJK0pHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525864; c=relaxed/simple;
	bh=FTAoOSz6/+aBx9BQg8CKa15JSKRi7Q8RjuynnHXeh2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqdYuvTa0Z+R+WcJ7wLONU/HUYSM779p2ZdFqtsC5LMcYbpbVvZKMArvlZ3G1GeylHEoS3ENwLnZcXETaMbcFDlDZEXexySEJm21KLSODMEIqiyBnyn9tKKzLpgpZLAf9V5GfIKbWtDC4gEbxDbp6OwpjIICcM9GwRdN8TPMJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qPS6NrqU; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qPS6NrqU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760525863; x=1792061863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTAoOSz6/+aBx9BQg8CKa15JSKRi7Q8RjuynnHXeh2U=;
  b=qPS6NrqUxmZfCtIUJFC30lpwmprxnUOMv+niDdfGb7K0tWAtI7mnTI7T
   8wPfj+qwnKv1lgtZz1lTTm6D9cpeWJk2jxF8QPRKC3q2TQwixwLu8cdCb
   ywR8DjrBOuFHgmbwpkrN3Y/1+qL3+8h8mcY+evTLjuisN4gbJhQk4+OSm
   8ba1Zh47/PJQP7zrB5p8t09e60cvJZsbL+SI2ySb3rpNIU9DlsKge8JU6
   0A01LGkHsPZxouIslOpTqPUo2ZYTVRdA/Yll5XxFz3UJk1odnBtdrhXPy
   dtu03P/NJYJ0uaeouDYQC61k6KtWvzAIHGQxavDjLl7hk2+ZU8lCcNOSd
   Q==;
X-CSE-ConnectionGUID: Q6+fPYmhR36fIAPyPTLRsA==
X-CSE-MsgGUID: rI8ZDDcIR9CD9rLof7Vdgg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754928000"; 
   d="scan'208";a="132935379"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 18:57:43 +0800
IronPort-SDR: 68ef7e27_KTwQui4gxUlG1M9n/2+heWLVFb8EPvIsMk8FKux0nnJEvDT
 Qu2I1Hn+cHdE6n+J095WU1hvxeLQ6nW7P4ndskg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 03:57:43 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 03:57:39 -0700
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
Subject: [PATCH blktrace v3 08/20] blkparse: read 'magic' first
Date: Wed, 15 Oct 2025 12:56:46 +0200
Message-ID: <20251015105658.527262-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
References: <20251015105658.527262-1-johannes.thumshirn@wdc.com>
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

