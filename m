Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7D340DAC;
	Tue,  9 Sep 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416145; cv=none; b=PzWmZ/nyF7mr5eoqpA/T6adCli3V7AGOvDyv3PhXoPdDrWzJCCQ2fzVhaQboM7kyQLs/OzBJqFJhTv4a3muxaGjX+blX4GKaNMoW4ZVu5wA7ntaVez0zEOCSO1jKoApSFxjsfMvfXTdAyisQQHwvd6IdT7pnjpkrdvq68OVHwv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416145; c=relaxed/simple;
	bh=clLA9tWFF0dM3xcPiJ8JYCP9d84ZpF4epwkmDjKG8sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgPLhlnUnRDHnUg7d4Z8a+BZG2ShgHZPBfpDkACUlEGkH3BlP4Ng66SAyc+T4wkct9vORbBxBAt6E67C4Hf3sVO5z1S0uvcj3c3vWo5/SPor13PfWTmCaDiEMsan3menRWxBpBBSsxK3lGENDwPF14SesaKs41dBM2TfyyM3EjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aFpFFcRF; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aFpFFcRF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416143; x=1788952143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clLA9tWFF0dM3xcPiJ8JYCP9d84ZpF4epwkmDjKG8sY=;
  b=aFpFFcRFgVxrw0pgfcnoZS2uUDHd6OxLN1KE2dS+vlHS7IrGw+twxHyD
   MgwLkgHbnXZIo1JpVDRXePB7HSCQMlUnQOO3bKcVTKiBQAKVkaP4uq3gP
   vA6OQoAezXwh+5yQapgLd81suY03krx7tGMLCKuleWSLXgZO0L6FJg/mq
   PCa2JTMQZ+2utldsp0BW2qjb+ZdsD8INV24H6salLFwktbIIp8iRQZFiv
   evRvCuAK5TqFdaFDLM3Q6FCKZrqZGEIaqCvlmHSZJ3P6Kxfc7GMhciKhD
   45tQJqgCy+FjnhX1jLqwXfrSkgHhoanGBUtFWWqKGVAwCmCaSwbpX6qvN
   g==;
X-CSE-ConnectionGUID: Ew2F+RyERl6IFxny4yDc8g==
X-CSE-MsgGUID: VLLsjRN1S7aB6f6+LHGXdA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810963"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:09:03 +0800
IronPort-SDR: 68c00acf_adlbHp1nnPv5ulJrlzstDkc3/w4XNGVvvEGzbkfRfyHILtn
 vLvcB0Me8Cdf/lazIPKZkzZuUfIxq6miMNYtOdA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:09:03 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:59 -0700
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
Subject: [PATCH 21/21] blkparse: parse zone append completions
Date: Tue,  9 Sep 2025 13:07:23 +0200
Message-Id: <20250909110723.75676-22-johannes.thumshirn@wdc.com>
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

Parse completion of Zone Append commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 467c8c5..725ddbe 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -331,6 +331,27 @@ static void process_zoned(char *act, struct blk_io_trace2 *t,
 			  unsigned long long elapsed, char *name)
 {
 	switch (act[1]) {
+	case 'A':	/* Zone Append */
+		if (elapsed != -1ULL) {
+			if (t_sec(t))
+				fprintf(ofp, "%llu + %u (%8llu) [%d]\n",
+					(unsigned long long) t->sector,
+					t_sec(t), elapsed, t->error);
+			else
+				fprintf(ofp, "%llu (%8llu) [%d]\n",
+					(unsigned long long) t->sector,
+					elapsed, t->error);
+		} else {
+			if (t_sec(t))
+				fprintf(ofp, "%llu + %u [%d]\n",
+					(unsigned long long) t->sector,
+					t_sec(t), t->error);
+			else
+				fprintf(ofp, "%llu [%d]\n",
+					(unsigned long long) t->sector,
+					t->error);
+		}
+		break;
 	case 'P': /* Zone Plug */
 		fprintf(ofp, "[%s]\n", name);
 		break;
-- 
2.51.0

