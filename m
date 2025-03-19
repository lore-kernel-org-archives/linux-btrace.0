Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BE35963
	for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389816; cv=none; b=cnMkKZMw8VBsABIWh/H+nbiTzlJXFuqeRVsvz/WMgklyKGn8Pm17vAEjWpqspUJ3628dqRqIvv682jeMuxB+EdWoI8xTElE3PXqr+sontVmeogn5de1OwAzPWs1PftSUURlvPptpJWCWgUWrxuasJq3dogJSuToqMfZ1rggVJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389816; c=relaxed/simple;
	bh=uu+/gpilfCVqqVgXCPZc1c9LbLWFl0PzCNpXbyLDLsQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=k2JlIfZxNghMoYHQPjq5aRhq5BoDboT62ZNOdoW2bbXdbnJMQDRUuSdnI9wZ8Uor4Bsgv3z2Q0HicWrQXQMIPJjnM+OVR/YcRSG3QHF1yYubOD/q5UBx4NnWTafSLMBjDwLFzBuiU2fd9i5K9EpNfjalLFE/VPvL17l1eELblkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TlVsYNnl; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TlVsYNnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742389499; bh=ClMS4+YFMVMpfTZT09jjKXNylrrl8NGSOSgrxEtC49g=;
	h=From:To:Cc:Subject:Date;
	b=TlVsYNnljXcfPyzX/zzHFC2efRj4WwI1SKugZXsliPJTnvN8Jof2XOCfxJWIPkchk
	 zRO8MG55EkVWEy5k5FqXTRoKGQfjxf0s42oOnbIr8FNp1Bx+684kMpS3CpB25Bljx3
	 kb3LnDImOIwhU/jjlzP5WOiC4wcwqehh6UOuR09w=
Received: from localhost.localdomain ([223.104.107.92])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 1398A8B2; Wed, 19 Mar 2025 21:04:57 +0800
X-QQ-mid: xmsmtpt1742389497tozzzzs54
Message-ID: <tencent_DE806EEE1852F9E79115172254B8A2789207@qq.com>
X-QQ-XMAILINFO: ObZOwVx6OJQlqqAoifkMuJbUTRTr9Luq9mzaGfJQM7NsDqIITghud84m4R/O69
	 t27OAaC07Hqaz+EPP+m3e4Oou6t5jZn5p9gwr5Leh1n/z7pzrQJFihJi8Ng8VOqGJiVZmC27AUQH
	 AmursrUaYnWvnG/hOq82wGPKcjCQ8t2b+NSrqkyRq7EuVbTtposAv52cks/Pj07aiXXiARo4Tge2
	 /ru1tP1jagFwAZ/JsBrrKA+IWYxzXy4EFymN7VSE0MQMuQaflynKdp/ynzrVgYi0eRp0Y1xP/6NW
	 LajlGoNuz/OiRz5p3yGz5giazOPz9dgWk2GN3YuVdpaZzNHOExurpLMgJAu+FCVYc7TqsrI9na07
	 iL2WLeRM0SiQxW5URFhBX+jvR3FjSq8jN7Gm8/Wq9c27+w3E/rx+cpwoa0PyGAcWTjKn+BxB9UmS
	 6bPJL/q5huX8AZ8xWDov0vzrjp6YqdclksDpWN1JWCOxAjhZUlvzUmVTsYWV8z+Xw9qQDrm6wP0e
	 mMEr/iiEo2mcEMN39CTRqT0VHCow214Xs19LCST8H+kuvtJ+jOF1xLY3MRxzd1cv0lGnBAeu+pDe
	 wOO2hyMyiKZI7q1IK2DLpMDyGSqTz3lIqPFahzHSBNZi+emfgRh85EmZ2mf97ACBGzJ2nM17D9nU
	 JsCLznpqpalyrplvfi9GB5OskQWkj40ug+RaxLdDB9hqyIKgysK0FKYVdq2kwlFWZt233EsYfpbM
	 1pNBOCSK78ymS8w9PN7HcawpZ004Z9jJPxqKSg4icImumQiwufkPR6jGoVK2X6bSoTZFZCTus0zr
	 N/g6SQjR5FrixOH9vCZRnVjpV+umRoh3U5/nqswFzSwQPHHPxf4FzYF05lYw72N8Wh4WYz5mmlkj
	 lIRUX4mAeWZqwnj0JrD5ad6b9q+1gRkpAMVx/1PvDVUA/07h6hUWjLRmHTz/6WhWoHTq7btJ2EuU
	 XLiZ/rQneVEERrPT5YCUXteR+8IVKE+w8E6uWHxAiwK5ckg582knUAHZARlEU2
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH v3] blkparse: Fix a potential coredump issue
Date: Wed, 19 Mar 2025 21:02:49 +0800
X-OQ-MSGID: <20250319130249.2640-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

