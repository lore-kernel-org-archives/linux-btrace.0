Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527985;
	b=Fz4LfljWWTHFWPNDwXleCfLcZmPmtuW10kvh9dlswe7jIAgTmunm5DPGMUp8kYwCxYLr
	 YGr0V7gBxPYL5mLYU+uBD/8nIVLGHqMrPgDMhruU5Ue120Zs4rGpQXylLSvd6l/OHNkYl
	 Xd5m155om/e/omVsuhCF1nCUjrEy/vAv6yh+Ym+kuG/WQ0jXATj1c7WG/DSscwadIjYfR
	 zrqYJbT2NOxCcBw9393oIBP1HS9hb7pQNgneC9qPd+ahSd541btT7J4HTkzpE0tQJL6yv
	 4i1DNr4Mj/PrgKcbmw4mf5/wWuxS+uaN8vXyA4J6P5kt/2cheM4JWMZ8lWKrEnm5kag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527985;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=QsEWjgjIOmpJqQPXfbccMKsm/3eRegB8GrS3FwUNxDc=;
	b=0oR36P5ks/B56/z9HvdF41phBmmebLveRuGoycfyT556+m6leARQ+T3xSgSCwsBu5HUS
	 6L8q+LZ4aqpmG1/uIsPfNTxb8aaj1FE/lj9QPSIsVwc5AW1WGYM/LR2UyIEDa+/Zhngry
	 OHskxVCZyswR9s0KbkUVLhRGO3dm77NwK/yLR7H18aPUXgUUoJnrNjNJTSPYGyktZujGI
	 Sx8h3BcfqrPiYUpwHcHlJZfBtetD/2tRBznny6HuO0P9NAxuORAPxpbxYS9caB+cAlTdv
	 ajMeNbpNVIdr9oECqgPa3MHcJsV7RTyHjRKWYnuGOewUYuJpKr7sHF0RIRZZxTaFHnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=A9FYdX7f;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=0HyACpQ8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFA606A326;
	Tue, 24 Nov 2026 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FFA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=A9FYdX7f;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=0HyACpQ8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527984; x=1827063984;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=pTOw+QaKMUS56sx0WMZHGmFc9MGaB4y3txlzEGAyVUw=;
  b=A9FYdX7fd+o+DGbv0SB4017GuPpxIqVI9/RIgOMawcmUjkXL7TTNmobm
   /LyWl9e+0OVEAhcv+OmUNn91fDr6dfNOu044ytp2jrznXUreD/VCceWPe
   XA5exVSxs40Yj5EJO05rMY5Dw95l3BrlrUkmTdC728loMeyuz8WiCRGlk
   +1bDtqlbqLnHgNoOdpBC5vhsCqwIGcbBUVF+AJgacUKlrO4qCJBnz0ZZ9
   MdT/Q/bsBBgvWAbMndriRzQLNU8xjK6KUtgsDnmzka6Wc0Ofn1iNo8Fm3
   KcO9kF6bZcdghAVHJ17cJ5Kr98GhT7QSdEnj1bReim74EqWXnW7r1LpIn
   A==;
