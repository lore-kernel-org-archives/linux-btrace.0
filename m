Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527988;
	b=1VXCYf78SFUhQfllC17anxyFZklwgGGOcxR0TfjodU1yA9Ck9odXCAQCfYVuYuziiIDT
	 7xgvUe01XzbBIMkiRRXfYzznG0nhhvOIxPOjDQ0H+OMtJxAzx/EvHPuMWGxb+8i+toWkM
	 1i3GQ37S88Z4CqSC8E8TmYueoxKT7IMbYDef+gMyYJjDTsrKxjIRiszNQYZek60jRyO1F
	 xyt/o/Z7B4cS5NdAE6XoScAHi1btHQCYz0ngfhODHf31FqARFFezJZKGRan0TQonlV7C2
	 shDRKeMYo7ZpFAPAj4BO9Yc9DTl86+0nlPicNM+SxFt+pTAbLbsrnYLlh5GUI0T6Pxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527988;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wIWpELsbxKymjjzK4XGszQgJlvven3hVDTVbmpsRXH0=;
	b=V9u8i1yjxBVQROJTlyC5SmfT5yFRPCPo/XRrGp1xG1HnTbk5aMmb79CYFJh1t1C9MatN
	 FnvxVBWzrtH/MIKzo9D+gfPqhF6+/vLw333k0r6Y88OjcFvsoTx4h42NarNBveXNRaJey
	 Uw1dC1PUd/ggTQ9VvM02eV5ZAp66SFUE8DKSosMO3hzjuDzJd4kSlfvo6UP0k6CB9IoTs
	 xVXFrPUCpHVojPFkuYGJftACKwsLO4zo0xBpd6+4z1rUNDXftHJYUp4uxlHne33fpiKWa
	 AOQDkFmRBUYq5DzgskNj/SdLD34c8YMTRUfyR1zEX4J1qDN5e4IdUYV8ugxUbqOPc7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=nZLO8M81;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=IJQW9+v2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AE606A32A;
	Tue, 24 Nov 2026 13:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 859AE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=nZLO8M81;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=IJQW9+v2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527987; x=1827063987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UFA0UP7zoQmyzvjh7dO7ZWZtmnpcIVdHLkZlcKSEmME=;
  b=nZLO8M81lDv3FFdkSLd7myvrMvPGAwYKeDOaTnRKgKQPzMXStwKrLRUO
   sNnShcUx2tisIW00+z9ZuFxqF+xQKFu2wGru6+H4HwnjZGbEom6HIPWTC
   Jq1JA58fOfz8bvDza6QKj8KhnbPfmlIHqq9REHGUwbS2BKZ1+8T6Z5XOU
   KwUAazWcjPlf0Ij/aYSmye6j8w99hhgnigoe6ESmXA4PiloTTNW2V7Tl9
   rEKurL6hB/S7ONIzn0FBYCpUWVr+61t2vr07nQ0MdMd3yVDusQu1fmPuz
   jveiZ7QWHZ5UjTEt137V2b4MY+UjLLaxZ1wiUqdeuCALyQRYMmBatGRii
   g==;
