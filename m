Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0363B9;
	Thu,  9 Oct 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008656; cv=fail; b=JOFH+hN2GH0hwVTpjajs9arFg31b2gXWZtzNXIu5GQ1/sIQYsaz0jYKfHUC1CeozrrfoVx/aC5HpzDVnB6T/p1OmytxZZw13zh0nTh8FQ4ZqWE3MKRwFI1GKviyHPyI8R31MwokNjRpMe0w34m24KtbUfX+T5fUlOTeggcd4Cn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008656; c=relaxed/simple;
	bh=vokeAUXAJDbBZZ5ThFc3b0S1xtLbUISj+QrKkiCd7Xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pJ2XvdljqzCMJYELKg7MnulG6/68iSsdbp/f7YjgU3j69LdIlCRY0GsUMGkLNGHIz6h4t7DCY/6iGTFBaD/LcS5X5i4pfm15QbfKQzSVgXFApe4MXUQfdL5KUPtWFBAEgyY6PhabCkda6DJfgmPpRMkSV+mH62IkdE30ppeTlGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eqPH7JTf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rOwGq4mJ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eqPH7JTf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rOwGq4mJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760008654; x=1791544654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vokeAUXAJDbBZZ5ThFc3b0S1xtLbUISj+QrKkiCd7Xk=;
  b=eqPH7JTfCpPn0cC9NZkxOHNopgf3+1UkAnAG6Y4EBIeKzFDxcTlMuBJs
   4aWXbbuJBpT3U8aKwt93Z2oy5LfNQ4hGSalfCwl4IQkGMieRRSWDWyF33
   sMDc9rJ1TNAG1aAwk/UK3G+EO7OF+5tEd1uNpokiMnAxiWJOISPo5IsK/
   XkMjirzpkHhs1mIH2rsNlJnURz2SKqpsguBMMzeTI6BiOy8jFLeBKHQmU
   iZwYL5wdt/YKaQIf8W7HZRl8zpBE1xMwhp2dOES62XlpdKKCo18ee78Lb
   ZVzsId6gXl8w+YqMwF5vt/+E4I+mba3+XfXsX1+D5nW3AYv/mlE0mSV7i
   w==;
X-CSE-ConnectionGUID: cSVPb8qVTMi6WVXT74Agfw==
X-CSE-MsgGUID: c+V7r0rRQAm5uSD4H5wY4w==
X-IronPort-AV: E=Sophos;i="6.19,216,1754928000"; 
   d="scan'208";a="133842047"
