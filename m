Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527985;
	b=CSFegcrzeMCx5r2v6b9JOkSiHH+jWkaCjp5VPTDzLucCaHIWURCuCPR1QUVBprnNtXz1
	 ZOoVdltx/NkA+D2Bh8cuz7YdRjkoim4fJLBGkqKJz1uDVI4an4Fdqfva5WpFCwBSXJ6w1
	 tk4sNpbC2n/QNYqQhlC2M/U5x/s38qSkfEzfeuwxxmbFj7MVULHuJD7cLagoKX8arimB4
	 NchR5KiqRdu/Wr0XHXEgUvz+KtvZgsFMbWppN3aQtviqllYh6fDxYzDBXiDaiHT026QBu
	 3BQ+GAljKa9LVF73GXtw815QqIoTnrZgl9r8ciZq8ahruqB0Cpa5E169Yg6Vdy113+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527985;
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
	bh=wNK/8CeqkjTqrt1pNA3rKwaYM+/zNjU3jLY3PVJqhjM=;
	b=bJGrDgyTwEvI8nFB0e4CUQAl7SvLkYM/6hsHAuMjnMkKBT9x1LO+FAMEW08Xm0JzUlfV
	 hjzOUOZ7uZuqycEu2YX3tQDkQKJJLK/JZKo7OID0d/TCOsqM9e5uBmpqDg/7VWw8/a5LJ
	 2kecnZmsDyY8SoZtes4eqmffsN8/n3eSTL3F0/ywGo328O3CM5hcFGaiWNLJGXJDufj/O
	 Y74q9P8wCYNgYGK3aMYkQxu6Ku4YkXryRjMtcNHiIBYOPQb0B2kphhJMMX7OPd+Fmd9CL
	 OUu2ftWBUibdsORx7xlSSTobd2BrrKZqdXY3lPZdhAe5zUygWVQHfFwXB2HmuXabThQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SuvPUBwX;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qNROnYTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1273606A32D;
	Tue, 24 Nov 2026 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1273606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SuvPUBwX;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qNROnYTV
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527992; x=1827063992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BbV3doVva4FknoMrRmhOcD0+eeRTi2lheNS4ZtBm1IU=;
  b=SuvPUBwXJqVoFgQJ9Jj4eGXPtLLleGGuRJr6slOGeZ8Aodlq6jkQ+ymM
   kiBnzON01uYy6qNq98SLm16+3nxM5JcB+6Sjf4da5OhfpGWDUp2aOkCDi
   cOHBUBIfdfXqfOLv/5Wu7uHmF9T0GnVxjV8/koBKM4hakVF84XngC6/r9
   GG8+iSR4NqnzD62pnExE8Rnktm4nZXxID75Cg7vaOz89EYW5GL1C9FVc4
   maQeJ6BaXWGR+ejDpg6523rRFD6/V/ATJ6Gj+j/yNeFYQcCcKKHakXfvX
   d+m7RbdAy/PQNK5aPD/JmXMAtFbblDzcs61AbtViO+Z6+57c+IvG8I/8/
   g==;