X-CSE-ConnectionGUID: jq7vg+DaTUatrtN3FSsuXg==
X-CSE-MsgGUID: MbvljrayRjWHqoTgzen63A==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="157409282"
Received: from mail-westus2azon11012014.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.14])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byv+YQeXOP2TCYK3zDeJR008dexTNxrnsELAv6KAplJkht6N6LTaSh2QYSW3wb5zBmzR/R6oBRCnXFsZmAFcXw1qnFZhmH0cb4C0VZehgwLZdMI7eFlfm1/nZigq5wh9Q8ot/nnxjWmUPepZbBwm2+rMytpgIO1i9S59w48XR6m13CRFdXixmPmyJvwqXR1guTx6mpkFgbyHPBk8pTYMNsYVew9QRBTiuVoeCXHoyQIxHG4BaqbhXRYMYkw4siYB/xIBAI0Q+hQ8QxGYVGGffup1iUlolQmqAmHZs5oBvw59ee3IO4e7Fs+G6mEm12GDWG1cu2xujtrMYHduTBXRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIWpELsbxKymjjzK4XGszQgJlvven3hVDTVbmpsRXH0=;
 b=F1hbJo9msVu1rGRRYnD8knZlJBPcI4gRqMPvCcmMEzORhQBXbfBEBlyGb9lYqz9T899vc5hS6GgRlQCXW2NedJrd5bkLPpwv1LcG4aG54zL4a2oj+QDomU5xQbMlGyR1faWXE+8xsYP3nQQJWQjHd7oqJi6B3Ja3mKSDSayUr+kGuRc3izjcXYt1OSHUDXLdchnc3VL9s311OGWUbZkvM0qmzAGSt5DUrR2rVUvQxNZk+/OiTu0mfDEM1sC6nrN+1IzD4dUcAnBXep6dVtHczBgr5kf9mS8/tUrTExCC+BaVmLuoJczCBqo5ehvBanU9Uh+Z9ALMe8D8wUcYd2JSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIWpELsbxKymjjzK4XGszQgJlvven3hVDTVbmpsRXH0=;
 b=IJQW9+v2rUPVftlyIEAIvQ+LDBu9n0p0iVbdvX4wwtKbuODHrpti2Ckg2kWAlT4ESz4SDXp/MtPkn8hZFw1vaGVR6Ptwu0ccJU9UO7YcV96g/P/q9Oy023fB8RN+/7/j1Bm4+5SMbduAlIjpoVAFF2vrpeSBbA7IHfQyZ2v5AXI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BN8PR04MB6354.namprd04.prod.outlook.com (2603:10b6:408:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 13:46:24 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:24 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-btrace@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace 5/6] blktrace: add --ioprio option