X-CSE-ConnectionGUID: l1GjO2j6Smm9NsZZ/0G+Mg==
X-CSE-MsgGUID: V0+c6z9KRKi586p0LATWmA==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="160679583"
Received: from mail-eastus2azon11010064.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhp/iCZSFsyqNoQ69VP7P5KlgpSSHDI2IYdLzzPX0QhktkFsGHcAvonmQTpTcswWYX/8GB5hIf9plRCICRjPazpWsnlwVHWicAjasm9O1dmTFlPwhRpmwjTtLvPwXrd6I6rRqpSdLrQuLVAPORRrj4RtjGrgpD3kTAVvOMEIA3K0aUjwQ3kqdh292TIp3t3gx/iltieVF7HCTBSozZdrhvb6oiv96Tbm8xXux6WGE/n47DpqZRsO6OHd096zTI5wCYCP6JpYTystRXBuQ5oyp9bCAb4j8LWQ+Gw12YbFntGdiilD/EHVyGrBBrLNyn3aIzQ7HpAVyUod7echvduoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsEWjgjIOmpJqQPXfbccMKsm/3eRegB8GrS3FwUNxDc=;
 b=xahrlbTSCmk2gzDeIQa4/SyRMkZpiSoayBhsoo5EXWf4EntOJchKNpOeGRSqbxq0amMDo8c/TPe9rmKBJt0jJWgYtS+f4DyuhBb7Tr0iG+StdTQUg6TryiUQZvkk847wsSEvlnkYFUni+Dy0fJmQE0ZLlTbCGNHSNwCPVEX7E8AdW63YvxPn7b7Vz8VDuo5Lq2mkZOB1tx3T9q+OKYNvjxqg08JIeZ/f6Q2lnEI8xW9F1mjzqZWral1qkSSrxUxeuMgM0EEZE6wq8AC9ogKaPGwMO2jtGsIiNXImn1uvsBaNL2wVvpZj3y/glX3xa8Y8ktvnqIlHV+wPaRp1mdhd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsEWjgjIOmpJqQPXfbccMKsm/3eRegB8GrS3FwUNxDc=;
 b=0HyACpQ88l6oQwSQxTi7Htnd0NhOdQYc1eldD2K7ui05EAS2hWnp+ob90cvN5szmsWdfuMGVX5LiGaQq5D4KNVQa30sroK3l/mC8W9DI2dRVrBSvCX5h4pmI1KEQ3BhVAqRW7VwvgrjNTvB4jZg7+2ULmXCsQDPRxy1SHR03pjA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:46:13 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:13 +0000
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
Subject: [PATCH blktrace 0/6] blktrace: add IO priorities
Date: Tue, 24 Nov 2026 14:45:55 +0100
Message-ID: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH0PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: f1270f81-e036-4e99-8069-08df4a314dfe
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qS5WaMOvemWzcQwkaa8BAXwSFFj4VBF8ZFbt36QUKzFtp44xD0tF7gYa2opglunRyWx7erjZfshPUBz7ZOCjQNNvoOMlufmB40RCAO6EzrEcA1QzwDeq+qxDwYthzQXaq4vws7Zcjoyl/xeS5jcWSoUe5wpo1ySKEVDan11lWhUo9rq0ZBB0LeET9N1w5A75Y42tNlgEf7S4FDG3vwLtmFqc1qEDN9J5C7qZPJ7u6FDTl+hFHkxcvIGSMnOhE9YG8wn6WRMKa7iodiv1Rri/j4vxwaQPCtV5BLKpkTfTdNF6nLvdIoqc9CI9KDmlX4qceYIU9zYgU9YMT6rEGUob2nwsRQXbWImBLI/9pZacpaZWx89fRFoKGubvWkRxMq3h+hKMVJcYeD6RcURW8zDmooPHiMX/5buPq3o4PHljz8sllK+iisgYdSItXedgfN5pl+t7boSifqZd8MfijE+JmEDUi+GxyhAeLl/Y3xA7sgD8wyqGFP8KLqKnKmGHFBiGJD4iUUamgWgaygRiHfsdCbcC0T7kxR88YAOrSKFxK/pH9BGvpdAzs+39e4TBPiOLwleWHJTFe7VK571Y4IVTb4MZJ18PMYyjdd+L8kS24Ou4NaT+p1lYWKVm/5xJbvor
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJ05AqnWhy0ZPuaA/3UwQcIT0jcdNqHvc3y+6x6pmoVU/YjfMWyYwqForo+0?=
 =?us-ascii?Q?hoDzCwuRet1fjMzah+MAAerCi//SMuLZS4zzhYLqQstQfu1/hdT1CAbdSqOJ?=
 =?us-ascii?Q?V1zTTQ5APn7+teuHa/4IYyXUR87HyJpSSDvob+mIT/hRrA4lsoFFX183kOTT?=
 =?us-ascii?Q?DGQz09Wvmzl419aU4fdMWAawvs5EO2z4rekcykKyNkVXY/ldpoAe4jje8PMT?=
 =?us-ascii?Q?VlWPpL2ZlysWC6NbqcEHpKDyfrAeut8JPQaZqBvHpInQfBJXM7sOG3JNiTEb?=
 =?us-ascii?Q?Ha3vtq0zWHBKqKQ4qoZaExw6Cihu1m/Ed4U0HqhfHPWjD9YA5pym9CdOT3b6?=
 =?us-ascii?Q?Jfjv+f3hkxq/DEPMyVHZGRMP1p+LOgtYwRH3588LCJAJKGFQEGEsOJirmie4?=
 =?us-ascii?Q?5xZh6y0XFnGYaEYgDcF55Y7PCDcPQR1O5ZI7kKyzsug1PbgYE6gjT6rmHvIJ?=
 =?us-ascii?Q?Ts8g5lMPIlG3XTLOrQ2TcjujD+/CgNoHH945SEoKLEs23M/u5NuNScvSELut?=
 =?us-ascii?Q?8/jnXT6o4DG9ObmNxvY9I1JdgCEeRMNtEMUjKsZLgdKRTjpnxSjPzv32jpWa?=
 =?us-ascii?Q?wD2vQPUO9EWXBoPqHFZJa3hgmtn52L6rTRnMmx4UGcMUTxrizKMQhBlzxkYq?=
 =?us-ascii?Q?RTeoXfussieJDkDWntizb03I4T3O8oAjEBOE0VmKjjCarn48Iqn7eUQSX8GQ?=
 =?us-ascii?Q?OVAO+dfwbP3JmqW+Mix0S/dYuInohA8y8VZDe36oJLcfIIU3z9BIYMQ/gr5M?=
 =?us-ascii?Q?hnOZC9EoBn1Bh10IIuojj+vMQGovebJbNhiVxze3inUIkJC7qk78Cn4/uHlv?=
 =?us-ascii?Q?m17DUF/lkcsDdhWXcPhCxfgTq5TGU/5UWaK8cD/6SRoaDkH4UK4zSUtxHh/L?=
 =?us-ascii?Q?XvPnWsqaDIsJ9arL5IZQAQ0Ix7PHiizvf8Q5xh+AyC3CeS3yfnptmT/s2sDx?=
 =?us-ascii?Q?HmwlJ9DzzAilh9W785DMy0HHjm9ebT/VO8vRYzN2FKhsfYdzF4i3h1pssoQD?=
 =?us-ascii?Q?/KXMX8JQAEijQhqrQ51qliDmw4WpoYMOQv3uQPjiV+39neQIsLBOoDQ63BmV?=
 =?us-ascii?Q?jWt3dRzSjGbk1PFLZJpfZaFabn2OFdMzVkWi7D7pk/cfUHHX/wpdJ6M5cZig?=
 =?us-ascii?Q?FhawjkfKCRWbH9QQVI32dq0VkfWhDoKuoQJ25kBJsWdyj5W8GpX0+676Gk1l?=
 =?us-ascii?Q?ZrVzUArsoeVL3JMyF6ruV5k6GiSZYN20vGbmetVchb1CR/cu4e7hbYbjGS4j?=
 =?us-ascii?Q?IaU3PmEYYOPB8UDUhSnSIMVmeHBXe9JdznsmU4gnoOVj6oq404wc9SbwMQR6?=
 =?us-ascii?Q?byMxupm5l/BpWsDhXKs6cBfspGY6FkDySwi3Bq8u9m7AnV4WZUTNMK4v5Ibi?=
 =?us-ascii?Q?YFkjoPbv4eZ9SJjKxL460d15zgKbyWit8mxe1TOQqcLyoFRehCHADxd5uGXt?=
 =?us-ascii?Q?6TxYthDyJ7px6VeZal1Cvj/NXPGMu63iugUPRQt/09UK+LF6DF6uI33M80GT?=
 =?us-ascii?Q?Mvnjp8DXe63pi33MrOyrvSFMauqJhg/A/1/Wis/p5W9csxONt4QmJYRhw9SB?=
 =?us-ascii?Q?0IJKs4OMeL9y4bXzFhJFgHXCxZrKiF5m6UBwFmZDeZm3dGCzIlJmdASaKgZp?=
 =?us-ascii?Q?hzahzZhtR1CLds6bU7bzGWdrAodmyaZ14B1bZwlAsNsAAOdI5TfoV6nWTRyo?=
 =?us-ascii?Q?kOuzFxVLILciHSTYT+MROQXtDLOmXbJ0NvdMqBSAee9eIKnecWIgryd3J6Oa?=
 =?us-ascii?Q?L0IaeTQ7RwLrKKC1JjWNvlkCRfQYjZxVHS9v8qyJswh2o8SldY5q76rsTNoR?=
