Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647230;
	b=G8eYavwpYaYtJfA0UauIfyCi/NdEbGgyE1YR8ZGXE//EemSWIL6dbtNoCe0R19NZRe66
	 oFIxoFVWJTqc2d/cz0wCE+Fk+TySwWILtM5PlSE678bygXRUhxUZQDUwZx7aJaG/pO37K
	 VVB9FrRcIvNH43yNHSzeWIwv11brXke4mcYsWxl7IP9545tLRM+dnv74QRXiYQJ5utQdl
	 hbhNoBvNjy9bZx8P0lDR1D6xAt7gDTKGSuNpDU3Fab6s3damR4jR+6nXlT1meW0xV77Ee
	 GUkvmvTfBE3pueR2hsaz+XXtItu52IlOu+sYDJNUJSHg1ZMA/sRjkzuelheuAIR5yOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647230;
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
	bh=T7zuQ7GblBbYd1nhhstpF0gIchwLsLiT4H6BO4Pe+uY=;
	b=EdvdSZpcbOho+60DJewIQw4P+Y22MZgG/cEwEjjMRkr3pzQFUXyyiEq+HQ/2otuzwH7g
	 kwDG9zIIyOq40Up7FFA7rmdA6JJq7FaIJsS3GCDw/xoDVEyXSW9AJ6SR2kqdfCCBiXkEv
	 r8lw+fljR6fvtj9j2/E+DxoFo7elqS0XR0uS0CpEg1EF86QijLmLI/CNgekvqYHWP3Di+
	 4T9IxdiBHh2gUlMEQ4oeny3gagKYjZYcIYhyiHhqSiUM4oFoYxFyieKgm8VRZpoCV94KY
	 43hPv70WY6fl/RfC+v+Bxm3qWgITswSO88YbPfgI99SHyPqaUgMakPeUzNXL6UOW+mA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IXljVPFQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.50
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE97606A690;
	Wed, 25 Nov 2026 22:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE97606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IXljVPFQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjnTTZD6liwDl9OX5YdZkWzu7hxvS68PeKapjqeMbRp+jz/A/Kjb1IBEpuKgLR9qUimoQ8lacH28+ERAH2elUvz5afg3+j0240llbjTEK6UuZ2Our1qGKHnOxyYV78wjaRJKAlqZAyabzH6cfKqvveSn0FTFh66ExdXL8w1xUYOgOg4wRDs/j29JJWaFq5vE5p56wZwsMnXxTf1e4NlPKjmlpp4/+ZvsogJ2bszMtx17qnzwoQxVagz5iZT7WMpWZ+HBMpTGd51rr4Hk5Ei23Y/sfzb9kwjaGbb1G0iU4dIuKGdfXf5PO0ENqDrHpZob+esC/VA6MGbrXhJGlg/lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7zuQ7GblBbYd1nhhstpF0gIchwLsLiT4H6BO4Pe+uY=;
 b=C/4QoEDu4FG89t0FzWdozLY1HeIghxPiNC5UIjuyK4tg324pcjaqq1HBqb0R7tGZz2/PbGZ2uDPYSfQ+5vVs6bP7zJnhAQKLqESHGObp0gX5SISl+FNtjOTTwqMOmW8WKmOEcKxQf1fn3Bqc0bb1pJ9kKPSqg/lw/lqbdR2TfIW2Cj8vTy6pEc3uqQiDjjKGwcI6mSPfUfBJOJa0x43vN3CvGBpTY+JKdIpzPExe1hR5DCNSJ2268ZpZ6vOEZfAg1AuQcxCEZVWE2t48uIms4ghQclH62YULAIMNn9DxqoLTikPDBpJx2pOTxEysoXS/+avfnLZ47UtZFZucbAb2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7zuQ7GblBbYd1nhhstpF0gIchwLsLiT4H6BO4Pe+uY=;
 b=IXljVPFQUOIq/WlSoZS+ud/gUDx+T54yntGoquUxATnMwe6Qg6Qti3LVwYa1lgkfu0FghtBvbzY4Hyfnw64feTj3KqkfGW00K7r+EKmJLCRDm5A3fvI0uJ72BYwd4xnIS7ZGLs9WFUwuYuifcu9p/bKn/A7E8hDDsKLOxDbl6yacmRXj6ef7yBYcjdSqQ1BiEep8EuLO5TsBXc/UhibF3hDiEOIdeP9eJiQLuuFVj9vr3tL5JeFcphCzum7zomOtuKrfhjfBeQYXIurpE25cP9SVhSiif6BfmwN7x6kq9lkxU7ztiXCrhPZ9/Bx1F+1x+AYKDAprvPfoR8BiLtdLMw==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 22:53:45 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:53:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH blktrace 1/6] blktrace: sync blktrace_api.h with kernel
