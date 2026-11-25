Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647394;
	b=hevSGdn+G7VQI4aOVM5kWIv8rGuarPXPcNbdIaG+MNEQIL5IA6dwzyfYDWSA/rEwysbG
	 t1xCDWE2+Jv6vaCP+P400OBSyV3bDoFmlYLP/fC0vpuypDbek2SMkgEAqOdH7hjmArnez
	 9ReCnlWTk/Xi1F2kSiyn7f9hGIGWeQXLG1BQ/W+sSgwPTdUHXQ9iJX/Hq6/0p2Y2V9mzv
	 cbH9OgnM+/hCuwvL0hElasErBI+YRsJCXvRgZrTeBuTgYfdI9Lfw7/Z/SPzsjmbAY2Ll4
	 STm1ozyK5WEpVOgs4mhqXb3lj8WoXavBuXO/54l0MAWVkKTD6t0QR19H5j8s1uDKhWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647394;
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
	bh=McEWqaGnwKTZ/4Wh60qAcHG3nE75pXZloBKRmmAcsbE=;
	b=vOfJxeRQ5Ibwhuik2Y4yoQSotom1keu9uJ7PgPPVL4+lachamn4WnAtsPLBP++mxfj0M
	 4atjTRISnc3bBJlIT36BZ4CKk3dQpVSEL/+JISjQQI45Q+L47eDdNgNEaCwmn+DfbPhLu
	 /0vM9HqyIZAE5ZpQv6HX1lu+ShVQgwEhNHZzwgdzftcjq8OM98A3qbcRYgo45/GnevTCY
	 cQC/5jlN+IhvuzMzImf0889OdCh2SV1Odki/V1cNDBngRljht+rr4gSwyVolCoU7uGrhx
	 H5YUyTindNo12NW8loFzVvFt/Bu7191AKKpfmE45+IVVwJytDAKf1fE5+Uf/XkDu2TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jHWpF8aE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.69
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A9606A33D;
	Wed, 25 Nov 2026 22:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 922A9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jHWpF8aE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpfeI9eN3XNDVJj2gYVeuIT/90DHkLKPx5DODMebU5ZkvykPVP1PO3F9hlNkPdEcCqAxK/M6NfKLT1n6Ue+98XzL5VcJhpJp68oMjThU+Fpxb5MN2C+OtCB+F2PMFwqjZ7n8QGxLLADt8LC5K8sFvFoyl3SSizlmOeRyTjYpvK9D1EG9+9FywE6kLNmZneczShEzW32BEZduNpsB3GyVcYZFnXYIYhGgS2x/n+pB9fxRNAEDL36n0UNM3gIbS1VIzyX/mrNiiBzR07YTAe8PGqExBVS0TgmOi6sL61ADH+cX2A2C+zv/0XR1UQq5yG55Bx/QLb/yeg7sMQcabcViXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McEWqaGnwKTZ/4Wh60qAcHG3nE75pXZloBKRmmAcsbE=;
 b=WBsXLoaqJx2J1ObSy2EL/NphB4ENghor76tFPxJLXGDhOuB8uhffd/nbr/GGRq0GCbwYF18rIVjlAUS5SiHpHkt8kV1hhtYHjPoDHaPVWMkc5yK/wgzc39urbl1VaKMm+UKY+BACX1j2GpJZsvPmc+XKDIz7rNWAF8CjT9slBgLC6B8f4W6jqrpcppAIrxZ3HXwef0FeLWnKi1cmJ709UTgVGRSHqrbCN43g/QWT5oxxCp6HaU5cqrsyPrsUHL9nih3aCyWk+whx6ennVxzrDB4Dp6YsUBX31wlHGcTD1YTSeLJb9y6OmwrIGkrH7v6gGSYOfxG1X/4tCMXl/l6cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McEWqaGnwKTZ/4Wh60qAcHG3nE75pXZloBKRmmAcsbE=;
 b=jHWpF8aECcViqBIdeiBwobdK4pV11+ZdIe6dfz/U5DIJF/cVgqQkJ23jOCdE9p43wfKKNPBVtEoOgyIsPCgOR5LREr0hkft4JPwWur+wqYLyXhKkC8tHqVN+G2umboylkPSDEYmOMvcggD59aYXEPZMmHNFQK3cNOz9NwHCbqBcN53uKQPW9KeyIRiB4XfHVOH0YDeBS3kfjLWHK+/Rl10Kq0j6zHs37DjL1EbvJRner9yGVPubhNzYXd/1N8sd9DuCg73U4tchLMr/pMIzQaGQzxFkKpA34v1JPt1xBnYWWrxi9X9QmWcM3RuH7tgywqc5vrodydywHCYQ8pFx4Cw==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:56:24 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:56:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH blktrace 5/6] blktrace: add --ioprio option
