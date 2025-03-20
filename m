Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7022157F
	for <linux-btrace@vger.kernel.org>; Thu, 20 Mar 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472011; cv=none; b=sMBVDLPzKS5vedpjVW+DA+ypZy7bUh0IxhhoO33Gc6MfeIEr0DCL4Ewz0/sH22kftXTDKn+MZSawalA0h9+/LYX9UMK+r1qpACW1mo1wkK+g88aP8mgRPKSU8P6AzgWnJpFYYoKINfDzONi+agf4cdG8qDFpR1nKUJyeK0bKZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472011; c=relaxed/simple;
	bh=Xa0ZYvA/GOf81b/vHVGtvawNuEV31AqwCwJFuu20FG4=;
	h=Subject:From:To:Message-Id:Date; b=IemJvzPFQF6weGcjC+vxomybXmchy6TPzq02ywJ7ymEaCAJRiPLkRznwnpHeg7Avq2B4LTbFKFXiXv4a1Dt2karaPwyDcAXH8tjAV1fzGzZRy4mjV24TgVvjZME2pxxHw+HgUKhSZwTMU18/oKdRnd3bBFUrA4ZkRmQ4uK09xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=fail smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lTxKMeSK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lTxKMeSK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Date:Message-Id:To:From:Subject:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=VgKhV6JgfNneSlED1qL2m+pq0RLABvhgU6XWs4/ZGOI=; b=lTxKMeSKMc2gNTi931VRn0hc8W
	rUSxCF7/WfeZO7qB7aUfawzQHffR4PdhNox5iMNapHEQXldIkBSyJ7wxY+COLoNY9rB9nAMG+0gE5
	KdsFH/3EwNC4RNCRRtJiGVKWRBnMpc6DnBnMZnevMP8t+jw3fhK8C9zrFGyeC0fo1RJtzjH4g0aA3
	igPsbaiGYc7OVWskFv+sdTYjDA+V5hh2cs8nBfAGZBmspDR9EpgLSJlYdUOuRCecTsa+cqtTc4fXn
	mWioghhfm3Pid+i/+UCCPQVqNwaEgkUZIWDeVmC8MkWUpjqrwDxmZAatY3xL72L0SkBTowvslPZfZ
	niAlIGCA==;
Received: from [96.43.243.2] (helo=kernel.dk)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tvEZB-00000009yPX-0hZG
	for linux-btrace@vger.kernel.org;
	Thu, 20 Mar 2025 12:00:05 +0000
Received: by kernel.dk (Postfix, from userid 1000)
	id 0DF3A1BC0134; Thu, 20 Mar 2025 06:00:02 -0600 (MDT)
Subject: Recent changes (master)
From: Jens Axboe <axboe@kernel.dk>
To: <linux-btrace@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.7)
Message-Id: <20250320120002.0DF3A1BC0134@kernel.dk>
Date: Thu, 20 Mar 2025 06:00:02 -0600 (MDT)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>

The following changes since commit 16b952f4ea2db052f7cc613474d15a76c91c93d2:

  doc: update RWBS descriptions (2025-01-30 09:54:59 -0700)

are available in the Git repository at:

  git://git.kernel.dk/blktrace.git master

for you to fetch changes up to f9bd00dfbd67ce62ca6df6f55d6275b523cd0b39:

  blkparse: Fix a potential coredump issue (2025-03-20 05:06:40 -0600)

----------------------------------------------------------------
Kou Wenqi (1):
      blkparse: Fix a potential coredump issue

 blkparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---

Diff of recent changes:

diff --git a/blkparse.c b/blkparse.c
index 9d2029a..d6aaa8b 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1022,7 +1022,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 	if (!iot) {
 		struct io_track_req *req;
 
-		req = malloc(sizeof(*req) + sizeof(*iot));
+		req = calloc(1, sizeof(*req) + sizeof(*iot));
 		req->ppm = find_ppm(pid);
 		if (!req->ppm)
 			req->ppm = add_ppm_hash(pid, "unknown");
@@ -1106,7 +1106,7 @@ static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
 	 * parts.
 	 */
 	iot = find_track(pdi, t->pid, t->sector);
-	split = malloc(sizeof(*iot));
+	split = calloc(1, sizeof(*iot));
 	split->req = iot->req;
 	split->next = iot->next;
 	iot->next = split;
