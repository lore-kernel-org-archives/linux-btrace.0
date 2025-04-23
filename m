Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E03276025
	for <linux-btrace@vger.kernel.org>; Wed, 23 Apr 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396967; cv=none; b=PZOFfnmx7JO4cBr7ZK3LbLEhFyWBL6EDKa0zffKOUcGSHFFqLHbB/8IJDYI94oDAnRLNU6Gxl7h8j9nxNnMPtc7wFtOONsYQVonOAzMgwePiCb5hednAv5vbJfhCtdxBeHJG2OP3BfsfrL7WDCfEwVNdkwDF9Y+pl6pF0SP+HZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396967; c=relaxed/simple;
	bh=b2QAajXa09Fb7VwXufznhRnqd8zWQ8WCsh6b4gCw5mI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VoVg6WDGDr2TB/LatT5gP8uQnHtvZ+Y3s77SsdNmea12wqNBLf2FMtSkT534Z3ZAxH/yeGlNHJLkjBArb2Ue22u7iLEHIoNndoBLGy+Hyo8yeUXdzU8hE2WCQB5HsXjnzrK6nu/Ac6B1NqQGPMPYlszbv5MfK1IbTZtuQlvFJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0ca80ca6201d11f0a216b1d71e6e1362-20250423
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:68617379-4796-4a41-9959-4652385afdb0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:68617379-4796-4a41-9959-4652385afdb0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:2b9ac480e4768f8e7f4afa02d5ad8423,BulkI
	D:250423162920LLF0C022,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0ca80ca6201d11f0a216b1d71e6e1362-20250423
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1819596621; Wed, 23 Apr 2025 16:29:18 +0800
From: Fanhui Meng <mengfanhui@kylinos.cn>
To: linux-btrace@vger.kernel.org
Cc: mengfanhui@kylinos.cn
Subject: [PATCH] btt: use millisecond output latency time
Date: Wed, 23 Apr 2025 16:27:29 +0800
Message-Id: <20250423082729.520799-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Output latency time in milliseconds to increase readability.
as the normal time for IO requests is usually a few milliseconds.

q2c.dat test output result:
1.725317 0.292148
1.725275 0.337183
1.725326 0.288462
1.725334 0.282350
1.725342 0.276609
2.039203 0.217158
2.039463 0.123061
2.039715 0.173856
2.040144 0.184456

Signed-off-by: Fanhui Meng <mengfanhui@kylinos.cn>
---
 btt/latency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/latency.c b/btt/latency.c
index 51e6881..331595e 100644
--- a/btt/latency.c
+++ b/btt/latency.c
@@ -23,7 +23,7 @@
 static inline void latency_out(FILE *ofp, __u64 tstamp, __u64 latency)
 {
 	if (ofp)
-		fprintf(ofp, "%lf %lf\n", TO_SEC(tstamp), TO_SEC(latency));
+		fprintf(ofp, "%lf %lf\n", TO_SEC(tstamp), TO_MSEC(latency));
 }
 
 FILE *latency_open(struct d_info *dip, char *name, char *post)
-- 
2.25.1

