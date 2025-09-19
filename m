Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF62940B;
	Fri, 19 Sep 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271769; cv=fail; b=Rm9giPoARMuQjV9O9X/NxvlRzK5qszkwgWlQHzZZh9YDaa67ncGwGqBr9qXbpUbZvUfJ28LpBIP0D2cp6VhmChA0wnRcnk6hgqsAbLoIuCrqiZAj0SMv2FuC5P/SlIdbZIFbE3YKzi1q3GYC1+i8EqwE9hn/P/84lNwcJEHgz/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271769; c=relaxed/simple;
	bh=zSVuJBWL0w+BScqOXxnUdKrylF5jfKyHM4Zc/gZCY/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdIeQA0fTHkd+1TvGsvShf2JcPHceV+VeI+0MAOkUqnP2vgISxTq4injtVUdzjYBm08A6nMa6aLMmmjy69PfqRmltVImDg+NORBwXJAjsfNI0HvdsDiwpae/IsbewfF/HAoVV1wuV1xyunNQa0gVPdJ78Q+4/mp7UxbuCzuUdQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FtW25F4b; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtW25F4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhvAc8KnfTT4zYefpbztyOXrH0TxA1ls0YnYFclwl2k5fwQao6suuo2un3vLLoz2yCc2SGP6p5aSrSVDUS8IZmpEAwdUAC5y50ueNdNobOOFH8vg0t/X3Qa3c4O8sC/wKAKo+CQROoGLiXAJigmpat9f+dst4eFJDGU9YcpDFzO7C7eEaMfZIa6ertZ/DyXs06xf+XzSAwb4Hi8C+jAyZ1uHnqBHr/9dLBMWrOAFytVy5U6ZtzLXyjBZ3IGUBQzm0b27SUIsn7dBE97lRgRfzvIF9QQj5oOUpaLWB/TaCSS0LMU9YksW4aMTTCbzF4TfvERrPEn2Ee/Kfk5vI9fgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSVuJBWL0w+BScqOXxnUdKrylF5jfKyHM4Zc/gZCY/Y=;
 b=XGH2YP/JdTlNUyjR2k3ogVbx3mZXygCftpZbtHafVBtPDeABYpnIvx2rWtrvpRShrztWXwqmTfa3lECRUisqZ8cIw70j4EEBuzoPXBIbsqMwuAoAsejyBetMoIQWM9/D5kZcUO0/+YMNAND5x6xPDkv2aBb6eQwC5EOwXroX/c1fC34rh1xOYpSyM7cvXcasgpT2+Dz6XTNX3YNYnBImcuU64j3NMAlMoBeW+416XsFZxqFACKsqn9Z0PJeujoGTFzyLsA8MRwZFReFeyGOm1cX7Fh26m06D06MP3jp0RnkZTYQ9R2wrBbekh0mw3PsbX8ISAbrvfQV5AtiT/2OCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSVuJBWL0w+BScqOXxnUdKrylF5jfKyHM4Zc/gZCY/Y=;
 b=FtW25F4b0eNiOcg4gSFnLOKLvLwmCniANZYb7OSk8xAXmGVxe0nyjBurNQn4zKLtG/NuJhuMqDwRZUMmLGDJEDTK/VIZvSjGRW+hs0ZJA5PfNx1Xke3xukGen+0bbcVjM8fSGW7bL/GysXRy0zHZ6WT/6ddISh0xWLixDQcfrZ2OZw3Ku55Ht2qqfiou1x/T1MjYtBczCvSiYs6UMwvTUx242oD40K0DOcpYqAy6BwesvJ4deEASy1wJUyMRJ0Y8k7Bmi+Z8XlK6C2HKlLkohfN+0b8vQ0usWeb12mfTf/reC+DI6PWNkcxClxZLygqYW5tM3pwuoM9myCKFHwjjmw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 08:49:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:49:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>, Damien Le Moal
	<dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, Naohiro Aota
	<naohiro.aota@wdc.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 03/21] call BLKTRACESETUP2 ioctl per default to setup a
 trace
Thread-Topic: [PATCH 03/21] call BLKTRACESETUP2 ioctl per default to setup a
 trace
