Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C02528E9
	for <linux-btrace@vger.kernel.org>; Wed,  9 Apr 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191925; cv=none; b=rIU4/xHj0/OzfdufSdJUC2/qyQEtWAbd2Q4g9DEUiIQe90Ikfnu5KC86F/jW9lQRMhcdhqfAIREp7UypbwhwQZu6BWIiOdbXc9qbjMhI1F6OVwgQQ2iFlD1CtUXG21N7Ygl/UAvxdLKdHdabveH29KVkJUq70ztVG7v4KX/YhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191925; c=relaxed/simple;
	bh=hOcPtbjRHcM2/YOf8OvHRxELycw6xymGlBk3OGne+40=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fTAXUbi7cl06m4b+VAMZz2K83jAtxlK7YiIwDam+NkMv2vqN/VfYecqaT28KwkpJbbqGjinVsNXB+z7/u2Hts0dRBCM/gTUGxkCsReBbzgmc80BbIzs0OHw8mBIqbu2WUVebauvA12aVTNqaaNUA44B1xhDrVjRazYJ4KanveOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KKOKGA46; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KKOKGA46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744191612; bh=Lw2FY3NmfKLUMMxlWf994S1Rm1THYVOI7OwEQGT4NdE=;
	h=From:To:Cc:Subject:Date;
	b=KKOKGA46MrgPgUbUulzMCkYBOiccBe6opAJitRjnuVYOOx9fGZVU0qTj/GuRqlllR
	 VMsQJpqnYkdDsF6ZnA82nCdPSO0NFYol9967EYpa1/boTWpmGVTFAHOLG3jiI+0E19
	 KOFwz7mMSnMbt2qsWh/Xj31h8Bn/LbrhE7IYlUVQ=
Received: from localhost.localdomain ([39.144.177.14])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id A0A9F07A; Wed, 09 Apr 2025 17:40:10 +0800
X-QQ-mid: xmsmtpt1744191610tz5qdc2i4
Message-ID: <tencent_82C549379F3956788830E028E3AB0394B809@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jNbfmyOo1xC5a+vcTdAffVQ6x2+ul0ajBycMEuPv/7cHwm/vAa9
	 QhBuNEK3O1Z5NMlNGiaxltQhxXxdQuy5ok6iKrP94DlFLvAq1n6JXeOaowBGhItBzy77wuT8rrwy
	 i5HGPUsM6iNEmWaC2JGhi6FfR8tKYmRCHBhRl8GuYXUpaK3l61matPLO2Xn9/O5m+nHnILNL9XJa
	 KTDJwEBWlZn+B85BYoroBL5y2vNwbsniUzTDrr9bIDDL/NqwqkS7yX8hcSaGw9sJgAoZqIbD9bml
	 2QVT3OfIQdCARxKaHiHXoDMq44hqq1wjNlPg9NObMyK7E8q0PDywnQw1KGoB7U21CtiyRkup8zpO
	 tEzzDv+979K0aV8XN4bWwLAe8YX55rztki34aFx1r9BRc5OBUtkJaj6lgGmj41QgpqUlsSO0p91b
	 ud0R7gRCZd4kdlFLY//7ZOxjE4mTQ8cUqmAPCuaBzDDV7b9Zgpp9aqst9wqvhzTwixqS4TKuVGdZ
	 EsDcVK6rgqpG1yTZmO3K+9ek888S/8YY2N9nAGtgbNCrax8URwXn3LVFQscpCtevQYI2P/BminV7
	 AkO5W8pMhKW6Fk0hPY7fFfnyd/i2LdyXkPAvS4IgluFFw6V8XC5LZ+Am6fgo+TW3nSXs6PP9jshz
	 MpQWondNVhGS+CSqQKw4k7fN9CJSCVFcOBrwID2U9TE+u5kp2vxW9BrVkbQGDzmNT0aHF+85UV+9
	 jSS4hkg8WGqqOtoOmzK5VKDE3sMnWlwj+WvdFG5erkFAccx8PKf34VZilAXBedy5Du8GafoG+rEu
	 tl/yI+K0raf7U6iPjVj8GtRp/JYVQKAokVjPpq1+Rvz5eC4QFlYE8joDbiiIHuvj9xSCJFDOu8Zz
	 /ceisGK0qZVCOaeUTWaonl/nrOdCMWS87OBwc6UX/J09JLfgPyvUEHK3EIrE9rg1VCbjvHl7MO
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: 303146950@qq.com
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk,
	Kou Wenqi <kouwenqi@kylinos.cn>
Subject: [PATCH] btt: eliminate redundant separators in btt -p display
Date: Wed,  9 Apr 2025 17:39:30 +0800
X-OQ-MSGID: <20250409093930.5693-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

