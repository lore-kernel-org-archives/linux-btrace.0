Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647371;
	b=hs8BIjFy3pk2tNnpBJ31WQRaqJozPrRaN3Xx7b6P4vek7KV7zJHsLqIwZ6DovJj1FLG2
	 s0zTXHrXRvCfV6JqXuzpK4t9+51GlDi0C9zN0TAgYIu+RRU8Kx7j2680WodPn7HWP5CJk
	 5kxOOr62vpGCF2pDR4mdZyHRGdk/G6M45y5CNKRqsgVPljfwm79qswKerMTVJf6Q+Kl5S
	 3wOKtCu45Blh428/258tJpRdOOgFrsr6I55qxbhOGz/I+K+K2euiIOf+XqEkEfF7pohol
	 3Y24UaCnUwjDwsE2IHU7dY3HB/lPTJP0urjRpc651gVxFblB3wF3o9rdnF55q2YZh/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647371;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CwMF8aDqoMuIzQEs140HjFpCX788B4TZ89zPNfdWxy4=;
	b=H8vOMGFZl7PQpg7Fa8Ij/wllln8WHsiqJb+64i3qKSNbPtC4rJKdcFq69OjpzaJ0QbnR
	 uqdHjovY0SuXKfzcXlQ9cdnRuh/ScE2y/mXgJXv86Zxi2lZcq+0Bw68QumEhG5nysDEgT
	 F0TrgEmjvXUSr00CHlWvdNjzwEk4MuuBygx8C1tY76ZyrJlhSm4vJtz47yigksKqB3Crn
	 HTgKC5lIRXnI2VlZl5GEepobIY/XQ4r7ZwjjD6puxem+RtfvCMShu/z5HW5p8dfgIN5z8
	 nlV64s7akbznvdA5c6azYQ886L0AxgHLr407BiZuv/VnDwNR/f4zoBydM0EexwaVA2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FHeve5dD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1D606A33B;
	Wed, 25 Nov 2026 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D1D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FHeve5dD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d77k2DExeHXRwuYXePn/TyWHQ+vVPXVyKj2yom8IwexUIebwACm/W4K8u3JUMpisSXd255vrtT780IT2yV5txACL4pIdigXqNxlxPIGCkIEDtqjpj1j8/4IfbbXhQvSJaBzlLoY+A1grq3kYF0ztF6AK4aqHCBkszH9MNie3C6QAeZ/VCO1g3gY4NjqKLa9rdcqz0cyoVT7iJm4eMS+hpW2qhPPJO4PG6VaSrBEZ/ntmSgMH/7PjUhcZPqZNMqerYKXIpDC8mJ9GKzqftmSFLLb6tNhsd8di0Ra6mlShfRlFDqrhTxFggt6s0oZsEhd+AbHcBXQGMg5dT/a39tRmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwMF8aDqoMuIzQEs140HjFpCX788B4TZ89zPNfdWxy4=;
 b=i8bkoonu/nZHluFmygYtHqfQ+MrWkBiEBpLsXRnPhHQ6hwb/5ToSiEnTLlK/gsiBN0cHe/b+cD7nIvnWqrku0ERqVnhnr0pDlVvO7zPLYO+G1shTtRxtT3DzwkVB18wdBgV1FMo+7v4XtLSuTQW5tlj+QqQRMpbXew69xCa1Rxhhd/xVlvINVz7btu3K68O3SCp2Nxq8RfrBZOFxgV5B/ieeA36JgcLKj7FCc5pi6HEB6xjmE3rnJiSG2Q/RqiLwIKolXB26yEvhG6QdIShRqddgkwg5SyVxsyH+kci+rc6C8RRCE2thqT6jvtMYBcvdDrmcycjp2msGrOWa+UyzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwMF8aDqoMuIzQEs140HjFpCX788B4TZ89zPNfdWxy4=;
 b=FHeve5dD5V4OUjbUgnBmeq9Xp3pTbpLnom8b1Zjh2iT6SD4mxU5FY1ofs12dYMygoXIF2XNPcyIjdWTbKg6aAqvUllTku1MmSNodpdUC6tHboIPva1lXybubbmn1yFKkVxhKyArMpNIHZ/G5kY1dxqdN9O0kwGSEeiJTzxZZtc+n+kjImz5wtXhBUqG1LcOAXQe5LH0F9cCDkhovGvxgus//+s3SdUHiZTpe34T72EJFb8JAIJWZ7d60tFKAImZ/qMoPGb/i0vwSbq+bTrtOtSiKSZsWMw2mgf2cQdDICiEUKeJZ1d7ZjL8JQY7GvdqKFMoLd5lRYS6rrdc3kW8PJQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:56:06 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:56:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH blktrace 4/6] blktrace: mask __BLK_TA_IOPRIO when decoding
 actions
