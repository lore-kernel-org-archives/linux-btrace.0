Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E92701B8
	for <linux-btrace@vger.kernel.org>; Thu, 24 Apr 2025 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474066; cv=none; b=SlzjQur6yQ5LWtMQx9tRmlj+usDEoSvG7tTNbxkhOVL8brIvliRQWKxebfVPe9CFXqWpBYTNZWl6i1P3pqNIOoMY1Xo/zC/UlPWNimLooUjJv84qPUsIDKWDwkvmBg/qDozjlqalpFAlXplL6bjd/THNQq4IjNR5uNnWJfBXzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474066; c=relaxed/simple;
	bh=MgH7reT437NEfgna/wKNc1v1arWy/+4kV2VUxbSrZp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XekT+8+iiAOdhW/qNV5x49mxdxTAzAjlEj6dHDh5uG5IEoLZBlArRhmjEPrT8FbjsXlqhoUzkT/480aIG41+jWLpq8RdcLAK62aDT7tD3lrZRapMG9FLXZLX9AiWu4W8Aoz9UZEOg3MD4EXEGEZEU7f9mbFW/ezmMYiehclJLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8cf339cc20d011f0a216b1d71e6e1362-20250424
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
X-CID-O-INFO: VERSION:1.1.45,REQID:165cd93e-7e6a-4de4-b903-25c8fa56b833,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:165cd93e-7e6a-4de4-b903-25c8fa56b833,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:9475b177a5da8382afa986bac69dcd91,BulkI
	D:2504241354162YT6COV1,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 8cf339cc20d011f0a216b1d71e6e1362-20250424
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1433592184; Thu, 24 Apr 2025 13:54:13 +0800
From: Fanhui Meng <mengfanhui@kylinos.cn>
To: axboe@kernel.dk,
	linux-btrace@vger.kernel.org
Cc: mengfanhui@kylinos.cn
Subject: [PATCH v2] btt: add a switch to change it to msec
Date: Thu, 24 Apr 2025 13:52:34 +0800
Message-Id: <20250424055234.985420-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Output latency time in msec to increase readability.
as the normal time for IO requests is usually a few
msec. Therefore, add a switch to change it to msec.

default command and test result:
btt -i   blkparse.out -q q2c.lat
1.725317 0.000292
1.725275 0.000337
1.725326 0.000288
1.725334 0.000282
1.725342 0.000277
2.039203 0.000217
2.039463 0.000123
2.039715 0.000174
2.040144 0.000184

switch to msec command:
btt -i   blkparse.out -q q2c.lat  -w
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
 btt/args.c    | 12 +++++++++++-
 btt/globals.h |  2 +-
 btt/latency.c |  4 +++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/btt/args.c b/btt/args.c
index 5c5078a..ec65399 100644
--- a/btt/args.c
+++ b/btt/args.c
@@ -29,7 +29,7 @@
 
 #define SETBUFFER_SIZE	(64 * 1024)
 
-#define S_OPTS	"aAB:d:D:e:hi:I:l:L:m:M:o:p:P:q:Q:rs:S:t:T:u:VvXz:Z"
+#define S_OPTS	"aAB:d:D:e:hi:I:l:L:m:M:o:p:P:wq:Q:rs:S:t:T:u:VvXz:Z"
 static struct option l_opts[] = {
 	{
 		.name = "seek-absolute",
@@ -199,6 +199,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'X'
 	},
+	{
+		.name = "sec-to-msec",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = 'w'
+	},
 	{
 		.name = "q2d-latencies",
 		.has_arg = required_argument,
@@ -239,6 +245,7 @@ static char usage_str[] = \
 	"[ -v               | --verbose ]\n" \
 	"[ -X               | --easy-parse-avgs ]\n" \
 	"[ -z <output name> | --q2d-latencies=<output name> ]\n" \
+	"[ -w               | --sec-to-msec ]\n" \
 	"[ -Z               | --do-active\n" \
 	"\n";
 
@@ -384,6 +391,9 @@ void handle_args(int argc, char *argv[])
 		case 'z':
 			q2d_name = optarg;
 			break;
+		case 'w':
+			sec_to_msec = 1;
+			break;
 		case 'Z':
 			do_p_live = 1;
 			break;
diff --git a/btt/globals.h b/btt/globals.h
index 22a1cb0..0331ecf 100644
--- a/btt/globals.h
+++ b/btt/globals.h
@@ -179,7 +179,7 @@ extern double range_delta, plat_freq, last_t_seen;
 extern FILE *rngs_ofp, *avgs_ofp, *xavgs_ofp, *iostat_ofp, *per_io_ofp;
 extern FILE *msgs_ofp;
 extern int verbose, done, time_bounded, output_all_data, seek_absolute;
-extern int easy_parse_avgs, ignore_remaps, do_p_live;
+extern int easy_parse_avgs, ignore_remaps, do_p_live, sec_to_msec;
 extern unsigned int n_devs;
 extern unsigned long n_traces;
 extern struct list_head all_devs, all_procs;
diff --git a/btt/latency.c b/btt/latency.c
index 51e6881..332d05a 100644
--- a/btt/latency.c
+++ b/btt/latency.c
@@ -20,10 +20,12 @@
  */
 #include "globals.h"
 
+int sec_to_msec;
+
 static inline void latency_out(FILE *ofp, __u64 tstamp, __u64 latency)
 {
 	if (ofp)
-		fprintf(ofp, "%lf %lf\n", TO_SEC(tstamp), TO_SEC(latency));
+		fprintf(ofp, "%lf %lf\n", TO_SEC(tstamp), sec_to_msec ? TO_MSEC(latency) : TO_SEC(latency));
 }
 
 FILE *latency_open(struct d_info *dip, char *name, char *post)
-- 
2.25.1