8,0    1        1     0.000000000  5315  Q  WS 0 + 375 [dd]
8,0    1        2     0.000005314  5315  X  WS 0 / 128 [dd]
8,0    1        3     0.000012623  5315  G  WS 0 + 128 [dd]
8,0    1        4     0.000030582  5315  I  WS 0 + 128 [dd]
8,0    1        5     0.000046089  5315  X  WS 128 / 256 [dd]
8,0    1        6     0.000047072  5315  G  WS 128 + 128 [dd]
8,0    1        7     0.000047513  5315  I  WS 128 + 128 [dd]
8,0    1        8     0.000051336  5315  G  WS 256 + 119 [dd]
8,0    1        9     0.000051562  5315  I  WS 256 + 119 [dd]
8,0    1       10     0.000079209   109  D  WS 0 + 128 [kworker/1:1H]
8,0    1       11     0.000308966   109  D  WS 128 + 128 [kworker/1:1H]
8,0    1       12     0.000467117   109  D  WS 256 + 119 [kworker/1:1H]
8,0    2        1     0.000596478     0  C  WS 0 + 128 [0]
8,0    2        2     0.000616049     0  C  WS 0 + 256 [0]
8,0    2        3     0.000618701     0  C  WS 0 + 375 [0]
8,0    1       13     0.000909790  5315  Q  WS 375 + 375 [dd]
8,0    1       14     0.000913783  5315  X  WS 375 / 503 [dd]
8,0    1       15     0.000918960  5315  G  WS 375 + 128 [dd]
8,0    1       16     0.000933605  5315  I  WS 375 + 128 [dd]
8,0    1       17     0.000945282  5315  X  WS 503 / 631 [dd]
8,0    1       18     0.000946635  5315  G  WS 503 + 128 [dd]
8,0    1       19     0.000947169  5315  I  WS 503 + 128 [dd]
8,0    1       20     0.000950159  5315  G  WS 631 + 119 [dd]
8,0    1       21     0.000950570  5315  I  WS 631 + 119 [dd]
8,0    1       22     0.000973481   109  D  WS 375 + 128 [kworker/1:1H]
8,0    1       23     0.001133980   109  D  WS 503 + 128 [kworker/1:1H]
8,0    1       24     0.001228540   109  D  WS 631 + 119 [kworker/1:1H]
8,0    2        4     0.001377897     0  C  WS 375 + 128 [0]
8,0    2        5     0.001385818     0  C  WS 375 + 256 [0]
8,0    2        6     0.001389308     0  C  WS 375 + 375 [0]

Before this patch, the output of btt -p is as follows:
-----------------------------------------
-----------------------------------------
  8,0  :     0.000000000 Q          0+375
             0.000012623 G          0+375
             0.000030582 I          0+375
             0.000618701 C          0+375

-----------------------------------------
-----------------------------------------
-----------------------------------------
  8,0  :     0.000909790 Q        375+375
             0.000918960 G        375+375
             0.000933605 I        375+375
             0.001389308 C        375+375

-----------------------------------------

After this patch, the output of btt -p is as follows:
  8,0  :     0.000000000 Q          0+375
             0.000012623 G          0+375
             0.000030582 I          0+375
             0.000618701 C          0+375

-----------------------------------------
  8,0  :     0.000909790 Q        375+375
             0.000918960 G        375+375
             0.000933605 I        375+375
             0.001389308 C        375+375

-----------------------------------------

Signed-off-by: Kou Wenqi <kouwenqi@kylinos.cn>
---
 btt/trace_complete.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/btt/trace_complete.c b/btt/trace_complete.c
index 44732c5..6fb2347 100644
--- a/btt/trace_complete.c
+++ b/btt/trace_complete.c
@@ -56,6 +56,7 @@ static void handle_complete(struct io *c_iop)
 	__u64 d_time = (__u64)-1;
 	FILE *pit_fp = c_iop->dip->pit_fp;
 	double cur = BIT_TIME(c_iop->t.time);
+	int q_iop_matched = 0;
 
 	update_blks(c_iop);
 	update_cregion(&all_regions, c_iop->t.time);
@@ -67,6 +68,7 @@ static void handle_complete(struct io *c_iop)
 
 	dip_foreach_list(c_iop, IOP_Q, &head);
 	list_for_each_safe(p, q, &head) {
+		q_iop_matched = 1;
 		struct io *q_iop = list_entry(p, struct io, f_head);
 		__u64 q2c = tdelta(q_iop->t.time, c_iop->t.time);
 
@@ -103,7 +105,7 @@ static void handle_complete(struct io *c_iop)
 		io_release(q_iop);
 	}
 
-	if (per_io_ofp)
+	if (per_io_ofp && q_iop_matched)
 		fprintf(per_io_ofp,
 			"-----------------------------------------\n");
 
-- 
2.43.0