Thread-Topic: [PATCH blktrace 4/6] blktrace: mask __BLK_TA_IOPRIO when
 decoding actions
Thread-Index: AQHdfBo44DBV3c1EQkO4IP6FuJuK2bc/aBkA
Date: Wed, 25 Nov 2026 22:56:06 +0000
Message-ID: <5ddca8d7-9bee-45b6-866e-b16e6cca6912@nvidia.com>
References: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
 <20261124134602.153239-5-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124134602.153239-5-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|IA4PR12MB590810:EE_
x-ms-office365-filtering-correlation-id: ff3b8bd0-7930-463e-2559-08df4b474a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|10067099003|56012099006|11063799006|261026140227099003|261022105027099003|261028144727099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 tOHUCcZ6XF0CvTNDLwo98yKPTW09EPMfhPZt+fK0X32HY3wV9Q9SOThifdTToeOJA4kBgsUCKlqQstPf6/2CoaZ9OPdzDRLp2u2ulc+Wyy0k2gqCyozeoh3f6M8kqFwOLQzWc+EoYIHHFo2rb+hqGEn1eEZlsSHVKGN2NOjpmjgWcgTG+uykLRGYwNyFaq8h5v3zGuKteL0M3ZJXcZTcYzH0qphwm4YrtzWjqhy6RW27jM+k2IEBh6+CbxW+SN9i2lbUt55zSAm5xAPqrkJzAo0s9wK7IGESDamJYOdG6kOf1Po6ClMtz4CeMD3MfFtU7efB3smepLpoJd5ubUQr8liU5PXdtELPtVYEI6+eUs7fTWw4991hNcYKysiV+oXyUTxNsw49XtDKlaCJNujs6eUyJ1deBpl0ChWgrqUvANiWdu4B09o77IRDz5EbxEhojHGV/jj31kDlFRjty6LLJcpxGpMXUY5z8TDhpw/F2zPidPsCYfFFyaHbw5C19Ab5a3RQQWAiTdN932BjmfIKp8/bZGaZAeg3vLZrbZEJNsgXAip/5UKdSKVkhcKhbYjNvsmJ06EIPgtvVC0xpdGoiqXDgHwLPOnmzjj2jmA636NnYNy+iElBkgm9Ymnp88m88zrvJw4kAn1M669OlbomzBPN6fRIS5nRvLGcOyq2KymwvTmSJTS/9UFDVAksCKSnQQwog4BcW6FIYErx1bMdIjKVADZB9/FMRCDTBr7qGR8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1dWU0JHNWZRNVNZNUdydkYxdDNCSXhNa0pjMmxMdTVGa1YzTWVCalBiUy9D?=
 =?utf-8?B?dnA0aFlxOWpNdFJuTWEzNHd5TzBOK1dkVnNXQlA1ZTR4TEZYODczNW5vOXNl?=
 =?utf-8?B?K2h5YllYNWhObkZLN0E3dzVjMjAwcHpwWXpJakdBWER4bnd0VDJNMlRoWVZU?=
 =?utf-8?B?a2tsTDZQeXVlajcvVmk4WkNuUlp2QmlheE14QVlPN0c1dWQwWkNDcE5BTTNr?=
 =?utf-8?B?Q1VMeHZTalg3bjN2QlFtR2RwVTRlWU5UajQ5blNpemdOak1UTnZja0dkeGl3?=
 =?utf-8?B?SW9EY1NidUw1NjdySW12dnkyZ2NWazRsaU5iVWZJSGZIQk5QVm5TNHdHVmVM?=
 =?utf-8?B?dGZ3eTZ2dHZNQXVrNHZGT0RMRGpuUkVnUENTODdVbVE3Uks2ek1YVzdCQUpr?=
 =?utf-8?B?dy92Ykg0NnBtaFNPSzdkNW9ZVkpKaUU4UXFUVEJSVnNFS2IyaWtvMnhzTVdR?=
 =?utf-8?B?OGZER0ttbEZKM0t0dkdMOVdWU2dka2FrcVRDZmlELytxZElyMzJHdHJUNjcr?=
 =?utf-8?B?NE5yWGJENjNXOTBXaHNwbkEyUXpmcVByRHk3UUlXRFpUcFZvUkM4WlQ2VW5u?=
 =?utf-8?B?aStESXVFakNMNk9ReUJLYklwSzBNUmhMWm96QzZpSEM1RTF4S2UxbFNzbUta?=
 =?utf-8?B?c2dMVzluRmlYZ3NTZWR1WXBia0RwYkxkdGQyTG9jZGhCcDVuNWNaTnpUN010?=
 =?utf-8?B?QzFKTUhEeHc1OWhOdi9FS0J6TXlxWjdNU3BDRzVkSzVkdkp6dlk1ellBY1BR?=
 =?utf-8?B?Q2dUaWxKSmVkWVdYa0RxSkxlc1ppM0tkMSs3QXpVRlR3NjZ3VEFLRnlCakUv?=
 =?utf-8?B?OTVWOThSSVY1aExoRnpyRFU1dlYyVGNaS0RYeEhLSk9taUNKYjlvKzlxRGRq?=
 =?utf-8?B?SklXOTVvbmIvT1VBeEx2cUVvOXA1WUdyOWZhdnRUSFJlbThKVVFnMTF6Wkpl?=
 =?utf-8?B?QUMwNE93TURweEJmR245cTduYVE2cERBWWFQWk9kVEJSM1hrMyt4ajQrWW9i?=
 =?utf-8?B?Z1pMUVhDaStDMGlScGJHcGZzZ0tyajU5WkpXNlZvZSttRThEOGJFSE5vbkgr?=
 =?utf-8?B?R1pjcCtEL3lNdlo4ejFOS0J0Y3BHN21adWxPYXBDdEh4Qlk0SVY4V3pBMXI4?=
 =?utf-8?B?ZXkvWTdEYlBxRGhKcVp6K1d6YUpvM3FlNTE1Tk94eDluT2VCUG5nZVB6MEdU?=
 =?utf-8?B?d1F0dm4zbVJxZnFJZE9LeHdHK0NUcHpMZ0p3bk9HdlNrQjRjUC9OZGdiMys5?=
 =?utf-8?B?QjJsY3pwYUd6WmIzL0pmMFlHOVE5VUlReGsyaHZjMklkRzFFWjFqQjRXTzZl?=
 =?utf-8?B?RGt1MmxycDd5bW1BVkNXMWpPTGNNR1Fxc0FtVHpJWG5aSGlLOGUwczVieVds?=
 =?utf-8?B?TlFWakk1UWUrckorTU0zc3ZNYkE4NCs5VXQzUFZoSEU1K3NuTVdlUWplM3RX?=
 =?utf-8?B?dVRZeGp6YTNqVngrNFBRaGNJWTFSaFJXaGRXemZ2VDU3MGQzbmk2M215djdV?=
 =?utf-8?B?dEtwK2IyMURyL0NMQnd2Y01aemtYWGFKN1dkd3QrSzlzSkhQSVlydUJBb2JU?=
 =?utf-8?B?NFYxbjc4NlBNU21VaFVQVWw5RUJpQ0ZVTXVrZTZPUlRGNk1OOVltWnAreS82?=
 =?utf-8?B?dHI5R1ovQmMyY2ZrZEJuOHRmNTNzbFVKaDU1bHA2OGJSWWc0NTZ1WGZEWnNw?=
 =?utf-8?B?dHA2M0pqbFFMZithT1c2cno2akcxaGpReGZJS2M2dHd3d3dSL1lzRVVWNGhw?=
 =?utf-8?B?cEM1Nk9JeGRGSE9INVNWT3A2djQvZVR3Sk5uYUkzRzltTi9BWlhVblNSc2c4?=
 =?utf-8?B?U2lVTThhQmczRG9udC9aS0xqTU5Zd1dXVCsyNHU1aTBLV1RtWE5xeEpqWThV?=
 =?utf-8?B?UGlBTFhyRmx5Q2E4dmY5cE11MHkxMzJUTjFtYjB2N3VRREhjaHNMZmkyVnJ2?=
 =?utf-8?B?SHNUQ1NnZ2lWVndJVTk1ZlMxTFE0VVpuYmM1cG5IcXR0UnZ1bnArZ04xWUZR?=
 =?utf-8?B?VXZ4RElsRGRTMkdoY3JvanpVSEtPQ0NaTkVleTZ1bjF6MTRMbjdwM281Q25M?=
 =?utf-8?B?MFY2cWZYR1BpTlppWUpNanZ5TlVSLzlIZi93WFJGVm50aFg4Qnp0TWZJNlND?=
 =?utf-8?B?YmZZK3Z2MHNMK05iZFRlV0YvOWJkZXk0eit3TndqZ2tlZVRZcG1IdHlYbXd3?=
 =?utf-8?B?aU5WSWRRdzMxNEpUNE80WlFLUzNrY213eXBWdSs3Wm0yUnNsYmpKZENFdUJJ?=
 =?utf-8?B?SUNOMU04RGt0T0dTcytpVzlyRS8yTGRYWlRQV0dNSkNyWmxtTEdDU09zQklv?=
 =?utf-8?B?VjdFZmNXRTZ3YVdHTDlVVlBOYzI2amwzNzlhY2krc0dhQVVLVDRtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23AE4CE9AEA493469D3982FDB974A3EB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Post: <mailto:linux-btrace@vger.kernel.org>
List-Help: <mailto:linux-btrace+help@vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-btrace+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3b8bd0-7930-463e-2559-08df4b474a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:56:06.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsRGthk7jvVSsYbNmb40/m0ZKuq2dCu/iUaYxeLkDUQbObge3hQy/6q/sKIpekKYafELaClkxnzbvD8WbrNXXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

T24gMTEvMjQvMjYgNTo0NSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBfX0JMS19U
QV9JT1BSSU8gaXMgYSBmbGFnIGluIHRoZSBhY3Rpb24sIGxpa2UgX19CTEtfVEFfQ0dST1VQLCBz
byBpdCBoYXMNCj4gdG8gYmUgbWFza2VkIG91dCB3aGVyZXZlciB0aGUgYWN0aW9uIGlzIGRlY29k
ZWQ6IGluIGJsa3BhcnNlLCBidHQsDQo+IGlvd2F0Y2hlciBhbmQgYnRyZWNvcmQuIGJ0dCBhbmQg
YnRyZWNvcmQgZGlkIG5vdCBtYXNrIF9fQkxLX1RBX0NHUk9VUA0KPiBlaXRoZXIsIHNvIG1hc2sg
Ym90aCB0aGVyZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
