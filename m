Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647694;
	b=L2QACTDbl+CvvThFP0CVXfiB5+pWZ4FcdIHDIA9TfrVuH5T7KMZrbgwLl7qKRSS0ORp+
	 oPUhnzDu+P3g+vTmMfoOPLhjt3QYnTfEKdCdq4eirwmodPSz+xsugJx2n69sdOoxu/dpx
	 8FQ0bBqBsA7cUl3dMqk7mW4uCgD4wgY3B5VgsoMzn6LpE6oRqr+Ytvrbu2sZ+anvZstXZ
	 zIC5+Xn5Qrf1oScE4rXJudWlEirluw5QIMuQykh490x5vBj61FyXGWxt723vngPsbk+H0
	 GM/OB5Dwo+67UOL/ONJjzeHFCIf8oVJbIC6TSQwnU8qXPgb4xUjUfAU9M15l56D6rEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647694;
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
	bh=9dDYwrFrhxKqJGZ+jWJOLpKYGtnFYgr8XVD7X6MrYFw=;
	b=jpQLy35a4NB5zF4NqPo5c0J22zrtRzeWhfWddccolhqGNwOvGvZIucM4ws6JqGNyk9cd
	 s2hlA8dQVfdzURlbWBWDUHVk2KfT23teYunMqXxmrGlp7M0AHjigTBvP5Pa/+zqfQ5Mkz
	 0aBtIwaqJhPK9SZpFvo+RNtAkrRUtN+ZiNJEIwaneP+ZvUNyGHJyZ+i75ksSscY2VOHGF
	 3/pvCr6xeHS6DFD4U9HuwH9qyEDr6Y6OfMwRBexrUgPvf/D9LizHrxTfKex9h3GbyBzvQ
	 z0C14fzmXQycej6/bRsgEKIZipfOGLfI2pR2geyWHBZgyleXdw5y+S2+5FVZBoB7irA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UTcW+vhQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD030606A330;
	Wed, 25 Nov 2026 23:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD030606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UTcW+vhQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rjvh/CHl67MfufxPPUEZUDC8nVvOQ/dPRTSGYWfUT2rGGIMgwgqsEZKmNQeuvell9Se2FK2t9ygBwrdMRXp8B1Zwt4ijlt8pymQV45RyVJTyXOlhevr4cwCihA6jZGKMpOuS0z6DQxbBd0UblMJiSQ4hl/Ejo4sz5va+x0zHMVYY+Fn/AyT305HJX4WkzWstq049ga0zUTMh5rdNmZdA/AG0bWaPYseQ/qOp2QTRMI1Pqe52Pi1KcmvVW3WPpU3mxuH7wvdfhq8QErdgCHVK+KUrEA54fH6BFi3N2Cb0lb3ScSiPA6JbHbFC/ho4nQ0HH5LAjiSKXuBikXiHEAox3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dDYwrFrhxKqJGZ+jWJOLpKYGtnFYgr8XVD7X6MrYFw=;
 b=gIZwFHWbDU0OBfOr/K7vkQKSlT1fc4tUcy5IaEOzyBMD0P9EfJtDnX/7uw/7ZoBYVpmZ25XlBEMzwQpTExQ/FRl0OUc4pcekwhHY8OB1fCAuqOLIpi0zLJOEFiTc5tdBFqH5OrKgQByeV2FImQMilzLg8KFTz3huO7hw/iiH4fODzntL6DG1ryMhJiAoEaqotOp+7zl8VpyD1EliXt+J0xRKfR1/C6d1RSJvyCPO2R/SujZSAlyJYZiE4k6Z+dPab//qAi5/3CE+eZf0HfNe3/xLRBIrBrrEA27qV90jfZG9f1tkew8BFyrFwm02Ee/mtxZSTDF7HzHaM/Zqe+4LKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dDYwrFrhxKqJGZ+jWJOLpKYGtnFYgr8XVD7X6MrYFw=;
 b=UTcW+vhQQRy5RkRaEk65qRxcjwMz7Bcv5zjAOLAoYUCd7Xw6nXn4Wmvsms0+vG5MQjZa9m/8OKa0ss6ZS3/pY/rfZKVuKJ+JtOiYeFuukitYmZtrKBaX5cXqEaSI10y+VFBmJ90xWF7/VNHzQXhbGr+kfBCTZMsehWZY11bjU8iSghWG9s53xuaes9+mmbGdM4P/TOkZyjFDHMiQlmkXkPiDm3LRnnfRUgrF+tVTaAIBD/qyrDFLgQlqvIdbGCjAB+arM4noucwm2OaU9IbIYUjQ6NY+z5BhhXhIltLSVoLAPMkMJnaTUj3ImUjjHpwrnvI/78hcBWRyg1lj6H6RoQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 23:00:50 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:00:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH blktrace 2/6] blktrace: add RWBS for WRITE ZEROES
