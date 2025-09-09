Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328E3218C9;
	Tue,  9 Sep 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416127; cv=none; b=mA7i6f+QGjkvUbVHeaIpFrSXZOOUIlotzCKxxh5Yjrh59BAgQSVLWXI79BqfrZx3MNbXHjRf0IvoZRCXBJmkRovwrbjVfUD5BH6RE7/S8BPsk8m7cqqIU2gIbQaRltcDrslz9xf35rMnE1B80qcrrmi5YhqNGstWjfMypvRz71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416127; c=relaxed/simple;
	bh=CTdpI0pBE7O8HMENjl+aLW7GQmWBJpgwd+dHiIIQBNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHog6zeZH8Dx7J5R1ZsRPLaaJXU1VFBK0P8aZtKLgqFDlxeJrHhHghX/mudSA24EotSKf9n2IR1lg/wZ/a63OTRLv8IHC5SfI2It+/Rwdc0cLh4MA2w5jyGd/Y/MsbvDMrMT9WK+DztnmGC7ifPi25PatY8FK1/2col31f4/alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HhK9Gl7k; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HhK9Gl7k"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416126; x=1788952126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CTdpI0pBE7O8HMENjl+aLW7GQmWBJpgwd+dHiIIQBNk=;
  b=HhK9Gl7ktaqGkN1IWjy/2/VqW9Hs2a519yb3I7IZKNgz+OaVwjXHgm2k
   fff8V/hKv9uX2eDRwCGqCzz7SOxDL0sfRq4qLXFlEqpOhOnafZCbcnzs0
   9DxrjB4EVTeJh1BhRTzhI/9Ou1P8SSmb6oejylMg5hSamPfTXeB3JCBCY
   9r4J183I9O+TbujnK7nZ57DlItYDxqvlUyPaxnaJ7NGv4yO4FG4n1K1vH
   qCmJ4m/yNHdze35onaq5+XFWmXlinQln5cf1a8USe3fbjWOVPbBsWfL8V
   4LZys4POgNJQrdQhR/VGXCsliZdu/hTZfHk0gC7PHWw+mHL8VGM0BNvp7
   Q==;
X-CSE-ConnectionGUID: yYMxx8zNRG2BoeJsxekFJg==
X-CSE-MsgGUID: BDdxm5B/Rzq5I4u/8RaghA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810895"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:45 +0800
IronPort-SDR: 68c00abd_+gwkQk6589caPtP8sBbRTYB8THgkZPYogV2Zk/mcDht7Qme
 AlAXIWsshXwqqSnvBiPY8zlLoz8U7esQ+uH/G9w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:45 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:41 -0700
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
Subject: [PATCH 17/21] blkparse: natively parse blk_io_trace2
Date: Tue,  9 Sep 2025 13:07:19 +0200
Message-Id: <20250909110723.75676-18-johannes.thumshirn@wdc.com>
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

Natively parse 'struct blk_io_trace2' from a blktrace binary.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 blktrace.h |  18 +++++++++
 2 files changed, 130 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 1237c02..e702356 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -2471,6 +2471,37 @@ static int read_one_bit(int fd, struct blk_io_trace2 **bit2, int block,
 	return 0;
 }
 
+static int read_one_bit2(int fd, struct blk_io_trace2 **bit2, int block,
+			 int *fdblock)
+{
+	struct blk_io_trace2 *new = *bit2;
+	int ret;
+	int pdu_len;
+	void *p;
+
+	p = (void *) ((u8 *)new + sizeof(__u32));
+
+	ret = read_data(fd, p, sizeof(*new) - sizeof(__u32), block, fdblock);
+	if (ret)
+		return ret;
+
+	pdu_len = get_pdulen(new->pdu_len);
+	if (pdu_len) {
+		void *ptr = realloc(new, sizeof(*new) + pdu_len);
+
+		ret = read_data(fd, ptr + sizeof(*new), pdu_len, 1, fdblock);
+		if (ret) {
+			free(ptr);
+			return ret;
+		}
+		new = ptr;
+	}
+
+	bit2_trace_to_cpu(new);
+	*bit2 = new;
+
+	return 0;
+}
 static int read_events(int fd, int always_block, int *fdblock)
 {
 	struct per_dev_info *pdi = NULL;
@@ -2538,6 +2569,44 @@ static int read_events(int fd, int always_block, int *fdblock)
 			t->next = trace_list;
 			trace_list = t;
 
+			if (!pdi || pdi->dev != bit->device)
+				pdi = get_dev_info(bit->device);
+
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+		} else if (version == SUPPORTED_VERSION2) {
+			struct blk_io_trace2 *bit;
+			bit = bit_alloc();
+			bit->magic = magic;
+
+			ret = read_one_bit2(fd, &bit, 1, fdblock);
+			if (ret)
+				break;
+
+			/*
+			 * not a real trace, so grab and handle it here
+			 */
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				continue;
+			}
+
+			if (verify_trace(bit->magic)) {
+				bit_free(bit);
+				bit = NULL;
+				continue;
+			}
+
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+			t->read_sequence = read_sequence;
+
+			t->next = trace_list;
+			trace_list = t;
+
 			if (!pdi || pdi->dev != bit->device)
 				pdi = get_dev_info(bit->device);
 
@@ -2698,6 +2767,49 @@ static int ms_prime(struct ms_stream *msp)
 				msp->last->next = t;
 				msp->last = t;
 			}
+		} else if (version == SUPPORTED_VERSION2) {
+			bit = bit_alloc();
+			bit->magic = magic;
+
+			ret = read_one_bit2(pci->fd, &bit, 1, &pci->fdblock);
+			if (ret)
+				goto err;
+
+			if (verify_trace(bit->magic))
+				goto err;
+
+			if (bit->cpu != pci->cpu) {
+				fprintf(stderr,
+					"cpu %d trace info has error cpu %d\n",
+					pci->cpu, bit->cpu);
+				continue;
+			}
+
+			if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
+			    (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
+				handle_notify(bit);
+				output_binary(bit, sizeof(*bit) + bit->pdu_len);
+				bit_free(bit);
+				bit = NULL;
+
+				i -= 1;
+				continue;
+			}
+
+			if (bit->time > pdi->last_read_time)
+				pdi->last_read_time = bit->time;
+
+			t = t_alloc();
+			memset(t, 0, sizeof(*t));
+			t->bit = bit;
+
+			if (msp->first == NULL)
+				msp->first = msp->last = t;
+			else {
+				msp->last->next = t;
+				msp->last = t;
+			}
+
 		} else {
 			fprintf(stderr, "unsupported version %d\n", version);
 			continue;
diff --git a/blktrace.h b/blktrace.h
index 196b3c9..ba06237 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -129,6 +129,24 @@ static inline void bit_to_bit2(struct blk_io_trace *old,
 		       old->pdu_len);
 }
 
+static inline void bit2_trace_to_cpu(struct blk_io_trace2 *t)
+{
+	if (data_is_native)
+		return;
+
+	t->magic	= be32_to_cpu(t->magic);
+	t->sequence	= be32_to_cpu(t->sequence);
+	t->time		= be64_to_cpu(t->time);
+	t->sector	= be64_to_cpu(t->sector);
+	t->bytes	= be32_to_cpu(t->bytes);
+	t->action	= be64_to_cpu(t->action);
+	t->pid		= be32_to_cpu(t->pid);
+	t->device	= be32_to_cpu(t->device);
+	t->cpu		= be32_to_cpu(t->cpu);
+	t->error	= be16_to_cpu(t->error);
+	t->pdu_len	= be16_to_cpu(t->pdu_len);
+}
+
 static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
-- 
2.51.0