Executing "blkparse -t" may cause coredump due to
accessing uninitialized memory.

8,16   0     6092     1.436280373 20685  Q   W 15356912 + 4096 [kworker/u256:2]
8,16   0     6093     1.436282093 20685  X   W 15356912 / 15357936 [kworker/u256:2]
8,16   0     6094     1.436282735 20685  G   W 15356912 + 1024 [kworker/u256:2]
8,16   0     6099     1.436358617 20685  X   W 15357936 / 15358960 [kworker/u256:2]
8,16   0     6100     1.436359418 20685  G   W 15357936 + 1024 [kworker/u256:2]
8,16   0     6102     1.436359931 20685  I   W 15356912 + 1024 [kworker/u256:2]
8,16   0     6103     1.436360874 20685  D   W 15356912 + 1024 [kworker/u256:2]
8,16   0     6105     1.436436572 20685  X   W 15358960 / 15359984 [kworker/u256:2]
8,16   0     6106     1.436437679 20685  G   W 15358960 + 1024 [kworker/u256:2]
8,16   0     6108     1.436438205 20685  I   W 15357936 + 1024 [kworker/u256:2]
8,16   0     6109     1.436439368 20685  D   W 15357936 + 1024 [kworker/u256:2]
8,16   0     6111     1.436530404 20685  G   W 15359984 + 1024 [kworker/u256:2]
8,16   0     6113     1.436530842 20685  I   W 15358960 + 1024 [kworker/u256:2]
8,16   0     6114     1.436531748 20685  D   W 15358960 + 1024 [kworker/u256:2]
8,16   0     6120     1.436755261 20685  I   W 15359984 + 1024 [kworker/u256:2]
8,16   0     6121     1.436756476 20685  D   W 15359984 + 1024 [kworker/u256:2]
8,16   0     6128     1.437120354     0  C   W 15356912 + 1024 [0]
8,16   0     6129     1.437121875     0  C   W 15356912 + 2048 [0]

Breakpoint 3, log_track_split (pdi=0x430260, t=0x711990) at blkparse.c:1076
1076            iot = find_track(pdi, t->pid, t->sector);
(gdb) n
1077            split = malloc(sizeof(*iot));
(gdb)
1078            split->req = iot->req;
(gdb) p split
$1 = (struct io_track *) 0x69bdd0
(gdb) p *split
$2 = {rb_node = {rb_parent_color = 6929360, rb_right = 0x0, rb_left = 0xe81bf0}, req = 0x2000d00080000, next = 0x800010000050cd, sector = 2251799813685248}

Program received signal SIGSEGV, Segmentation fault.
0x000000000040bcbc in rb_set_parent (rb=0xe81bf0, p=0x69bbd0) at rbtree.h:133
133             rb->rb_parent_color = (rb->rb_parent_color & 3) | (unsigned long)p;
(gdb) bt
 #0  0x000000000040bcbc in rb_set_parent (rb=0xe81bf0, p=0x69bbd0) at rbtree.h:133
 #1  0x000000000040c724 in rb_erase (node=0x69bdd0, root=0x430418) at rbtree.c:273
 #2  0x0000000000404810 in log_track_complete (pdi=0x430260, t=0x712810) at blkparse.c:1223
 #3  0x00000000004055e4 in log_complete (pdi=0x430260, pci=0x4bc100, t=0x712810, act=0x40cf60 "C") at blkparse.c:1518
 #4  0x0000000000405ea0 in dump_trace_fs (t=0x712810, pdi=0x430260, pci=0x4bc100) at blkparse.c:1680
 #5  0x000000000040604c in dump_trace (t=0x712810, pci=0x4bc100, pdi=0x430260) at blkparse.c:1722
 #6  0x00000000004090e8 in handle (msp=0x433cf0) at blkparse.c:2639
 #7  0x000000000040931c in do_file () at blkparse.c:2712
 #8  0x000000000040a0cc in main (argc=4, argv=0xfffffffff438) at blkparse.c:3045
(gdb) p rb
$3 = (struct rb_node *) 0xe81bf0
(gdb) p *rb
Cannot access memory at address 0xe81bf0
(gdb) up
273                     rb_set_parent(child, parent);
(gdb) p child
$4 = (struct rb_node *) 0xe81bf0
(gdb) p node
$5 = (struct rb_node *) 0x69bdd0
(gdb) p *node
$6 = {rb_parent_color = 6929360, rb_right = 0x0, rb_left = 0xe81bf0}

Signed-off-by: Kou Wenqi <kouwenqi@kylinos.cn>
---
 blkparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.43.0

