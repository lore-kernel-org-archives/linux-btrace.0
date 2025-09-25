Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3386230C347;
	Thu, 25 Sep 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812620; cv=none; b=CDgKjPhZ3Y5zHTuwdiFtdxusAJisKplasOVUAi50xofjVdmkSDVTzaGQ2hybtZ5FW2Ayx+1gaqAiVQsfCt1goTv6dKzAI9QmnMMEs9IWuZltDINSTbGeVvpYHDHMUKViX6z/hml/NgKdqFn1oRA7cXNtxYJ0EBQrZZRqrraB9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812620; c=relaxed/simple;
	bh=L1r/8uxRlM/kp1r+xQYQKLRaeaIZcG+wTHH1zLo1dPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8KG7BVaOw3E6y9KiLXY2qvUZChL2ZLQe0iJ7IjAbDfc4ZL/RRqL6aKGYmb37pWis923M5957Mn3BzRwxm7plqQiMrR/SsLDuQGnfwhnLaW961qhGRRmpCC+PKKaq4O1I8J/cAY53AWpZd185PAGS6J7POn1MG3lJPSg9PeiML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W8hdysWY; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W8hdysWY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812619; x=1790348619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1r/8uxRlM/kp1r+xQYQKLRaeaIZcG+wTHH1zLo1dPg=;
  b=W8hdysWYHkGlaZaI+EjkS2Y7jod/8FbdjqI6qj+kQZof7w+nqIbkYnMl
   np1vYfL6WeC6Wloe9GW7VA+6VoopxUtWBF+HxA4M3z5hulWUuBl26M+cb
   Kn9qD9HhRc2hDsv3MPbzLAy3Sm75z7K3VA9bjVK7mSgliinYtMGkwRStw
   ujEVQFxB6ZVAT6R2OcwrjA9gOVY+dmxrTIVH7XwYHWxJ3TAuGWscP+ydk
   OWYL0y3TBO7qNWOjifDkZsRsPBfShF65x6XneLd0eGEuSqIEr9JP3i82b
   EgZQk90V52BFdNcTB1ZOSSrVbMHfNvWRUr2+nnBkCR6ncNkwKdFMiQLhk
   A==;
X-CSE-ConnectionGUID: xcaTH2reSTS05yPRBLm39Q==
X-CSE-MsgGUID: JZ52WxhtSXG7fiKjoLWb2A==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130348179"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:03:38 +0800
IronPort-SDR: 68d559ca_2/71+nprOx7Ijcm7bzGr+JCTHvxvao7EDdCI7mi+R7r+T/F
 WylNHt8mj89UexRwpLblObjFSn+RijHH+fmIXKQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:03:39 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:03:35 -0700
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
Subject: [PATCH v2 15/15] blktrace: handle BLKTRACESETUP2 ioctl
Date: Thu, 25 Sep 2025 17:02:31 +0200
Message-ID: <20250925150231.67342-16-johannes.thumshirn@wdc.com>
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

Handle the BLKTRACESETUP2 ioctl, requesting an extended version of the
blktrace protocol from user-space.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/ioctl.c           |  1 +
 kernel/trace/blktrace.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index f7b0006ca45d..e7f83a58c8ae 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -691,6 +691,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 
 	/* Incompatible alignment on i386 */
 	case BLKTRACESETUP:
+	case BLKTRACESETUP2:
 		return blk_trace_ioctl(bdev, cmd, argp);
 	default:
 		break;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3e7cd8f46c0c..e16a3dbed527 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -742,6 +742,38 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
+static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
+			    struct block_device *bdev, char __user *arg)
+{
+	struct blk_user_trace_setup2 buts2;
+	struct blk_trace *bt;
+	int ret;
+
+	ret = copy_from_user(&buts2, arg, sizeof(buts2));
+	if (ret)
+		return -EFAULT;
+
+	if (!buts2.buf_size || !buts2.buf_nr)
+		return -EINVAL;
+
+	mutex_lock(&q->debugfs_mutex);
+	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
+				     bdev);
+	if (IS_ERR(bt)) {
+		mutex_unlock(&q->debugfs_mutex);
+		return PTR_ERR(bt);
+	}
+	bt->version = 2;
+	blk_trace_setup_finalize(q, name, bt, &buts2);
+	mutex_unlock(&q->debugfs_mutex);
+
+	if (copy_to_user(arg, &buts2, sizeof(buts2))) {
+		blk_trace_remove(q);
+		return -EFAULT;
+	}
+	return 0;
+}
+
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 static int compat_blk_trace_setup(struct request_queue *q, char *name,
 				  dev_t dev, struct block_device *bdev,
@@ -833,6 +865,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	char b[BDEVNAME_SIZE];
 
 	switch (cmd) {
+	case BLKTRACESETUP2:
+		snprintf(b, sizeof(b), "%pg", bdev);
+		ret = blk_trace_setup2(q, b, bdev->bd_dev, bdev, arg);
+		break;
 	case BLKTRACESETUP:
 		snprintf(b, sizeof(b), "%pg", bdev);
 		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
-- 
2.51.0

