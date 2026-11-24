Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527983;
	b=vi2+dd6B5woNr00vj0mR3hHcBKmUceHHu5mcO4oLig43i4z972x5Q8ni9mO3NpAcSkH+
	 2J0lIAdxq1emG2hRlm2ds08/frUoKLu7HIjWmFnYnC76gqUEeDHUbctSLKuD+K5YlMM8E
	 3wSs5YQCAfpnrIsbEmddZSbzf0j1tx1eVM0TaweWWs8iqPtnJgBdG7VFEV3YoQWZH3Kfn
	 xq0bAnFuzsI+ZngFAuAd6ollJogwrlzjbjyD/UfZEm662AZ+idudPvizkiFzU8LdpaFR/
	 ny79zwUczQvYdwHj5Q6pkaQQghNr+1KQ0seTj3tChBNDbOW6cO5bsWm4Vbg/5VOyQJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527983;
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
	bh=yIEzhEYLU/ewAZGbaoLHbhD9/xt+GpgJd/Qm48GP4j4=;
	b=fBBuq4LlVt+Q6j3I51rAul0oMSp5bxoe3qyT/vEh04YxJLkndR1HJNdAM/PM1TwtEslc
	 NvNJPE8ddint/jj+apuRk0T+aG7L7ooP2B6fSnaPVT/rRlBvV3QQ0nNJH7tplKb3rl7/O
	 zFd7DOLx5kE1J74eXUSEFLylM8dtecxq3qTcZkJlWI7QUOYmpJLOeW5QAto7RJq4qSwyI
	 9wy3XWUuDviiVBZpqnSuzoXfVzS0zMEG7s1qisemvpaVDNcVA12/o4E/mrp2pyW3whK/s
	 DTiK6JJaOZIabJvn7flNYT8tbpUmMvQ9FCMmSkojpN3MEfXaQr+Lau7gWaqzt9hGzIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=C3soJQXr;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LYhu7QVc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603C606A322;
	Tue, 24 Nov 2026 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2603C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=C3soJQXr;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LYhu7QVc
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527982; x=1827063982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LL+z7osGS2f0o2uXTHsKjKVkW9pfpgvyBWBkMQAcpso=;
  b=C3soJQXrw2D2dORRJH3fg+WEj/zoH9ewB6jEImY/YChBrG5jsk8GVqVC
   8nrWaPek+QGoUoWMvVtNNHh9p09tUSKPjsoHR6fhr9mUQerf6FshU4yPv
   m57vABMOmOqWtGuq1l26YYXo/zmVQeSIpw2ySdN3AsFmiv7QdlI9QnzSP
   SBDvXUNiMPM+8/5fyAJvTZzZln+xmWjexBSZ2nbbNRunRyVA4Bpqz4igz
   TQIR9+qHKXiEbazVHE21+Qy3Y6qkYYkSYG649kZDsxpCIjtC329cu5lqo
   crrANjOFKzGUoommGx2FAPNYBEFEXt46+r0REpA7MR5FRoci17cCMMQTp
   Q==;