Thread-Index: AQHcIXn8HrHgb331ZUSjMhxaoP7RnbSaQaQA
Date: Fri, 19 Sep 2025 08:49:24 +0000
Message-ID: <aceaeb4f-40ed-444e-84a7-39ca640fe913@nvidia.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
 <20250909110723.75676-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20250909110723.75676-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5889:EE_
x-ms-office365-filtering-correlation-id: c47841a4-281f-4ca0-40c7-08ddf7596f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHNkYWkzMnZtS3hFcjl0V1RiamRreG1aSitpdXlwUUE1QUdwZTd6Um9qbXow?=
 =?utf-8?B?eHdDU3plVnZwT3V3eHVZOVZFQzdBM3VnZ3RaQzE2R0d6eXZaTWdrcGdlaHRM?=
 =?utf-8?B?YjBZY1dSUGx5Wnp5d1NrM1c3RG5QWTFXQWxtUUJqRUxhYXQxQVRoZTduMStI?=
 =?utf-8?B?eWlZekhHWk1Id1haMzQ3RVRxOFA3WG15STdHUkJMTms5THhtanlNS0pPQ2xl?=
 =?utf-8?B?NlYvSzUreHNKK1RWNmlPVnZqSGFpWHJ6STlUczVQOE9MMDB5ZGZ3T1FHaDQ0?=
 =?utf-8?B?NU12bk1JR2cwSFpuNCsvRTUvVWJMUVloRXhnR0lqRzZmUXFhNVZaSHJYS1dN?=
 =?utf-8?B?SStPam40SUJ5UnpFSjFsOHRyOUtTalc2VTlPUTV4RklodytFbCtvTHRiZzht?=
 =?utf-8?B?Vm9MblFIRFcxakE3dzhKYi9vODNLWlVqVEF4eVg2UWhqU0dGd1R1L1ppVDNo?=
 =?utf-8?B?dStnd2lzUW1GYTgvcnlOL0JLUlNFUVhESTRjWjJsbVl5SHBVYUdyY2dKVGZB?=
 =?utf-8?B?RWdGWElHRXRlVWpxL0FqckJCUGNTKzdPYmJPQVpwV2JXME5tbml4UFVqSm1H?=
 =?utf-8?B?UktzUEp5eDdDWjdDdFRsNGRjek1XNXRuellKdEZVVWtrWU5kTzQ0TFBrSUJt?=
 =?utf-8?B?cW5mRjNpNit4ZnV2Z2JKT09aVms3cGFqbXhpM0V1WkNPK21SeS9pWFNHbHlX?=
 =?utf-8?B?cnpyMnljMVFCaEw4MXRxNmNmYTVhNjJZaFpBbllGOTB5YWRjZ2QxUW5vZm02?=
 =?utf-8?B?a2lkM2R0RE9vd0VLZUt1M0tTRzNDclMxaWYyWkJQQVhjU1BtL054Y2k4Qm9u?=
 =?utf-8?B?UDRvdGFlVndCTkJaYks2U3NOWDJONTVsSno4Vi8yVXJnd2k1MVVSZzV2SWY2?=
 =?utf-8?B?a1Z5RjNMQ2g4cDQvYVJITWs4cHN0Zk5DRGZVeVQ0ak41cjJWQmNRbGNMUTY1?=
 =?utf-8?B?cW1menMrdE1SU09uWGE1VjIxbTRWMENnUVBhTzJGVHR0YVJ0WXdOS0RaZ2NT?=
 =?utf-8?B?Rzd2RGJXMjkvUW56N3ltVkM3QjFPMGN4MllLaGY3S1A2aGwxS2lFYnFiQVJV?=
 =?utf-8?B?VUFUVlV3dGk0dTU4Y3J2eExvYzNDSStJdkdlL3o1NklMeWcwNzhDdzhnUjRr?=
 =?utf-8?B?SUk0cVJmRldGQmlKVHZSckh4S3NIQU8rZkZWRytsWU9UOHdlRndlR0duMWho?=
 =?utf-8?B?eGR1R21sU01oRWNDNU1iTDBpOVNSWlo5MHdOMm4vVXJidnZ0ZWZVY256UFhh?=
 =?utf-8?B?OE9sVTRzT3lhbkNmUkZWeTZJSnhobytlbTFtdlAvSnpKTlNtUmRHVFp1L3dG?=
 =?utf-8?B?dXlqUnpCLzBoYTBnNFg0UXFjV3gyQW1HQko4Ti8rMmRBUEc1RVNVTnhsZjdO?=
 =?utf-8?B?N3JsRlBzRmMvei9obEMzUmlmL0lWaU5iR0Y0SzdyNUVXWHZWSmh0ZHpqVGNo?=
 =?utf-8?B?cFB5RkVzRy9vRGx2eWYrUnhYWUlzOUhpY0U5Q1FwbGZSbUZXWTlLaGRvYjhY?=
 =?utf-8?B?UHgxT2gwZ2NINE1ndXh4RkppVkE1ekZDM1NmQitUb3dyMXp6U3V6QjlHdDB2?=
 =?utf-8?B?WUx4VE1QTHpER0p2dmFXaEpxVTI0bytjOVZxTXJ2WDZPM2dxUlNGc1pNTzNn?=
 =?utf-8?B?U1ZOWDU1Uk1XaGZpanFZdFFpNkdxRC9EamREVGRTKzU1WE0rNUxBWnM3Sncw?=
 =?utf-8?B?QVdrczFYN24vNFNqQUlUelIrTVJPbTNKQkQydFJTVllqY2U2VGJvMjJUTFpF?=
 =?utf-8?B?V1VGRi9Sd0VpcHBwQjdiSFBSUjdpa1N1Sm04aVJUVm9JWWVHQ1YyejRpbFUv?=
 =?utf-8?B?MjhhWHYxcnUwZnIvRTU1eENuQ1ppeVZIdXRLNzI1V3ZFQk9Ra1hUQW1WYkRO?=
 =?utf-8?B?VVFmYUQyNkJMblVzZnhyY0VUbEphOTkrRHNSRXJuRHlDNTFLZnhEeW8wMDBx?=
 =?utf-8?B?TmxCZUFiSXUxdGowWFVqZmlTOE9yTFJ5aUFBKzZPcDMveXNvTjBFaktOcSts?=
 =?utf-8?B?b3JrRVNwUHRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TklrOGVnOEJhSjdkLy9wc1lvMC82a1RDcEtwdi90OUg2UVA2UDlGTWtQQm5L?=
 =?utf-8?B?cHc1bFpMdWNHV1pDMkhFaytTTi9WYmJhdUpRUnI3VTNGck1MUkg0Z3QxWDc5?=
 =?utf-8?B?dG5vNi93ajJKb1RaNW9vSU5sY2NjWXgzQ1BHVXZ1MjVjSzNodCs1TUxHL3hG?=
 =?utf-8?B?THdVaXVRMVJiME1FZ0NKQm43Z09yWnkyQUVDbXJ3QXcxQ2ZnNWkwSitmTDVn?=
 =?utf-8?B?b2EwbitTNk9pc0lWOHEvcVRhVzNVbHFOcHlRU0c2eUV5OERmUFZMS0xSWDVv?=
 =?utf-8?B?K0F0aGorY25QSHNxbHFGMkZQZzA4d0x5MXMxZVp1dWZ0TFZlMGwzcm1acEt0?=
 =?utf-8?B?TVZhVzRWc0t4eHlUeThwM3hxbmVQa3dzcnZxTzNLcWN0Ym9yU2U3bk95aHMx?=
 =?utf-8?B?OFhjV29sa2M0L2lLTWFjMklZRlhaT3gyRWFSUjZQanlzUWNUVzE4RHRxNkVX?=
 =?utf-8?B?eGoweDdVd2NvTXk0cG1hbkxQL1dLSjJYNU1JWjlET3NheXJMNUhYRCtoSUZp?=
 =?utf-8?B?MXVsdHYxWEp3T1p2SGpQMDRYN1pkZmR6TEMrWFhGUVFlNTNTM3B4NEI3TW9l?=
 =?utf-8?B?aC90aTR5ZFV4V09mUjRUN0JXWXV3NTBOWHhSSndMUWEwQTBqSldKdkFZNlkv?=
 =?utf-8?B?ZEFQTmYwaG1ERXowNHRhdDgyTTJKQ1UyclBsbEhtWnd6SE9jNEllMWtuZFda?=
 =?utf-8?B?ZC8xeDNSRGhLVGw4WTBHUXFDMTkyOUtvdHh5bVduMysweUQ0bU0xcE03Ry9h?=
 =?utf-8?B?L3RFWndKNXRNbWUrZXJqbWo1dHQweWdYNnhXdFQxa2JKOXBMb0VvZFpzSUlU?=
 =?utf-8?B?VEFVNHIzNlhRa1A4alErMTQrbGlyaE1nTXZSRlRIK0RJR081d3YzQWhJWlBN?=
 =?utf-8?B?OFdEK0VYekVielNtb1Foa2tUazRUZU45VlR0YVltTDJ1TVBJcE43Szd2cG9C?=
 =?utf-8?B?ZkxqVGhvUE03azZkN1hLSG5YSldDYks1aFNmamJ4amUwbHVZNkdBWjg5emJF?=
 =?utf-8?B?U0dBQ1BPRkl1YXo0YkFEd1BwMXpEd1p0WG5ZL2QwclY3WHVVMXVqRFhxQ25h?=
 =?utf-8?B?K2ZKbXhCUXNjRkNackRTeXZBaEdsUUdpN1NGTmltWGxYNmlNK25XcUxsNUZL?=
 =?utf-8?B?THcyL25tMXczTVhWYjkrakovaVVlM2IwWTdVU3JWaTltRXdjZ1ZSZU50dHA0?=
 =?utf-8?B?aTJSaktCNEVyejAyWmI4aVFNTFM5TnFqYUExS0ZiRmZDM0RQanpRVVRQY3Rw?=
 =?utf-8?B?R3ZuaU01UkY5UEE4SHBaYzN3VFhWdmtDdXNIQlNwdEF5Q3Q2TmRmWnN5eExq?=
 =?utf-8?B?QzZtckE2ODZQTUFPajRxbzZHU1hEQUJ2VWdPaEN5NEhhRXcxbDdOcHZ1UzJW?=
 =?utf-8?B?YW9pZ2s2YlRZbG1ISnhFaVB0WWVLbTV4Vk9VckVPM3RIdmpCcWlGMzByRi8v?=
 =?utf-8?B?cTcrMElVZ2ZwLzE5Um15SkduVVA0akxTdkdWVWhNTktveER2U2p5NFB5aHQz?=
 =?utf-8?B?T1d5REVHUFFMLzZlcFlIL2Eyb3A5SEZyckttRks3dC9YUkhFM3lpeDYwd3hk?=
 =?utf-8?B?UDVYai9DTDNLNyt4Yms3RVhadzZ0RlN6ZFJBQ0tLZC92a3R1VzZyQWJpQXNO?=
 =?utf-8?B?TGMzRUVKVjJ6SXk5U0IvZ1VxUzlwVEI2TEtaVGhreks4L2pKRWNkdUxXd0dT?=
 =?utf-8?B?aWpiMVUrTVZzLzZMVE8vUEpuWVNRc2xjWlFWcUhsYllzSldHU2M4U2wzcDNT?=
 =?utf-8?B?bC9hdm1TWEZyTlRZclZUaVgvK2FUa1pBSUYrRlRnU1FuZDQ2MGVtMU1FRzJK?=
 =?utf-8?B?WUlpeFRmTmZXekF2angxMWlibWFQTGNLdkF4dmNFS1NIc0pNRk5wNGwySlFF?=
 =?utf-8?B?NjBiUmVHZlZVakhQdkEvdG9FendtNU5xSFNCM292aDJhd2lhN0c1UStCT25F?=
 =?utf-8?B?RjFhKzBGaFdjanBDTFJKQXVYa1p6NFhsTSsvVDNNenVnekxkeCtBZUpsNkpv?=
 =?utf-8?B?cG1teHl3bEd0L0ZoOUNNY29iWWRETTJ1bTV6UXk1cXpVYzNtQkZQQnFEaDFm?=
 =?utf-8?B?QU1ZNEYrSFJFTEM2REJ4WmN6eFphT0dyUlBSMkFud1hBQitQMXMyOCtnQlI0?=
 =?utf-8?B?eUlnbjkrS1lRYlR3R1c4WFAxZVNRc1dBclkza3BQOGtiNkt1bHc2SXFwUElW?=
 =?utf-8?Q?irA1fjCUOWv3vRSb69mibTfp4QGkPH6uhuS//aAHSK5W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B9838CE856ACE4F92C9963A3DBFA126@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47841a4-281f-4ca0-40c7-08ddf7596f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:49:25.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtBWJ8ywai+jHILahLrRFT5Yytl3CsnegqFKMQQQ1iBIi19MXYm1rjNUuCSkFUF8riwNpICbhs7x0AOi7aZw2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

