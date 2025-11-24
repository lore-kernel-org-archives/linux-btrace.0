Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9C2F3C09;
	Mon, 24 Nov 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975075; cv=fail; b=QneiHsLEEd8NKnAKa2mCxDwdqnwmVo0iOi/30CEvlbeWrCD6DAMEU/wxugLDWujpUn9k7n4RCKLpLtwBtZ7RBgZxNf2WhiCcJGu9Dwl5bVW+vLOMQvsx3TbJxeCr+04eomMkNgwHrf8ZHsfg1C3Z32YT9ahjTMzxw68hazI3yCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975075; c=relaxed/simple;
	bh=OSdlKw4J3OyqDcN8Y5gHYki+2+HccqU8QKso3HzuAOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GvtoinHC+aydTcewq7N9Klk+kmEDw3qibMT3zpgdnnxKi0KOjbIZgadM7t+zpd1wK1jKt9JBCtoZJxuqhS29tKpawhw856r7XW2ICdOmTW/baZtLeMRJbfwf1vEJvBmaGcpP+qmwcpKrA4EzjqLeAvqF9/i8fCBB6h8N6oFf72o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NW0WvUPW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d5PhIyub; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NW0WvUPW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d5PhIyub"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763975073; x=1795511073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OSdlKw4J3OyqDcN8Y5gHYki+2+HccqU8QKso3HzuAOY=;
  b=NW0WvUPWBJ5SEEoFKNYtDNUMMHJJVHaX/9KnJ+TlRzAt4YI8UQfehkn0
   3UDZ4El2QSuy+3IE3FeKbRAb+wVhVTFRy1FcyvU1Dvz7IzrSzUbMh2qHP
   nh0V5V21klGMxhIfUEwJcAqdiTYSAesF/RO0jpL/oDCgE4pvtwA/xgbQg
   X54vJ/GR5VlzMO10SBK8tblXwFJa8TkF58ulYX518M1wIdd2QTe2Wo5fq
   toYSbiuCCTeI4EEBHircTDIt8eXy8xFZ1Au7mHffO1x4EjB8tvuIlIoqy
   W8kA0PnpI8sZdNSqF10D2VsfC48EWnZWGi3BHq/2uqZwW5miwohbsYVqk
   Q==;