Date: Tue, 24 Nov 2026 14:46:00 +0100
Message-ID: <20261124134602.153239-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
References: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Post: <mailto:linux-btrace@vger.kernel.org>
List-Help: <mailto:linux-btrace+help@vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-btrace+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BN8PR04MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7abf20-7be1-4d50-e952-08df4a3154a4
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|23010399003|1800799024|376014|366016|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|5023799004|11063799006|56012099006|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nUDBGrDnEFLU/SHrFqOD8v5+2tACzJz/qp/yN7Hspe+xkY+YPjAslsIAemGUDelN/DYUao4PX/plRQLlbhtEXxHrx/Z4uJSPLde7KN5kuPCY+9p/jBxQqAPczDQDMWA3yZIiyTJHDp+u2sMjb8Gme/t56l5mDq9YwfrDTMjQdajAi13Ioyk7TLWKdM6GxyOmOFqZJ3UPceBk/i+uD1JwVw5jb7G5Rlej2/yWUTMKt5eVwx+CDjYoiNQB9mavUSYq7BY2p5RsuQkq8WqDLU5GCOCc0Lg1vPMifSrNIEsFfd/FTZTiKV4xdyib6z4Sumii+dDx/DdjyCaL4eT4VKtW4DQZhjCxFHxr5VZ2t8j7QxDpCoomUn0qRWbyeskvqhxE45Rn+nOkziUJMr5/7QijIxUlWBw37c0Gvmit+HDY/XWb6g3K1cUkgEonRk6g7LMLGrovilPOPcjRKZ7B9YdkULvVg0TGJzQayp23aXKhlk2JDieFz5vLVWlgAu/zQQ7L0YMOHGKNeyR6vVqzFKW4ZoB6gpQ+jgsX5pDREHW/Tw29UWW+K4/q5pPt6xYoRAcgo2DMf5zykF6BbsDOIJATFdTTxKWnD2bTEDHexhzoT3vwLUO7TCM/Xjh1oqwxWaFWcVeYSoszOGuNBZPM3qqJslDOvnAP/3csjozXwTXKhDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tykD3y+aV0p2GcMPhIOiL1XYkDX3tXDLXI49DiqJxb6n5jxzxxHSWTSEWO/p?=
 =?us-ascii?Q?tlLXY2FgW8ogNtxq3g4ydG05N8albW1nRAI1LQiPyXoqSSFLKt/qMHYLAy4J?=
 =?us-ascii?Q?7ksqrDq1yd0/crtItIz0M19La5Qs3ngZ3tWYqgejm/Xm9fgsAmDqZuQhbL3s?=
 =?us-ascii?Q?w1ij9dLhTaYYHl7obk97p8qFnjdlo3YylUwO2W4f47xWoKLS3VTBT0jCKulu?=
 =?us-ascii?Q?Z+OuozETACKTNCX32hf7G8/lcYlAIQfPZySmfJyo+tg0A3sPHOq0ietfzAl1?=
 =?us-ascii?Q?jeipRJ+IK6Zs5zCE4Pf9QOjdL6rwLIGfGURpSInaCGir+xihsIK6WbeK0gip?=
 =?us-ascii?Q?w6JwUmd9ZX2fFvMlAcG/sGL0+7MFa8WpAPm8su2naha5HgAEQlbhZEiqHq9R?=
 =?us-ascii?Q?mfl7BzAorDqH6cSSSePXo7UI/ngwQM/FaRXOzHCUiKjk7ZBpnELebrqabXbp?=
 =?us-ascii?Q?Nx4YMAhOqqULoGHupR/CvpEE7avV+BQFS9oO9fMdZiCt0iTc2AFWmSEkGfmS?=
 =?us-ascii?Q?gNb3rIc47KC3o+W1+8h2p9izVY71huaTPZeiPlwpFNy377JUeG7dvvOdWWMc?=
 =?us-ascii?Q?LGiKyMXlWVdAv+g10HhXtwJr5ptqi4T5LNrB/EhM4A270a31nQ6s/ntom9xQ?=
 =?us-ascii?Q?6Wfso3jS9qCIbDTRnZuhJU78PbB0Qf/doBcGnexqDyrqkDRRUHGijve3joMO?=
 =?us-ascii?Q?VjCYxbsNLpwIGXOZlMBbOdp+wYhrFEjtcbo7vxeUrYuwlQMlxGBrapLl6Vuo?=
 =?us-ascii?Q?0Bq4aVyraFQ/8ew1C7ROBDnUx+Yjz6shl8ct1VgSkWkOriPLslo/Wp1nAcYP?=
 =?us-ascii?Q?iUa4NMkzFxtHV+VEKGRcEDjNVKyrzHpqB0csuP7Kh6Ozd4AlTTdgs5BXxTPz?=
 =?us-ascii?Q?38eXmnfnS5QALspxd47bpYJ6Qb+x4dupiQzuQ3pmSE8GI57g8OBipLeTU42U?=
 =?us-ascii?Q?HzAyuzNFnaHuTRIayF0bUpvgH8Uz3UKJjqcCuNoRD+Hi+qbp6Mv9nKv87AmN?=
 =?us-ascii?Q?bFSKJQDXp5pY19UQQYuAAW9G6pVdyMbQoXYFwMVs8loHcSlLr9QGo5PGWEH6?=
 =?us-ascii?Q?AzmQpw3uZx0rQ93ACb7XiwFdJNDxn9NkzuZAOdnSODLMGCAPPf2HfoWWtXfH?=
 =?us-ascii?Q?tZfNfSrqNzC1BPg+inYnpAo9oEQsxCHRjYTEGYVWQpy9Ba4exkyRJoLecoVo?=
 =?us-ascii?Q?D85PX2FgcjSUaJkoQFRn5Ik08Y9FwBlesEB4N31eo0LrBwVyLK+Vaq572WHY?=
 =?us-ascii?Q?dN7mUkfHh8n976f5CgsjulSNISekmxeOwF8rQlX2sq9efn/ipvsbs71J+jHQ?=
 =?us-ascii?Q?Cs3e817nWruE9dzIqslqG4z/GJGTQzDMIWpdg72od1R2SR19a+zhg0QBDmJF?=
 =?us-ascii?Q?hxModWb7uN1Ivv09deuh9kYe7QMHGws8dDKZJh0fn1gJlnvIltzDBFnzGQo3?=
 =?us-ascii?Q?PTJYFcViOqvTnaK4zaWHX/3nrFje7VXmmiwR7GOIl2WxVzXpA/qX+FsSSg1b?=
 =?us-ascii?Q?XAm10pYqHjcjAiEllEUhbtMp2BAvdjh+8B2uXOCnGV3xd5Srlhn88JuinP8d?=
 =?us-ascii?Q?vp1z8V2009cGMpKr6Od8ZKhWbigiBYMhMF84dbiWFlV2mBNK5SD/YHGIEc2z?=
 =?us-ascii?Q?xCc4MF/jIvAaGssWsQpV9ADDCgmS/JROFClaboTNpWRgwutBt064wrT20U9Y?=
 =?us-ascii?Q?RTNvmKfLSap2iONoFUPwuzy4yi22TsQnl5wcYlV7VdYNGLSoml7eQ6tBrSpl?=
 =?us-ascii?Q?1IafFf9EHtBkccmF+88/s7ed1hyE3GJTA/NvSejktjIoF3w/TEu21c4gg5z2?=
