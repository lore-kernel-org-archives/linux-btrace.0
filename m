Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B14770FE;
	Thu, 11 Dec 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434868; cv=fail; b=n7cD/VF/u7zCIuPgzg7qcn60/hGk6Ey9tnRCPUXIIgkRxInTrJQ+tx0uSvqj7JI5GX5KcwPwPUS2yjex+/YpRijQGxZLWW70jNO7sif5wFKPNCSY+x3CxegeukzoE6yqIrsMid0vyQR2gFLPNPzEuc2gmud4OpssriMidjpKA4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434868; c=relaxed/simple;
	bh=DsBCwdcIIsopehRui40XQohuw7pPP0456Lv3LA2grPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DFNnS2LLX33R2MpKmp5ee/bX/rIpmZSJ37rinah6VThj8mjZY5UEWbonjcpSdNWIoCF9rTOO841MPbyMwwEk4EPUPaGBUlcUOdXrv4uhLHlBZa8W4BekgrwQLoLID12qdUaw0Apetqv4gu+e0qFLpQCoA9pCNUP06F+xxTr5rxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gU5ykaZJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qC3iDG0f; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gU5ykaZJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qC3iDG0f"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765434866; x=1796970866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DsBCwdcIIsopehRui40XQohuw7pPP0456Lv3LA2grPA=;
  b=gU5ykaZJub3r0uDTrJ58pO63sljwXp4z7XvWqkiMJe0ULKXrHegliaz1
   w9cTZ2lDzz3ZzLX/1iu90EfvJCIzwYj3HK226hvtqYJhXvTLH2021JQQU
   nrAUOjAOjfzvZ/TeLQ5g9LCQIYF6xaxN15Kw0y+4nDmbHlOlEasDMzmAV
   pVkzKO9GfnJTGoBto9izaYnm2dUpXashGsru3eU22XcF8VE5YYMLta0Sp
   CsZ/jpMk1m4T7Hk0guM/3Mxyu9ZYbhLx4NwAo4lCI1/ooEE8fkeC+TYgX
   ECG4Uknq4VW8ZjmG5hruGhCZQpOA5JWw/w70BYSOmnA5ADJZe0YVe+3Co
   w==;
X-CSE-ConnectionGUID: 5qD3Pti2TaSQxZyJwAibBw==
X-CSE-MsgGUID: YosafEM2STKM7rzr3aETPw==
X-IronPort-AV: E=Sophos;i="6.20,265,1758556800"; 
   d="scan'208";a="133653280"
Received: from mail-westus3azon11010039.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 14:34:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AprYnwK/E88PHGD5Gtthm+jeqoedKFvDN7CREODupX+jMwXGvkDD796iwM0fkegbTxuKyG9GS0plGlR7tcmgV9iDD1pUANojaxq8SsTQgnxSsLOyiWXFgxCsdkOYNsHECBVCL67LUnPo7kqbSEcg5TmiGc/8Imyl9pdLRGW4yD9+5wCSVCMPSlJeFb6ZaTKAgliaiiiu7cm/CWJh/WP6cbrEyPC4CLVji1cyBe4Sja0Nf1l6ah5nVPSn1Gb9ucf/5fb1BWiRARE+IzppRju1dOlexBj4gZlmXudvbgTtdQySmip9D6QuwpiwxVXwoltmQPDW6G5f6KTOa46M1V2h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsBCwdcIIsopehRui40XQohuw7pPP0456Lv3LA2grPA=;
 b=vVgMIHNcycznDbDT8wWL/aviJjJ8kwb+KbuRCJ5W7BhDeCUDTgFDbaYWERPjdvJZ3wCql6gsBCO66GI+KE7vs8D3xO/afHvB5+ez6SKPH66ovFoMe4dqhiSVircdt9aYeiHZo/rLS+ccdxDLEPK/TOpzBobOgitASPSW1+FyiODt3cZACrjyqP23WJpTOa69e6H6gdQBm22Qn4Xsxtk2hETR6+ZtjatMxNhaArz/awv4LNYbbkFITtAoiWHkAXM/LIAHBvj+mJgpg/pqFdCo+BR4dkqOLYXJ8OkX62gzJg1V5zfLZX9WWgImojoyWjefjTHLWwAy/Yfj4miXJ9rOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsBCwdcIIsopehRui40XQohuw7pPP0456Lv3LA2grPA=;
 b=qC3iDG0fCTFy2D0PTMMjXV2v8OGLKRHsmYBpngSHmTGuimi51Cg6rZXRsCQTy+PG9uEXDkwFV8vo1BrS8giYr39IugwJPeksEF1Td2CBf5B8SvuSaWHael6s98WwKfrL5xdDP7cN+UELxlVVWH7T+ma+roebfc7J2BpQOdXdXWk=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MW4PR04MB7218.namprd04.prod.outlook.com (2603:10b6:303:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:34:17 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:34:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	hch <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, "Martin K.
 Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 00/20] blktrace: Add user-space support for zoned
 command tracing
