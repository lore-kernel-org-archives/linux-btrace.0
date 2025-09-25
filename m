Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354B31D73A;
	Thu, 25 Sep 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812764; cv=none; b=t1UNq/Jjsw+LYo0Qz5+g9E5cqdGr0KxCuPkzjki6d0S1DXDNeRaYH9tZxV3u1CEF6i9QEYt8g4765gOF1Ms/n66sIL+PAny2AuCBJ9aDnOqrz53IQ0ZyWFhSfIeGvu2KlMpE3MgO6PDxkBu+1ZVLmv9tA0XMDuJNT/sd2HmtvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812764; c=relaxed/simple;
	bh=Bq1feJ+M5PPyabVZFLEfvki0f4y0d112SBTH0REqjF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy7eY2OLjOJG2ZQngOUkwtu1l33cY/rYQmlMBQA60tCrgfR/8OwJFLbvk3vwdv5M1w07T1LlTXkQdKFTGdf8GiD95xIlf96ALMmedX30Hc3wBkI/Xj/JKKWWXgkeWKKAnNG8A/ILAIOcVfkA4KT+/8e3HJiw4KuUOU7ENd3NQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=abvjWhkH; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="abvjWhkH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812762; x=1790348762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bq1feJ+M5PPyabVZFLEfvki0f4y0d112SBTH0REqjF4=;
  b=abvjWhkHk5a08zJJ2cxw6qsHYZzYcYAKl5ij1IWwN3kAbn2LTTdtUxBV
   /emit/rFWpZ3tOLWODN6lDUdkDwYi++aHy7OGHIS/oC6xmIa9EuaO+m2x
   HEkNFTUx4fFXh9w8mFZhCjgoqmBDthuszbsGWHYuFZPD9rohtMwlaRZk6
   7gbPPjapt3ABib3UvO2aNEnODPUfRwVRRjw+fARasIxomhrXwVj80JcQM
   HDSscwVfgvjPl4ZP/EOrRSGHb30b0ES92LbcAEVCWv1ggqK4l4QKDlfK6
   etJtiSo6w8eAkZEZpd0q3jwvRoOKc7vCuu1fy016wZxgnJblgNcroTG3d
   w==;
X-CSE-ConnectionGUID: 8dPN7KkxSP+xI/Wzw4519Q==
X-CSE-MsgGUID: Y9ecdGLTQrivtfEn5pm9Vg==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349683"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:06:02 +0800
IronPort-SDR: 68d55a5a_TWec/Bbmz029fiaUmIH7r01bJiH2Jff/in/EH2/TTXKAVYj
 jqM9OfWuR0LmxdUgQwqBuvwuEo1V2MxW1LAwXJA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:06:03 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:59 -0700
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
Subject: [PATCH blktrace v2 21/22] blkparse: parse zone append completions
Date: Thu, 25 Sep 2025 17:04:26 +0200
Message-ID: <20250925150427.67394-22-johannes.thumshirn@wdc.com>
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

Parse completion of Zone Append commands in blkparse.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 2767edd..725ddbe 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -327,9 +327,31 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 	return p;
 }
 
-static void process_zoned(char *act, struct blk_io_trace2 *t, char *name)
+static void process_zoned(char *act, struct blk_io_trace2 *t,
+			  unsigned long long elapsed, char *name)
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
@@ -471,7 +493,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		break;
 
 	case 'Z':	/* Zoned command */
-		process_zoned(act, t, name);
+		process_zoned(act, t, elapsed, name);
 		break;
 	default:
 		fprintf(stderr, "Unknown action %c\n", act[0]);
-- 
2.51.0

