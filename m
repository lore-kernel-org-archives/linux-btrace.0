Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396782BE7C0;
	Fri, 19 Sep 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268325; cv=fail; b=P07KNf+IjUORvQDplq2iDFPkpQoe0kUngugXW3vOmRuGJenxYb+yeqcEpF3W9z+AU67EMq6AvRSZ5Mw7Nrrw9RFAiAI3jqDdgxc1JwZtiIizuGCdXLUY49zBGWmdk+2lovGi4hUsOPPNKotZ7PXPbyxKdYUkA3+j+QoFd0sTDWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268325; c=relaxed/simple;
	bh=j9v3g2Vg1+FZy48lQT2iUL51qC2lx55X1clneMXlOIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=io/j6oyuynkAIlN6eOVjfR1nUnStjIFUdmpqgzK6ts6wxiiqP+dBc9mpXT3qhk9hBybv/WNpoLKsQnFliorbOEKdZ+CjMl7V7A9GjYYE66EIYTx3k1cisjPU+vsFtH1fhbdVR98FMtqoY8Vrnet1wZ/A/Ihoo/n/UUHGS6La7Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+EasF2n; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+EasF2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyjsr6j3abOBSf2AgSS6IchkBYXits3OCxePQSx5B8niHRTpEm8bSY0m1l91qA3gi6Q/Ph3iMfFI68A+cMy1mSS/LDiZJp2qYZ5yVSkY7BqaHV3NDohY8qlfmaEF3VRmJ7agnHPAYPuVMyLXWVl+M9FQRNVyE6inoeKPmh4pIla6xdZ5hiGGQER2BNHKoMtCBmuU+oRjjhNIRJ/lG7eOxdpio/ZdyQoTt362y4SSMU3TsfraRCNtdiG1usvk1Fr7xtyRwI1x5O8+6aUy4NOk4uC2nn/u2oCikfE3rbusAP5BhAY09UkPtF3P9SRYN7VELws5Ro4f7wWW2ZzYIRXotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9v3g2Vg1+FZy48lQT2iUL51qC2lx55X1clneMXlOIQ=;
 b=CIuQybjml2oDQtm3XGpkMWzpqLnfbsvEPbQy2qdqWwRa66NbqeY1it46ZZt1ExJ74Y+Ka1yuBtQn3EGErAzj9udnwMCT+y2OzE7q/oBkgazJsIFtf5n5xe9aScOXNiF8wLOvQOzrXOUxVD583NaCQXifxcVX8SYsBKLp8szuWHtLgUTlp3EGuKUkIQ3kB2GLbx2gaIDwFNXUcRdP/4TKYICof8S49V37dKvfCGxqHRegijCVsGWoPO9OvT/C88KjZAqUFq9DysACcjLHyKYri4wozaQKGGbZ9kc74n5qbqOku5VSrQOpaR6xkZl/3hV4aGZapKmM0K1mRFGULG1waA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9v3g2Vg1+FZy48lQT2iUL51qC2lx55X1clneMXlOIQ=;
 b=O+EasF2nKmJTShgxRfWoQsNwyZKrVz7I5b2/+7s6EfIfMPd0DxcWlLdFckw+P2vuzmFWCMersgZM8KFFfvWcj56uifIa6nzBJe/JMC3GCqR3bcMNDNm+/e8u1QINnxRNYibf2o8fMaQebAOaSXuskN+MmpCnKEWIRp4ihDVpsq0YwOZPSWgSMnJqWXQts9VeXRJ8cCasMX6DLlgsYC8WAPo2IEFr9GlL90W9jriG4kG2FUYDFaYu1ykFcMU/+YyTf7bsZbAqA7kj3/wO0IQCuV2zoVVatd0BD+70TKhqa7iTtflEY/pPICdRI52SPNgTY3vWaXD3u8GOjOk25+qoqw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 07:52:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:52:00 +0000
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
Subject: Re: [PATCH 01/21] fix comment for struct blk_trace_setup:
Thread-Topic: [PATCH 01/21] fix comment for struct blk_trace_setup:
Thread-Index: AQHcIXn25Iz4/DG6ckmMYnQ14Iw2FLSaMZqA
Date: Fri, 19 Sep 2025 07:51:59 +0000
Message-ID: <d4b86321-2826-43da-88e4-d3a4d0921e09@nvidia.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
 <20250909110723.75676-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20250909110723.75676-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: ad953164-7dc8-495d-2bd3-08ddf7516a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGtFenNvdGxDWWI0UDdtWU9RbUtDa3JGbTQ1K3MzcElnRmFXeHFEMGZOenNl?=
 =?utf-8?B?cVlhKzVudHgyMFNWek45dExTV3hLazRFOU9wbTc1REh0R2VHMWZVRlk3UEt6?=
 =?utf-8?B?bytxUHMxby92b3NpdWdVdDhQbW9WTCsyS1JseEIvTWpCSEQ3SmJiTXFiL0ti?=
 =?utf-8?B?RlNockdycWNTUVBpYzlaa0dYQ3UvMEpsRWxGSytEdHQrU3NGbktGZ0tRNjUy?=
 =?utf-8?B?aGVDUnY2clkwWXZXWC9tQ2FtWTB3SVJZN2JXUStZTk5MeFBKRmRRYTBnNVVy?=
 =?utf-8?B?bjhlN3ZNVktMVVBWVlJnMUlQSnFKUFJab000Q3FCQ1pscndZTVhDakhIY3Qv?=
 =?utf-8?B?dDR2M1B3ZjQ1eUYvRHVIcG9Ia3NZeUNqTXdVT2RYaU9zNTFickhpKzFXOUNl?=
 =?utf-8?B?ZlI1NVBmVUpaS2M2M0dQVFVucjFpOUVXQkR3VTFLOTZYN1BuWHVxeU55cE05?=
 =?utf-8?B?WnR6ZDRKNVNoQkROMXVOY2psS05DTTFGajdUSDdndVVKMGRSTWZram54WEVr?=
 =?utf-8?B?SERFK2FDaStWUWlQcWREN1V6dFJ0bVpSUmxMVzNwRGdKVmtLUnVsRnhtK0Y5?=
 =?utf-8?B?WlJGcWtLanU5Um1tZC9ncjVNNWwxUmIvU0w1eWRFZFk3NlFlT05iWkcvdzJV?=
 =?utf-8?B?MUs3UzhabklxaThzcEZBaklxTEtrZ0cxZ2Q2K0ZUemJHMXBGVWI1bDlvMXEz?=
 =?utf-8?B?NWF5VlJtSWVMMXpjdkllUVhGRlJiZ2RoaXdEdWtLYUo1TW54NFBFS1NVYXA1?=
 =?utf-8?B?cHNObm1aSEZzcHNlUExMWkg4YnhwdEVUKzNBNFNnTmNXVWIvNjFvQUVFUTVu?=
 =?utf-8?B?VWVDMDEyOHh4VHlOSDFxTU9MNlM4TkcwNGlnaVIrSloyR3BaUnFiZW9HcWsw?=
 =?utf-8?B?ZW10SlBNd3lJTDYxRU1kYVp6QnFaWTBXRWJxdnBSWDg3OFJ4QmNONUhaMWFo?=
 =?utf-8?B?d0RpeVMwMVhGZVdab0plQXdHbXpoUlpMaVFjYmRhTE9XU0JMd045UlRyY3Bk?=
 =?utf-8?B?d1Bnc25yMGk2OGpPY2dTMFdvbm54SFRCT2hxcjczV1pEUkRLcXBZTVFhUmJ6?=
 =?utf-8?B?RWRCSU5BYmFSeEcvQWtRbk5DVmlacXZ0aE1ieVdMZ1N3QW9ub0N4YWxzM2hP?=
 =?utf-8?B?SDd5N2RjM1pvemdVeDcyeUthbGVZRnNmWTVUbVB6cXpRbzRDdFZJY3ljaDVY?=
 =?utf-8?B?NlRSZU13SlYwc01TYWNYeERDYjllWVZWOVVSZGs4Vk0rMHBMRkYxSnVaSWxN?=
 =?utf-8?B?UEIrTnVBcXdwaXU3cDY4WWtYbHpML3pRWEtJZytBMmlHRmtIOXlROHBwZHdm?=
 =?utf-8?B?OHNYMklLc3JFZzlrNG9iS2Z0S3dYbjJ4WWRlRFlva0VkUW4wdGx5WEtZZXN4?=
 =?utf-8?B?UnRmcFFKb2hKTGxsMk5XY3VpNDFyTmo0K1Zabi9tZGdlNzVoWVNYQ01kazMr?=
 =?utf-8?B?eUc3VTlza3ArTDgyVmlPSmkyNVd4b21YUStUVS9HZUttMk00bVl6NGQyclB5?=
 =?utf-8?B?YTFTS3VvMjFWdnJudmJocFJJVXZTRVVSUFFNeXA2Y0QzeVRHc2k4Yk9qWFhJ?=
 =?utf-8?B?RlpEelBQbkZRRlVrd1N0ZHN6KzZ6VXlqQnRTU1pPbFBac0dRL2ZUUHZVYmZq?=
 =?utf-8?B?RGx2RGViZmo3QzJ0Q21uYXhSSGE3UW1lNGM1ZDNRTW5HMEhBTjFVUzNrZ01y?=
 =?utf-8?B?MFAwNitKN3FLb2hPZGF3SWlxSUxnaG9rZXJ3YTk3ZXJSUXllR1dteVoyNWFJ?=
 =?utf-8?B?c21ZcjBHTEZwQjdPVTdBMzYvZGh1bitpbkNpaGhMKzQ4aFZ2aFZvd1hGTTF5?=
 =?utf-8?B?SXJYb21uekpzVXhMUnJ0ejdGcS9XRUJKb3J0cmlFYVpDTzJMV3FFSUhJei9q?=
 =?utf-8?B?VG1EQ0c4eXhZQVl5bzR2YnF6TUlueEVHTUdsTlZzWldLeGw3aW8rVExCTjh4?=
 =?utf-8?B?RVJqVGkweFRZWCtxbVVKZE50bnVPZkJwN1gyQzNlVGRwUHk1NUx2Zlk1Y1cr?=
 =?utf-8?B?T0oxWUMrTFh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlBCZnVwVEpCQmZyZS9QejdkNTZ4NU4xVHFERXoxS3o1UjRpNGl6VGxydzF6?=
 =?utf-8?B?b1pzaDllWnh4M01vNjBjZUt6TSs1VXg2QTJub0Z0dGF5RVN2MGVFZFhGbW1h?=
 =?utf-8?B?Qk1sQmNRYnl3elJJZlF6MTdKT0pFMlY1Q0d6eDJHRVM2V09aMzJveC9KVUlC?=
 =?utf-8?B?QTh2Yi9POUpCa2ZxSkgrS1hqVlNNTDJoZzg3cUtrbkhOM1BhYmxPVmtWeU9v?=
 =?utf-8?B?UVd2K241eGRGZGNTUUs1T2dTMXBBbGhiV0JJRmlvcHpGSjBSZndVenhLVlJK?=
 =?utf-8?B?bFNRbnhRM243ZmdkS3Q5MFNoUkVCbmk0ZnRkb1J4bWZ5aXVYam9idkY3VmJI?=
 =?utf-8?B?YlZjdUpNNDBIWjltVEh3d1NkNy96R1hkY3hJM0JXS0JFUDlvQWF3MVcrUkRl?=
 =?utf-8?B?UVExaUN3K0ZNZkd1MWlQQ0VESk1IVVpnRnBHaVNJYm9WNjdEb3EyaXpRaU8w?=
 =?utf-8?B?SlUrU3NvdnJwUE9jdkh2NThveC9pMDA0U2MrbStYQld1c3VIM2tURk9rUDZu?=
 =?utf-8?B?bWdHNWJQdTQxSEpDMFROcngxVlY3cHlLSS9LbWIxSFRrUDMwRlZaSm1GMW9S?=
 =?utf-8?B?WGRsdXJ5NG16VTBYZ2hIR2lHWW9ibFByd094TE56dmM5KzF6cEM0Zzc0UW1i?=
 =?utf-8?B?Qi9naGphSmRnM1JGOVhUSHR5THA5b1Q4OFd4QUJrQWFYdE5aWFc2L1k5SkRY?=
 =?utf-8?B?WWQ4aFhUYW15bnhsT0tLWlRQaTdha3N6bUJXLysyNXlCYVE4Ti9BMDZwMFJE?=
 =?utf-8?B?Z1IzRnQrcVVYZjVsTzgrcms0eVg5WkJDWDBBTmo4dEpoQTRVTWkyUlpQNnRn?=
 =?utf-8?B?Qzl1QUNLTHJrMzEyeGNMbVY2Ym5RMVJBZVpBd0xaMzh0dng1OHM3OXJWSEs2?=
 =?utf-8?B?ZEVqSHdkclk4UGhhU3JsOTdWV2hhOUpja1pRUGRaRm42REJNT2cxMXUyWFJx?=
 =?utf-8?B?Y1kvd0VrcG9Ybi9Gb1pQNFd5clJ1WHJEWW5Jb1ZaWEZja2dYQVQ1OUg2MmRK?=
 =?utf-8?B?MVdnZjNFem5LWk9rWk8zaXNvMG5vT0JQRkorNUZyTnZwTWh0dkdSWmZUV1dY?=
 =?utf-8?B?RTB1bWh2MTBGeGVTTUI4VVZOeURIWnRQbU9OV0xmcnQzZEk4ek1TZnpNbk1E?=
 =?utf-8?B?M0lab0htYzRiK0hjdHh0Y25QNXo0bFVSUVVCL2ZEaFJtVHc2Q3NBSU1sZ28z?=
 =?utf-8?B?cVprdXoxZmQwbFg0MVVhTStZbDNtd2svc3NCY0ozUDhKaEk0cmNXWmpDTjcx?=
 =?utf-8?B?VW91aFplbmdjeDlyVWFCc3oybVd2aDFZSjBDQVdVQzVhNTdQMlFLVzRvdFB1?=
 =?utf-8?B?NlUvZ0VMTmluc2ZhR2NTc2dwYVRFeEcxckQ4b0NwbXdPZUpmY2kxS0JMLy9C?=
 =?utf-8?B?UGlzZXNoRnJpSzZXMmN2ajA4YXlJc3N2WEd0SkttcFdxZTB3ZTkrZG9HSmVE?=
 =?utf-8?B?aDdHenRFUENZWXpSMUIyRnBubkxvQmpmLzUvQ0FUTm5DUTVPaVE4bE00MzRw?=
 =?utf-8?B?MnZUSER6U3FYbWRvNTZVTm1OUWRiaGowL3BZTHpORmlsOUlXcEtXNDdGTTdp?=
 =?utf-8?B?N0pwcGF3TFVicEcrNXNZTHI3cFdNRVFKN1F6eGFGRktsTnRoM3VCNGJYWmhk?=
 =?utf-8?B?azYzR2V6c0h3MnBjTmgyVTc1Rk1tNEY4amp2T0w4UjNlTDA4Q1pqdEhJaGhx?=
 =?utf-8?B?OXUxbzlEMTZLcG1sWkFFUjNIUXRXSW5ndE5HTUdFME1FRURLeitJUXRRcVNY?=
 =?utf-8?B?Z0x0clFROUY0cXI1TDhVWU55aDJYaGFZMVNMYlZMOUhtcW9LN1BkdklFcEVj?=
 =?utf-8?B?QW1CYzEwOGNVcmhKMWZiQ0tCOEs4dHdQUktnZEtiRWxBdlAzR01zdWJTbGNW?=
 =?utf-8?B?dm01cUNTcDZtRXRxTUg3VTBaalU3cFptV1dBQUZkWmtKLzBiaFlCYjVFNXF5?=
 =?utf-8?B?UkVWNFg3Nm5OZERqU1FhTnlLWFdEZXJEQkpqNlpaZnU0bUZ4SVE4eGhuQjRB?=
 =?utf-8?B?U0VIa3Qxc0cxbGtMVXpFY1p1d2dJY082VmU0VGlWRzJhdEZXc0ZSam1adzZL?=
 =?utf-8?B?bFI5ck5PNkZ3MlJmSGFtOEo0Q241Mm5SYzFvSVZlL2VPaFQ5dTdHVzhDVmlx?=
 =?utf-8?B?WlJQeDlLVmNrdS9tYWpKU1NiYWMreXJ5K2EyWXJuUTRrcVUwVFNOM2w4VGw4?=
 =?utf-8?Q?qIw5Gu6fnZLVdi0PBO21cEparyl7LF+axKjyYVSY96DZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFF0701948E7CE4BAD28AE8EE97E7CFF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad953164-7dc8-495d-2bd3-08ddf7516a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:52:00.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDNsVjAugxheHSqXmk24seY7dQzSjoMJzII4y1TCllXAaM6RlvXHB6RJCyiw7iX8QjvSB1ipFo1GrENA438G7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