Thread-Topic: [PATCH v4 00/20] blktrace: Add user-space support for zoned
 command tracing
Thread-Index: AQHcXeBpPFpy+uemYEipyeBJXPxiLrUcFJYA
Date: Thu, 11 Dec 2025 06:34:17 +0000
Message-ID: <9e5bb107-a4ed-4f7e-a0a7-a447066803a4@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MW4PR04MB7218:EE_
x-ms-office365-filtering-correlation-id: a8140d48-6477-454d-cbbc-08de387f4f50
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajAzdkFvRWpuOUNLeXdvR09YK2M0dFZpU2g2ZXRDV3V0UkxuaTZBeGRLNHQz?=
 =?utf-8?B?dkJiM0h1RDE1U2JzZ2I5ZHBRVHRiU3p2aHB4ZUQ2NVBKNjBLUnJuNVg5bnY3?=
 =?utf-8?B?NWJ6dXhhbmUwTjVVeS96RTdINnUwN3I4bVFXNU5zS0pxT3hEbTltWXRSUDFo?=
 =?utf-8?B?R0o1dWpJWWxlMnlsQ0h4Z21UNFhrZHdLamV2cTRwZWNJc0VudTErb1lYaW5m?=
 =?utf-8?B?TjhCOUJDVFFqMjJJM3JiTkRWVGo3SCtzb04rRk1XN2l6Ym1pWmx1Mk5ETzRI?=
 =?utf-8?B?bHoxK0RiVnAzYWswQ2RjL3NOQm9nN2k0ZVpXQTJwam5nRnpMbVIxdkRiOXh4?=
 =?utf-8?B?c3pWRHlvUE1ISU9heVpVQnVVQnBhWmM5bXluTDdqZ1cyM1JzcjUzWDVOWFg5?=
 =?utf-8?B?OFNVR1c2WG5iSFZuVlY3Vk1LT1NFQXN5UlhjN1VhTUt1TjRaMlY0VGJpbmgr?=
 =?utf-8?B?TVAyalo3aDJndnBMaHVndkNJSGdCWTgxcmRTUS9jVGpkS2Z5c0xzNDZSRzhi?=
 =?utf-8?B?elQwMDFGS0IrR0lTVjVqVXU0SlZ3N0lLdzFOaUxIc1VvRitOK3JqcUZWL2hn?=
 =?utf-8?B?R2lsdjM3L1pTUnovK2JqdGhlV2lRQXR1azh6RG5jTXBtT2pDRWNjWkxXazd0?=
 =?utf-8?B?cmhxT2xndnlOMUYzTXcxczBFOWlnT3laY2J1MG5ZK0xZaVFtNlV6VjJMSTFu?=
 =?utf-8?B?aDdDVmlta3FvS0laR0U1R0FadDgzNUtOUmxQT0RldnExQ2VVVDl0bDBFZ3pm?=
 =?utf-8?B?eDZIZ2NBSWtpTENHYWU1NmY5WnhwYXZaYTBwc0dHV053bU80WUVyVGhZdXRK?=
 =?utf-8?B?aDFlQytaTTRSZVBuZ2tXbmU0RGU4Q0xKZGNwenFodG44cytsNkYvZ2R1dEFu?=
 =?utf-8?B?SGR4Rm00dFh6N3pQVDZMRSt1QUM0ZjJXQXVLa1ZDRDNqcGN1OFdiWXRvTnlx?=
 =?utf-8?B?VVU0T1FYVTdPUTlidXhxWmJnZjErdzhKZ0FzTWEyOC9Sc3p4dkM4UWc4TUNa?=
 =?utf-8?B?NGZ2U2c2MXRScTJaaGpVOU5sNFM0RHNqUnUvWnZXeHZpM3lOOFhXNmpTZzls?=
 =?utf-8?B?bE9wNmd4N05JV3NOaThWSnJTekd2dndsMFFZTGdxd3g2SHI3UDRzRm5ZUFVZ?=
 =?utf-8?B?TVpvc0VVOEd6bEJKdXRGUmNlY1ZsNlIwekR6bWNqeU9iMDIrTFdhSWN4aEh2?=
 =?utf-8?B?MjdjRlo4VHA3dlBzQXNVM0hpZW95WE0rWGxleHVkMVRJN1F6ZlE4MG9Kb0ZO?=
 =?utf-8?B?K3dJbGpHeWN1K3dPMW1UNGlRdU1qYzZ2dlJrSXYwR3czTkpBN3BnbVhqS0Jl?=
 =?utf-8?B?Q1pvRkRTZ29SRGxtaEpZRkE5aGg4b0VDT2p1WktVT3p2WjkvanhRQjNWMmt2?=
 =?utf-8?B?YnRTQlJDeEhtOEYxZ3NrME9oeURwbEVGTHhIUWRwRm1vRzF3VUZQelpHWjN5?=
 =?utf-8?B?dkJYcVZncERyN2ZtWWR5V1kxMHFYclp1L0pBeDQ5T3NsMHZFWUpaSDNZZWQ3?=
 =?utf-8?B?OEpDM2oxZzZvZjlvVDc5ZkR2a1FXV0prWHAxZDFZZVJhVVREendlODhoakhH?=
 =?utf-8?B?STZ6ZG9JK1htcityWHNEaUZLTnBOVGI3RUZBRlZCejMxQ2p6N2IycWJjOUts?=
 =?utf-8?B?N3hDM0V6RTZSNlBCbHV2TkhremVWYkg2SjdOcFBDSHpPWUVKUDd0Y3NHakti?=
 =?utf-8?B?cERGVEZFSHFhSW1tY2RsTnpGNGhtb29BQ1JFM2JqT0FUOTF5STV3K2grTlZT?=
 =?utf-8?B?SnVjc0FwaHVpUG8xNERDMjZTc1hDTno2QndzTzJTQ1E3ZXg5SmdTQlIwZTdB?=
 =?utf-8?B?VXlLWktoTmIydENQY2E5anlLRDNBekt0SXdsekNHbEFBaVVjcTdUU2ZrUHpR?=
 =?utf-8?B?VVhVTEZiWW1xT0d4UjAvRnVWSnc2RFMxMlFXclpvSng1MTVEY0kwSGpJbjZN?=
 =?utf-8?B?SWhDQVJ4VVBHekN4emJlZmx0RjNYZkhNcWUwT1V0UlJxazBNREFUUk1JZmlx?=
 =?utf-8?B?b2k4K0FhTWVGMXQ5YWk2OHhwZHV2TmNvVFVYdWswN21OWjlxYWdQYVByTzBi?=
 =?utf-8?Q?vJtYkn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qks3NEk0NnZnV3VpUG8rU3FrallNamJiQkFJQkRHOTRkczVRQ3l0ak0xc0t6?=
 =?utf-8?B?WVJIVUowMVRhaW9hUWc0YWhvVHlMZWtSWWY4R2FLMzRMNFBzQk9vQ2hvakR3?=
 =?utf-8?B?R2ZUUDJkT01Fa1c5MTFzSWhuOGw4ZGlWV3RNVDM4YVNodTAxVUlWdDkyMFRq?=
 =?utf-8?B?OVM0bmVFZkxDQUdCd25oMlFJTHN2enRFbFdkdlNmZjhGNmo4eDk1OWlpRTNH?=
 =?utf-8?B?OFRmM0IwOWxZY1Z4MEVUUXZMbUdwZUlmTUR3NlhJc2p3cmRoMHVNdHNPUDNZ?=
 =?utf-8?B?aTFzTzFDM0wxS0ErMzBObC9iU2VOQ2M2WHZjL1o2OUpUZ2c2Vzg2Qzl3ZnVG?=
 =?utf-8?B?eWdBdElJeWp5Z1h4SnFGU3VFNnBtbExLMWM1WncweGthQitVdm52dWw1eEwz?=
 =?utf-8?B?ZFJmWERUeEpXcnBjTGMzc2I2ZkpyL2RpbTdmWWp0ejZyTklleVpDMDhQY3N4?=
 =?utf-8?B?WjVsejE5cUxRdVpHMFhTSm1IZ1lYNlRRN1RXOEZFazJaZXkwQWpCRDY5Mzk2?=
 =?utf-8?B?NndWSnlWWXRHYkphTUpobFAvV0tXL1FWTFduaDh5bGRkMzQ3b1FEV0RJUk8y?=
 =?utf-8?B?a0dqd2YvZk5NRlRsVDlEZ1gySkoreDMxTzhWbHYwVEhGRnpZTzBOOC9sYk5L?=
 =?utf-8?B?RXdnSHdQNkU2K2NLaWcxdlpvcmUrQ1JwY2lLRGRFb0pHOFBSRUtwWFFYWkNv?=
 =?utf-8?B?dTdKbnRkT0g3a2YwdDJ2MXppTXlQZi93OG8vVGRCdERKaG9XMFJoM0x3eGMx?=
 =?utf-8?B?aFJQK3FTc1ZOMXMxeEViOFR3Sy9GTXp0MTl0M1l5UlVrazJUaHBZdjFEOFpq?=
 =?utf-8?B?UEREK3Qza3ZBbTFqeUhVU3h2ZC9pNXQwWVZjWFNyQ3MzbkE4SWlBREU4cmtx?=
 =?utf-8?B?bGFMSzJNZ3F0VFdWUUpZMy9CSDJEZEt1aU5uMFFXSUVsZFpaYnR6VkRPdDR5?=
 =?utf-8?B?RW5INmN1b1JpTHo1UCt5S2tWOXhBRzVodnlxZ21tSVFUenlJVUV5cWtrYUIy?=
 =?utf-8?B?Y09uZTZyMlI2QTN3UmFYR2JFeFdnSW1hUFBOLzRIZ3MyallZZHBiTVRpNHRx?=
 =?utf-8?B?MEJnWHpESmpSYURhMUlOUHlxcENKenRUTk9QdEcyUk9Sb2VXZ1lLeC8rcWp5?=
 =?utf-8?B?WVd3Zis5RjBaWElaRitqOG5mTU9XM3BmcDNZVlRvYytocWNkSVpNdWFOS1Z1?=
 =?utf-8?B?QThkRHJVOWw2UUhMMEdvSXJjZHlyN0ZLQmhFM1FOeE9JNEVacWpzbUdvd2N0?=
 =?utf-8?B?VVpRUDl0UXlCazVJa0cxTFlUZnd1Qm9KYkFuSW1GNHp0WFdyZ081cmxpNWZv?=
 =?utf-8?B?YVE0TVd1U25LUVZ4ckZseWFDaWM0Zms2MUFNVUFqaFA2QWlvaktRaEdMbHIv?=
 =?utf-8?B?U3Zia0pING5rNUtoNXZmZW5lUUZETXRrbkxPa0xwSkZRYjkwdjJCckgyRnEv?=
 =?utf-8?B?cEM4dEZSd3BWSkI2VHA1L1JmN3R6WUwzYjAwSFpFUTJOU2huYWkwMGVFYWNP?=
 =?utf-8?B?ejU5R0huYVhCb0F6a0YwRmpXUmRpUnJxdUlKeWNTQ1JjeHZmMTdwRWErWk1i?=
 =?utf-8?B?ekpoeFhzOWMxbmhZRUoxYytTZlRHMTJXNnJ2R2t5YW1FYVhnY011T3N2Zkwr?=
 =?utf-8?B?bWtCRnV6NGpvS1Mva29ET0s2eUU2MXN1NER5TzgzbldXaHZxd0ZGQ1VUUlVS?=
 =?utf-8?B?MlpuV2JHTWZpbVc3VEt3K0dVcWY4ZWVQMk9ZelExOGZsZ3dqd3QrL0M5ME5U?=
 =?utf-8?B?OExBZUdnRjUrK0RvNmY5ekhjN2hjdkhQdGJyQkdiZURsRjlNcnhHcWdjQzVs?=
 =?utf-8?B?a2xFSktpNXo1a1RucEdQQlVsT1RxSjYrenZzTklJN3FPMHp5NFpnbEx3NHls?=
 =?utf-8?B?SjJrdWJJM0Z1cHJNb3lYdEVESFVPWTd3K3R0d0lwbTE5elFmazZNNnJRSEd1?=
 =?utf-8?B?ekZucys0S213Yy9idmVYMDQxVkpUbm15MEp5K2tLYkU2emQycGZzVTMzUG1T?=
 =?utf-8?B?RE44LzZzbXdZNzM3VU5nRXZjbUpVNkw3ZTEvQ2tFMndYeEFza3ZGT0lPRGM3?=
 =?utf-8?B?V2lMbFRhR0JnYmgwR2RSR0xNM05jbnBTRE1pMHRUb1NLSHZmS3RwRXJHMnRj?=
 =?utf-8?B?a2N6bVZpaUJ2bUdkcjJ0eHBhTUx3d0cvL0V2YlRFQjFNb3BHSHNzN1dyQWs5?=
 =?utf-8?Q?wQohFNEVmIoGtog1vENeUSY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14CCFEF7AEBB57448F5DE1BF02007E50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23gIwx6PIgyh75p95+gaHOXDH68RBB/MWt8lAf7NN9ufouNZONQcjsm/nGzFEWwJoMKt0Fd2CvupMO8v0owyk4KlQFTazyg9/CtjQjHPK72wTr8zAY3UTSwy3aqjbTeGU3HxRDDayXZVFpb98s6aifhWNiab5rvzsub5IauxFh1SMhbSLsqZcCzVs35rkWUforq1jrFikr1ZvjXW54DZ2IaFeRKfTMRN5/OIcCdFsAyYYrakj0gznDSoHS/uYyF9a+/S7FrfyR+8MksieOTImRkmT4ShXnhvGA0yibp3hjTD5tZdxMidWOpckPshNtDINLVzjLeK9n8vpw3jTfOh2e+Cmd5PduelbJRFZH5QxLm3Xs/4YiM8XHl+kZWZkj/xVo87bSTN0F+tP/t979B+NUpr26whHPd+0DknKN87zVXS7vzNL2ngrjxBQTmyTaL/dajEzvcg7CJNdkLw6xm3T4DKB7njEhWf6y7c55kUjtz52o1zhOrjZAlAZAfODNwc0msojYghH2EQsnbIvkfSNG5jHhLUELGod3V4Nyi+yg4fElgxqJHesRHe6WXng1iHmS9vMVG5SamvKYTzXk9bcci8Ae8CiBXu00S2z6NlPlplBhjYqGL3tTDe4YekEhuA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8140d48-6477-454d-cbbc-08de387f4f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 06:34:17.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9/tTIVrImn5EzDDQed1OtQ5VGppoRQqipgdyzODZwVU6NhbLutr2SYKYH26j+C7wU22vuLBZghRR3hrJduKchT3F+4HuuVfexCBCE5s6Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7218