Thread-Topic: [PATCH blktrace 1/6] blktrace: sync blktrace_api.h with kernel
Thread-Index: AQHdfBo48SfIbzhl2kWTtEG0S0/oUrc/Z3AA
Date: Wed, 25 Nov 2026 22:53:44 +0000
Message-ID: <b3af6833-9b6f-4a04-942d-3e14c4cb31a1@nvidia.com>
References: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
 <20261124134602.153239-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124134602.153239-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|PH7PR12MB7870:EE_
x-ms-office365-filtering-correlation-id: 532333a6-30d6-482b-f3d6-08df4b46f59b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261026140227099003|261028144727099003|261022105027099003|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 zkpnNAyqSpPotBaNxsTBWI02Lq5IydGnQuoZ2cnMSFOlr71iUTqdP+rYkFuIzuSC8PwgbDAVWYbSx9tGsP8L0lLBWVbPSmoqHxSZHw208rCNrWNnCJLQnmlGsDJwas/jgP+153f8so9calK1Ab5ibVW/sOdX9tD1ikbtdDzFax0a9otKE3SzD8iyRQ4qYcL9Z6noRCiCgV4EiTmIHzsdL+fiMPhuV5g8nN6sH0J2P/UjKopx48SDl0IWGH9VTa3ZSkDhAvZjMSGMEBRn6g+YdpEgCmliJsw6MxF4V8C/Jzytvm5YDaFxF1eDblGq3nlZsdsLgf/j2Qe/B6OygUmBgj9Jv7b6Y0FXGrgStQaN4f9V8PZQtmvFjzRTzwn/RdTQ83deFZPZni+NlAtEUs7q7pf74jkOOB+Z69Mqh/1ulsJibg5O30DEDlek5laIDNwEPQ2F0KQxybqHP+YkoKGBJm7fwoW5fRbKTVL0vasOY+IzwbJfs0kRUM6R4gQG4BZRY8X30PgRC2etzqRmUX/nM5gaQQRPJL/qvbEl2Izqsf1llp5t8fi1NCAQ4Crd/clQXMA3JF8F1+aet8Lzb9ys6RGALPzn2WgLfEuSqOcb2x8MqNtB5zfY12mtbEJe9sjcyoKH0ZZPlyBnHOTmjdzSXKgXqGvLmdjUYAI+SbVfesl6nyx+K/j7ZrveaZNp4H3Gdu+SqDT4o+NVBHN77fCVsTHgxmVvpClaNfVDJIaGal4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261026140227099003)(261028144727099003)(261022105027099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEVESi96c0VWcjB5Q2pVTFpXMVdud2tEVkMzVlU1WE1VTWdsSk5kL1V4TWZp?=
 =?utf-8?B?SWVzM0tmSWNZNSt0bnBvckM3K3lUSEo4Ri9tSGlqOHhSNUhGVFZiUzFodUhW?=
 =?utf-8?B?RXJLbTh0T1NCalVWOGpQcjNidENwV1hvMU52ZHZ6bmxXWWVuSmY2NHpMRTkw?=
 =?utf-8?B?SjNCYzFCZWUzQmQzemo4NXgzTTVwa2F2eFBQdmI3ZWlkbEtLeklVdU5ZYU9P?=
 =?utf-8?B?RmI5NUNuMUtVZFgxakNjTkFZeUtPMng4d004T0ZROHZsVVI3UE1rMkU1NU11?=
 =?utf-8?B?SkZ6bmM4NFpqVEdzYm9NMHJqd2FzQkdmSmFuNkhJVDY0YWR1Z3VXWmtFOWIx?=
 =?utf-8?B?dmJLWnFpTmZNaFlXV0wwNnNEQm5reGZmZ08wSEdRR1FoZkpleDVLZmtVYVlS?=
 =?utf-8?B?NVkwWEFWVTBBRFhWMGUwYXcwcHliWWVISzEvZEV3VUtKT1pxNis1c1R1M05W?=
 =?utf-8?B?MnJXSGJ1Uk1VZGpQMkcxMml3Q2NIUUlkb1RtNzQ2MFo0ZGI4TUwybnBvVG8z?=
 =?utf-8?B?M0RueElLR0N2Y3hKMUN2RDlkVHVQT3JsZ1h1ZXR2ZWhMUWYybmdtZ3NVT0dX?=
 =?utf-8?B?bzVLT0txTDNtdXQ5UGlvbkJEdXBNcmhyYWRvZHNOVCtESFB0TnpOdzJET29K?=
 =?utf-8?B?Q2U3dTRKbjcvbXhXQ3hoQzhSWC9BR085OUZvaENVN21UVkpiTENNN2RCZ0dK?=
 =?utf-8?B?am01STVSdUhyaG8va1dwb0FjRUc4SkJPL3FXbFplOTc1alJORVdoa3VHdGMx?=
 =?utf-8?B?NHZNRGRQTHRlaTJITEZmRW51eGZqTmtyQXF6dlJDR2d0OVJvZndxaDgyNVgr?=
 =?utf-8?B?TFNpeUc5UFA5aVJLQzhheENzVXBMdWFlQjdvMGN5ZnRFTU1tWitrQXB5SWw4?=
 =?utf-8?B?T2xwU0NqUWN0OGljWW9PTFNwMm9LZi9LQjQxUk9qUGZnN1Z4cjl5dm4vQUxO?=
 =?utf-8?B?MXVneUduM0UxSC83L28rbTViMzRiZm5QQkk0NGNsdzFpMDRjUGNITnFzcDRK?=
 =?utf-8?B?QW81dU9aeWY4Y3VvdlhqeFRDNnBmb0I5ZXVoUDRKajhQK0lCWE52dFFPL1kx?=
 =?utf-8?B?S1JlZHRUeExLOUxPN1piaEpzV0dJVEdEQUtCZ0ZyL0NIcTFXZk1CU2JqRzUy?=
 =?utf-8?B?RnFDMG1rQUpxdUpNODlqejREenBPeC81Mmc5MmFrTHJkaTZNN1psdG41cFFh?=
 =?utf-8?B?TkxEVnNIUXdLc01iY1NrRkt3YmdKOTU0SXBwbEoxdlMxc1J4M29GK1ByZ2Zo?=
 =?utf-8?B?eFhBMU8yS3h4QnFNRjQ0bk5hYkMzS0pROE81L1dXRnNuN20xaDAwZTJCSVdR?=
 =?utf-8?B?Sm8wYVNpa1FHamJwcTk4UXg2dU5VZUVSc29SV09VQnNlU2FPY01LYXFkMXFK?=
 =?utf-8?B?V2JaWmNuRWdxdUloWFRzdTFIQjJaazhKSjF4YXBjYWtDVnRjNkVsVmwzSDNW?=
 =?utf-8?B?UkFjb1VLSy9LbG55NGo0emJoZ0dTOEdwZlEzaURSdTlZdTU3bVFiejhZMWFp?=
 =?utf-8?B?eXV5TDJSeDFmSWdLV25jZzhERk9TTVFXNEJCdFQyVEVqajBZZVIyczRMSGRI?=
 =?utf-8?B?NExiMnpYQkRmTUd6WmxPZTVMd3lCaEpBWjl4OHhnUHFrb0dINHo3dzJtQVY3?=
 =?utf-8?B?amVTZkhydS94WWxNMmR4SVpQMkpkUVU5TmlRSWxydFJrajBmN2ZXT2tOTThW?=
 =?utf-8?B?aU9qYU5HblQ5dnlpQXRta1lBNjJuWmN2cWlIUmdCeDhDYXB0WTdQTDFXM1Jm?=
 =?utf-8?B?TkcvaHlWZHBSUzU0Z25kejBGWHdrMGlsWFA0NlZENUI4MUtsdlk4VnRlOTcv?=
 =?utf-8?B?Uk93ejJTMVVJM2dubXk2YVoxWm15NFpYSmxxUWFnTU5IY1MycGVUQk1JTGZj?=
 =?utf-8?B?UFBRTmgvYTNwb2QzYzlHbm1CdEc4MFFlWmJUb0U5cFJJOEJTZ1REb3dLbFN0?=
 =?utf-8?B?OTdZNW9lSTlKaFEvQzhXYlVTQXlrTk5LSFNVallQTDhDMHAwZGFuOTFTYkNX?=
 =?utf-8?B?YUUvSC9Sb0tDRmtEd09PZDRNY0JFQ0JBaDk4YkNzelBwVkY4ampwL3hUcEds?=
 =?utf-8?B?WE9leVh0VStmbnNpTkEvTHQrQ0ROak5FamNNcFVJaE5vRkRnd2NPMmZoR1hY?=
 =?utf-8?B?YmZlSXoycVltSVFWYUNPQlFaKzQxSFN0TDhOeFVMcWlZSDRIRWdPMGQ1Tk8x?=
 =?utf-8?B?SVd0bHdMa2Rtai9EMjFBRjJ6OXE5MzBFYkZCRGpWVk84WjZNU0JmUitDVXJz?=
 =?utf-8?B?THVqTGxaTWcwbGVOeEVSMnJ2M2E0SW9XRGhpZGEzVEhiRGozUEVSeXh4RHgz?=
 =?utf-8?B?WjFLV1ZSRGpSTnRHZVd4RXpHc1gwbGlFeHV2VjVMNHpLbUhYZjdhZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B28FA2E4B4DFE489D66D8EF75B85A0E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 532333a6-30d6-482b-f3d6-08df4b46f59b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:53:44.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wstgKSEkEAVfiFjg6BharZitXKxACiitJ5/WZHKjk+y/4NgDxvh/7VgIRt44XdTweIDEUEamMZ11XtFfHBLOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

T24gMTEvMjQvMjYgNTo0NSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBSZS1zeW5j
IGJsa3RyYWNlX2FwaS5oIHdpdGgga2VybmVsIHVhcGkvbGludXgvYmxrdHJhY2VfYXBpLmguDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybjxqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
