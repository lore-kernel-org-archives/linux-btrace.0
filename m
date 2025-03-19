Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC462571B1
	for <linux-btrace@vger.kernel.org>; Wed, 19 Mar 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387434; cv=none; b=lkZ4j3Y+ns6nVmN5u1hAmAp8HGuV16NT8Ic0DjYYmFQCtD3m/hrGpOspepOtESvJI0OKGJDhnpUvY3I9R14nyboy4DyJkEkmPHhdbPCTX6Vcb8hp1D7bt+U7BP52GLWFfFuNcJTaQWoO7/gNgfPF22xNIJFI0H+yREVlTaLERZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387434; c=relaxed/simple;
	bh=7xIC5g26z6KQnHZdmbYA84eI2QLK6ejxDN6PXgF4DuU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JJ1yWwEC0WPmeItXYavmDRKSXK8BF9KGVoKtzAjhXu0qn/YiXFh6fxqZAO9WqRhfTgu5JEppKjdfa8wuWsl7qApNk5LdEV9SS9h1+j2IAcn2ybgW712fCJJj84THahYAQwqvTXjpwmjcbZx0f/kmUe4f2l//l2e/1sqdDAzVTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EF4zfLaJ; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EF4zfLaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742387119; bh=eU0gP58zu16nK0crC/kucP9eLX8UzXJ81SCeLHhIUPI=;
	h=From:To:Cc:Subject:Date;
	b=EF4zfLaJTVba2grjT5COoAdUvs4XBDiznYfijICfUnThPTiClVDrag0DlUTfrO8me
	 BYnHyPrs6Rlz27fOO8dX1/Q3gPNtkbY15wmS93ymyY9SGzRnvs5mKunnNT8I9k54N3
	 mnAFUvRYw89nT/aiVMD53pqhVT+tvap3N6ZhK4gQ=
Received: from localhost.localdomain ([223.104.107.92])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 6513D283; Wed, 19 Mar 2025 20:25:17 +0800
X-QQ-mid: xmsmtpt1742387117tzfq746uz
Message-ID: <tencent_4C259E2F20843B8474E09968258CC806EE05@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlFK6bs9YRCibMI1MCTeiizcr7RSY0sVfLpcD834DfhVN/QM1KMJ
	 pMsyrIYQ76ZHfCEeOmsZrDFsazaannpwbmNCwpormK8bLMBW2/IgbyrGcwyAQ7ralqZDC1xm6fTb
	 zg5QaHnBSCbKyBVKweDnpn5sW4/CWB7sYphjqXLrM2xf4/Pa9he0TZmzQwN2Oj24dO1UyOUDXmd7
	 LUOEpHVEvmtlOJCbve4sZTxQ2uRDZ9w63otyOOyo1Rz+7nLYwhOT6Ld3OycUBmSbXv5q6BRDWUFc
	 GSkWeXyVySdzsOZT9FXryCW6UATKNrMemhq3NIKWk/A0J4gKEEsrYFVYEcDN2U5pEFgZ3DR1qtPa
	 WiC4PkkRuB0Hptm8rKskVzelAscJa5p/fPS6FNdbBmzOrsCw66r6y8Njhk9Zho1hqbdGSJIl+0Uh
	 8t001UM5KllIEbbv1zKPgyQkqcIbzRLrY98ZusjQohY5xUqcO89J5cSS5/07Aecg/l0cFHk+otQC
	 4JCEeIK293UXbjpmnXKiCRi83gvKKKNEQzqRaRbfmuAFjQAnV2PiLq29drBeEpl5N4Gl1LkKLdGG
	 2A3TaJprJ3WEOZ6rRwwSO4x48Oyqkgta/KdLadWdcIYjZbZNCa+ProkiFlKG02YJDBomtUDHEyKq
	 ZkfbTuxxgUnJeLLLzqXvZhkebnvSg6MwB9qhWBmVMAk3Woylh8AVlPatEpiQ+pYR1wsCXGU9lFSr
	 o2Dfcc7iEceK9aQjHMtipjUyeqOhnzw9Z0nnLFo6tjiyAXaTgU5A6I4HZWrQoceWL9mPjCB/N5+b
	 YbisB4IM0n1v/UpJ4EvvkhXYvHn4wiOjuQaA7vp1wccgaAdo/7U0lHwuk6we6Yormro7KTFSo8NO
	 aR6RCtwm01TSmWbvKCnDTSA5Uo1/AWlAzDIyWoeWqomlk5VM84O9YKxLo16mEsuQTu0xYOSXsQBU
	 k9PjyMonj4hS/RzhRPOOB9DPVW7sbcq98thJiBfWA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH v2] blkparse: Fix a potential coredump issue
Date: Wed, 19 Mar 2025 20:19:50 +0800
X-OQ-MSGID: <20250319121950.2543-1-303146950@qq.com>
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