Thread-Topic: [PATCH blktrace 5/6] blktrace: add --ioprio option
Thread-Index: AQHdfBo6Hui7Q1WqMEmwN4I3T8zHI7c/aC8A
Date: Wed, 25 Nov 2026 22:56:24 +0000
Message-ID: <da963d0e-b00b-4c91-b380-66a6b71947cd@nvidia.com>
References: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
 <20261124134602.153239-6-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124134602.153239-6-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|IA4PR12MB590810:EE_
x-ms-office365-filtering-correlation-id: 082ba440-7022-441c-88b4-08df4b4754a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|10067099003|56012099006|11063799006|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 jELUpCF+w4cmJ3hsLMtI4+5NpkWj51JLA+wMuMOp3pCJm9x7sGXYo8Ztx0oPoG5jf3aRSHeXepjDaNagMwfkXXzoeyqHSjZIF4xN25g6Q+d4205e2b8+AcaY0SS7QmTkag5uBXeV4CvexaETjec4BnzyaF0aetcJnBitS3uPGto7IIof+LHXonk0XoMwfa94WKQHXcTr6nSiNMKvbTjXC5hh9EPJ5vkqfRNUPxaJq4VvwLjDIRkjA2UmXEPrD++qMtuD6Y/jxQD0a7ojZ0b/+N2XHaTd4maKO+LJGhN7mXQ1rYZW9ndZiVfzq7mlsHz7iw8IhvWCBXys4RSL4+PFXeCjTRFNhcreQq7CtSJZPXSM0J6HO/2Mj8JBcbfD62qG/deZ3U9uSb1SB9YmNKO/Ghdvct+r8NOcQ5c6GdAj3QOTjgKDZaMX3Byqh9+mFjlXyygsMh+ustWM5L0hzWAkrf1JcXqhlypgJG0uQ6Grm7zMca+q+wXbSb+asCfJ+a2RtMz15xu8ilMLZHkSrCydgwyTTyFN1s+XbJi1foFh4yfK32fm1FZp8tbmBICg7nq2Z96806jWpnBazgKOW7/YXUX4ExvK4BIhRHgoX9+TRZviSN+UrQ78swe4v6Vc4Rg3X5nlLM9olFrQyS9pYthRVcX1W0SPBlFZ8+D7t/qgvVeWeH/BGEF45W8gx+wXKHBG4TfIUD00CI47JqqAMbesYenM8dNNdfQiEagW57iAQ/M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEJqeDFKcVlPa2txOUtuM2JiQ3lNTVVnRzluU1JBOWFOTU1xYXJ2YjVMbDlK?=
 =?utf-8?B?d3ZJRWh2ckdCaDdQRmFrM0NkdmVOSmdlS1N3alk4MEZ5OTkyMmIyd3c3WXdU?=
 =?utf-8?B?Wlp0c05ZaU9kNlJBM3hKNXVZWVVpZzZnM0hWcWRxR2k3VzM3NU9YbTVzRmUz?=
 =?utf-8?B?Z0tuaXl2eGIybU9zb2ptUVBCSGpWQ2o1ek9JMFdSUEYxYUhTMWhPRWcxWGxu?=
 =?utf-8?B?VkxpYmRRYzJYcUJpUk5rb0xoZ0dpbXMvQWV4SEwxN2Z3aVN3QXowbHNoM1lz?=
 =?utf-8?B?bVM2RGZ2RW1jRjRhOCtpSjlRdWUvNll0WUNGTzRMUWx5SG85VGw0dnZ3d2Rz?=
 =?utf-8?B?NFRHcW03MGhPdzh1dnpPUzd2NmhIbktZUHovYnd3UWdwanN3cURtZnYrK2Nh?=
 =?utf-8?B?dkFya1VDODdnM0FBTVBPVGZrS0tSVCtRaGlpMHAvRU90WGswYThDVy9yVEl2?=
 =?utf-8?B?MTV4b3JJajRoYjJLUTFtd2pJTm1aQStOQVR1cFpLam5OTWgzRnRNZUdQalk3?=
 =?utf-8?B?d2RnU0EvbXY1dVA0Mk10KzFzSHVWUHlRc3dBM2tlWkxzUEg5NjRSSGVIcWts?=
 =?utf-8?B?bHNMOGQ5eS9UV1JHdVZKL2s4SE9TQlNZT0FEMi9oUktpYkhLQmlOYStnalNR?=
 =?utf-8?B?c1dmZkpPNERVenFNNkhmZ2JPYUJsdlZFRzhnRTZZd0swM3RIYWNwK1Btemdt?=
 =?utf-8?B?QTVFQjFhZ2FYVU41WWUxUCt6UHJiTDZOWDFnMHI2MnI5QmVBQ1NYYzVPYkZo?=
 =?utf-8?B?Znd1SmVIdzA5UXErZndldVB3bmVCdDlKbmFvN3FEay9OTjBlM29OdzBJMzhx?=
 =?utf-8?B?RnBQR2ZlZU44TkJNNjQ4M1ErSEFXRW1BcVR6WUdRQnY3ZFplc0RrN2VCMm1l?=
 =?utf-8?B?azBMY0h6Y3JuZmMvM3dYV3RCbENneW1JcE1RcjRKSncyL0V6eHR4OE1wc3pz?=
 =?utf-8?B?SzFETVJzTVVBVyt5TTJhdmdpT215Rk5FenN1OGRhNzZNd1dNTWMyREZLRUhS?=
 =?utf-8?B?UWNYSXBTSkxOWVFYY3REdC93L0trUGp1Y0ZucUYrNEpGbjlDdC85NzNYNFdL?=
 =?utf-8?B?a1B5dnhqbWVvdlRNeVFOU2g2R0tlWTZTYlEyN1hUa1ZyWHVzWlpySEg5UTJS?=
 =?utf-8?B?QXpOem1JNFhWSTlCU2ZzWFluUHFuVnZrMFBlWGgxelJMdUdvdW9jS1NCcWxz?=
 =?utf-8?B?SDBZS2l3NENTejhudmZpb3MvRDVGQW5lYzBTdUlmUjBNY0dnakViMU1JeE5s?=
 =?utf-8?B?UXYwVVdZWTFMS2FxSzYxTm0zaVRxVHBjRC9NMFNXMDBCN3NNRFFLVlNCcGJq?=
 =?utf-8?B?ME5aMTFhOEtuQlY5T3pUUE1nMEtqSlIvUmUxQXdVek9mVkpXa1IzblpxQy9I?=
 =?utf-8?B?VFhxRml2RzNFSGRUS1lpc290MmFTWlJQbXpOa3BoMDZuYStNd21EeXhFWXNq?=
 =?utf-8?B?NEQ2d2xjV1dtaFB5UlJSRy82T244WUVodytXNzJRL2hXcy9yL0pMV0hVL0p2?=
 =?utf-8?B?cDBDak91Z1hLck5XVUVuY3JrbkZUenM4S2h3NkpjWUJJREdQMzNsR3FQSlZJ?=
 =?utf-8?B?MWFSOVRkZFo4T0VkK2NLc0J1Tzg5NmNLYno5QU02Z0JQemZhUURBMUJhZjNX?=
 =?utf-8?B?b0VLNWtHbmZtR2ZLR3piZjZLcjdCYzRyVnZCOGpHVWhBTTVGOUhJK3R1WU9N?=
 =?utf-8?B?MkJ5Z0ZocmZzRFFwU29oWkFHam0rd3RtVXU0Y0g3UmVXNGFQMDUvQmJ2QjZY?=
 =?utf-8?B?WjdjT3lPYlo0RVRVOE04cnNPMi91dnRXMDA0VWFGVGROWWcwTHFpVmoxZ2Fu?=
 =?utf-8?B?NmRQOXFhNjU1QWxodFpDWmxCNm9hZ0p5b084RHpJWHNmV21XNFlIai92Y3J5?=
 =?utf-8?B?MXlURFFmODd1SDcxZnpoWmY1ZWFhZTFHS2VtNXRubEwvRFBab2JaRUJ1NVFu?=
 =?utf-8?B?eWRPcURRT2paNTZWMC8zaGZPdTZ5M1ZsUmhlSUlQQzhuNUppK3ZRMGVwcGlM?=
 =?utf-8?B?VDFTak4rNHl3N3RYSklVM0JCNjVmcm04U2tvTTlheXQ3S1c4NVlSSUduTG1y?=
 =?utf-8?B?QzAvTFNpdk90Z05JN0RCdGlYcXpjdW1qK2NhMGE5QmJVbW1vYVU2QVBobDVt?=
 =?utf-8?B?L3NvcDIwenlCNi81aXp1OW9UYTBiNTdBZUxPZVVZdWt6T2hYWnlpSWU4U1Zz?=
 =?utf-8?B?RlNlaGIrcEFjbUlOSjVWUVdheXlGM0sySEtkMEIvbWtKa2xIV2QzM0tCZE9T?=
 =?utf-8?B?NGx1TFpoYmVJZUJBNEJTcitoWEJBVWZFRFFXSDA0M1YyZVlPSElyRnhSaGt4?=
 =?utf-8?B?VGlzbDRxcHBZUmJGRGtQL3ZFdWxSbHkxV3RuMnZLbDhPNU5Gckh3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0627E862BFF28F478BB919002E4ADFFE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 082ba440-7022-441c-88b4-08df4b4754a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:56:24.3994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8GnQmbdjcI1qFQbNePQ6QdBBEbsUiK32wJTo1jhg9H1OIsPuwpvgPGDUsh3v8hcChjsoFxUCtgnQjyLL2zfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

T24gMTEvMjQvMjYgNTo0NiBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgYW4g
Jy0taW9wcmlvJyBvcHRpb24gdG8gcmVxdWVzdCBhIHRyYWNlIHdpdGggSS9PIHByaW9yaXRpZXMg
cmVjb3JkZWQNCj4gaW4gaXQgZnJvbSB0aGUgS2VybmVsLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBK
b2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQoNCg==
