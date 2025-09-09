Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C0320CDF;
	Tue,  9 Sep 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416109; cv=none; b=cYbFna0v2xBXPKfvDYFhAC5UvnIaV9imONVrJ07QWUv5uYHURnZBXvSiSSbX+54IUyxAwHvsaJoe4+Ua6J0DaaEfWt6sEygvbagINqDNngc5ikZ/1MA2c/3hDuisyWhS0ZIwvUycgURIg01OgqkEJQgjI1CTkV3MKRuegkwD/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416109; c=relaxed/simple;
	bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4gQMfnstXgrLNCWc/LU+wm5hKuh8oP4X/Bi0YfF/FlsoRnniM0GwlwhTZkBAOEl4IpIbcKiZMyJOoCg1vdJx7Qv3lv7KB7dKjrP4W7rOd94Jur+ptncqQ+Pq46vndywXfX3RbiMMGoqxA/XKu+0QKklbt526CPVpYMsBVtVzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=roaUqzG3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="roaUqzG3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757416108; x=1788952108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
  b=roaUqzG3DKNuKFvwY9ZANIPuVhW1w/6Vyr47ap6goPkFBglfWp/m/mpM
   knjbkLbfs4sT1qJ+uvp+B0GoBReNJZJG/UFBzlxUng5UsQYVvXdlByM5+
   XRH7bAc0vA/Rf6Se2sx7rKkmTVszLxh/50uZbbZH50Vw7CCc/zcJPhF2q
   u/prMbXFPyRZhym9HRc8AgWV9WewXf/7aKMZlCjB5drsXVP/A37vYGJNb
   35jZoRIKu6iWur3sl2EwJFVP0k/mId6QjkVJ8b7wHV9ehFAibCOatb32A
   Oid2cZX5UKOi8aJ9w2YAbK//DrAmpInQiiHkeTeBo1NjPTaq9kHNkBEi2
   A==;
X-CSE-ConnectionGUID: /39Hfy8YQ1adk9uhUW8uTA==
X-CSE-MsgGUID: aflApoD5TWeL72hVWjLdkA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751212800"; 
   d="scan'208";a="112810744"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 19:08:28 +0800
IronPort-SDR: 68c00aac_kMsR2DaramIEdoDIgi7N+rURCKvCMBU3hpVT34xqU+990YI
 VjG7RlOuAIXjqMbzGXh26z3+MePYIk1BzDV78zw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:08:28 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 04:08:24 -0700
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
Subject: [PATCH 13/21] blktrace: pass magic to CHECK_MAGIC macro
Date: Tue,  9 Sep 2025 13:07:15 +0200
Message-Id: <20250909110723.75676-14-johannes.thumshirn@wdc.com>
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

Pass only the magic number itself to the CHECK_MAGIC() macro.

This enables support for multiple versions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkrawverify.c | 2 +-
 blktrace.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index 9c5d595..cc5b06e 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -183,7 +183,7 @@ static int process(FILE **fp, char *devname, char *file, unsigned int cpu)
 
 		trace_to_cpu(bit);
 
-		if (!CHECK_MAGIC(bit)) {
+		if (!CHECK_MAGIC(bit->magic)) {
 			INC_BAD("bad trace");
 			continue;
 		}
diff --git a/blktrace.h b/blktrace.h
index 3305fa0..81a5b51 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -67,7 +67,7 @@ extern FILE *ofp;
 extern int data_is_native;
 extern struct timespec abs_start_time;
 
-#define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
+#define CHECK_MAGIC(magic)		(((magic) & 0xffffff00) == BLK_IO_TRACE_MAGIC)
 #define SUPPORTED_VERSION	(0x07)
 #define SUPPORTED_VERSION2	(0x08)
 
@@ -93,7 +93,7 @@ static inline int verify_trace(struct blk_io_trace *t)
 {
 	u8 version;
 
-	if (!CHECK_MAGIC(t)) {
+	if (!CHECK_MAGIC(t->magic)) {
 		fprintf(stderr, "bad trace magic %x\n", t->magic);
 		return 1;
 	}
-- 
2.51.0