X-MS-Exchange-AntiSpam-MessageData-1: xEq/G0y/WSXDxLF1F5nTguDFueBW/tK9lGc=
X-Exchange-RoutingPolicyChecked:
	TaKaPIiCCNJXbP/rGE4TcxU70HehXICB/MLMKgX4/NvC8IZn1sP2I977TPuL6mr4qOhwUx6O22gmO/jWs89R0MePTrAGFis38VFL7za15RdkaAvdNTLr4kLkhDpjVf/93CrQn3V8r+T0I1K7KtATOvpU9q6mLm1U0BkSlxNSoZHBYzDMLPEHlMhPlCyQTinE3jKHCvHCnLHOcHkbzyw2sP+M7dunSY0iCYWw7V/zDBFVbrp0qgT0phHxW53MU++a71mWDQ6Gjbd8iIfiQq1M9N6W8UMZkvwEmiQoOG5ICc0TdpE+yZjgJG9MRLnBX42P5UeV+dupToEFAWesSKlwaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xv4cvsCaI8y6GrV2zJMcSUjewMxswBVi5iZwHQtmSSCQ15sqi25mrw6b09GHVN5JekRCfQnqy3njzl8rI2lrOxjjbyADQm8ZSBGNxFsZVRtZNNzj/pM7aL8ZE+8uCyq9yNtjF6fYerGuOSvUtabO4SILSs12TZedQ/GX3nrhqLyi3jOmMGQ4HeA0gIBiUysseFDh+9lrccnXQCED3HjxXmgjsmZN64I2BdrRGjmXJytB6LhNPmigQQxv0sgUmAesB3YbqC/Ea8JvVyPuIctdRNLJrhPxvSivnlPkNKJ6m2lZGVnJo2DvSik2QA2Bjy7fF83SZa8Z8L/QlR/OasU34TNaWE4ZET5lYNoZUgOPR3JUjZ27lBniHE6HJ+Vlicism4QmJnvMPaRQNC8KzZSfJDr1kh3D3xVSqtd7+bsqI4I6MwIYsgLxeEiXpjmYkuDdjELU8FXbaWus+R22rjtxmOfqnhAvAxHVxpf9ZlMA7BK3+NWQDA2Xkr5FVenhI7qfWf00X+W70KkcT8pMIWpHI9bJkCq2mkecsXrtIMgJyWqnswIZMtcFZGjqBTvW5hp5YM00TPCe18suQY1mwDESnDSfGcxdI0SbWhk8rDMYTikJ2UA9hB7zHbxU0H8cCcge
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7abf20-7be1-4d50-e952-08df4a3154a4
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:24.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg4ebtQCL1LP4TUoJFKQFYYSFNlhz+JonFHbdEbXzO9gfYhu8nfqeGWkcwXQb9MokYtWCl4kgwhjNhsBojay/wzaxF+pG3tMiFdB2sD6jP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6354

Add an '--ioprio' option to request a trace with I/O priorities recorded
in it from the Kernel.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.c     | 29 +++++++++++++++++++++++++++++
 blktrace_api.h |  5 ++++-
 doc/blktrace.8 |  5 +++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/blktrace.c b/blktrace.c
index 89a8f8a..9ba3b3e 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -27,6 +27,7 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <fcntl.h>
 #include <getopt.h>
@@ -284,6 +285,7 @@ static int kill_running_trace;
 static int stop_watch;
 static int piped_output;
 static int trace_ver;
+static bool ioprio_trace;
 
 static char *debugfs_path = "/sys/kernel/debug";
 static char *output_name;
@@ -332,6 +334,7 @@ static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
 enum {
 	OPT_TRACE_VERSION = 256,
+	OPT_IO_PRIO = 257,
 };
 
 #define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
