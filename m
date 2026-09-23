Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7533993;
	Wed, 23 Sep 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167223; cv=fail; b=B3belM8Hak0Ymek1ZR5bxWX3S/LsYwkOhQ6YhS/qAyDpVfwG/XrnBtSNrhBe0DtqVQ9hwY2ilIKTA/ViOc5bFYLXH1IDKHWd/NlULOxItQTaDr1KuKbAGzFcW2bbsktBYTxRcWhMoucgKxEnw7eNAW9e4fWmShXyts0RJBk2nLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167223; c=relaxed/simple;
	bh=iMVv1urevXjWVzuKpTszUPll3thb7WlSfGI4kzhhtdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cSxMAaqR0g7XX8NGzibec7uCvbe4Cc8xxlNIbZzkjloj+bFu/3ou19Mlfb22PXtxrQdnu56j/1XNw0XZXTHutbjwxFyy6OxyuElcqFD7G5d2UY5LLFgx8SkKLxZCNfeMR9ePU/ZuScCH8mB1r2Qbj0Zmk1LAizHeEJMq+RpV5vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VcOk37bI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RhaFDd2A; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VcOk37bI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RhaFDd2A"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790167226; x=1821703226;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iMVv1urevXjWVzuKpTszUPll3thb7WlSfGI4kzhhtdg=;
  b=VcOk37bI355SM3nc1nNt8/8wEfhI1+vcheXyOvj4NHQp0Km6cgzGWt3I
   ZFYjjjwqFITyFCcF0DR6RFOmv8xsawlRrvcc/9qaw1Lj35/rbKYmJ/hcg
   vEAiRB4VNEg8jCBdgf6IXKnIsBuxtP/AnLxbprM2eLPs+1+8eQOJE7BI/
   4m3Y46oKA0IKCfKNhwqeS9uDB3J0p+nSFXNVxst/Ow8MiU0Nm18RrWm89
   RNaWk21pgS4FD6iXjr/dS38ury+yIXPBoEmROIia0UblA7jQV/dCJoqZR
   JEDHYGcHXihY8mibHg+HB/nZCZK9uTMY8VB32h4kVkfAlQp68ZPf7Oenp
   A==;
X-CSE-ConnectionGUID: EFFGFoW5Q9KmQx+X7hoTdg==
X-CSE-MsgGUID: UUb53YztQ5qSP7vAzbRlDg==
X-IronPort-AV: E=Sophos;i="6.27,118,1786982400"; 
   d="scan'208";a="156366499"