Received: from mail-westus3azon11012023.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.23])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2025 19:17:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2Q53eWGuvmLt/Oz7VaG1ZDQKTjXgeygAOBzJhy+5g2iT19NTAhq37IUeNZeUEzITA7ae6Y/stl8qiYbChUvbghVoGDjGmdF0kOGNZQiCE8f62IDPmAE7O6CJHgCSQx1uX41P2TH4GLHQstfzk74u4fUYstJzfFYUUhckHz3SfOa669hac3j3hTXwel3HcM0vWJfK8G6IoEvL0P7UXTMB8xGvrhxHEJfErZeNCbTmaTC/f0aArkYp6rwRndq6mQeVmt9N5F5svvV/PkqB/VvRWOdML7+Tc1FSHiKmyfJ0Ma7IB3ZQ6c3bT/hMVEYnTz76lHBHcZ3XFFLJNx3Qc4IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vokeAUXAJDbBZZ5ThFc3b0S1xtLbUISj+QrKkiCd7Xk=;
 b=mOfAfg8pr8+Awt4LUJ6jQp4RuEUA6a+sM5vVZD5ooK3+q+Lu7i3tjXxQsg8gzLr4H/3Zf2dAm8AQh8Y4vV1UbnIDCWSohtYoDfKkcbwEbxjLps+6oSdGB4TERDTrVzzEXd0iKDS+tv5oeHQ+f6bDyEhRwI22UNeM7/c7lIV8aCrJlE8IY47RTgcZkG7jPo/22lZ9qHH1B+HDR8Ao95TNIJ6KFZFOBuJO1ZXK2m3RJv4l2kh9LULjLoFNGN7pFS5BdEHHR0zXh60sMvM3LP1TNSeAshoCe0vUOVnjYkmpoSi410t7kkOXChMCZu0P6GKTAdMzC8IfEyBBgRnNDPvQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vokeAUXAJDbBZZ5ThFc3b0S1xtLbUISj+QrKkiCd7Xk=;
 b=rOwGq4mJg8oZ6BmfAgRRKeW4xBU35+jNfJvjICutg6yzTMTVGzuYm2dVPwFc+LW2nXDxNErOzX/oFPNd5XgZvN49HjUS3Rf3gJbZfTcZyqOsDPWg00J7GFEKmBpRsKTHNILgXWfIKjm/hGa8ArFoWV3mRjMDpPcBDZ5n24HOkYg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7091.namprd04.prod.outlook.com (2603:10b6:a03:227::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 11:17:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 11:17:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-btrace@vger.kernel.org"
	<linux-btrace@vger.kernel.org>, John Garry <john.g.garry@oracle.com>, Hannes
 Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Subject: Re: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
Thread-Topic: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
Thread-Index: AQHcLi2P41isIe1XeUeby1yqta+5krSwE4WAgAam7oCAAR6vAIAB5xKA
Date: Thu, 9 Oct 2025 11:17:21 +0000
Message-ID: <99edea66-957c-4804-97e3-c88b615e54f0@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-12-johannes.thumshirn@wdc.com>
 <20251003073257.GE12624@lst.de>
 <4638c185-ac5c-41e3-8c79-5c995228ec0e@wdc.com>
 <20251008061403.GA13979@lst.de>
In-Reply-To: <20251008061403.GA13979@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7091:EE_
x-ms-office365-filtering-correlation-id: ffa701ce-9ae6-48ef-adcc-08de07256aa6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXFPMDRIWFFrZDdVTndpb2R4YkE0WFF0MU1PcjFmOWRDTzhWL1JHVmh6ZWJ5?=
 =?utf-8?B?N2NVc2RLU084TWtjYlRYWXdad2lOL3JPYkhKRkZmcGYvbWdkMktCVHJqS0VU?=
 =?utf-8?B?WXZCMXJDTWpOY1FVMDA0Y1d6ZG9YQU5CRmhlVVpqNElsTEh2WTQ5M1FySm9s?=
 =?utf-8?B?V21Lem5TdCtvUWh0Tll2cGlmaFpoeVcwcFRkT1N2VUZ3ZlBDNnlncEdVMnZ6?=
 =?utf-8?B?SzhsOU1SR1BkNVlBd09kVlV4Y3RaWVhNSWpIT3d4QlkzVHJhdmV6WUVBazZO?=
 =?utf-8?B?clJjOTNuelZpWkg1Q2tyL2JUajErRmZYRkRxRTEvcWdpdFlYN2p6cjRpM1Zo?=
 =?utf-8?B?WnUycEVuUWlodFlJWFY5NUovSXZpTTFtcFJadFN2VzlKWFh3MjRxSE15SDdm?=
 =?utf-8?B?Z0JOTFNqTElINXczWjFaNXRFcERLYjAwSGxLWTRTalZvdUNPVVBGY3NGdmdi?=
 =?utf-8?B?dE1rNnBwTHE0dkJVYzJkM0VCalM0NzJjQjVFQWdXV0pKL2tqTGFpQVJJOHJS?=
 =?utf-8?B?OW1BVmtIeHRuR3BXNThCcFFvUTgrMnpEbzVUa1RtYWMwYi9tYnFFbnF3M0FM?=
 =?utf-8?B?OTlNZkpyd1JUdGROVmRDb2tMV2p0alRBQU1PMXNZQmpjZ2hLYmh1ME90SHFh?=
 =?utf-8?B?ZmZ1OHlNTFV6LzVXQWx1dTdkcmlhTmxYN1pjUkxjejhjK29LZEpjeTlkRnZJ?=
 =?utf-8?B?Z21mdjZoU0ZlelFOVlBWekpJeFliSDZWb0pOVm42YWFWSWdvMEsvRGhqT3E3?=
 =?utf-8?B?akNCUCthU0ExSFhHaXl6QlFxT0tGS3RDdG1pVzluVHAxTHNMUkRtQ25FbHIw?=
 =?utf-8?B?ZHhTMlRzOSthb3ZNQWdPMFRmdVVzRWZqU1BMc1RJU0tOZkgrcFMzVnEyeDd4?=
 =?utf-8?B?KzhaTjNraFNXUGthMmhtS3l6YjV5MGI3SjFseG16Nnl5eE56MXQ3NnpjZHpi?=
 =?utf-8?B?OTlyQ0lNbXUxYnQwQ2RNNlljTXpRRHd1YVFlaWtYTnA4c2dxcVdBV3A0USt5?=
 =?utf-8?B?VU9FWHRPeVd0Y0loejZaandja2pmbHlORUNHU3J6WXNxZllYTjlyd2EzSjhB?=
 =?utf-8?B?TGhrK1dmWjZiYzBocVRwNEVBRWRwOHZrNVArb25yaGpINUNEd3RKVDBFL1JF?=
 =?utf-8?B?WkVNMTYvbFVaWG9reFluRFl6bDVJM1R3Wm5rbzA5WTMrRldsUmg0dk9ieVZT?=
 =?utf-8?B?TGFielU5a3dHQkpEbUFNdWsycG1tQ1NROHl4M3FLWitDZmM0TzRHMi9yUyth?=
 =?utf-8?B?RXpDY0J6TWowcS83NThVS2RKbWVDa1Z5ZitWc2F1YUt4bDkvWVM0YkVYNEk2?=
 =?utf-8?B?VE5qSG14QjYydXRuMW5KalFZRmx1eHRjRnBORzhyWTFPS0Z4SFBYMnlRa1g3?=
 =?utf-8?B?cEVmOWN5MEFnZWlVdVJqM2xJQzRNeHBtMk9reXVGZ3EyclN2K014Tm9tZ2Jr?=
 =?utf-8?B?bFVwNitZMHVtZ0pSdmFuRW00SkxjbER3RlA4N3I1NzRMNTdaM2MreU9lYWlM?=
 =?utf-8?B?ZFEzK3ZnSXYySDB4OEt2OHg0UnpLYXhaSkRMdTlrdXNkZmhzM0ZDazZwamdC?=
 =?utf-8?B?eTUvckJHRWpPZVBXNTFmNFVveS8zTEVlamh1aXhNUTFFaUlWK0VYWkhoR2E5?=
 =?utf-8?B?WXo1dVFmMjNEenV0aGVwK3pyR0RXQWtEbVAyZ1pxdW9lN2VSakhZd2tXeXVH?=
 =?utf-8?B?Kzd1VDlpaGdwcjlJWDV6anVucGdLWElVczdISHdreFJaazl6eTAzOUxIcDVE?=
 =?utf-8?B?d2ZlcGswaTBWMkpXN1FuM0hTc2toN0ZFZUhMWGVUbklnY2Rzbk1mNC83elVK?=
 =?utf-8?B?NDlWbzVzMWp6MmRLN243cktkY210SGNGeDVlbU5ZWjgxNFI3MVh6Qytub3NB?=
 =?utf-8?B?RDlHcktWWVE4VkRSRU82dnNONnlhWEt4aGFTUFNsYy9SVXk2SzVVYWkxclNT?=
 =?utf-8?B?Ujg3M2VZS1JBSUhPdW1xUWxDSEdWKzZCcXpwV01UM3lXVVY2ZUh3MEhmTURo?=
 =?utf-8?B?ZkJRQ3BwY01WVFpRamREd001YWE3R1NFQ09IQi94WjhRMWZZVGlVVzhIVmJD?=
 =?utf-8?Q?Rpcl52?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZndyWExyd1NXNVF3UDlvalF1b2RqalNtMkhHR2EweW80TldRNUxrWmg3aWZY?=
 =?utf-8?B?OWJuRUNrRVgvbGVxdVBSOC9yZTdEUFY4THNlVVBLR3RrTnZSRWk4NW5mc0Zj?=
 =?utf-8?B?U1oxSXg3dFRZQnl4RlgvNXE1bEI2UDNpdEluenI5blZKTy9kTXRsV2NsWjMr?=
 =?utf-8?B?cUxoWmtFUW9CWDBVNng5cGNYeVo5RlRKV1h4a1NVK3VpOEFvMzBpNUtLcE11?=
 =?utf-8?B?MWtOT3dZOTBtVkg5Nk9PQlhWVzQzNFNtdnowUk5lSE4rOEJhcnI1ekVYbGlY?=
 =?utf-8?B?Sk5OY1ZmSzNHVHlpKzhTb1lWZVNOSm1DUzFNekVlQTR2SVhIa3JPUjIzNE4y?=
 =?utf-8?B?MjM2aFhUOUtzN2ltY1FFb1NybjZrb0xrL3RWeTU1L21GcDg2eEpYVVZKdzg3?=
 =?utf-8?B?NGFMOVdjSkdqSDdEVE95UXh6bjJDS3M3d09qRVNZVDhmMEhxQmdtS2J5L1o0?=
 =?utf-8?B?ZVlMb3hWdlgvMm5RaVdUTDhvZ0hMdzhhZjcySWxRSGh5ZUZZRWJyOWJTNW55?=
 =?utf-8?B?SVM2TXE1NmZsZE9sR2dNZmNXZDN0a3pjTWhYTGk4aHFUNzhwSjlIUWxBZnRm?=
 =?utf-8?B?SDhzQnNjbHIwNkNRbVRLYVhPVURQeHIxMm1kQS9TV0duM2thUTBzRGs4U3V6?=
 =?utf-8?B?QW1XSnRYT3p0MGVzWXFjd2NZYjZhYzJiMVBGcHIvVlhOUkg1OVJJWWl4RUNu?=
 =?utf-8?B?N1hFbkkyNWVJS241WUQrcjV0dld5a0JnNUJOSEc3cFlXUURXY1pSTzUzU0JH?=
 =?utf-8?B?aUFQeDc4dE8zSXZSdEJ6cVdnYkRzSXB4NzJpWkxxSko3dGJUZFBNaUM0MFFU?=
 =?utf-8?B?TXRyQWs1VUhUOXg0OEhMVkRSN1UxZG5ydUhPRnRvdWtCWk5GZDF6QWNkcFhZ?=
 =?utf-8?B?b0ZvZEIvNVlWQ05MWlA1ay9iekZJVGpnQUJ0LzNVSFZBZ0h0dldhamh3NC9z?=
 =?utf-8?B?ZDJ6S0d4UllZV3RRaVEyYnErK1RCOTVJcUl1aUdidExrUUxXV2xnL1MrSlgv?=
 =?utf-8?B?Q3ZVQmVhWWlMMVFZbkdPUVo4ZnErcVk5QmpPK1VPLzhrWEVVN0w0L3JpWElP?=
 =?utf-8?B?Y3FwbFp4QWk1YnZGWVJsTDc1UHVMYXdZSUNVRSt6SG56ZjBCOXlNZXZ0blp4?=
 =?utf-8?B?UDFaRnc5OTg2ODJGMGZlSVhBRnJNVXFUSi92SFVYeXFUZnpoTzVZTGFRWm9w?=
 =?utf-8?B?ZE1ESFpoWkwrQWRCQWt0Q2VyMzdNeG51U3BZMEJVRkE4cjFZaU03ZnUxQjh1?=
 =?utf-8?B?bEJhMzBLd0owMERqUUJDY0hHNVB2eTdaM2VDMW1KVGlzMTAySlFLdU9CN1My?=
 =?utf-8?B?SFcreE1wREl4R3pVYU1mYWxObzZublpad0o3Tk5meDRSUWVtYytwVE1GSks2?=
 =?utf-8?B?SWhEZEdLUkpBNmZOajN6M21VYjJKZDlMQzhRZHl2TkF0OFJ6TVEwRXhWNGlY?=
 =?utf-8?B?R2YxaXl0ZyszNUZUMDl4eDBGSGxGSWRKYWFFT3pDMEs5b3NRVjlCTGlFNE1J?=
 =?utf-8?B?bUdqMWVuRTZFdGZja2o4Rm1OanZzeEJMRUxNYXMwcHpPYndOdGsyditGVkd4?=
 =?utf-8?B?L0JGKzFqQnlmV2tWZ3hKdE1XWUgxb1lDWDVvUkdzd1JpNys0RWQ1N0ZoYTdH?=
 =?utf-8?B?bytobWxlYnRqcVhZZDVKRXFPblk5MXBpUHFFS1R2dmlsbFllUWNSR3JNOUQ3?=
 =?utf-8?B?d1dhSldEaUg0N2ozS0FycXB2S29PSURsSUZvN1R6MDh6U2hoUVJKdnJSY1lm?=
 =?utf-8?B?eUtNanNkMXNuNVBNU1ZvcUJJT3NWVFM2NXY4Y1pSRStPMGZvU3RHQzF1YTQx?=
 =?utf-8?B?bExXQVVVUk9pUk1ZbjkrMXNkbHF2ajhodDFoWHNOQzBIM1JVWVdBWGhoSms2?=
 =?utf-8?B?OXRCZ2NDRDkyL0src1pwNkNYT1dNRjJhVU82OVJnZ0JkUk01clFBQmlOdDYx?=
 =?utf-8?B?UDd2UCtQWThpQnZscm1zVHlzRzFvaXJhWTY2VlloTy9RQlNtVGY5S0pjbWRu?=
 =?utf-8?B?UEFidmx5alRFRWs2VVhIanloQ0ZFdU9oeml3dDB1UnlUZUF4NUdoRGkyOXpT?=
 =?utf-8?B?U2lpYy9FSE41OTYrbmhGYWhjb2ptWk1lR2FYRC9ZOXlWY1RlMS9XYjdERzUr?=
 =?utf-8?B?WGFSelYwZzdSSVM5aTl6SnBLTXRtMUhWK1lwcnZSMFEySC95UTJXN0ZYL1J6?=
 =?utf-8?B?cXZuZS93VXFSMGlmSnhkQmg2b2JMMTYwdU93c01MN3ZWRHU1SFF2UVNtYXZl?=
 =?utf-8?B?TEVhWXAwbzFNOTFpTmkwdnVyMk9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE8256DC594C7E408BB827E6C1A11BBC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oCrCDFBf4lbk2Bm4aAicNF0iVwa2dTEGeKCI7Al4GE1ZDdemkHQS0cKX3LBO3tskRjkUjOKFwx1Innlk08nks3TqqrR633MGEtEao8fJw9fxZSsrjcyUhOe478rz6FQwJTbg7iShEdB0+wMREyzMjeH55KSop+9ie/+kO1rTW1zpFWQjXyKoXQO0WE7ZZ2GXkuFvpQaW7r6oCRLXFXZQUpy/+DblY6pIHI+7Y5XDgdJ9PSLeb7g5no4BOBidWQfbElpzoNZX22nP/15szzj77BE3GJSznxPvW4HVKUqk8snwQ6pAJJAfQwhS/W4FUoZwCpa2UpeitD/ar8Y5uA1ASusfnZHktz/KmsTRvUwywtoGFrzcbtDR6T5TgHluNvuJF2vSkKLMqFORg7RpblnZfvG5bQ/H3XaQjSGwbDSXZ7tgyFqjn6Uh//yrL6mnVntV8cvRPzGH2rnSM+FQ8eXb9bqiomcCJPavZgKOJyySx+Z7KczeFalqWQHCkjR7jSTHEZClr6g/TxKf0WcrDBtgEUZkwhDD4rWGva3JTaFMFgqrXXRL7ns/4SKvTI1cixDNE3P3b2O4ifuRmga0N8hpoiUgjTegmy8RU8iIV9ITltwr64AUWNQVLUrAfuPh6ZPd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa701ce-9ae6-48ef-adcc-08de07256aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 11:17:21.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlDD0gBTz7NL5la/FG1gm5NrA6kDiPwFy3oaJv6vk3cB8jOXPxRrNEf+uBHDJCqd/8LveW8aEWBroNDoyeUqibrATP449daQmB9Dk/8MU70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7091

T24gMTAvOC8yNSA4OjE0IEFNLCBoY2ggd3JvdGU6DQo+IE9uIFR1ZSwgT2N0IDA3LCAyMDI1IGF0
IDAxOjA4OjAwUE0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IFN1cmUgZm9y
IHRoZSBvbGQgY29tbWFuZHMgZXZlcnl0aGluZyBpcyBzdGlsbCBpbiB0aGUgbG93ZXIgMzJiaXRz
LCB0aGlzDQo+PiBoYXMgdGhlIG5pY2UgcHJvcGVydHkgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIGR1
cGxpY2F0ZSBhbGwgdGhlIGNvZGUgZm9yDQo+PiB2MSBhbmQgdjIuDQo+IEkgZG9uJ3QgdGhpbmsg
eW91IG5lZWQgdG8gZHVwbGljYXRlIGFueXRoaW5nLCBqdXN0IGhhdmUgYSBsaXR0bGUNCj4gZnVu
Y3Rpb24gdGhhdCBtYXBzIGZyb20gdGhlIGZyZWUtZm9ybSB2MiBjb21tYW5kcyBhbmQgZmxhZ3Mg
dG8gdGhlDQo+IHYxIGZpZWxkLiAgUHJlZmVyYWJseSBpbmNsdWRpbmcgYSBtYXBwaW5nIG9mIGFs
bCB1bnN1cHBvcnRlZCBvbmVzIHRvDQo+IGEgY2F0Y2hhbGwgdW5zdXBwb3J0ZWQgY29tbWFuZCBh
bmQgZmxhZyBlYWNoIHRvIGluZGljYXRlIHRoYXQgdGhlDQo+IHRyYWNlIGluY2x1ZGVzIHNvbWV0
aGluZyBvbmx5IHZpc2libGUgd2l0aCB2Mi4NCg0KU28gSSd2ZSB0cmllZCBtYWtpbmcgYSB0cmFu
c2xhdGlvbiBmdW5jdGlvbiAod2hpY2ggaXMgdGhlIHRyaXZpYWwgcGFydCkgDQpidXQgdGhlbiBp
dCdzIGEgZ2FtZSBvZiB3aGFjay1hLW1vbGUgdG8gdW5icmVhayBjb21waWxhdGlvbiwgZnRyYWNl
LCBldGMuLg0KDQpJIHRoaW5rIGl0J3Mgbm90IHJlYWxseSB3b3J0aCB0aGUgZWZmb3J0Lg0KDQo=