@@ -444,6 +447,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = OPT_TRACE_VERSION
 	},
+	{
+		.name = "ioprio",
+		.has_arg = no_argument,
+		.flag = NULL,
+		.val = OPT_IO_PRIO,
+	},
 	{
 		.name = NULL,
 	}
@@ -466,6 +475,7 @@ static char usage_str[] = "\n\n" \
         "[ -I <devs file>     | --input-devs=<devs file>]\n" \
         "[ -v <version>       | --version]\n" \
         "[ -V <version>       | --version]\n" \
+	"[ --ioprio ]\n" \
         "[ --trace-version=<1|2> ]\n" \
 
 	"\t-d Use specified device. May also be given last after options\n" \
@@ -484,6 +494,7 @@ static char usage_str[] = "\n\n" \
 	"\t-I Add devices found in <devs file>\n" \
 	"\t-v Print program version info\n" \
 	"\t-V Print program version info\n" \
+	"\t--ioprio Record I/O priorities (requires trace version 2)\n" \
 	"\t--trace-version Request trace protocol version 1 or 2 from the kernel\n\n";
 
 static void clear_events(struct pollfd *pfd)
@@ -1093,6 +1104,7 @@ static int setup_buts2(void)
 		buts2.buf_size = buf_size;
 		buts2.buf_nr = buf_nr;
 		buts2.act_mask = act_mask;
+		buts2.flags = ioprio_trace ? BLKTRACE_FLAG_IOPRIO : 0;
 
 		if (ioctl(dpp->fd, BLKTRACESETUP2, &buts2) >= 0) {
 			dpp->ncpus = max_cpus;
@@ -1103,6 +1115,10 @@ static int setup_buts2(void)
 			dpp->stats = calloc(dpp->ncpus, sizeof(*dpp->stats));
 			memset(dpp->stats, 0, dpp->ncpus * sizeof(*dpp->stats));
 		} else {
+			if (errno == EINVAL && ioprio_trace)
+				fprintf(stderr,
+					"BLKTRACESETUP2 %s: kernel does not support ioprio tracing\n",
+					dpp->path);
 			ret++;
 		}
 	}
@@ -2264,6 +2280,9 @@ static int handle_args(int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case OPT_IO_PRIO:
+			ioprio_trace = true;
+			break;
 		default:
 			show_usage(argv[0]);
 			exit(1);
@@ -2291,6 +2310,11 @@ static int handle_args(int argc, char *argv[])
 		return 1;
 	}
 
+	if (ioprio_trace && trace_ver == 1) {
+		show_usage(argv[0]);
+		return 1;
+	}
+
 	if (act_mask_tmp != 0)
 		act_mask = act_mask_tmp;
 
@@ -2735,6 +2759,11 @@ static int run_tracers(void)
 		printf("blktrace: connecting to %s\n", hostname);
 
 	if (trace_ver == 1 || setup_buts2()) {
+		if (trace_ver != 1 && ioprio_trace) {
+			done = 1;
+			return 1;
+		}
+
 		if (setup_buts()) {
 			done = 1;
 			return 1;
diff --git a/blktrace_api.h b/blktrace_api.h
index 4b56e96..884a718 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -188,10 +188,13 @@ struct blk_user_trace_setup2 {
 	__u64 start_lba;
 	__u64 end_lba;
 	__u32 pid;
-	__u32 flags;			/* currently unused */
+	__u32 flags;			/* input */
 	__u64 reserved[11];
 };
 
+#define BLKTRACE_FLAG_IOPRIO    (1U << 0)
+#define BLKTRACE_FLAGS_MASK     (BLKTRACE_FLAG_IOPRIO)
+
 #define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
 #define BLKTRACESTART _IO(0x12,116)
 #define BLKTRACESTOP _IO(0x12,117)
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index c502adc..d35cbbf 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -191,6 +191,11 @@ Outputs version
 Sets run time to the number of seconds specified  
 .RE
 
+\-\-ioprio\fR
+.RS
+Record I/O priorities (requires trace version 2)
+.RE
+
 \-\-trace\-version=\fI1|2\fR
 .RS
 Selects the trace protocol version requested from the kernel. Requesting
-- 
2.56.1