X-CSE-ConnectionGUID: Z1F2n4MdTZiN/zcE38d+Hg==
X-CSE-MsgGUID: fvZXSh4JSV+35YRckoOhoA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="135674181"
Received: from mail-westcentralusazon11010033.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 17:04:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8pqrYQKGN+7A/yn+KS3eWtPS5CXSTTKLlFTxc8Raq+tFH6qRW+uBlGV//uaNZWDE5YfmzvTuN2gqI+5y4V3gCU+S1zD2TBBW0cIQ1eb3sCW9LmEyWXjxgvtHbKalQcIaW6RXuk1dehJPus90KUUpF1qfx0YTHQhkS+qKe0C6wPuOXK/kXlamfHhZZdA55MLLGy6G8PcAbv6cu1bTUBfOz5+O5j9LnGbD+CdE7JC4RVW56Z0VS/YwS8WrysOm/A5lWF4y9Rv7bA/g50KoFiwisTe23VQPTv4ZHom87kb2tP4HORsSkHfYll1gFz2BTISSb6uqzhonjecQFSVjL2jJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSdlKw4J3OyqDcN8Y5gHYki+2+HccqU8QKso3HzuAOY=;
 b=J7uNStEIPDUemqvGPRIuEctlvEe+HKVclEhQW/Iv7WbgRJbAhLbiqgpKENt4d1Ll9X0wJPkvlKynUNPQp1MNAlH7+sAMQQ61GTHB9vQAIcZD+V1y25Moe13KyeM6VS6SciELkhpOe8lw8zp3Y+2JAFnIPOSnI5qSzxrjWVsy7s+qo3M918/X810dioEk865cmgaKBaAdXayseA8O7CNmBFbe15/glY9bypcwKGZsZMkvMOUFV0GUN1o18AhMoAdWWpdbvtxfFFmZDm0rDYJvyXd3L0i6YzHl9nEcrGTASSKcfg+vwGNQh/SV4TuIumLoM7V+eHai54IekROIt4dXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSdlKw4J3OyqDcN8Y5gHYki+2+HccqU8QKso3HzuAOY=;
 b=d5PhIyubtjmqnT7Wt57NvVpjhqqhxZwUDUAh4A+KhIeXH5apZO0h0omH+bfGSjL68Yz6TSMNKKsiCo7FQ83gtlc0GRAq+uG6JYpokaQQ0YmFRDWq1+OV8VCH8PwF8+xihU3hbLNXgbBfYliC6BFt5D9AyDB7zcWi42+As2BN8jo=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH4PR04MB9156.namprd04.prod.outlook.com (2603:10b6:610:233::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:04:31 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 09:04:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, hch <hch@lst.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Niklas
 Cassel <cassel@kernel.org>, "linux-btrace@vger.kernel.org"
	<linux-btrace@vger.kernel.org>
Subject: Re: [RESEND PATCH blktrace v3 06/20] blktrace: support protocol
 version 8
Thread-Topic: [RESEND PATCH blktrace v3 06/20] blktrace: support protocol
 version 8
Thread-Index: AQHcXRVJI4NDljkOVUeQL/2dMnEEqrUBh2eAgAABHoA=
Date: Mon, 24 Nov 2025 09:04:31 +0000
Message-ID: <65d00bb5-8fe3-49a2-8477-20687183d0ac@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-7-johannes.thumshirn@wdc.com>
 <62285a77-2bd2-4357-b2fa-443eea262f1b@kernel.org>
In-Reply-To: <62285a77-2bd2-4357-b2fa-443eea262f1b@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH4PR04MB9156:EE_
x-ms-office365-filtering-correlation-id: b81ccfbf-fe72-4636-4ead-08de2b387b0b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bk1UWEJVVHMvNDB1VkF6d0hvdVJhclpuZThmQlc1T2VPbXlUTHNmQ1J3RFpl?=
 =?utf-8?B?Tm5uZ0R3RUFXSmxpMGFJdzlKanFUeGFacTM0aDIzL0RLMXdLbFRQdHBCaENl?=
 =?utf-8?B?VVUzNVdxSEcvbDN1Z3lDSnphNnhmS2NxTjY5REpOSVZrbXRYR29HbWNBdTly?=
 =?utf-8?B?cWVXeGtTbFZKR0locU81dEdFZkhJaSs2Mms2OW90ck8rZ1BCQit5cjJad01V?=
 =?utf-8?B?eDFaRGRnSmtkSjhIaC92SnBqc1dLYThrR3J4NkszNUE5MXhDVXczblpJVVNT?=
 =?utf-8?B?ekVYTWhWbnVOUlRteWtLK3MvS1JTYnJ3WU45eHByQ0VGTkUrRHZtejA5Q0VP?=
 =?utf-8?B?dzdxZWczSzRrNFlnU2xpTktoWXF4blhtaFBrRnB4YUh6bFozVEgyVTJFUXpw?=
 =?utf-8?B?NXdDOXNZT3NYYlZBSk8xNERBL0N3bHc5TEtYTU1pN1JwZVZoQXo1MHczTjdu?=
 =?utf-8?B?V1lUYUd0WXNxRXFHSDBmZHY2S0ZIZHFBaUp1YzA1ZEhISDhuK2trZGo3VzhK?=
 =?utf-8?B?V2lzRUtJVnp1cFZrNVljMWNkSllQS0JkbTlwYlVmRVNsV1djK2ZnUVlGSXZL?=
 =?utf-8?B?VU1kNzRVQW1SZTZPOE9PK1M1QkVzUDVkOU81cUpsVEpIdG1VeUhETTR2QmdG?=
 =?utf-8?B?YVpQeThYdXc5UWhJT2V2cFkrdllFSVZFUTNLQjNLOHZSOFh4R0wySU8zeitF?=
 =?utf-8?B?cUlURmJpRVljb3hvQlg2SU5aazNCTHNSREVaMjl6Q3hOek5RNVRYOUhxSGpU?=
 =?utf-8?B?SGhmRi9uVGdzNnZPbTVBbksrT0tEY0JmcWczUXcwaXNiaUtDYk85QXQ3MHRu?=
 =?utf-8?B?NWpCUWJ3Ry95ZFpLL0x2M3ZMUjJIbWVtRS8vczMrek01aFhpMEI3cEZka3hF?=
 =?utf-8?B?ay9GQkNUaHJYQ2ZLNHlyT1hadlVMV1dXNWxaMEx2Si9vRVVUVkhQUHdZWFFl?=
 =?utf-8?B?SzliZWN0TjJhdFBjOWdqYjgxWFdwSjBveWN1ZjRpcXA4eWorUUlXK1hYaExw?=
 =?utf-8?B?d2JTVEV5R29laHZINmRNbHZ3Qjk1aklHeTduNVQyZlYwVXMvc1I5L0pwVEJI?=
 =?utf-8?B?MzNtRFh4Y1h3eGlub2RwcFpxYW5Dam5oMTc2eHlyUFhvdEFWVVBHcFR4N3Y2?=
 =?utf-8?B?bUxCaVJwSGd0eHNZSG1ualk1Y1JzVVhZckVzeHZtUXNFLzdOZk9ESUJTWitL?=
 =?utf-8?B?Mnl4Q1BFVnBaM3JIN2dtUzdJZjltdkF4enpTOExWWUhvQTdSSTVraEdJNWdl?=
 =?utf-8?B?dWgxQmJxRWM4eE9KQnVRU0lLSXpqeVdWNnJpb254ajZmV3ZtOFMxOFErMGxP?=
 =?utf-8?B?TmV0SE9jYmdnbE1oVzFDTlBqYWxTY3FLR05GTWFOa1ROanlYUk9teml0N2da?=
 =?utf-8?B?NjBjUmp5ZzhZMUNCbHpNVUJFWmJBdEhwdElqazBUaFJYNVRwZUNiU3NkZFR3?=
 =?utf-8?B?MmtRSXZuOTJLVWlhVExnN2FlSTNoL0FYdmNzTk9sOG5NVlJyQ2VvSDJnZTl5?=
 =?utf-8?B?b0QxY0hTYzdkdWI3bDYya1l0a2FPL2NiSFpwUFNMTWxUVVRxVStBY0htaEp6?=
 =?utf-8?B?cGc2K2FJRjE3by9TVUF6djM1SDRybWUwaFVlTEZqRDVSTEVxNlVLK1RTanpT?=
 =?utf-8?B?U3lmSFVCdHlrQjF0NnIwMDVuUk9CQjZ3eWx0cFZncjArRUdONmdUZmFjYXBW?=
 =?utf-8?B?SUpsV0g3OXlzdVdmZlVRRnREeDBVNnpzVTdWdXZqWjRkNnZ5Y09tVEFmUFRD?=
 =?utf-8?B?SFZ5ZE5WejgvS0ZmZThiWUhLdGdSR2ZzRXlrNTl0M0ZDWUZPVThCVlFJUUFN?=
 =?utf-8?B?NmZiRmdRVHFjcWdWM0t5NlZEUmc5UlVhcnhDM0RvTFExZ1lDVVd3M2xVWi9H?=
 =?utf-8?B?NHVCL2tzM0E0cTcvODJRSWxuRjkzQ0R5dVkwREhWaHk1VDlkeUNMSGZEcDMv?=
 =?utf-8?B?bjd3K0JpRi9SMXR3dUUvMVpkQTI3YmV4T1hNL3dhSUZqZTIzWUFBWDk2Zllu?=
 =?utf-8?B?RkZSQ1NlR3VQMGs3aHR1WW1iSzVtbUpIS2hoUnhoYWk1UXB6NkZiajBhMW1o?=
 =?utf-8?Q?aDXitA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M25oQ3RGb08vdE1BS09YWlRXcC85OXdMdjI0Z0pQSE9wejYyWHVZdllIRWFF?=
 =?utf-8?B?WWZWdkhNbTgwVGpKVG1NNzl4dk5DSXN1QXdGWmNURS83YUkrdXdRQ2xMK2lV?=
 =?utf-8?B?SHNITktXYUpSRmtCb3k1SDFFS25RR0xlUksxVEZVbTB5Y1d0cjVmNEVUUC9x?=
 =?utf-8?B?N0tqZ3VxalcyaU1MVndBRks5VFlVaUVVNFd3dktWTDE2YlE0dE5kcHQ4WFY1?=
 =?utf-8?B?aGFBS1VFdFFLVDRmNnBvQW1rc1hFSWsrNDNnZWdNT00rVlVHaWgwSHZ3a1ov?=
 =?utf-8?B?TW02UUFSQnVlVllXOEJNSWI2THRzeU5jSlM4K05EcTVhdWNma3ZRRHR2anF1?=
 =?utf-8?B?eVh0bVhrTDZPWXIwWkgyaHVJdVlscjZXS3V5bTZ2WW1wa2Y4QmpOL2NRN01Z?=
 =?utf-8?B?MG5IZmx2SjVpR0dYRnF2ODFnVmR4dGtPM2lzeVZQcU96VXBOSjJCNEw4OWZo?=
 =?utf-8?B?aElacU13S1VhUmZVVVZ2cG9DYmVlQ0s0Z1dMQWI1NGRCbmg0SFkxb1NUU2c5?=
 =?utf-8?B?anIxdjJZeVFzbkVKZjFDTFd1dlZpbVdtVEJEMm8wRy9URGZTQ1ZzcW1LTTdZ?=
 =?utf-8?B?YUpqSzMrNWdHTHM4N1llLzFTa0tCZzRrb2puM3lXTE8zWFpiQ3VucStkbmd6?=
 =?utf-8?B?OUdrY2gyWDJXWWxiV3V1d1hwczJ1QzVVSnNRaFo5bGd0MkI1Z2ZmeFdrSWRC?=
 =?utf-8?B?OGo4b0FKTFh5SENVSWRRL3V1RVNYL2dJVVlVT1NKRkViNEVIZXIvamNBVE1E?=
 =?utf-8?B?OW45T2l2ZEl2THRTWUNaZFAwdUFvTzE3L1V2Z2ZxRVV6Z3VqNkdFaVh3anZu?=
 =?utf-8?B?VldKNVJhdWFHVE9obkxnM21KOURsSmVnUmRUQ1R0MURwTGtUR3hUdlo4NWxP?=
 =?utf-8?B?MlBXMWcvL0c4VzM5OTB6WnIzdCtQbStuV3hlY2dNbVM0QnZSRVBySHplVlFh?=
 =?utf-8?B?MERNUHljWUx5NXFMekFrK0dNUTRsWCt5SUx2STRhMW1CRjJHWm9NOG9tSmpu?=
 =?utf-8?B?SFZ3bTJPWlBpTFBYSmdCK0JtQVoyU0ErczA5ZFlCekZBdktkTVl1ZnczUjRr?=
 =?utf-8?B?Q3g3UzFScmZwWHFhWkhzVXFHcnJrQ2N6TmZpTEhCeTA2c08rUEQ0M2lDaUs2?=
 =?utf-8?B?a1MyQ1Yxd0YwbWNXYTNBS1FON2UzNWowYVd4V0xEcVVOVkJ1ZnFRTEYwWE1n?=
 =?utf-8?B?emZvVSsvUVd0MWkxMXFSV2Y0QkwvdFJHQ1ordThCcDQ3aW5mQm5mcmJZUm9M?=
 =?utf-8?B?ZCt1UDBndWw2ODNrSFlvdHl4dWc5ZkZLYkl3eUdobFhFVGhscWxxZ2wxR3FN?=
 =?utf-8?B?ald5WEEzczlKUGVockNFRjdvTEdJYUIxd0FqbUFVZEMyWm1xTStGUzNQNVVS?=
 =?utf-8?B?ZVAzbEFEQ0QraUNXSi8zU0tZVEhPVVBDUXFHcW5QaG9oUXNUQi8xcEtPZVNL?=
 =?utf-8?B?VXdQUHlOTTk1NnlVdE84dWtMVUpKQUhlL200SS8rU3VxbEowRUo4T0JNWEpy?=
 =?utf-8?B?YzB3RlVQRTROQ21PTXJxZ0hDeXhwU0k4ZGo3aldTcHdkN2YvUDcxSzUyRDNp?=
 =?utf-8?B?UXJiYlZIRUgwbU81T0xUc2YybGJhdHM1czMvTFprNGtrd2doM3dvZTZiN0lX?=
 =?utf-8?B?czl6dkdRQVBpcFk3MWlyellkWGs5TFl2MUVQaWFCZFl2VzBhRVowUngxc0M5?=
 =?utf-8?B?QURXdzVNZ3lQWjMrZWdwNzQwSDl0TjU0T0VRaFVnSkI1Rnc3SW5HTDdJY0tG?=
 =?utf-8?B?NzBPek1lWjEzWGNkRXlMUEdVbjVtMWdqdUJ0clFvcTFsZTJ1MWF6ZTRtTC96?=
 =?utf-8?B?MEhCc2k3bjFSUzl4bXJFVlRMb2hhT3VDUkpzZnZqdExhSjFJa2ttNW9lSWtU?=
 =?utf-8?B?Rnpwd0tLZXNiWHBIVk1XK05zODdPSFBKNUlGdEQ1MkZLclpodE12eUFzQWdP?=
 =?utf-8?B?WXdzaGtkMDEraXY0RDljVjFFZjdQb21KUWdrK1BrU1VGdW9neGY1MmoxZmNl?=
 =?utf-8?B?RnViWUdtRWxLQXozWXdrc1RnWWVmcHl0TXRXYnBEQ3oxQm10bnZTTm9JNVVl?=
 =?utf-8?B?amo1Nis5SmRhdXJzSWNpRUUxMDJ5cTBZWHBGTEFsenlyM0tycHdITGFWRjQy?=
 =?utf-8?B?eVlOVUZMalZQeGZXMWRjSHQ3VHd5b3Q5dGdXNDJJVEtIR0pFcGRsVThyNmh3?=
 =?utf-8?Q?7A2ybmKiw98nF9nMXjtph7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <126C897BB239934AA1CDE1A25D9A7998@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bQJ7+Y0fiYv7Wje6YTA/JW7nG0MMBgW44182JNX8M1rPPi7EwoN1/n4L1FiB7HglNDgthIRPabHpzcYXlXJMMNgnUlSNEmKtIbOGgn+q6M0bhnDyt5a1yNNIURVMJQo+xHyoXI3zSAG9oYDxttWy/chTv6RFjURTi0sVDX8gjs5N45keYzPZGV+DrIcJWs8TtuQqvYcbz/1Ag+9/EkS0TI8Rp/9DfpQF7N8YGrPbuRzvidZq/8gHhDgv/m9nQ3YFBUe2YI7v3ipmadH4yVOy44GqNvcN+bdId19P1bh4DhFliMwLWOKUCqNhpYvLuIw5r9HIAGCqb+2xSdbBK9r4FaCO8HIiEgQvsEDxfPKsAgz8beeKLndEqTKeu2lHT0pQ43gPJWQiYp+wVrVe+dowf7bozxO+74Apl1WuAiFdrbWFEJz9uN2teY1WATb+fOSSQM3rCCJvP2/EShFhnBErdjxLRxNlLN0GDGcn4m6+9LmSnKbQPuNspKQ1DGX0Sc+Pl6SSC862qLpkqL9Za7QC4a22F/k4HKkwSR3JtRCLLwf9ZDbPJbBe43AUUdJuObKnUiI+6y2pz25GuN3yxJsTVIL4m4wb7Ea6XSu9N0tRyF+owpepaIpCmBryQVg7MMgm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81ccfbf-fe72-4636-4ead-08de2b387b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 09:04:31.5612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWec028WvpFqPXhXm1AAy4Q0ArqxlGwjV5T/K8NnvOvCyN+umKXFNTixmWUUDVs0mO3gdZEJ3d9AOiQbCSjpeOVSBIb/99HejLg27zoyTQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9156

T24gMTEvMjQvMjUgMTA6MDAgQU0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBTaG91bGRuJ3Qg
dGhpcyBnbyBsYXN0IGluIHRoZSBzZXJpZXMsIGFmdGVyIGVuYWJsaW5nIHRoZSBjb2RlIHRoYXQg
ZGVhbCB3aXRoDQo+IHRoaXMgbmV3IHZlcnNpb24gPw0KDQpSaWdodCwgd2lsbCBtb3ZlDQoNCg==
