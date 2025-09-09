Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B511320CD3;
	Tue,  9 Sep 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415996; cv=none; b=qYSVV19YkNqKGZN3F25FVaSLY17oDEsx+oBHNIAikCtGL8acz3stxjt7mVEzhuH0BG87k9q6ZwwJ/aAsG7tlgTnfEdeSvnuD+0fuSn/zaItDWITE4pKC4/xuDm9Ge1y2FSyl2SgqV5TDKrhESQefvqskxiHQVETWodpdLfngdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415996; c=relaxed/simple;
	bh=ysAhFqP3AWeX6zFL7mVOZDX6G6Yvrf7rwLRnwHCjxV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hquik4SWLiFxFSf3qUPy8djdXUTVk67pyG7go+wXoXkngVTII/O6K/JtdkyC/qBvgEAvc5Qycx0oJABF5AKfxbCK0tSF/N8zc20tgRnAqhLao4TyKySK1R1lUcymO8OWXz/ENd9nQsvGc6x031h09NV92YbLDGCSdIkATi/oHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=roJn/rPI; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="roJn/rPI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757415995; x=1788951995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysAhFqP3AWeX6zFL7mVOZDX6G6Yvrf7rwLRnwHCjxV0=;
  b=roJn/rPIQeNSuZL6XjjiuP/i18gfzDnORNX9318erVcnTuLEc0xONHSa
   WBT5EPrDL6yWX/1RaMUDDOgXuY+X94zb8frbDvMzwtsI+Hh5NH/YCLuQg
   vZbmYaHDSvlpCf0GfpJAm6oQsB9u0bAUFLyyMjd9E6rx6S9HUwT489iZY
   vH1Payy9PUSrJe3FlLcDPnXE5m0DKxhP2oSTXMKyk7QYnz7+d1DRWfwBE
   wDztvzBQavAFAvyGrzMSX0vOLBjJRXEBSSJvBTbfDAy72Xm+/wbUxKufd
   Jdy/f2YJRtt8C9zHUfwWjf+/A7qdEUutuRowFONV2fs5zCgdyTOmB9ALD
   w==;
X-CSE-ConnectionGUID: mLft5LT+QVa3rjTgSjBeWg==
X-CSE-MsgGUID: BKF45ofgTCyw2vWcJdhaPQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112809922"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:06:34 +0800
IronPort-SDR: 68c00a3a_HgQTHNDValobHkWZM5lFqtRcowe/ywW8/r4E68tZgK/vxZk
 n0WNGVdycWwwZvpdUSonD7ub6jXhRytlPSKG7qQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:06:34 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:06:30 -0700
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
Subject: [PATCH 03/16] blktrace: pass blk_user_trace2 to setup functions
Date: Tue,  9 Sep 2025 13:05:58 +0200
Message-Id: <20250909110611.75559-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
References: <20250909110611.75559-1-johannes.thumshirn@wdc.com>
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
index 487eabfaf70e..4a642a812854 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -575,7 +575,7 @@ static struct blk_trace *blk_trace_setup_prepare(struct request_queue *q,
 
 static void blk_trace_setup_finalize(struct request_queue *q,
 				     char *name, struct blk_trace *bt,
-				     struct blk_user_trace_setup *buts)
+				     struct blk_user_trace_setup2 *buts)
 
 {
 	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
@@ -607,6 +607,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    struct block_device *bdev,
 		    char __user *arg)
 {
+	struct blk_user_trace_setup2 buts2;
 	struct blk_user_trace_setup buts;
 	struct blk_trace *bt;
 	int ret;
@@ -618,6 +619,15 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
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
@@ -625,7 +635,9 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		mutex_unlock(&q->debugfs_mutex);
 		return PTR_ERR(bt);
 	}
-	blk_trace_setup_finalize(q, name, bt, &buts);
+	bt->version = 1;
+	blk_trace_setup_finalize(q, name, bt, &buts2);
+	strcpy(buts.name, buts2.name);
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
@@ -641,7 +653,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 				  dev_t dev, struct block_device *bdev,
 				  char __user *arg)
 {
-	struct blk_user_trace_setup buts;
+	struct blk_user_trace_setup2 buts2;
 	struct compat_blk_user_trace_setup cbuts;
 	struct blk_trace *bt;
 
@@ -651,7 +663,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	if (!cbuts.buf_size || !cbuts.buf_nr)
 		return -EINVAL;
 
-	buts = (struct blk_user_trace_setup) {
+	buts2 = (struct blk_user_trace_setup2) {
 		.act_mask = cbuts.act_mask,
 		.buf_size = cbuts.buf_size,
 		.buf_nr = cbuts.buf_nr,
@@ -661,16 +673,17 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
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

