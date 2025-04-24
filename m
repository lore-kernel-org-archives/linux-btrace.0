Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784441B0435
	for <linux-btrace@vger.kernel.org>; Thu, 24 Apr 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478837; cv=none; b=ows8lCz/g3Z5OIMINdpA7MjQjOISu669bIatIBGa6BMO0QjskJ9WN8jNvlqiXTD7qvtYJm3Y2yFkOAxxtTIjJdDYLO5ZKGTcsvJFwVi+HBm1g4IbFWwiguGX6jyboAAm3zhSMgdqNWc2pR9HD5g4CmSLWcGld95Ypc6KKkDOGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478837; c=relaxed/simple;
	bh=kFy2j28Ry6G5c7FjxIp6hVeUlO1T141DddvRpRC1YXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FCp+5vBrolqbijQBCECpVldLAYfSR03yCJI7puSg00YdxFBoGxY47OL1FvhzbJuX24PFvC8vUZIMR+xVYZ7FYdtpQDWjBzcxNYmTV2xsOrGfPaz67XI10Aw0THzBJOIapOPil38+6EPQvgvL3YIGGfZ2i0tCNVUE8gBYUyTmpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6d7c47420db11f0a216b1d71e6e1362-20250424
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a6e1149c-4630-454d-8a44-ed4aa8cbf29f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:a6e1149c-4630-454d-8a44-ed4aa8cbf29f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:2941fdd6cf3ea2d11702314d427408aa,BulkI
	D:250424151344HDHUDHQD,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a6d7c47420db11f0a216b1d71e6e1362-20250424
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 763811195; Thu, 24 Apr 2025 15:13:41 +0800
From: Fanhui Meng <mengfanhui@kylinos.cn>
To: axboe@kernel.dk,
	linux-btrace@vger.kernel.org
Cc: mengfanhui@kylinos.cn
Subject: [PATCH v1] btt: fix error configuration do-active parameter
Date: Thu, 24 Apr 2025 15:12:16 +0800
Message-Id: <20250424071216.1356183-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_args handle do_p_live function using Z parameter.
Therefore, when configuring parameters, it should also be Z.

The introduction of parameter help also corresponds to Z.
"[ -Z               | --do-active\n" \

Signed-off-by: Fanhui Meng <mengfanhui@kylinos.cn>
---
 btt/args.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btt/args.c b/btt/args.c
index ec65399..56e3f6b 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -191,7 +191,7 @@ static struct option l_opts[] = {
 		.name = "do-active",
 		.has_arg = no_argument,
 		.flag = NULL,
-		.val = 'z'
+		.val = 'Z'
 	},
 	{
 		.name = "easy-parse-avgs",
-- 
2.25.1

