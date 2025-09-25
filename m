Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219A315D5E;
	Thu, 25 Sep 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812730; cv=none; b=ksyjHfjGX0qHkrnU2BYgqBZ5HiWGnzfnsj12C17uCGT6IgNsqv613LdBiN1Nh2jwQJ9sJp2VAnydn9Jw+ZnJpa1wve5Bk2jZyj5zgdCUYSnvC+6/IogHgmiIfPilXzsQ6IAcimcXN2XBfekLQaLON3GlxEmMNOin3ea5LYFZjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812730; c=relaxed/simple;
	bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmyU+D/EV6Dz4lidQ1fLw8MiDjRl9I3hLcnmG8QkaL/C468lB3d/f6zHLW3CI2xqrZi7QyzTIbf0wh9nVDT9rHZQne7MJHyPnnxUtHmL0y7rZFzlxunHzfidOB7lhyv14B+ydM+CbKwVVbw7qe47RqHTQhSv+1Buwt+Em5lKb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AmfS68eA; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AmfS68eA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812729; x=1790348729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oS1kgcAgXjp0aHkhvXj8mPE9QIVrKKYTq1StaQgUmk=;
  b=AmfS68eAF4dpOfP0vNeWghk4+SgLVJsUa9vMddMbj01K3CeJq8DOaezT
   vAtr3JMv0SA+JWq94mD4ZshL/b7UmiZnJzUZ/ZCLcn2nmzUePrydn9/3s
   fH+f80fq+5zx8jF0m4C7t1Ni9Or6uYcNND2C+gsSHvqScb1kgZeDPHpcq
   +jjuNY5+VXdTe+Bsd//6JWUxxj0St9XIhn8ErV9DvWM/6qk8W12k1e3hn
   CAxKdiVFjn4zlzhFFM6TEoOMO4ZwOYr4KBT+lZe809EzQSzuqkGrCEt7e
   cSPAlh16e4A1uy/ZjJGoy7IBC/K1gG50fDby6KFYfVgQmInPaSzjBuguW
   A==;
X-CSE-ConnectionGUID: NHC+JBhBRh2S9dzfMSLQ7g==
X-CSE-MsgGUID: dUXlX1NMRomcVn89f1GltA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349192"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:28 +0800
IronPort-SDR: 68d55a39_jrFYughe2AsfsWDuucg0pGckjgxxX+/WNXHHfluxxhsDwx0
 SHQ2o5Dr9Yw/WNqtr3mvybqXruuKcELa3fKqEwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:29 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:26 -0700
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
Subject: [PATCH blktrace v2 13/22] blktrace: pass magic to CHECK_MAGIC macro
Date: Thu, 25 Sep 2025 17:04:18 +0200
Message-ID: <20250925150427.67394-14-johannes.thumshirn@wdc.com>
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