T24gMTEvMjUvMjUgODo1MiBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBbIEFwbG9n
aWVzIGlmIHlvdSByZWNpZXZlIHRoaXMgc2VyaWVzIHR3aWNlLCBteSBJU1AgZWZmZWQgdXAgYmFk
bHkgXQ0KPg0KPiBUaGlzIHBhdGNoIHNlcmllcyBleHRlbmRzIHRoZSB1c2VyLXNwYWNlIGJsa3Ry
YWNlIHRvb2xzIHRvIHN1cHBvcnQgdGhlIG5ldw0KPiB0cmFjZSBldmVudHMgZm9yIHpvbmVkIGJs
b2NrIGRldmljZSBjb21tYW5kcyBpbnRyb2R1Y2VkIGluIHRoZSBjb3JyZXNwb25kaW5nDQo+IGtl
cm5lbCBwYXRjaCBzZXJpZXMuDQo+DQo+IFRoZSB1cGRhdGVzIGluY2x1ZGU6DQo+DQo+IC0gSW50
cm9kdWN0aW9uIG9mIGEgbmV3IGlvY3RsIHJlcXVlc3RpbmcgdGhlIHYyIHZlcnNpb24gb2YgdGhl
IHRyYWNlDQo+IC0gRGVmaW5pdGlvbnMgZm9yIG5ldyB6b25lZCBvcGVyYXRpb24gdHJhY2UgZXZl
bnRzLg0KPiAtIFBhcnNpbmcgc3VwcG9ydCBpbiBibGtwYXJzZSBmb3IgdGhlc2UgZXZlbnRzLg0K
PiAtIERpc3BsYXkgb2YgdGhlIG5ldyBldmVudHMgd2l0aCBjbGVhciBsYWJlbGluZyAoZS5nLiwg
Wk8sIFpBLCBaUikuDQo+IC0gQmFja3dhcmQtY29tcGF0aWJsZSBjaGFuZ2VzIHRoYXQgZG8gbm90
IGFmZmVjdCBleGlzdGluZyBmdW5jdGlvbmFsaXR5Lg0KPg0KPiBUaGVzZSBjaGFuZ2VzIGNvbXBs
ZW1lbnQgdGhlIGtlcm5lbCBwYXRjaGVzIGFuZCBhbGxvdyBmdWxsIHZpc2liaWxpdHkgaW50bw0K
PiB6b25lIG1hbmFnZW1lbnQgY29tbWFuZHMgaW4gYmxrdHJhY2Ugb3V0cHV0LCBlbmFibGluZyBi
ZXR0ZXIgYW5hbHlzaXMgYW5kDQo+IGRlYnVnZ2luZyBvZiB6b25lZCBzdG9yYWdlIHdvcmtsb2Fk
cy4NCj4NCj4gVGhlIHVwZGF0ZWQgYmxrdHJhY2UgdXRpbGl0eSB3aWxsIGZpcnN0IGlzc3VlIHRo
ZSBCTEtUUkFDRVNFVFVQMiBpb2N0bCBhbmQgaWYNCj4gaXQgZmFpbHMgdHJhbnNwYXJ0ZW50bHkg
ZmFsbCBiYWNrIHRvIEJMS1RSQUNFU0VUVVAgYWxsb3dpbmcgYmFja3dhcmRzDQo+IGNvbXBhdGli
aWxpdHkuDQo+DQo+IEZlZWRiYWNrIGFuZCB0ZXN0aW5nIG9uIGFkZGl0aW9uYWwgZGV2aWNlIHR5
cGVzIGFyZSBhcHByZWNpYXRlZC4NCj4NCj4gTGluayB0byB2MzogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtYnRyYWNlLzIwMjUxMTI0MDczNzM5LjUxMzIxMi0xLWpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tDQo+IENoYW5nZXMgdG8gdjM6DQo+IC0gTW92ZSBwYXRjaCAiYmxrdHJhY2U6
IHN1cHBvcnQgcHJvdG9jb2wgdmVyc2lvbiA4IiBsYXN0IGluIHNlcmllcw0KPiAtIEFkZCBEYW1p
ZW4ncyBhbmQgTWFydGluJ3MgUmV2aWV3ZWQtYnkNCj4gLSBEb2N1bWVudCBwYXRjaCAiYmxrdHJh
Y2U6IHJlbmFtZSB0cmFjZV90b19jcHUgdG8gYml0X3RyYWNlX3RvX2NwdSINCj4NCj4gQ2hhbmdl
cyB0byB2MjoNCj4gLSBTeW5jIHdpdGgga2VybmVsIGNoYW5nZXMNCj4gLSBEcm9wIHRoZSBab25l
IE1hbmFnZW1lbnQgdHJhY2UgYWN0aW9uDQo+DQo+IENoYW5nZXMgdG8gdjE6DQo+IC0gSW5jb3Jw
b3JhdGVkIGZlZWRiYWNrIGZyb20gQ2hhaXRhbnlhDQo+IC0gQWRkIHBhdGNoIGZpeGluZyBhIGNv
bXBpbGVyIHdhcm5pbmcgYXQgdGhlIGJlZ2lubmluZw0KPg0KSmVucywgcGluZz8NCg==