T24gOS85LzI1IDA0OjA3LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IEpvaGFubmVzIFRodW1zaGlybjxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gLS0t
DQo+ICAgYmxrdHJhY2VfYXBpLmggfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ibGt0cmFjZV9hcGkuaCBi
L2Jsa3RyYWNlX2FwaS5oDQo+IGluZGV4IDhjNzYwYjguLjE3MmI0YzIgMTAwNjQ0DQo+IC0tLSBh
L2Jsa3RyYWNlX2FwaS5oDQo+ICsrKyBiL2Jsa3RyYWNlX2FwaS5oDQo+IEBAIC0xMjcsNyArMTI3
LDcgQEAgc3RydWN0IGJsa19pb19jZ3JvdXBfcGF5bG9hZCB7DQo+ICAgfTsNCj4gICANCj4gICAv
Kg0KPiAtICogVXNlciBzZXR1cCBzdHJ1Y3R1cmUgcGFzc2VkIHdpdGggQkxLU1RBUlRUUkFDRQ0K
PiArICogVXNlciBzZXR1cCBzdHJ1Y3R1cmUgcGFzc2VkIHdpdGggQkxLVFJBQ0VTRVRVUA0KPiAg
ICAqLw0KPiAgIHN0cnVjdCBibGtfdXNlcl90cmFjZV9zZXR1cCB7DQo+ICAgCWNoYXIgbmFtZVsz
Ml07CQkJLyogb3V0cHV0ICovDQo+IC0tIDIuNTEuMA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