X-MS-Exchange-AntiSpam-MessageData-1: xKB2Xj+liM5GXrSxBFy8nNHmt7c54sa2mxY=
X-Exchange-RoutingPolicyChecked:
	CkW5iv4o3yckdGFdIkboULo0Xc2IMZa2d277k8BCk5dJt9/nT5W/kfp+Mekvy6fo49shp8X9w3og4nH5MYkuR9+DFEbE5NChNWkP/65mbxH34cyJs5Xtuy/hPgG1wuUMT71c6dQN4CEgK6XJj8OzjntZuM2rAig8ONJ/7RxLYDkZdwaWO6Faw6d5ukVn4FHfxCQWo1IMWK+gKi8AbhRS/oKcnTltNMeCCY7FFvcgDCZ/6JpxyT9r2xfLDqLzKS4cG5+XrvC6Y7kS/3jSUd30lROghHwsijlEO3T4Pw3uFLiuVTx7IoNLTR5OUT1nN64n1ikD1So15GuDEEWMf+BSiw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pUjmuwfV9LRoRa7uu/uiDVJng8Om37tTlts1saaBcEXLsTEO88DiEEk53eTnk8iii9dYZh7xaNuCrkRNEV5qrWlbis8K9CP53l7XDqUa0V5d5XJFmTQgqmqoxOZLwYWbLN2zjyPzcXh/PCVQI/bQpQk4TQQxdpwDSCEs2d1q38s6u6ju392q0r6S0KLkckSZ5qt0U7TYgPreDMUW5qXhMvyOFR6NLfYqhmndLWTmut7FFpNBIQwgBCRqeXfsqgcI0Pxqrcn6eJ3BB587Qcnh+X0hpXqQ1fqnJeWzg+2qKMu1ZKoDR+PpI/3X7ZmzgX1RYRGg9kAQ6mC1tDkHN6MT2M/jjsAN9S1P/jt7C6gobsfVBaS2KdE2Th7tp42uTkMKVMqXaMUzVBu3Kcallk4bGSpVmyinMa0Q1OMkUAgpJbzOJ/jSMBT1ljN12Mdh2FyGfH5UJawcUoE4S5Dweis+VzBcDV6wAgpG+tS8g7AQFfSCzA9JYhPedvo00akpD4N+bYgkjOUWos+AQpjQxKHRTkMHGfoooGRLiu6AkgTIRuAqs7c0T86xVYCc/AtVIczLsXqh+5N2G5RfHin8rcyniuJrxMELSF0gTXkW0A67ZuFp2PJzOmXWEMHcKzrAnUrT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1270f81-e036-4e99-8069-08df4a314dfe
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:13.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDRAoLRagLTxPZs1o49/VnupyJ7hNlbzpu3r5ZD/zSkT7m6Gzw8qpw+LvFoGvL3H+sdw79zZSPf17n0uSC1QXUQciLUEWhTJmX81+I7IugQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

This is the user space side of
https://lore.kernel.org/linux-block/20261124133553.152463-1-johannes.thumshirn@wdc.com/

It requests a trace with ioprios from the kernel and blkparse parses and
prints them.

Johannes Thumshirn (6):
  blktrace: sync blktrace_api.h with kernel
  blktrace: add RWBS for WRITE ZEROES
  blktrace: add ioprio to blktrace
  blktrace: mask __BLK_TA_IOPRIO when decoding actions
  blktrace: add --ioprio option
  blkparse: print I/O priorities

 blkparse.c           |  4 ++--
 blkparse_fmt.c       | 37 +++++++++++++++++++++++++++++++++++++
 blktrace.c           | 29 +++++++++++++++++++++++++++++
 blktrace.h           |  3 ++-
 blktrace_api.h       | 31 ++++++++++++++++++-------------
 btreplay/btrecord.c  |  5 +++--
 btt/trace.c          |  6 +++++-
 doc/blkparse.1       |  7 +++++++
 doc/blktrace.8       |  5 +++++
 iowatcher/blkparse.c |  3 ++-
 10 files changed, 110 insertions(+), 20 deletions(-)


base-commit: b3015a35bd6332dfead81aa29fed5b8a6567036f
-- 
2.56.1

