Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF025333A
	for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386173; cv=none; b=DYSvFpM/2UHe7FKCdJLpzdlhDFy5J5VFRUdD5p4fnAEavIO9ED1UTbWWkOd9Pe4b89DppjgmaUgRtYgvbFWnaVHjlF8h+DbmtG0ci5+TKP7Ys4lzswqqHxZkAWufh4TmqxVegbMAb9ZYN4+aZMdLw+iIsK69MhsZo+b7JXeHO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386173; c=relaxed/simple;
	bh=Hw7Kclfs6OCuxfj/KyVBuRwN0rrfRAOjEA0EcsImeQU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Ic23tSwJM7M7AKg3IkR4LCeXkvdZrs+ByIqdlUugnsW9EyBaOoNeRGpKkzvWSskdGaIpKYs+eMwM/JGZtBd2+s+eHSWQaupCwUA1XNvi/CIhCBWDr89y1lBNyuOHlHkHhAILrx7CjZ050LyN2FtW3FrQE5kZkcY1U7tOlj1o0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=meODEBfE; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="meODEBfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742385856; bh=18mqPh/6ZSFH1IbMNXbXiPVd3TIL6py/piVp1Iu4dCM=;
	h=From:To:Cc:Subject:Date;
	b=meODEBfEU+z0nIc9tl1bvDgvNpkH1H+QA20/Bt4A+y04MaphR9gZC0k+4LpY3VMdw
	 m/E6pVjYNYucU1H4l9lbq/fmVhCNhjMLB9G50bQDJD/a+I8F9/FTXofrnWGTucghvR
	 1NuOByEyZGpqKMmSTZxBENP+uLCd6szddQEFLQr8=
Received: from localhost.localdomain ([223.104.107.92])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 10E2245F; Wed, 19 Mar 2025 20:04:14 +0800
X-QQ-mid: xmsmtpt1742385854txjsw6v8x
Message-ID: <tencent_5CF89C00366E7B52BB678A9512223238E207@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkUnBOpAFtX7Pt5CosnCVQLnJ9gq5Vj/5j3R6l+5b1N0TNYTo+tC
	 bK73fphTRUHOrDC6X0xIHTZL2M+6WR/iLqdxdgJ8II//3uzY0g2QDdb5qVGeCzUSV4vXh5wFD9FE
	 fqD9LK6qcH8nowr8s0UkOn8I+OWo2FJHyhhDZEt1RlAxZFuZ5OQQvlH/a2L1xRVaBQtsDyeHhfxM
	 KNTqjlCGKboPNGohMR9PTbJV6TK3cT8ibiUkpNSUPGG5Qnh3FCEdYMLHmSrkqbBYnvkAl+zvxsh6
	 FN5AV1L/JU/s1n5hQbVrhMLyHU8SWpZSu0KTT/odvaSyZrYYActYoKo6eHVYcT9A+LTVpSyEfpDs
	 Q4JtM/xhf17jnc2ykQ3LCn5jZeT4SJowaD36YCrG+ft+BhKwNOmlSY2GxTI05rHa7Xa6oH2oiNiS
	 pcEGt1uznQ0axbGDgat8DkXyey55D0X9AKCRIm77kSaoj7X0r+A8aofyMum8uXKt+Kp6ULeuajqn
	 6IMX9S0Ly9qB/39DivgySzlMEm3cxsw/QZRiZkf777qlC01Pv3loioG7c7goS46h77F93tGKB7Nw
	 OOyM8zf6WBu2vIpVVJrF6Dn1K1rAhG5Kv74kPs9qZlOTZPcbOsp3lCME+ePo57MelENbE1/zlH9h
	 duXde+ZRNnRsPfVJ97RxxlIFx9lk1u60ehta1syg0kDx6+IvnHTghImB+ecp4CC+zurVCKAlXwuw
	 ahxh3UoHjTvf45E2jKs3yh/NSx/qbVDzw6VEw4b9887rK7BHI9ArvBmSbd08iA9Vmc2cbp9cVR16
	 tr31ORkOwKymdHsOVDsrc2JhiAAHXHdoDUkskC6CAVxz/e0Txs/QruSa4BiInuk/KZmqoVEhb54a
	 CC2OQfQ77TM1E/KxeeV246EQBN43gbOTpTAGdzQRtyCxCOrQqPXLxfrMwaLQOXk/mIWQC8kecF46
	 OM6QvN4zj8gUjXg8ODgw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH] blkparse: Fix a potential coredump issue
Date: Wed, 19 Mar 2025 19:57:01 +0800
X-OQ-MSGID: <20250319115701.2479-1-303146950@qq.com>
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
 blkparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 9d2029a..2c459bc 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1023,6 +1023,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 		struct io_track_req *req;
 
 		req = malloc(sizeof(*req) + sizeof(*iot));
+		memset(req, 0, sizeof(*req) + sizeof(*iot));
 		req->ppm = find_ppm(pid);
 		if (!req->ppm)
 			req->ppm = add_ppm_hash(pid, "unknown");
@@ -1107,6 +1108,7 @@ static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
 	 */
 	iot = find_track(pdi, t->pid, t->sector);
 	split = malloc(sizeof(*iot));
+	memset(split, 0, sizeof(*iot));
 	split->req = iot->req;
 	split->next = iot->next;
 	iot->next = split;
-- 
2.43.0