X-CSE-ConnectionGUID: bvKmW3LVRyGA4kNQyqeukQ==
X-CSE-MsgGUID: wXs5DUEQSn2oDFwRexHl9Q==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="157409275"
Received: from mail-westus2azon11012030.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.30])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uio4TJ0Ta/QmwiR9dEz27qOAKx8laAC1ceMzop1XPOvuwEkgqTmk2uNt20TB3Ha1NfObePh2EG17dUub1IrtzL8C9wShyaArtyKRm71hVeWJdlq85t/VDH7k4X7mET6i0Y5lBn4swMbwMX4Mk9fp1k7+t4bmEP8Eqk+4BBqxtULKUQzmpU+IFNhOItSHxjAEJ7qt/qmHHhmvMRPvHMD/wG1XAvUs9sPUZ9wvbG/EHZOdBbOgNW27V65ZRMhTn2mzn5N0lOq610PoJVvUXc1E3Ii2Efw0Fmt34rpkVKwOxwc11ZsNtVSwiSuCnfQyqp8BId9QzY7HCG90SO4WEpGC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIEzhEYLU/ewAZGbaoLHbhD9/xt+GpgJd/Qm48GP4j4=;
 b=vDSv4dgHs/JVDE9Ju/d/63LdfZY6pyzbVy18fRfZB+rkuOsxZTxD7Pv/pxcIgj1V38wOiO3SqustBCigsM8j+uG/vwwjRIbOCr4qg2r0M7An5zlrw+BMz16+4i6JFkhupvWdSg+TJkdtOzakvuvNu0+mHIN2kWXtHjbwEpaYg4mEGWVchaEkenub9x2MWZJURos3NUkbbw1E14P6ysSKJ6a6vv12fWNdMW372LfLCYMhy7l1pqWF0YR3ML9tGYQbvC/45T9EuaOz+dfzSLniGN4xXKU02eyKSnpUudg7ci64rRbQ5OYkgNSfQTZO2+bnHoCyNwul9STctkN1G+Ze5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIEzhEYLU/ewAZGbaoLHbhD9/xt+GpgJd/Qm48GP4j4=;
 b=LYhu7QVcbfCGWfxpDdCL1vWoY8RoijMDZEaGxaeSvlLwtUm1ico08aSn6+9BqO7FDtUBBDMFPzU+PlV0w00uBNJC4C9pyV9JcSKlNpqF9uVcFpRjynP657weP1f+NNF5GEnyoEpF11dmzb7scSooS089rDut7wwCZMzxGa5V/ac=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BN8PR04MB6354.namprd04.prod.outlook.com (2603:10b6:408:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 13:46:20 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:20 +0000
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
Subject: [PATCH blktrace 3/6] blktrace: add ioprio to blktrace
Date: Tue, 24 Nov 2026 14:45:58 +0100
Message-ID: <20261124134602.153239-4-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ebf7c46-00d6-4650-1ac0-08df4a315207
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|23010399003|1800799024|376014|366016|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8j6c4pdv0l6DWDm2FcXQt0PBTCfyE6L7J/IDRnCWTTQUYOCSkpJf0SnyltCCQSPyYmRRoGM/NzsMRHWh9BLLlYnirBOortzAGXSrHnkVlR6BvgFRgUrgcdX1EZIKFao/ufLpzRn4hstbQEDqyqeO6KN1Lt01G72MpBu4az8uZtog4VZAfuOSIe6nSARSke9OE1//+oKl3N+FYr2GzuAyevFg6H7th8Cm/0D8k4iR5fOHzdUZKnM+sT1f4wkq+1JHPDqwYtKKc+lvawxf4d525AIk8sSgJf+M+41CJX4Eo7P/4eN5BQU1Nk5GqAB0hzDcwbdGxeVwrYDseYMUIR3/GyKW5T5G3oHl2DahgrNs3miGF2kvHA6Bx6hYFBwdgXnHflMe8qgxTmXk1TdnqkqJ5vZjx3zufjpYU6+cUOoItAr1VTZMvjHSgTWnWl5p7sdPG/6CC7PkbGXKqIcPPKkvSzxWT8CKWK0OYtLl6vQemBiCtQlM3kMbFu7yANLaippu5G8EpelA0TgP2wKEbcHVXMzz7vBfZ95hj1cqC/hAuKN0s14WOH859zb4E4x+gChz/XNh6HLX/6cq8jIcm1vpi1soCPvkg/IYfiE5l721Xf9o96SiItqTzwqrE6u/uotKldrQJIDBlmbiQ4lj9QUGtb/VxZAojsCOkzFRPDEiL3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(23010399003)(1800799024)(376014)(366016)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JWSb6+iibdkGMoAK109CirISJxnpXAPPB7LY41GKqo1wSg26cnOsTvHixLR?=
 =?us-ascii?Q?TuVvRLR4S5apE1ymwpJpmAJp5WuexCmBbUMv6eqyObaSQd+wtxCUfSmSivFz?=
 =?us-ascii?Q?eEdtAmpq8kVSF8Y5oQLboFq9hJPMVTW7bQnEIAsuKzS2BZuh0A/Hug+AweWR?=
 =?us-ascii?Q?VNQ7IDju3JLrHE2DaE/4Jafm43JlrJ+SWTJx5xJZdSKgh1WiBBq9UYuRekWd?=
 =?us-ascii?Q?Ni1X9JiNdOuklILel/57O9Qydf4CqfSLA5z6ZL9FRwnyC/X83bz7Ei7eproe?=
 =?us-ascii?Q?/U14ENzH7rSwtlgkicRr89Te/UfaVNuclF2n9cMI+lelqzBKV+PkheT00Mgq?=
 =?us-ascii?Q?I1guyvdVddgina/1XJgnD//5JCGGLd3ydR8kodeOmi5dhbr4SAc8zmUwoK52?=
 =?us-ascii?Q?eVCioeJm8+va3xzRLglIyUlSZyZyDSdl7Kt3Mpl2Bfd3eKoHsTqduC9rkaay?=
 =?us-ascii?Q?j6Dq7qgvJ2qRi4HssO75WBOb1712olKuroQtAXnMW06Swo+s4rykO/7K9OZ1?=
 =?us-ascii?Q?aQipPdTe0hLNL0LxBoU/pMoF8Leygt2YcpnEPDJVUN6hFLBJ7XKZ+xI+1yDN?=
 =?us-ascii?Q?44Ql+ctD6A6paHpdqxApADEYWI5BPMzDBFNbJJDgrv0VZCeL2ewC/leR86Mk?=
 =?us-ascii?Q?F9IKqvSMQrzzudn47PmAvMdymg4IZxRUjoL+iyrjnQsbeX9Sber4YJzgAnF5?=
 =?us-ascii?Q?7bx9PKNFcTRBsH1uhUZH407EGxph0Bom2La2Nn5F449X7z9Y565sntqgjkKg?=
 =?us-ascii?Q?vf4K3+OxCQSYnLoA9qvVisEGzFQmDunUk7q7gi4V2TDh3xSdEUqMHTW0GPqK?=
 =?us-ascii?Q?v2iwmahQ3R3qawI25xCEPBUTHvtJ10bBvEUJYE6kOAmTF9e4aNqfAqa4NSKQ?=
 =?us-ascii?Q?u2N+DAOuohSv9sMhKYWdZwSi+zCQ/160AvxYqa7inbZKSF1m5Qh29L9rncE5?=
 =?us-ascii?Q?9rXT6CJmOe8Gnhu2+U3YJk4OvDXWjGm9fqNb9RVUi4ZgKotEZEl7+X7sTGHm?=
 =?us-ascii?Q?8C8gt3I3HQSrpVC8/gvPG8/rZ8tOXUX/AtNW3cauwRzWGVLwdvalLyg5xQ1V?=
 =?us-ascii?Q?SaV/N0gIhFRZ8V7pxmVxge2VrHDRY2ZLgEYGISoWNRImKPcOBFvVHnXGbgw6?=
 =?us-ascii?Q?cgzxQMlwm9GAAQ25geZpyFIaBfSiGJIciI969pbuc7EXINs+QYpiRelJPgkT?=
 =?us-ascii?Q?lkloQXImm14z34jK12lkigEh7nxJJzJh3EwYBl/eaV6PuBdGNKLsUjUpNuG3?=
 =?us-ascii?Q?j4v1SN+hZVBSF8VKEAfsWI2FbAi3ipa5zs5/9dUadnut/nCTcEuywGaJAvA3?=
 =?us-ascii?Q?Czi8rKuPOu5NvTvag25J2PfbcXefoJsnQp+FzPSCHrnw54URsWgyTsEB5hxO?=
 =?us-ascii?Q?kTJTmdwuYlf/FB85R+67BIbPpTlUlRWc2bn6TibZjJtcfpsjx64KMe2uple7?=
 =?us-ascii?Q?oFbefGPq7Kni3/WNfrz/+3/wctrm2wbMgyZUD7Y5mGUSaRaNzrrDtmZsKmDa?=
 =?us-ascii?Q?sST/0+zTxPvBvOpIYXx/b5mDk0M0e0w/dlnPLSBmpW+x5vr56vB78PKWj+ww?=
 =?us-ascii?Q?wKV8T2YVlv1AraYEbZkWVD/Axm6j+N94tv3W2oBs0YzZEgiqmQ+wyRJieKtE?=
 =?us-ascii?Q?m7vOBuQhKqkveMnra7uD97Oe3zsw0zzsaJYrBDrgJaFZDgV8PanhVVDXIEFe?=
 =?us-ascii?Q?/nWrltOSVzh37k3+xZYGBWW3JAsanqWEMyXwzUb7vqHUR8v3+rahTMJgg2Qp?=
 =?us-ascii?Q?8nzTHPBtvvjC/vMYO1pX8/c32c0tSJBykQPqrmCsa59Iecp8LKyeS5AzARgG?=
X-MS-Exchange-AntiSpam-MessageData-1: z445UiUxXvHmCwBDpQuBzeocZ8GJIN4/COs=
X-Exchange-RoutingPolicyChecked:
	aernQKGvCwEvHYXxtl1XfH2trcWG/PCMyZ/POIxV/o3zMgdFoW/WTNZg6a6gc6Vf61L8oNvau7ui0kVBlKW6z5fFSwOof8jBqEh6FCG8R1ocqr90H247pDFzTrzB8yhm0lnCa43aS45yR898Ha3vD3a+QHZUFd/oIGD7Dlh6o/8yMA7QepxYuS9xlUwix0B2hmC7qWByrjrqUBOPa2gOjotAhO+x44EmSj82bthGeYHJrH22ceqXurqCcyjp0WGFnCMoWnJTd0LTPEgq7sD6TS7nMJ6TiI2QavKHpaAMRh9ozpDm3jeOaxsAMaFasK/GAl7IREgX2IucoiolBTniwQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y3IHs4vjghbh3fq7fxoKM5miV2bJfmu/tpyGUzhQPkVakPkfTB8LtoJDTnNdzi3HeHyVS5TpIRGhtusnSmwBr4KIlhpJ7N9ksXtkc8GrEKq8aUBPTkErcxgSSu3zBLCq1HHC/BHWA5P99yP4xTUPnzs4856/uJ5H6tn7MP44PbgD8IKnVw01yGx/ObYT+vBAeBHa50B2ThI5euhAcwzftUb0d8Q8z8jBIGVYp8vK4dj7QYfXcP+oBkJ3Ga9Cq3SLw1tBkWDTc7kajwOMRenDhjuSM0bYv0+yQPJipamB01HLSrtw6gbxr3myeLaZpG7QwRzGySJvF3ueJbMtyi58Na8LW393ZHyx243x6RNelvJGhVSe5x4qRNAcrsmYTDV5/1s6kco9T3xR7o92yEXbdBQeswI1qK/xdOd3CSoV3OWIPiW8gBCqhLE5PXpHgQzGpSbDVBaCicapFnGFtX8lvYRwbnDGZuVZZ1j/UfpqPyt2oke0LAaaBwJ8G5zHIIo48ohVVnK62Cp/Ysr7wJaY5m9dVVnkeA85GwFG7i4FYIBOjk53mELN+yJeaGUu25xlHDl6O+1TkHMqPKquDhYwRHoTovZ9IdZT6QK/Ajxm4uWZylMqx7ZWEJvNfGsihbao
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf7c46-00d6-4650-1ac0-08df4a315207
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:20.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQPLXV68kmTglw6MxuziMuBYsC6BlL5IcW52EnahsQYsgyS/N5G5pPDSH1mCa98sNBKhlqPjbVaRqlNNd23dY+jJkZfYqmJtIe6dyKnzDBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6354

Add the definitions for I/O priority tracing from the kernel UAPI: the
BLKTRACE_FLAG_IOPRIO setup flag, the __BLK_TA_IOPRIO action flag and the
ioprio member of struct blk_io_trace2.

Convert the ioprio when the trace was recorded on a host with different
endianness, and clear __BLK_TA_IOPRIO when converting to the v1 format,
which cannot carry an I/O priority.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace.h     | 3 ++-
 blktrace_api.h | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/blktrace.h b/blktrace.h
index 370e921..ea48f3e 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -137,7 +137,7 @@ static inline void bit2_to_bit(struct blk_io_trace2 *new,
 	old->time	= new->time;
 	old->sector	= new->sector;
 	old->bytes	= new->bytes;
-	old->action	= new->action;
+	old->action	= new->action & ~__BLK_TA_IOPRIO;
 	old->pid	= new->pid;
 	old->device	= new->device;
 	old->cpu	= new->cpu;
@@ -165,6 +165,7 @@ static inline void bit2_trace_to_cpu(struct blk_io_trace2 *t)
 	t->cpu		= be32_to_cpu(t->cpu);
 	t->error	= be16_to_cpu(t->error);
 	t->pdu_len	= be16_to_cpu(t->pdu_len);
+	t->ioprio	= be16_to_cpu(t->ioprio);
 }
 
 static inline void bit_trace_to_cpu(struct blk_io_trace *t)
diff --git a/blktrace_api.h b/blktrace_api.h
index 00740d9..4b56e96 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -65,6 +65,7 @@ enum {
 	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
 	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_CGROUP = 1 << 8,
+	__BLK_TA_IOPRIO = 1 << 9,
 };
 
 /*
@@ -150,7 +151,8 @@ struct blk_io_trace2 {
 	__u32 cpu;              /* on what cpu did it happen */
 	__u16 error;            /* completion error */
 	__u16 pdu_len;          /* length of data after this trace */
-	__u8 pad[12];
+	__u16 ioprio;		/* IO priority */
+	__u8 pad[10];
 	/* cgroup id will be stored here if exists */
 };
 
-- 
2.56.1