Thread-Topic: [PATCH blktrace 2/6] blktrace: add RWBS for WRITE ZEROES
Thread-Index: AQHdfBo0XQHJ19UBl023fZsIwf/SJLc/aWuA
Date: Wed, 25 Nov 2026 23:00:50 +0000
Message-ID: <05f3a029-36a2-44da-b18a-e76f2ef9b2ff@nvidia.com>
References: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
 <20261124134602.153239-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124134602.153239-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: 04033734-43fa-4fb7-40c4-08df4b47f30c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 t/R9cJJy/Y0/iCYuD5ar2s0FZigXW10PfEMwUv2os7cmKgUNVXNhvejRAm0soRnwy974XLyCiVaVDB0I1iVFJZDvIaCxyaC63aKqFRXOMbwv7DTaCHoUO/NjHd3evoo73+7Pyl0slGjeD5/rJ0hD0EP8lOF7f1ZMxLOfTr7qgcsen1E+y56uuhSYnLtuaCBd3gPe56xTc2hbmAaLNKicoU2vrFNHIKzgyqN6UoNvbvWADsbKuBPN/WamjnLjWfa+vX2Wq5R8fSlfJxYkof8bDXGdTO0ASTo1kuEXXd0JmUd2aTHc2E81FWobiv0ccx1UTgM3mwyZvVDVTCENkxz6eeXe/Ju/ZZP4SKTzrTd9STMk64rPIIgXkgxey7pQfHSjBm6ssVaJRKYe4bglsqtfOimFgMfY6mqvmBVILvCayFFonITcfS7C3F4KSeW+1plLDfLH9+3Op9EAnshPTrFqK8Cwt05kL1INcOBJqdj1n6lYLfQXmKrimUggMgHgTxCIhMmHhycrXHESaSenKdkkddz85yr8Ew0Nw5x3z/oHnpOyof65rZC/n0BhEsH8sy161D/EwTaMNeKbTWC2u0d90JvsY1hgmaRzv1/5AQ0oKNKVky/o4Gxrvl+O0xwMl3Qyytcf6mtGwvNtRkiLwAS6qttv9MRQBtBHf1zqNBTz7q34QS2Myl4R+JYeVnHnbg5VytUozk/iFGZJBZcf4+YJ1iV1JMV0rYJm98805RizCiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0xJREtOYUFmWFBxN0hvV1gzK2MxWnBwYmhxVHZzam5iZ095OU15NmNMR1Yz?=
 =?utf-8?B?Z1NxREcwUEpRd0ZXMzIra1ZLbjBidSs4dVZwT3RINTMxemdXS3RpL2EyRU50?=
 =?utf-8?B?Y3drMjJlV3NJNTlMZkpjblcwUzc1ZS9YNGdzcDhleXQ1b01ZUVBEbTFYb1hp?=
 =?utf-8?B?aGpwaXFFUDZVVHQvSStCbFYyc2RYanhSRWxtcXlCT0Uram9GOTZxTHZ5Zm0y?=
 =?utf-8?B?UlZMSlNwYXBtRUlhOVhid3JPNlF0OXNHZHhJcjNrQjl3TjJIZVBnTzgyRk45?=
 =?utf-8?B?RmkyeG0vNDRIOEdFejNnUkJhSWoycVJveEJibkhVVE5JbVJXU1FOTDRxV3ZS?=
 =?utf-8?B?aHFKWXdtWVBvQUdrR2RjY3haSUNXUTh3S3ZNeWdwVkhPbFlTMEZxcS94Z2RC?=
 =?utf-8?B?OWVPWHlrSUpYNEhGV2gwdjhCWXdQd2F1Y3c1RjMzVklBbVcvMVhaWmdvV2dh?=
 =?utf-8?B?UHN1VDMyRnVOMFpraTMwYmU3MU9oM095cEZNQnF6ajVFMVl3UHMzK1Z1Z1BO?=
 =?utf-8?B?Y216NTdCLzR1bW1iS1pma1RHeEdVNUFxVHNPU0NOTlJqbjVOTUhiNzl4Z2Rh?=
 =?utf-8?B?MXd4b2lTRWZQOVJZWEV4TjhDTTdoV2tMeFlSNlN0eE5LVDZWeHNudHVEeWFk?=
 =?utf-8?B?U1pWaXlhVEtsZnNHKzRDckcvNFhoL1pFN2hBYUVMVlYxWHNuaVg4L3JGU1Fr?=
 =?utf-8?B?MjNCbndmbldvOEd2WngyaE8xTHU5Ri9Gd0FYbFJaK0JWSlNkMUl4K3VtVjVl?=
 =?utf-8?B?azdtYUNaa3lMOUtENjQ2UGhSU3c2Qy9WSVlDRjhCZkMxNzVFSUNnZks1UFMr?=
 =?utf-8?B?c3hwQUxIa0NpcDlmclJGbFV3RFJ3cUhDQTE0RzlZVWxoZ1FiRnJGdVFvc3Bn?=
 =?utf-8?B?cFpoa3k2ME9PQTk5QzRMVDJWNHZvb0praGNxVVdvYXMrc1FwcVhVcWF0ZGto?=
 =?utf-8?B?eS92cmp3c0dRM01CTVU5di9zdVA5eEdUeWtobW1HREJIUXhXdWhHYzV3aUVk?=
 =?utf-8?B?ZGc1NU9jT2FZYnNiTlVSVkdpcCtDMitxZzgxemx5aWRGR1dqeENtUWpXdU5P?=
 =?utf-8?B?cXU2ZzAyR2dCMFRaUWpGenArS0UrNWVNUGwvcUxvamVOV0RUOGJERlF6Ui9l?=
 =?utf-8?B?R1liSTc5dTVOWEsxcWlFaEdtTmtEU1VuZ2NJZUR4QzYvbFVReklXakpsWUVv?=
 =?utf-8?B?THlQeEl1RlM0bnl0UE56c2h5WTRmRHRsYnIxWVM3RXFVejFvVnBTR1Bib2J6?=
 =?utf-8?B?MXkxSFVnWktlRkVaTGcyMkthdndGZWtzOUFIU2Q0RjZjOWN2Zmw1UXhCZFBO?=
 =?utf-8?B?WlF6Z2N4YVZxRyswTFV4RGRmclBhSWt2cmFlL3JSMVkvYmp5OW4zdS9qYW91?=
 =?utf-8?B?a1ptYjNQdlkvcVhvQjlLK3VNOWZwUUZUZ3Vpa0gzeklNRnBLRVpyemlvQ0lC?=
 =?utf-8?B?YnFqdDZOdlZQdjc0a2QyU2ZOOGJVWUpOM0lad3BLd3JjWlEvd0w1eGZOUnlr?=
 =?utf-8?B?aVpPVnVTRENGcDFBckNiUUkvSXpZWDFCQmdzTGwydmR2Y0M5VEpuWDArUmF1?=
 =?utf-8?B?cHhWaWlmVHhZOGl4ZTBZMU5ZL1poWUpxNjJBZkJEaFl5UzNVVWZDVVpZTDV2?=
 =?utf-8?B?aVRmNlFkeFdQcVFBcnZZOTg3UnFjWTlkUU9LcDlCWk9xRHNqSkdOUllzZ3oz?=
 =?utf-8?B?a0o2NDYwMzNtd1dVcTlWdTFsRjV0TjJuc3A5ZCtVOG81blhtUzN4OVdtbFB1?=
 =?utf-8?B?ZmRJTlNvekhDTVpvT01rVHpHV3JsSlRrVzdhZmtqVEd4Ni9aSTZ2aTAvZXBp?=
 =?utf-8?B?UCtoZXk1ZWd1dEZOSUE2a0ZBS2kzYUlpZ3dEMkExSEMrWFFaeGlqMnJTejhE?=
 =?utf-8?B?MXY0SlYvajlzZEo3R3QvbnBXaVBycFdtRTJsZlNjbzAyN0ZCazM2aXVHWk9h?=
 =?utf-8?B?bHhFTWxsVmFoVFhVL3BWUWF1WERrWW9Ybmprak92VzFSVkRPbXVTNWhNN29q?=
 =?utf-8?B?aUZMVkx3VXVNaUpxcWkySk84MXFVTXRoclJ3WHlBc2d1UE5YakYyMmJXVENW?=
 =?utf-8?B?SUs1VHdxR1dnQyt1WWpQZUlQQW1SRkZsR0djdUlKdmlkaURBTXQvbDRCRUdG?=
 =?utf-8?B?aDlSS1EySTd6UjlJeVQyZ2FGelRmT21UZjJYeTV2N095Tk9MVGpVZmo3K2M3?=
 =?utf-8?B?QXBXU0RmZ0htMDZqcFZDOENNTFg3Q1F5Z3l1VUtXQ3FzcGxZQTkwaVBBaFA3?=
 =?utf-8?B?TThlMlFxdU5NakowZjZIMDIxcjJtRldWZTE0aHV4SVZIa0xVNFJPbFh5c3RV?=
 =?utf-8?B?dXhCWXNSMHVqQ1lJWHE5ZVlObFFNcllmY0FMeGgyYW95cGdJVWM4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF83AA46E5F0A542BA62F2451FD21BA7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04033734-43fa-4fb7-40c4-08df4b47f30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:00:50.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54uACe8zbIIcYk3zptP6xdOP3nID2gdzl6CYe2TBexBwfUFS2AfS3IFIgW67g4F4Asd2mjS85oo3waxZngWExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

T24gMTEvMjQvMjYgNTo0NSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgUldC
UyB2YWx1ZSBmb3IgV1JJVEUgWkVST0VTLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiAtLS0NCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Cg0K