T24gOS85LzI1IDA0OjA3LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQoNCkNhbGwgQkxLVFJB
Q0VTRVRVUDIgaW9jdGwgcGVyIGRlZmF1bHQgYW5kIGlmIHRoZSBrZXJuZWwgZG9lcyBub3Qgc3Vw
cG9ydA0KdGhpcyBpb2N0bCBiZWNhdXNlIGl0IGlzIHRvbyBvbGQsIGZhbGwgYmFjayB0byBjYWxs
aW5nIEJMS1RSQUNFU0VUVVAuDQoNClNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQotLS0NCiAgYmxrdHJhY2UuYyB8IDQwICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAgMSBmaWxlIGNoYW5nZWQsIDM2
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ibGt0cmFjZS5j
IGIvYmxrdHJhY2UuYw0KaW5kZXggMDM4YjJjYi4uNzI1NjJmZCAxMDA2NDQNCi0tLSBhL2Jsa3Ry
YWNlLmMNCisrKyBiL2Jsa3RyYWNlLmMNCkBAIC0yNzksNyArMjc5LDcgQEAgc3RhdGljIGludCBt
YXhfY3B1czsNCiAgc3RhdGljIGludCBuY3B1czsNCiAgc3RhdGljIGNwdV9zZXRfdCAqb25saW5l
X2NwdXM7DQogIHN0YXRpYyBpbnQgcGFnZXNpemU7DQotc3RhdGljIGludCBhY3RfbWFzayA9IH4w
VTsNCitzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIGFjdF9tYXNrID0gfjBVOw0KDQp+MFVMTCA/
DQoNCiAgc3RhdGljIGludCBraWxsX3J1bm5pbmdfdHJhY2U7DQogIHN0YXRpYyBpbnQgc3RvcF93
YXRjaDsNCiAgc3RhdGljIGludCBwaXBlZF9vdXRwdXQ7DQpAQCAtMTA2Nyw2ICsxMDY3LDM2IEBA
IHN0YXRpYyB2b2lkIGNsb3NlX2NsaWVudF9jb25uZWN0aW9ucyh2b2lkKQ0KICAJfQ0KICB9DQog
IA0KK3N0YXRpYyBpbnQgc2V0dXBfYnV0czIodm9pZCkNCit7DQorCXN0cnVjdCBsaXN0X2hlYWQg
KnA7DQorCWludCByZXQgPSAwOw0KKw0KKwlfX2xpc3RfZm9yX2VhY2gocCwgJmRldnBhdGhzKSB7
DQorCQlzdHJ1Y3QgYmxrX3VzZXJfdHJhY2Vfc2V0dXAyIGJ1dHMyOw0KKwkJc3RydWN0IGRldnBh
dGggKmRwcCA9IGxpc3RfZW50cnkocCwgc3RydWN0IGRldnBhdGgsIGhlYWQpOw0KKw0KKwkJbWVt
c2V0KCZidXRzMiwgMCwgc2l6ZW9mKGJ1dHMyKSk7DQorCQlidXRzMi5idWZfc2l6ZSA9IGJ1Zl9z
aXplOw0KKwkJYnV0czIuYnVmX25yID0gYnVmX25yOw0KKwkJYnV0czIuYWN0X21hc2sgPSBhY3Rf
bWFzazsNCisNCg0KMS4gT3JpZ2luYWwgY29kZSAoQkxLVFJBQ0VTRVRVUCkNCnN0cnVjdCBibGtf
dXNlcl90cmFjZV9zZXR1cCB7DQogwqAgwqAgY2hhciBuYW1lWzMyXTvCoCDCoCAvKiBvdXRwdXQg
Ki8NCiDCoCDCoCBfX3UxNiBhY3RfbWFzazvCoCDCoC8qIGlucHV0ICovDQogwqAgwqAgLi4uDQp9
Ow0Kc3RhdGljIGludCBhY3RfbWFzayA9IH4wVTvCoCDCoC8qIGdsb2JhbCAqLw0KDQpJbiBoYW5k
bGVfYXJncygpOg0KDQogwqAgwqAgaW50IGFjdF9tYXNrX3RtcDsNCiDCoCDCoCBpZiAoYWN0X21h
c2tfdG1wICE9IDApDQogwqAgwqAgwqAgwqAgYWN0X21hc2sgPSBhY3RfbWFza190bXA7DQoNCiDC
oCDCoCBMYXRlciBpbiBzZXR1cF9idXRzKCk6DQogwqAgwqAgYnV0cy5hY3RfbWFzayA9IGFjdF9t
YXNrOw0KDQpIZXJlIGV2ZXJ5dGhpbmcgbGluZXMgdXA6DQogwqAgwqAgaGFuZGxlX2FyZ3MoKSAt
PiBpbnQgYWN0X21hc2tfdG1wDQogwqAgwqAgYWN0X21hc2sgKGdsb2JhbCkgLT4gaW50DQogwqAg
wqAgYnV0cy5hY3RfbWFzayAtPiBfX3UxNg0KDQpObyB0cnVuY2F0aW9uIGlzc3VlcyBhcyBsb25n
IGFzIHRoZSBtYXNrIGZpdHMgaW4gMTYgYml0cw0KKHdoaWNoIGl0IGFsd2F5cyBkaWQgaW4gdGhl
IG9yaWdpbmFsIGRlc2lnbikuDQoNCjIuIE5ldyBjb2RlIChCTEtUUkFDRVNFVFVQMikNCnN0cnVj
dCBibGtfdXNlcl90cmFjZV9zZXR1cDIgew0KIMKgIMKgIGNoYXIgbmFtZVszMl07wqAgwqAvKiBv
dXRwdXQgKi8NCiDCoCDCoCBfX3U2NCBhY3RfbWFzazvCoCAvKiBpbnB1dCAqLw0KIMKgIMKgIC4u
Lg0KfTsNCg0Kc3RhdGljIHVuc2lnbmVkIGxvbmcgbG9uZyBhY3RfbWFzayA9IH4wVTvCoCAvKiBn
bG9iYWwgY2hhbmdlZCAqLw0KIMKgIMKgIEluIGhhbmRsZV9hcmdzKCkgKHN0aWxsIHVuY2hhbmdl
ZCk6DQoNCiDCoCDCoCBpbnQgYWN0X21hc2tfdG1wOw0KIMKgIMKgIGlmIChhY3RfbWFza190bXAg
IT0gMCkNCiDCoCDCoCDCoCDCoCBhY3RfbWFzayA9IGFjdF9tYXNrX3RtcDsNCg0KIMKgIMKgIExh
dGVyIGluIHNldHVwX2J1dHMyKCk6DQogwqAgwqAgYnV0czIuYWN0X21hc2sgPSBhY3RfbWFzazsN
Cg0KSGVyZSBpcyB0aGUgaXNzdWU6DQogwqAgwqAgaGFuZGxlX2FyZ3MoKSBzdGlsbCB1c2VzIGlu
dCBhY3RfbWFza190bXAuDQogwqAgwqAgZ2xvYmFsIGFjdF9tYXNrIGlzIG5vdyB1bnNpZ25lZCBs
b25nIGxvbmcuDQogwqAgwqAgYnV0czIuYWN0X21hc2sgaXMgX191NjQuDQoNCmFib3ZlIHRydW5j
YXRpb24gb2YgYml0cyBjYW4gbGVhZCB0byBjb21waWxlci90b29scyB3YXJuaW5ncyA/DQoNCmFs
c28gaWYgaW4gdGhlIGZ1dHVyZXxhY3RfbWFza3wgdXNlcyBiaXRzIGFib3ZlIDMxLCB0aGV5IGNv
dWxkDQpuZXZlciBiZSBzZXQgYmVjYXVzZSB0aGUgaW5wdXQgcGF0aCAofGludCBhY3RfbWFza190
bXB8KSBjYW7igJl0DQpyZXByZXNlbnQgdGhlbSA/DQoNCi1jaw0KDQoNCg==
