Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195E2F39DE;
	Mon, 24 Nov 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975048; cv=fail; b=ILNao7wZ3+sw04Lg4jfP4wL43CdQnM/mRIepR42LKQESGwKEI84HpmJgw5XxO6+O+a9bGjmxK918g1jbPeNHsE/b0ly+rKzyeAIWeAKTmzu5zZlhoUUt3NrDwo5JhK7SK1EStvLVSMWOo2+MTjzQ3eyK+NzPVvPENokeJ0HKq6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975048; c=relaxed/simple;
	bh=oK/1BtlqKncW47kCnyI7qPCdUTa4guL7oj3dGTofCR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ae/3m2Lb7RPgJGXHNckAc8sD1qkyKQgLCQvOxGxuNcgh07/fY4j/2AY1T5s5qFKdDK620lC11ejOfJe+bAt1NcAujjp/sGP/aGgstW0mH55d3+pAP+aT8hS1M14tOaf5+wR8uUBplUw8PNk4+WHwj+YkKdRoU9zd8D35Ljp6vN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NTDGKZth; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fZKk1Suu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NTDGKZth";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fZKk1Suu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763975046; x=1795511046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oK/1BtlqKncW47kCnyI7qPCdUTa4guL7oj3dGTofCR8=;
  b=NTDGKZth7dacm+1KHe3gFCzH2p7YBVMrqCLbaGdjuWG/vYE2jP+O1g4x
   mCEm3ecnX5grGjpjMiZMJSkTRriU+4WEmWm2LpFqKqMV9NfQA704yHJQU
   ydsMzpnIw1tKuluTxjnLkzmGwWU/8XGYyunppgJskJ8QKKRqiyQt203SH
   qZgxo61lyoqBj2R6l3G6bdBKNTU9AeMz1zQguVSJzySyMxzjt8pz1Ve/Z
   3uQPc+qIM08AHozuqILp8tZ59c2u59ii7r92c7hkepZ67KiBS+f8OIGcw
   1e+kTaJA91whEzFb3l7zM3IpYlwxlpSW/ccXS8tfSBkWn0gWGCvVjutPp
   Q==;