Received: from mail-westusazon11010036.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.36])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2026 20:39:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0gD1TC7TEg0W78GLC2RqYU7hzh/dNn5PMzxYpkWtMqKMz3smwsXmNa19bHCeSjjuxDSgHgFFecJf441cYcSzqpAM39yYpNGJFoSkeF0MXCbJpkBVqHTTofNUBfHaXRssNu5X9qitsgsoid0nfFi4ZUlwuq7Fvae8dK8l0Z1c7Y2KnaVOZbZRwcnbec15IWgwFoXKzwnndo+KyNrEPCTulYt9kwMZrkgm290fGmWN753oVDMgbEVXsXm33bDYX/qfXDvCeQbCYS3QQQlbq4+rLdbuo0V1E7Iz2hnKkGp3XgPGZ+TBkiNpgnSbnjm7tzQ9rl2VDh39N376ADHsgjddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocZIBSQga1QSoknv7kN1RgKGgL6ulXF60hNTyexCiI8=;
 b=YRD67il5AypWTQ/G4wz8KaWNS9e20vDWjFwR1pum+PNKr5Ij/WaCCFiZ2Lj3YaNLsRyYkvJDKaMeJYJwH335djhF9e6cyNHaaiN8W6UyOKzagFWJZp9+SN8SMOVBlzcajiEzrPBZvD/Incx2cRnCG0SbMjCuDNONRm5maBuL2spwEaOTMwZIRdfqENb/QQw8/S3bLDbtWqrRv5eZtVCZywvLbPC+Q5u1gob7gqaZipJXJnE9mxAF2gxlgDscsePRRvFFB015Kmqb1LZPqSMmK1Ugofpzv8+HwGgteqvF5ZPhIyfWS4ltHStUihoezDdawTz+m2hbwCh94Jbgrj21kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocZIBSQga1QSoknv7kN1RgKGgL6ulXF60hNTyexCiI8=;
 b=RhaFDd2AG84vZUBaItJMpNHCBMeZC5ZIOrJIMX90j/lrocqVNI2JfKG/3PxQNgXgicvIF1NdV2JQzA6JFNF2B8v+8Uwxx55LJtEyFK2w2fqRvKn1kKf1aMI4Qefvsg+7bwDlgehZt2Bkj/WSJjKy7LCGZMx1TWdJZ9kP8d3VvsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by DS2PR04MB9725.namprd04.prod.outlook.com (2603:10b6:8:27a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:39:08 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:39:08 +0000
Date: Wed, 23 Sep 2026 14:38:59 +0200
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	linux-btrace@vger.kernel.org
Subject: Re: [PATCH v2 00/11] blktrace: parse blk_io_trace2 in btt and
 iowatcher
Message-ID: <arPISNMA9LiFR8_w@mayhem.fritz.box>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|DS2PR04MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c9296d-90b9-4dcc-3d43-08df196fa96f
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|19092799006|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	adiSaMPL10vOBnuML6wZ+pqt2+SqSkPl018YmHMyGiO3bfTPivCz3AlCj5y8glTXRFtyiq1F5sD6jkEtmKDt3A7sLI8acbteCCLVuqLdsJ+FYHUXB0UbhkmOPR0rmL3B5qZUigqyKFhRyZwJpuKYY0IbtD3qqMP9O9WfMbBt1TxbyjwM0ZuKg6zFWMN2DWU/1UEPPrrNpD46Wes4yCAYpoVk1/kzgWG2ca1/gwW9e8iAx5/zLjTQ+eUSND6MjxivelrH7ZHRarVLRjNpS/m3d+Ub2NEdnDc80NpdArKnXVTj0xjHE82URRq6nVgLRYjbD870uVmLvKLJzt+whpDvewWrncmBNoSLjdxUtJnPlfE9bR4DnAHzsnQ2X9+oIqlpmjBhKHShYBkrVBR6euEDkHZoGjspHwgYxrhiiPuFPWLF6RtYWmLgUegK9IaB5kKnbVs7GnpeOvO6qOR1rRU/ZtNy4DxtHGQufcHbT9xMC7N8xUA5J/fTCP8cZEQZrzjX5FU28smXQUGE8RQlQJ4MInVjzDRqiI8grnAFkU7vG/syv+u+83Ilh0Q9AK+ajpX08zPz5+t0XHgcO2LWi7h2ApWv4RXnUZQx7kh1PWvf3Ib/dIAjtr91F4xikOyvGDtuzAJZXQezaGyURILQWmnaFB+nmKAEbpsdXWKAeYjYI1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(19092799006)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8u3o99YOtzjl3BGYIMEqPvZRdLYxLVGzsQv/MNCoLaYW/6N0Hph9FI6KVhPi?=
 =?us-ascii?Q?sKygOBT0m/ehlKMAjg9xcAwjsrrFpnZjs2yDzUxXJvJ100ZQO8IWuplkhlmh?=
 =?us-ascii?Q?QyUn2w5G5Q4OQHNUhDZy37Cl5LEneZnKe1IE3L9yCqjuQnJZ9sfIjIp05bFc?=
 =?us-ascii?Q?VQK2d96IhSGSrr/UPU2Ejh7avAtOXs9kyT7g+nsfmL5Yb5d46FG8EbT9mds5?=
 =?us-ascii?Q?WHXn+YAxqZo6IjEgkLcARymXlpnP7zDunoeHUdcotUd27cuJMvOkH1llNRVQ?=
 =?us-ascii?Q?K0whEPW+pGOU6HzwjmPQqbwDXpvQFy4oeI7VrjpD0EQVGhu4HjlFf+iQAEYO?=
 =?us-ascii?Q?+Klshmk8j4JAXzIFaT3IqY8wyn1SV5WUvCK8JvnQV2HubxHRR+Dm2S8jT7K1?=
 =?us-ascii?Q?b86viuRCPEYs+7RcUUu7mA1MizqZJ+bpsDuDSraMy2qQ/PZnUAZLNyrls0/j?=
 =?us-ascii?Q?KOrUK+1zLdhjG6RgDaFG7JBZQd0OE5ElRCaH7x0gJcrjiwIrxdfJteNHSt3h?=
 =?us-ascii?Q?ojHbPw7Aa1izXg17w1qkEInJmCpvP2KuzagWlW31C4u6v5Vyml8CJoiGN2ju?=
 =?us-ascii?Q?ZNHE1OOT5COjJiCYI1jYGSbtLgc+1U7sZz5Kh5D3/htHlEFsttwobLS0A2BF?=
 =?us-ascii?Q?pOHzWhITYiAmbIf36YoGOJ9j0aqgXh9BMgUZGpkGWpSJkVkcK8mDLtzLPLrS?=
 =?us-ascii?Q?vUkzDAt1xpbqRObTpAgQQ8EiZ+ZqSMB5y2Vrr7v9p9+KygfgfUVq1maoSOLE?=
 =?us-ascii?Q?UaDnlW3ONQp0cl13J0GocMzKN5hLLr1d16pfuQVB92Ao93YP1+50UuZNxKOy?=
 =?us-ascii?Q?2dXUPS8OU9wYSoPDKz5sj0pWoafpMcFiC7ZVWr4cUQSa43PTlV+/EpdKh38Z?=
 =?us-ascii?Q?DtqgN49A/TPqUtUXqir26xX/1eC6+v4gRHtHTnx1If40gAw5V77mNfyd4qY7?=
 =?us-ascii?Q?QfEgWKnuqSh2Da9CM2RRagghFvG3GwFV8yhXNkMvP4dbyx3aMRTjCc3GwKGy?=
 =?us-ascii?Q?9he7M8Y5Et0cHCcUM07hecIGUd34ScDA/o+Cqilr7ewjclHk9HhtVWCtqIab?=
 =?us-ascii?Q?p850JqG/G1GofZlRD5di9E7a6yKL9ZLFEg33wMIX0KleCeq7zgovyQ9TzvZh?=
 =?us-ascii?Q?Mq9mQMd6k+wI2Fb0Y7h0HvHDBNwUUOC1Yyd59V1SR7/kfXc1CIo+SbHYz2G2?=
 =?us-ascii?Q?6hJuTRJ43NGUKA4/K6X0QTh0ngyirw1TaBo5OLZNBOEfLRKEte9AOMb+IXO0?=
 =?us-ascii?Q?LLelnh/JAOicOGEr9kl3FqPzG71tzotrqZiEfN0+NgV/8brTR4YcgXbXoauJ?=
 =?us-ascii?Q?SEJ4okz1ATavL9ao/r/0TmutjnhuQvEAT5jDT06cuSzYpeTDvwo/lg0tqzaA?=
 =?us-ascii?Q?Ddzf8Oro4qISd3YNFSdvfD4PXj9smFYYndUCzde8So5ry+qetUdYT2CX2iNx?=
 =?us-ascii?Q?zTh404lrW3v2RaUkmfXBkh4hSELkqsWY8FLN1zMUqx9AayLQ1dGFt/p1EbDw?=
 =?us-ascii?Q?YQXk/j5P7zi8eHz5lupSRugNNsj4YGf5+AGyxxdeYebUTNYmpZPlA0QJMuTj?=
 =?us-ascii?Q?BIUiK+AUkh+eKYAFgLOjIOXL40mz5Bqcmm2nvx8GAjgxi597+4lPECL+3EHB?=
 =?us-ascii?Q?RT0FYVOvCKiYe/PcnPCjU33LjDwbgl07DcX4/MrhEiDdV4aCcJ7DINvrTHAJ?=
 =?us-ascii?Q?rtvmefSdnXqSHEIzTEVLyjKRePY2OfpcuiX7GAyDZEW1HsJSGKz/U1ApCAhJ?=
 =?us-ascii?Q?x4ASvnCBNhLKexBH7O+pfR9tILRg2W/Gj6s+qj7G6DOeaiGZoCZ/+P4o1PM+?=
X-MS-Exchange-AntiSpam-MessageData-1: 66kwEg85jtoMNmKQULBzglfbUmphQJVORCc=
X-Exchange-RoutingPolicyChecked:
	WJiZ94O8MbbZIlqmTh2GA5pyTb0/BpaLmSJ5eYnQZ4ey4ap11KzbWNckgrLA7p5SQWhASASn16wx8VBpkumvDxihFWe5NtxHBkoEP0MkIXFOp58aGMbIzmm84y2L+pf9aFOgEot8mm0xsGsCbQq9VrTWeZNd/nYKlWQA6zwp8i7bkr9kj3wAW5euQRvIB9onIU8oZkeTJ724cje3aH1kVjsUOHhA1SWBwZHQ0A/o3QEAf7Cb6limcg2d0ELY3ls7p95QHwbdIkSfIhfPyB5Ft7TEPdksdk4uy0krmnREFO1rybZY5Vw0iB6H8ST8ZKfgbN/39shW9bHbG5m9KNCDDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VWIa8BhQtj66MSP+iWrO7jmRuToh7i7ZXLN0RPS+GJnZEsDa0S0G8NoYRyMlU2N6zFpLfGZ2OBcAc/KXwEGX0Ba0uJ5Y6xKFFeNKpNz8my3gvmFsHOL2S2AMwlefw99nt/0/QxQITcPEtKHWNUIre7TpW11nMf9/0T9ZIsRyCpcon9XON/twZAJy0IqwPy5pVkcSk4ICBV2g9/M8f++XmVfcdSlW4F40jDLO3moEcaf4zz4oj8KIpht7mZIThuUkE+vE1bmKuH7sf9Ig1/Nsz5oeLlCS9PPY1YKw96JFdCoDvviDGV8PdieK3zhA09MPAD37qXp3N08qcP7/18BPrIyRp/z0VjEq9mbaz3YeNXm9xQ0G+tjbYWqRXSMXQc6DE47C4ho9J3R86OgGXl1aIm1xsS5sc+hBTK1DqhfOtZr8dQhx3waUmByr+YzUCOotwan64WKJYrchSulT9m7ZSqHcZaH7gXKnInj1bQkFznfFvSxECwoXsG13uD7UH9IwvlA0wYiThstx0CuLAfL6Bi81QXz+k2lXJ+95eu+50aHr8rhP4mxAmi9+LcVVRdEdqwyb6ShlBiN8g+ueDkGYQDyTCX9Y8qgtyZuk1pNglMw9+Dx/Kb3VDh8zfblt9utC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c9296d-90b9-4dcc-3d43-08df196fa96f
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:39:08.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnmghDxhBbWhjSQpXFalhqjWEClJnjlEfOE1TJnD7eVu3tGL9xqA97dG1TyJiORPf9FDpikiPGK3ztTFMHve+lhr3txeT0B7MvoAGDhKpgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB9725

On Mon, Jul 20, 2026 at 01:14:06PM +0200, Johannes Thumshirn wrote:
> We had an internal report that the new blktrace format does not work
> with the btt tool.
> 
> This is because I simply forgot to update these tools. Do so now and
> sorry for all the inconvenience it might have brought.

Jens, ping?
