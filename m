Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76662E36F2;
	Thu, 25 Sep 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812592; cv=none; b=CrTHr3540VUnlNfoZxTmW8JB02l1eTQB0awO9fnSIjrgDLs2dhlQ8JqxUXC4GHUmjHzli50K5xENjm1RP1qdj6cIjzT3E3ot10e485UwU9Y1voiThTN/B1jhFK4r3KxYs9UoWyD1E6wcJn6j/mdAzfXvAJhgoK6nskwsDcDANog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812592; c=relaxed/simple;
	bh=1zGL8PegQsm+QTeH4lESXnPHYliYIj5Ef+giPrlEZME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugRUtQiq4McariqN3EdAJtIE8o8eJJazzN8+nfI7QdSRi93+rKwKcRPCzCKFM4qN1Z4yoERbcKUeDuhBZzgWViEJm7ok8P3amI00BXT3vwiRTo1+y9jBpC0oYw/LkCDwZ4RGX4xVPlgLJAn7GCyKN4qvSZxdSdm2uGlxqWkCoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WM4dUL2g; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WM4dUL2g"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812590; x=1790348590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1zGL8PegQsm+QTeH4lESXnPHYliYIj5Ef+giPrlEZME=;
  b=WM4dUL2gfFINeZL6sKIWcc3baE4XshV5MUcqQHqY2YdRrs8gEWbFGTxW
   8Ric4FKesqWttK7EHads8wVUUfwx4WeSFXNiJOhmdEFhVonZFeDTX9zzL
   xKypypnZMDnnWA8AHYFhq1CzKEbhj6jhQsyFgZGnUf2wE/+oCcJVSHnRM
   qJjoK12wssUcnWdizkCIavBARq3ADBGuebpTeI4HeuIbvZg4h/FRRf078
   Xoc19Q2VNqALRFvyAQC1pbH1eOWftBHJeYIMciip3lFNFPeV0Wejt7b43
   6Q0FIci6utm7gChGf3yxJ13QSu5Gw5HlfTcYDrIQM/1G67qfYkGvY8SvS
   A==;
X-CSE-ConnectionGUID: e19VdQloTBiJXs78mGWogQ==
X-CSE-MsgGUID: /DUNn603TEaNq8zbRFUeag==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130347975"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:10 +0800
IronPort-SDR: 68d559ae_kolp9y0AQMUOMAC9HFscZ3hq7oxShTg88AEXoxDiH6LJ0sy
 3jCEVBF0+toLpzfOraJiFAFkJna9+HdWeElPrCA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:10 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:07 -0700
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
Subject: [PATCH v2 08/15] blktrace: pass blk_user_trace2 to setup functions
Date: Thu, 25 Sep 2025 17:02:24 +0200
Message-ID: <20250925150231.67342-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass struct blk_user_trace_setup2 to blktrace_setup_finalize(). This
prepares for the incoming extension of the blktrace protocol with a 64bit
act_mask.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blktrace_api.h |  3 ++-
 kernel/trace/blktrace.c      | 27 ++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..05c8754456aa 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -14,11 +14,12 @@
 #include <linux/sysfs.h>
 
 struct blk_trace {
+	int version;
 	int trace_state;
 	struct rchan *rchan;
 	unsigned long __percpu *sequence;
 	unsigned char __percpu *msg_data;
-	u16 act_mask;
+	u64 act_mask;
 	u64 start_lba;
 	u64 end_lba;
 	u32 pid;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f6a41e9510f6..9cd8eb9e7b4b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -599,7 +599,7 @@ static struct blk_trace *blk_trace_setup_prepare(struct request_queue *q,
 
 static void blk_trace_setup_finalize(struct request_queue *q,
 				     char *name, struct blk_trace *bt,
-				     struct blk_user_trace_setup *buts)
+				     struct blk_user_trace_setup2 *buts)
 
 {
 	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
@@ -631,6 +631,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    struct block_device *bdev,
 		    char __user *arg)
 {
+	struct blk_user_trace_setup2 buts2;
 	struct blk_user_trace_setup buts;
 	struct blk_trace *bt;
 	int ret;
@@ -642,6 +643,15 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts.buf_size || !buts.buf_nr)
 		return -EINVAL;
 
+	buts2 = (struct blk_user_trace_setup2) {
+		.act_mask = buts.act_mask,
+		.buf_size = buts.buf_size,
+		.buf_nr = buts.buf_nr,
+		.start_lba = buts.start_lba,
+		.end_lba = buts.end_lba,
+		.pid = buts.pid,
+	};
+
 	mutex_lock(&q->debugfs_mutex);
 	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
 				     bdev);
@@ -649,7 +659,9 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		mutex_unlock(&q->debugfs_mutex);
 		return PTR_ERR(bt);
 	}
-	blk_trace_setup_finalize(q, name, bt, &buts);
+	bt->version = 1;
+	blk_trace_setup_finalize(q, name, bt, &buts2);
+	strcpy(buts.name, buts2.name);
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
@@ -665,7 +677,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 				  dev_t dev, struct block_device *bdev,
 				  char __user *arg)
 {
-	struct blk_user_trace_setup buts;
+	struct blk_user_trace_setup2 buts2;
 	struct compat_blk_user_trace_setup cbuts;
 	struct blk_trace *bt;
 
@@ -675,7 +687,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	if (!cbuts.buf_size || !cbuts.buf_nr)
 		return -EINVAL;
 
-	buts = (struct blk_user_trace_setup) {
+	buts2 = (struct blk_user_trace_setup2) {
 		.act_mask = cbuts.act_mask,
 		.buf_size = cbuts.buf_size,
 		.buf_nr = cbuts.buf_nr,
@@ -685,16 +697,17 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	};
 
 	mutex_lock(&q->debugfs_mutex);
-	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
+	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
 				     bdev);
 	if (IS_ERR(bt)) {
 		mutex_unlock(&q->debugfs_mutex);
 		return PTR_ERR(bt);
 	}
-	blk_trace_setup_finalize(q, name, bt, &buts);
+	bt->version = 1;
+	blk_trace_setup_finalize(q, name, bt, &buts2);
 	mutex_unlock(&q->debugfs_mutex);
 
-	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
+	if (copy_to_user(arg, &buts2.name, ARRAY_SIZE(buts2.name))) {
 		blk_trace_remove(q);
 		return -EFAULT;
 	}
-- 
2.51.0