X-CSE-ConnectionGUID: hv2ntfWtSTSq3iE4Hxp78A==
X-CSE-MsgGUID: CVWISYSUTUOak2W96NjL3g==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="135674145"
Received: from mail-westcentralusazon11010068.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 17:04:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keK4CUTruVIOrzpt0YjaVUd6xdtIGLxeNcOoKRzTX1gWP8wU6Z7koOQPH5axjJMIF/AbdHiPOkN3he+IjDJcQiIh2dOZltX9I9Wrcqn5KjdaSvR+h+0LSq/y7+U797+UHbEnqQHJUraXZnfdyRQTDMFFcfQx9za8Il3ELIss0zBKo72PHTGO6KkMjYf7AAc3SSFZn+AKlwVWgfO7SVzJmJlKT1LumtARCGBYy4IU75ZhrYptqvOWjb2nGtP8OBmTwx7OU7LZWaomLDLnW3XAq40rxAZ8cRddRxq5qop7PlBLZFXLz7MUzKbc8xJMes/l5B4zTuE+6PRxx1UVkGiowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK/1BtlqKncW47kCnyI7qPCdUTa4guL7oj3dGTofCR8=;
 b=yYxJLbYmBDv3Jw5nuLobEYUbzMGPWJ3uGXazW2Ac7hJTwRwgf/JjTuch8RjZx0aX5XjLtzmiX/1D36vYLKkf94Q8GpgiHnCBKubBNdN9CIIJjEuumc74djrF+ucjccJK2X20i5AzstExvx06WD1+C8RUEIwJIefrReIM19pafduT9CI0xyvhPLR5o2GqAK9o6Kpjiu0wTdNkyWhX4PBHYhDiPDPzMcctqCqC1yiRRaG4MbcRljUk8Wtw3TXiS4SMo2iHnYYK1BP+NY5BCz0zb5rM6JNpyNSMMLoVrDQ2OcKnpYh27MRthz6nMRm5E/L8VEVNI6BqPsz4BZDMmWd2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK/1BtlqKncW47kCnyI7qPCdUTa4guL7oj3dGTofCR8=;
 b=fZKk1Suu0tp5v8m55iSFm34zwU1Rbw/v5CAevb7wnpfiWt+015gytihb4YL0WhZ7rhb7rwV/p7959OTYoSckIK67vl+vrPTYqEdt7kgsuqupqOSashXu9VKDQlU6BojVfoVmadeZDIyaR36L+mvnr8Bryi5rdPCbepp5UBJq0Q0=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH4PR04MB9156.namprd04.prod.outlook.com (2603:10b6:610:233::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:04:04 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 09:04:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, hch <hch@lst.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Niklas
 Cassel <cassel@kernel.org>, "linux-btrace@vger.kernel.org"
	<linux-btrace@vger.kernel.org>
Subject: Re: [RESEND PATCH blktrace v3 03/20] blktrace: add definitions for
 BLKTRACESETUP2
Thread-Topic: [RESEND PATCH blktrace v3 03/20] blktrace: add definitions for
 BLKTRACESETUP2
Thread-Index: AQHcXRVCrxXqcwXWrUiRuc70Ekfu37UBhp4AgAABxwA=
Date: Mon, 24 Nov 2025 09:04:04 +0000
Message-ID: <26112997-3a53-45ef-9db8-007026c46589@wdc.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
 <20251124073739.513212-4-johannes.thumshirn@wdc.com>
 <daa2dfb3-91f6-413e-af38-2998d3a96806@kernel.org>
In-Reply-To: <daa2dfb3-91f6-413e-af38-2998d3a96806@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH4PR04MB9156:EE_
x-ms-office365-filtering-correlation-id: c46cb5d2-b254-4aa9-078a-08de2b386ad2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEh3Nm5pZ1FlSU0wUHZKQUFZa282WFBVR1JvZnJkRHk4QWpuNFJ0WDJRV0U0?=
 =?utf-8?B?ejVjY09tbldUOXJsRmIzQ3B0TUQwVTNvaEtTVWJNVEJYYnkyUE1WTE5MMTQr?=
 =?utf-8?B?QmlZUkVHRUN5R3pWeVM4MlIxWnp3dDF3ak02V3dkUjNKWUdJaWtteHljODRl?=
 =?utf-8?B?N1hqRnhVT1hpektqRVBCVTNNdG10ZlBZTE1BNWw5TnZ5c09nNEhORWlmbkY5?=
 =?utf-8?B?N1JKbkhNSXZ5VDRaa0NjcncvMW9xb1dEQnV1blNzaExhUUVkZmpzY1VsbnNJ?=
 =?utf-8?B?YWorMUQ3UUZZa0lQWncwK2s1VHR1czE1bGdyaXd0aURlWVpjMmVDNVA5T1dq?=
 =?utf-8?B?U3RYYXVrbTBLSW1lSjFvbU9TOUcvaTcrZm9DOVpPNUlvdjg0V21NWERlbk9t?=
 =?utf-8?B?SkdYQURyUXZNbS80cy9peTZCc3dOZytCK2NVTHQ2SVdUSThGVHFHeElUK0hT?=
 =?utf-8?B?WXdDRmFZNm1jcmpnUy91M2swUUNzeVVYNWxvdmh6ZGhIM2ZTT0VWT2dkQndQ?=
 =?utf-8?B?YTFzd2J1ZHlMMEJFYUdvSGNVemZSWEkwRlBRQlFFc2ZQbHhlUUtYdnFkTWpG?=
 =?utf-8?B?UVFxY2lYUGUxRnY2QUpXTHhBUGJmdHpROEw0VmwxdzlWWDBIUzVRM2RDZkdr?=
 =?utf-8?B?dTE1cWx0OFAzUkowd2RFZi80VVBIcThCU29yeWVXRHRSRmpDNXkxZ0REUlkv?=
 =?utf-8?B?ZEVVSGt2OGlwL3NTUnlSNFpFRTJUbzlEeDhqb0c5dzRCcit4aHdiY2RpTmtl?=
 =?utf-8?B?Nmw3Sm82Z090Rlg3Y29WN0dRNUNDL0FxNWdXRHZnVzR4UXpnSUlocDhicWM4?=
 =?utf-8?B?WGMxdXpTbFdLY3dBdFlKNkszYlVKMFBJaVhhUUZJT25OYmY4NGM0TW5nczhh?=
 =?utf-8?B?NldnSjZDNXl3VEpoRkxaLzNlN2h4MC9Fek9DV29iL0o0UXdCdzF2eDBtMmJK?=
 =?utf-8?B?cDJKajVIK2JHTXR5K3hrcm9TanhTbTJFZDB6cGV2RTJsbUowUUVRUUQveVd2?=
 =?utf-8?B?MkJLRE9ERlI4R1E2S1hObzE1TUNKL0hmbWxSUTF1Q3pMWll1d2RlUXhLYzRS?=
 =?utf-8?B?aVVSMWpOWDE1OTlneGQ4cFZNZ1MxdUtUdlhOUTlYNWtpZkIwYStjd3U0UHRh?=
 =?utf-8?B?UmNRdWNrejc5aFBITDU1dDNNOTNVYWpOUUloZlJUdXlIOUZqMUl1aHRGVFJn?=
 =?utf-8?B?S1dFY3ZENmIxUjNRSVM5TTU3UGk3aDh3SGhyRTV1dFVVaDhRajR0RGhWa0dm?=
 =?utf-8?B?NU8vL2hVK1V4ZmFFYXFXejl0dUh0UU0vWERiNW9ZZ1FQaXhqSTZKSW53OTRR?=
 =?utf-8?B?WUFWY29UNkNzY3hmcUJhUmNXQS91aXk0c2pLTHptMStLWDYrQlNVbVBCd0Fq?=
 =?utf-8?B?Y3FFcE5IT1ppdldkZ0JCS1UwQWkremIwZVo1bmlTZjZYYk56SEY1Y1krSVdW?=
 =?utf-8?B?NzR5WmxkNGRtbVdaQVBqbzl1K1cvNHovdjcrREo4TmZTdFZaamdDMWNKWUVI?=
 =?utf-8?B?bGc3NnBtVllmUVlFcnByYUt6RUlZUlhsQWIrWjRxSVVxZngrdzZ0ZXRCZlpz?=
 =?utf-8?B?MWkrbWo3T2lEdWIySEpHSThNMkwxOHEyeitROXVFa2J6Zi9DZ09GS3VMR1NI?=
 =?utf-8?B?TC9EZ1dQQ3BvNmpHWkFJNWt6bVh4S2h1UlVUSHA5ZjZjUkg4ZE5jN1NwZUZH?=
 =?utf-8?B?QzhpaktGdjVucmFrOXdMeTlaQW5JS1ZWRWFTTCtNYUx1QkFnN1U2UktRVnR6?=
 =?utf-8?B?S3MyWGtwc29HdmVxRGlBb0ZnY3RKMUNnbVk5eW1pTWFVdHQ5Y0VTYTcxREI0?=
 =?utf-8?B?MXdvS28xRE9BUnI2S1F0eld4Q3YvUzRGVWRqQWZFVTZwOUgzY2hrTGc4TVg4?=
 =?utf-8?B?WGlobHNxenByZFBua0NWS1ErU2wvT3pvMDVoeUJkS2RYb1ZGY0svaTViaG5D?=
 =?utf-8?B?Q2ZkcW1OMmNRMWtiVzZBM3Z2MjFXMHkzUzI2MVFsL2V6enI0YjVEdi9kRWxH?=
 =?utf-8?B?R1FDVURBNk1NZ1Z3WG5SS2NpTjNFWGN2RG12UHNHZ0ZJd29CNCtVWWFXbmV5?=
 =?utf-8?Q?fyiG2b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDg4aUpJUTByWVlnSXBEaTk0UHhjSlB4TGxjaXE5RkhwQjJTZkNWVkhxRDE4?=
 =?utf-8?B?Q3htM3picnFsOGR0QjQyeFAyT3c1OGxzaW1kc1ZnSE9WbFh1VlRRZnhTa3Y3?=
 =?utf-8?B?WEJUcDRUaFZrckdYdncvVzlob05sSDJEN1FqYk9Nb2FLQTZCeTZuZlRmS3I3?=
 =?utf-8?B?M0ExaHlBQ2VucUlZMnorbjBlWldMR2dlM3lZMDVGajUvdGl4R2YvTHlzN2xy?=
 =?utf-8?B?Y21PQmxpOUR3RUh5K2VjNnVjVmJXMnBZMkhiSkw5TmhDbkZ4WVR5VC9RNTdr?=
 =?utf-8?B?MWVUK1U0aW8wVHc3WkY0ais4Sm03YW5mUnVtSnpqTkwvMlBEcmZPcC90S2pS?=
 =?utf-8?B?WURNcTVhSjF0NllSRGdLZmI3K0p2UzMwSHhPWnVwZlFoWSs0OTRPUWRNRGZG?=
 =?utf-8?B?SzdnazJDRzlqS2hmandFSlhXSmo2TlE1MFNiYlprOU1LNGplZnNtbmVyUkNH?=
 =?utf-8?B?dmc3SWwwQkNvY0dFa0txV2pIOE02ek94SFRiQkxYUkkweG9yR1JVZVpHeVdw?=
 =?utf-8?B?WXJWYUlUYlgrcXMrUDgybkNvejRjNVdPNlBoRlBFSWI4R1RSZUpPSnp3OGRD?=
 =?utf-8?B?UWd4N0tPeDI1WFV2TWlIT3JvZDJWS1VpaTVxbjdoc1FLU1ZsemNGaGdlaTZE?=
 =?utf-8?B?VVJJZjRFeUlyaHBOREg4d0w1ZHJvb3Bkc0NLYVpYVlRtRjhGYi9lSWZwWHFq?=
 =?utf-8?B?VTdnaUVjV25yT1pGZGVRanJNamNDaERoQ3REcHpGRTJyeGl6U1hVbzJNVnFU?=
 =?utf-8?B?Ky9HVnUrZXc2WDVvUm12S2RieEpYODJ6MC9vbCtlWDh4QmpZU3ZCRm5KaWdy?=
 =?utf-8?B?NzJYbHU1aWhSSEpLeW40V1NSTWh4QTFHd1VuWHdXWUhpZWVWN1dFNWt4Q3Bw?=
 =?utf-8?B?YmZ5ajZXMTlIQW9XbHZzemI1OXNISzd2OTZLT1ZWL3dqa0hSSXZVTVp3UmdR?=
 =?utf-8?B?czluQitMMlliUVcrVXhGUEhGRUdYcnZ5Vmg0ZG5QMzgxQ25XMDQ5QUlSak1u?=
 =?utf-8?B?MC9wSDdkak80dHBOcVZmM1ByeDNrVnV6QWdGSzBrbDB2T0pXYmhxVHdkRk9W?=
 =?utf-8?B?dUFsdmtwbGV3elBFa1JCSEdhaVRoVUNuaFIxdGIvcGJwVUdOdXlzQzA1ZDI1?=
 =?utf-8?B?em8wU3dMMDNNRG1UakRaajVKRnFSOFNjNFVLeithNm5TMXBHdFgwTzRGaFZt?=
 =?utf-8?B?WFMreCtJKzhLdlRndmRnbjlIY1o3M2l4WUN3bk96azkwUk5iQkkvMHdmRFRp?=
 =?utf-8?B?TWtqUHN4Z0NUTjJ1UzV0Qnhxd29KOEZqT2hSTDF4ZXdMMWxHemEwQlRISkpM?=
 =?utf-8?B?eUlkMnAyNjlZSGdEVjVYZ20zUy9IUTNMK0w3QUdTS3dWS0dRSkN5eWpkY3hp?=
 =?utf-8?B?TXhXRmRWcVA4bG1FL3pBUlZydmh6K2lkb2NBT2t2blQyL1FhNHQ3cS84YURw?=
 =?utf-8?B?TkU4bzdudGthWU5nS0ltL1RPSXB2djJKMHhzY0pCSEZmYjVGNWIzcXZnR01O?=
 =?utf-8?B?V1BhOFMzVTRxVGd6VmVybWlzRytIcWRNT3FJZnRmOVlpN1pDY1NEZURxZWV2?=
 =?utf-8?B?S2RkZlRTZWpFWnpPcU1ZNnlqZzJUYVp4NUJTWTA5c0xzMDhDRXRsRHpQUmdV?=
 =?utf-8?B?MjNXYS82UE1GOTJyTFZNT29GbG5jU0VtM3lBc09WUE42RW42T2o0ZHdBWi9Z?=
 =?utf-8?B?ZXh3cmRSZStoNFR1UFJFZEhOSVpxdFVFbm82b0U3aWlJOGh5NTJ3SWx4RGJr?=
 =?utf-8?B?TVBCUlBhY3pIamNUNVRFN0IzZDZEV2ZxOHdZZldxMy83UGx0TWx1VWExSks1?=
 =?utf-8?B?OHhrWkxMZ3hya05ocVI0SXBzV3c2dElncURYR0FaMXJrelFyYkdTZGFIbFFj?=
 =?utf-8?B?anFaV3FTd3dOVXRqM2dnZXJLaGxsMDBlRStVc1Yrcy9aK2w1RDUxZUs1d0g3?=
 =?utf-8?B?Y3NJVURQdzhCaDhocXBXSWhIVkpyajVEa0dHbUkwNkdWS1RKa09tWW1taWZP?=
 =?utf-8?B?cVZZZFhGeVBaeGRaUmdlNG9qeHZIcklYbVZVanZJUS9wL3Nha280R1Bjd243?=
 =?utf-8?B?RnhrS2dGa1RQU1ZCbmM5a05OMG9iZ3FDMlg3RHlUT21hKzBPc3czQXpJdlps?=
 =?utf-8?B?b2JpRG9YR3lMZ0l4S2p4Rm8rVDRoTTFKSGVKaEtISVkrN1IzTVdEK29YLzhU?=
 =?utf-8?Q?aVLMgqvouRypGrfblhiZMJM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75355F9B88659945BD095193A2DD2E8C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QKTx2C2D93zgG5G8PIYp4wPApnuITZBnpgC9y0nxCYnWTSgmU4gzf/VCyM7/ZDfL34UYdeaHtANbew0WXzE+NjgElNm8n0k3vLPhRHRK2nK9YLYrphHBTME91+Rua4ZF12Uy593NonlcZ6EqZ7ymljPWdLxeP7vXWgS2C9Kv7BOBfHqqGZvE3nyLnmSj3gvbiOFDRr8UbGe7FeU3qPYYqD4JShDkUXge3HxSR3bPjEKvjRwtqtU91914D2kiAgt3eB861PTHHMKatzuZ0kE+DefI4moZ5dWoaLoqiVNfNk8SpeQjCAk9KzwOKeuPk+dI4bNcAX0IFCgps9des6Ps8WaOQ5SOv6dPOXlEdDqfU5d/0WrhIA3ZNLyCKRl3LJEO1SjtHE1mQ6IKwg26ctEjPbMdykhJiZFA9voBHXuJ9hCywMg4/JI/zEX9i1evprpTcj2CtiBPhwIuD4NeKaL0tLL4a4sad0/MMzZiw38jU/Y1pia5OENn9yKYlBVhfVdmFygKA5w4LW+zik4ifJ4hylQq1mLRrZuU3E0Zqsex8L0kRfSKiiEUAlr5/8+W3OkbhU279DgmD8jJP6PuHFNbUPU4+DSSaItU8WNf7bSr+OtL9+Bw7kV0FZGjzqp7DxQB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46cb5d2-b254-4aa9-078a-08de2b386ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 09:04:04.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NbjVve6ps6evid+vFOUTXyDsRLRLjbyi9Q+CL92DIS3jIPlFYrqPVXFU46dvzGGzSxK87A6VD3lCXENjbJEfG95XISbZ36gYBmaIAOsVPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9156

T24gMTEvMjQvMjUgOTo1NyBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDIwMjUvMTEv
MjQgMTY6MzcsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEFkZCBkZWZpbml0aW9ucyBm
b3IgYSBuZXcgQkxLVFJBQ0VTRVRVUDIgaW9jdGwoMikuDQo+Pg0KPj4gVGhpcyBuZXcgaW9jdGwo
Mikgd2lsbCByZXF1ZXN0IGEgbmV3LCB1cGRhdGVkIHN0cnVjdHVyZSBsYXlvdXQgZnJvbSB0aGUN
Cj4+IGtlcm5lbCB3aGljaCBlbmhhbmNlcyB0aGUgc3RvcmFnZSBzaXplIG9mIHRoZSAnYWN0aW9u
JyBmaWVsZCBpbiBvcmRlciB0bw0KPj4gc3RvcmUgYWRkaXRpb25hbCB0cmFjZXBvaW50cy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgIGJsa3RyYWNlX2FwaS5oIHwgMTYgKysrKysrKysrKysr
KysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9ibGt0cmFjZV9hcGkuaCBiL2Jsa3RyYWNlX2FwaS5oDQo+PiBpbmRleCAxNzJiNGMy
Li5lY2ZmZTZlIDEwMDY0NA0KPj4gLS0tIGEvYmxrdHJhY2VfYXBpLmgNCj4+ICsrKyBiL2Jsa3Ry
YWNlX2FwaS5oDQo+PiBAQCAtMTM5LDkgKzEzOSwyNSBAQCBzdHJ1Y3QgYmxrX3VzZXJfdHJhY2Vf
c2V0dXAgew0KPj4gICAJX191MzIgcGlkOw0KPj4gICB9Ow0KPj4gICANCj4+ICsvKg0KPj4gKyAq
IFVzZXIgc2V0dXAgc3RydWN0dXJlIHBhc3NlZCB3aXRoIEJMS1RSQUNFU0VUVVAyDQo+PiArICov
DQo+PiArc3RydWN0IGJsa191c2VyX3RyYWNlX3NldHVwMiB7DQo+PiArCWNoYXIgbmFtZVs2NF07
CQkJLyogb3V0cHV0ICovDQo+PiArCV9fdTY0IGFjdF9tYXNrOwkJCS8qIGlucHV0ICovDQo+PiAr
CV9fdTMyIGJ1Zl9zaXplOwkJCS8qIGlucHV0ICovDQo+PiArCV9fdTMyIGJ1Zl9ucjsJCQkvKiBp
bnB1dCAqLw0KPj4gKwlfX3U2NCBzdGFydF9sYmE7DQo+PiArCV9fdTY0IGVuZF9sYmE7DQo+PiAr
CV9fdTMyIHBpZDsNCj4+ICsJX191MzIgZmxhZ3M7CQkJLyogY3VycmVudGx5IHVudXNlZCAqLw0K
Pj4gKwlfX3U2NCByZXNlcnZlZFsxMV07DQo+PiArfTsNCj4gQW55IHBhcnRpY3VsYXIgcmVhc29u
IHRvIGdvIGZvciAxOTJCID8gV2h5IG5vdCAxMjhCIHdpdGggYSBfX3U2NCByZXNlcnZlZFszXSBh
dA0KPiB0aGUgZW5kID8gTm90IGVub3VnaCB0byBmdXR1cmUgcHJvb2YgaXQgPw0KSSBkb24ndCBj
b21wbGV0ZWx5IHJlbWVtYmVyIHdoeSAoY291bGQndmUgYmVlbiBhIG1pc3Rha2UgYXMgd2VsbCks
IGJ1dCANCnRoZSBrZXJuZWwgaGFzdCB1NjQgcmVzZXJ2ZWRbMTFdIHRvby4NCg==