X-CSE-ConnectionGUID: e/AXfiHoSreNUd7GXm9oPg==
X-CSE-MsgGUID: 9Z+JKx1xTdKkq4O/3aH2tQ==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="162633100"
Received: from mail-westusazon11012033.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBRZe3OH+1jaK4PiS+n245CzD5nwNJB1UOqMTfS9XGTbib8esQrOeOb03CSrxuwiaajiRNzUOBPEKE0dAAz48MppOaBKnC4QhV5KvPF7WFkvYwCaM13DR9Kn+82eIxUoKFdKsQKO21GCWtc71Xe+fcge3MmuVs8GiOQFjw6WpkrbwjFCsG8sMvloxZEN5Xw4FHDLED7GKrJN3IVOCMkp+pDknDUv4Fvi8JEsqNhNJnGstsfAYx+vqOV9I7LcGyz6QeXtR5pI6cHBrKH8EBWwDiV19jR3Rx+1yFt7D2d6KYC0SsncwtunsOXFZc78gnOdGuaGbh12AZzbblKdPBI9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNK/8CeqkjTqrt1pNA3rKwaYM+/zNjU3jLY3PVJqhjM=;
 b=NETNHje/WwH6L2trpS+DIzhAAnTFOscFovrdo/GP1kW5oAUisjc01UsVGYmbcGWYREjC4+Ge28Mn54xP9C/orsEl5nRbsyTRxsNYhF7hq45i+tk0aYrnwyctu++Q5JFass38UZtanxCQrSgwsqf6YRNJGR3QGpd5oeGFzhjGtozRvIBxlTC+WGIlQNVrH3j5sN1ty55buABajkWjT+0KK3R/4+W3eGjAuFuA6B/F6UeJejIZVdKU9yIAGDscbVvyaK3jr4Bc3BLGNiUVnmu9E6fOT+k/5IB/ih49IqLKg9Q4bqIu0VLRCzaZTbyMalf43bIrD21ohE4IciTxf6LMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNK/8CeqkjTqrt1pNA3rKwaYM+/zNjU3jLY3PVJqhjM=;
 b=qNROnYTVoLqB4ldpan7+EdkbAtq9+5nWrsmVUqxj7TUl8F+apsNa+y+VANiWRccriBMI7Ag8tfhty4W9Bu7WhPxLToUqCPmeZfmCHiGZGQBihKxytXzTBJVWVdVbGODE2S0PC5Xv7YnDpf9CFUe2Rsai37lkkmPtyTjBhBEVz9o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BN8PR04MB6354.namprd04.prod.outlook.com (2603:10b6:408:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 13:46:16 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:15 +0000
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
Subject: [PATCH blktrace 1/6] blktrace: sync blktrace_api.h with kernel
Date: Tue, 24 Nov 2026 14:45:56 +0100
Message-ID: <20261124134602.153239-2-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 057bddea-d5cc-4e39-c4dc-08df4a314f5e
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|23010399003|1800799024|376014|366016|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GRs7naVH8D0z1wCXvshdPP/BqZOjE9IQ5GccgFEal5KHhGLo+V3Bv2YHFFjsgdxSPPpZIvoW2zT74jra6bmsIiIwgFX+gt/Esowah80VXTf/mu8+/GTk3i9UrkCNHKz0FrNW5ZcNa333KYe/IJeyXf1PyeACfpsxzS9k5Q7T0vw5mtSEdMnNlqNKpAN5HGkwMaHNnkwYtufQgzkw31OggGMtKRF8gHdFhC2F39vj/wosMR2dS02rSCy1cESbyNGxdxhuM6vmfYSwEsgqr84tap7OSkn3XTtlC2xe/KrF2LB7tE50expf+qzydETjwThVb6tNY79foldj4RQXuU3Ajpr+/mkKyEr2IOr2kjisRgTwbRaaFcUm1AR2PyXqH7q2ZbCZZEeb3C96+omDNmdBgMnpJJKEgkL7hOFnIpzsSW1OplGkDR6fi/0MLxfrEWxBFycdhComtbLYgxSIOuIY0PT467NqQjv52pK/UboqM+vYrXNnRY6Od2EyrtCIDdivP/RVDLGu+dDHoQ+1j8xOy7OMtI8/pLgEjaT+oWCwmR4wlr3IKFmQoG7wfAguXkKH2Hwnp/afGqH+iFPuVseUEfDimYez6PUflhpzq7XN/C4ktic/PkOqlkC6Ef9wGy7jttY02oZmoxARYqylF6KMLMiJyqkPATr2O1rkB9n43l4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MSO7WpRMv3imP/93aZM2SVRb3g+zdrj5tcoLzSA9mcy5uLGxtUz1WPFkq9IR?=
 =?us-ascii?Q?da4MnYo1te1OjGtkuq1YdjJ/fdxvOaDC4YVrcgxWpu+ftriMt4Kc8TAuGi87?=
 =?us-ascii?Q?075YNojnF3HXW1+kRsjoH6YGZCIrw9qp0gmYC58vE4umjLDERV32JJTrIGvu?=
 =?us-ascii?Q?/b8TVfP3sBbMD5e0jdPb2ICkpLkkaWvy4eh/5oCB1FiMwLH5r36P3SZ2Bi5K?=
 =?us-ascii?Q?fc1Ky19wykXBUVxPgoOnOeXyk6XYXsScwzPH0kWpdTcfyshieKQq5ju+FwoG?=
 =?us-ascii?Q?wiOnrAioedFvrCBCB86m2cWtVhanYFGMitAXkHOn1uKsvqi19JHWJQXC907D?=
 =?us-ascii?Q?kkZAhmdAVtgIMKerxuYXNgscglOsVdjjrWZqRS5oIn7L8laEyN7NucZr3DCT?=
 =?us-ascii?Q?qNtmnjllEjqUnJrQPdMKmVxtdbkyI+yHV2EOdZnh5On8TUNqaGWAnzjdoM3F?=
 =?us-ascii?Q?r7Z6dwLJzBNZkSt2MoXIr7Pzk7Hx3JsHmccDwsjTaGm0I8QE9hmByyHkHGxc?=
 =?us-ascii?Q?68OGmH4e2/uqk2trQ9IKI6Kvcpk3UGeJmy3RO/4yjoNZFQwgE3LrLqNZdH9I?=
 =?us-ascii?Q?0Po0E1KtREZYGBYgIgHtEPjJxcfsJeOZHKCVEh0vKloRcDhmxe2g+HHAu+K3?=
 =?us-ascii?Q?M5niqpIAChHfaEsgqFeGiFF4bS31MwTIAbKhKemmxYnK6dSE+q5T+xYmSVFu?=
 =?us-ascii?Q?H9aw/+2NPMmHFdhPh7CmRyZ9/UBW0PhMUJJU+oJFpQPqou1tSY9MDS3ps0tY?=
 =?us-ascii?Q?Op8NiGYZHrEa4M6sbMrxAkoJLbVbL9mEguAMnJQC6vFlijHBrJMjfcvXKWp4?=
 =?us-ascii?Q?La71HT/5RZ966wFO6B178PuWKBZKTi+rLKH8HZc4iE74r4E2rz+S1ZUYgvg7?=
 =?us-ascii?Q?+Cf3Mr6SYs/0wNZEe/cTdbGNYgQpFUP4YX24R35L2bCBPRyRB0ojEF1uPX7I?=
 =?us-ascii?Q?I73DjMZzfpTZNvdjTqe0dIhD++J1LGGgcI2KaZ0A33TdmpGFtzg/nlS+kIGn?=
 =?us-ascii?Q?fxzKzznT5nNcsNOQCrUUwS39MqZGEwvwS9+2zemT54ry0J7hMubqBG/eqDRR?=
 =?us-ascii?Q?QAvrxCNjknyiB/cwScybejbmos8ExB/EEaUa3Z8vT6kMF5+55Uv2tQ06R8Ug?=
 =?us-ascii?Q?DYl58sXa3TUlh8fl7gbJHdXxA1swo2SJ3iIHoiCUf5sPJXkT42g7L9OmqsRG?=
 =?us-ascii?Q?dV0gI9ue6OuVYx8zexjiumoEpZA3fPcGODovW1gHm6UjbSvN+kJFlpemTxlJ?=
 =?us-ascii?Q?ea5B0NjNWxkGdkTnMBAQQbsnFlxzexyUdyVbq0oS2i6CWYXfQ/h1BhlXRdJt?=
 =?us-ascii?Q?l6HtogKGPFu/XFR3ZgPQKMBNv12K1Hmfibk5ViY//+tr07nCu0aaXd16Q8ur?=
 =?us-ascii?Q?FhO7Tt3JmRlInXxTXgRLzO9PighsG+5DUNARZaSvDQCr/Qad6n2u0dqCawRE?=
 =?us-ascii?Q?BEQ3c3IlCDQJvpIhb7DTK2jbVjDqmpMvJ+KxkrROJjzxT5wgaCOGrO3JmgjF?=
 =?us-ascii?Q?tK+P4flTlOK4u/R+DpWhWwKoq55S7/vcnhluiCUd+/6X7B9yLSOC7LTSrA/W?=
 =?us-ascii?Q?+Sb2zw5Pooitcq/4Mw1bREEGSCqLQKfbX78tWtN4Hux82bjHIqjLa6XD39vc?=
 =?us-ascii?Q?A+r+WRABITpOBnRndKgJXQ/HMkiUhZTTtls7pth5KlOyJiMp4MoRPDv4MvHW?=
 =?us-ascii?Q?xiag0taqVwixTmXd0WV54neBxwnPnTTt3O7RxjnZ2qR0jLKxTNMb4msERaFU?=
 =?us-ascii?Q?B/NIEfHOkK83Zk+69UazhqcjElUhw/53gWyDAUVYlSWHwu6S/AdB/FeNuqOS?=
X-MS-Exchange-AntiSpam-MessageData-1: +nWILxyyWYkrVj51qUYr2T20wkylF8Ciw0k=
X-Exchange-RoutingPolicyChecked:
	Z4sw2LxohnH3vOHG5/ysqXihOwhv3toRi6Lc/fxx5oLi238c8X+pmHsOi3I2jAKMJo8M2Znb0Th3JnUhG+npx6hXl7s1Zl09iBAjrs/Slj+j8nAKUG0GCLd6LVBqQmJTHXquaZZlb0xn/qQ6PIvZWHWOvnnMAvLIf91otdpQnhrXzBGWXxojlKrFz020rr0WfQva/e7T8qQohGHpICjitaKq4iywMJFAJzlm6CpAABdCosdHhrTEctAbm1sfeHJuOMKWre/A0JA37GLoqogwIrIm3hztBropkk7vwYH9tjb5kKjfzY0rqtMt5NP7IGKY5sDf+fMrR3VoUZSdH6N3Eg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IBI3yWWoCFJaCfcwcoU26BPsEpj+87aN8r3ViS8e5+O30qK4bn3BZ3s3NBJjMehq+BZi3brvB4MsCLaVZs8qnUsbeR6c3/n86b+0FMttl9gCxk8w1ygR4gLpTwlCKTeQkyMbXWqD5pNG17CMdUH+/T345jh+RA4drBFyivV3JATeA48GhwOVfjpJ2GaEwUL3bhm5/Q49yc/JVVDP4Nna8x2GKi4Y357385L9QPwm7yO928iY0wW6x6kwowHldrMnyeglryNbm9/nWXLQ+YJSxhuNnQ3GIUJdaQkISHs4jz02UK1iKr9garQNCEPqSG8eQrK88y3GZt4RL509VDiAEg83PTCnDZcBfWtES8Vy9bowDtd2XyO2pc9JCQxJEM5H2w1DMVlHLMfaPS5A0D8aJmlblb4huklzXhK1/NCfP3S+rdZqXl7s62jeXfVzRzNuPcVtRyQNK4KffcwzOAYWHlMpYfju92SR5qotpYZfo8bsqp8u9P0AhI6UygmsrcRtBP8JhZxxrRyspRKNZLTndZXKjV6N+Vk8vAC8W+AeHT8j9sF1SfUBXzyHpciYj+rdNKVGphTLfu0P8QedKwd6/GWtEuJpoh5fmw9fhf+2/QA+7W5bK34Iu3Y33FB9ZQu1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057bddea-d5cc-4e39-c4dc-08df4a314f5e
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:15.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPNotnE7zh5EPv8jOLviRFNy+eNzZwJye1K7nh2ngCF9p9TO/BlVhNEf9SWLkgVjfL8CNs7z9b4JU3vjdBb9gL98FC64FesEDJh9J9bZ9U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6354

Re-sync blktrace_api.h with kernel uapi/linux/blktrace_api.h.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blktrace_api.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/blktrace_api.h b/blktrace_api.h
index 8db24fc..00740d9 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -26,14 +26,16 @@ enum {
 
 	BLK_TC_END_V1	= 1 << 15,	/* we've run out of bits! */
 
-	BLK_TC_ZONE_APPEND      = 1ull << 16,   /* zone append */
-        BLK_TC_ZONE_RESET       = 1ull << 17,   /* zone reset */
-        BLK_TC_ZONE_RESET_ALL   = 1ull << 18,   /* zone reset all */
-        BLK_TC_ZONE_FINISH      = 1ull << 19,   /* zone finish */
-        BLK_TC_ZONE_OPEN        = 1ull << 20,   /* zone open */
-        BLK_TC_ZONE_CLOSE       = 1ull << 21,   /* zone close */
-
-        BLK_TC_END_V2           = 1ull << 21,
+	BLK_TC_ZONE_APPEND	= 1ull << 16,   /* zone append */
+	BLK_TC_ZONE_RESET	= 1ull << 17,   /* zone reset */
+	BLK_TC_ZONE_RESET_ALL	= 1ull << 18,   /* zone reset all */
+	BLK_TC_ZONE_FINISH	= 1ull << 19,   /* zone finish */
+	BLK_TC_ZONE_OPEN	= 1ull << 20,   /* zone open */
+	BLK_TC_ZONE_CLOSE	= 1ull << 21,   /* zone close */
+
+	BLK_TC_WRITE_ZEROES	= 1ull << 22,	/* write zeroes */
+
+        BLK_TC_END_V2           = 1ull << 22,
 };
 
 #define BLK_TC_SHIFT		(16)
@@ -62,7 +64,6 @@ enum {
 	__BLK_TA_DRV_DATA,		/* binary driver data */
 	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
 	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
-	__BLK_TA_ZONE_MGMT,		/* zone management command was issued */
 	__BLK_TA_CGROUP = 1 << 8,
 };
 
@@ -98,8 +99,7 @@ enum blktrace_notify {
 #define BLK_TA_DRV_DATA		(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
 #define BLK_TA_ZONE_APPEND      (__BLK_TA_COMPLETE |\
-				 BLK_TC_ACT2(BLK_TC_ZONE_APPEND))
-#define BLK_TA_ZONE_MGMT        __BLK_TA_ZONE_MGMT
+				 BLK_TC_ACT(BLK_TC_ZONE_APPEND))
 #define BLK_TA_ZONE_PLUG        (__BLK_TA_ZONE_PLUG | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_ZONE_UNPLUG      (__BLK_TA_ZONE_UNPLUG |\
 				 BLK_TC_ACT(BLK_TC_QUEUE))
-- 
2.56.1

