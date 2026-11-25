Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647568;
	b=jbFW6CqvSko+J2kLcDV93/leWeX/Btav6FJneyQYqj5v0G1igNorK+Qyu01Yi6cO3v6E
	 Zdz7eA0QPA8br97P//Yw4DRNsQsQ/aLXae5ZplRuU8/DwZbkw/6lT28ZKqvaF7Je9T021
	 QhpyDS3CeT8RMpDfWfNhni7oIJ+mTjgmZCab1zc6FA4Ka6V4DXp0Miw6U5b/ZdExHA64v
	 OzgTP+YT2KkbiDRpUEwpokSJXATfs2MwlZRGNrVWxeGzOFKuBl6OxuysLipkfoVpnkjwI
	 RoL+B+rHYKqaBnWyu+7VNIVUN+S5UiTwCD8153ifhwfP9PcYvrTJ3LonaKyWpNS+ZMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647568;
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
	bh=2/YBYzO5aPwtPXGZisurWkdrbx7sKWD5StEfF7WLP3w=;
	b=B/IwMsjxXaX58OGry0psGj/V9t77W8vlrJ4yoBSHUzuA18I/fs3XCyTmxSeBjYT9FB1V
	 m0K/uu0e6FQDoGjK5qRDx5wV/CaE8YNS2+S/PtROjc7dN46Svhkh7cfywvzLYtbj6ecdq
	 7JKFv3ppI/ifV4vQsM9H3Sx2y6a2fcw3elY8FheeE2Ksr/IiDCFbYvX95AJH7hEKFRXLt
	 rraHWSiHKnDMUkNnTgTnPKmgQbXYaQw87QwIYCRN9rU2U45usNaLJ6jivmnYKr9RwzHp9
	 flOjIyczDPVxhBbYoqjnyHHT67OCjZFS05e/oveVtmQr8K0jDwANU70cA+nnfsL3bGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="LUQt/MuC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E965606A33B;
	Wed, 25 Nov 2026 22:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E965606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LUQt/MuC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naYVMN/9AO0OCIxpY4t9sdO/QLAx0tR/BSHJ8/RBJfHWJA48ndKaoThYeIYuga8+0axZ7AdcZf5ctlAtWv/D+P0f2rys04J9W9sZYjto4ayrINZYN2FSxDF7CM9IEk8AOZFf32TQHSmpQDIKc/O6tdv7DIthdMZxudBXnl6WS/fdlitHuwnS0TEdIt9w4BKi+lLBYsBftjRZi7ozriG13EFa7yBhTXYiyXQwenI6Gk+rxnYZVonwcVxVIpggaWlf4P+uiW/J3RbT/HEmEDlQUMEuLQTVeVh8aLPsqvcwEoi2W1bwcUsbClD7t3AP4Dj3Qz1QdSjAk4Wul/Aw1WqYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/YBYzO5aPwtPXGZisurWkdrbx7sKWD5StEfF7WLP3w=;
 b=oTQkQA/5aG1Br2G76U+s5onqdAwYLpSUoPi2vE3OGArRK0RzO67k7oRnIaUDDD7NeXMlfpIESnm2+76QVAZnqAcHV3Xu0F3lEBPJcPV3kgYGhmmTnLJ+xTDm30v9iKf0+5eha96Bwr8VM9U/AeWG60KMhhLi+CpbIban1uVkEb+auwpz9Q1U5aGOmoYi8E+QCu5MBURFvAGEyr3gQNP41ioitp/pO6VkL0vtv/TfNg9OJcLqPak1HE77yLyCZ91dHXOfXn32mh38F1lUOIjcnrtISL8aWOOcYDd79IzoopKgG79IA/91dyMGyEAolgwLv11xg2de2d2v8cCqYlwl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/YBYzO5aPwtPXGZisurWkdrbx7sKWD5StEfF7WLP3w=;
 b=LUQt/MuC6mnczeglvFHsyDEudCCWc/NkgyV1P2S5av9WxMFBnGjbgmKH7gHLDTXzbIMkJ9Rybvq4iQEDbz8E21tfu5jHTVGXLZE//8+mpPca4ThAJVak0wj3IbLl1UwxXPa1gpwPNmjHhCY+wzKLY4Ghu+9nPed6Dy3Wv/L2X+VGnbyjehTwk5qwcj5Da7r9cYrKUd7MIj6epRzj0AQHI513PByvdvy6T0EZJRdCanW1gE+0I7u89VhQ7PvqxTcD6kR4hjwbefwD8760onTrfOd6nSRjZI7GYRaXvsCzkBmCp8h1cQwIABPzq0b4TRKoqXJoHAIxgDK2F8hTBsj7kw==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:57:20 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:57:20 +0000
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
Thread-Index: AQHdfBo0XQHJ19UBl023fZsIwf/SJLc/aHIA
Date: Wed, 25 Nov 2026 22:57:20 +0000
Message-ID: <c91fa97a-5da8-4b6f-ab05-c3dd1b3809ca@nvidia.com>
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
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|IA4PR12MB590810:EE_
x-ms-office365-filtering-correlation-id: ffd0429f-b1ea-4956-e481-08df4b477623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|10067099003|56012099006|11063799006|261026140227099003|261022105027099003|261028144727099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 E0ea8IVTbgYcU6SyqCSgMxRWKnZPRCSy5yQTBlF27MJtdEaXpUmUHfy902bY/d5gIF9eb/6WNRUfcuN9R+4DD+zTGmoI2XeKwKX6xmz0OJLMysUbhxj8H9h8a0jz7CY39OTmL9a+XFqCiS0C3CJeV1RXJNs4dZksnJvpQ+eWLEmydWVUzmSAsdsEn/MjfugQgyGDejqZCVLkX4lhiQeYJxOfirTeMUesZahvcR2oqkUD79FNCvp2yHBgwPOyfqf0rfR+kViJu+5HEewKNpNB+iQ1MYwX5gixINVU1WF969IqFb5z0ZCH67oKs8Y1LoRVgYP8aWm8SCjtG2nrBsESuQv4vZXfRnMGxMTPQoOTFppJ9epdzTPNRQ5mIwDZQHN+evNXtEKkZlt9dWslVQqwU6IJK7yttFpDPJ4LRTUls5uMSHi3hRjSRwHsmxFjzqvANijNGLTDl/zVe6hjqfxWlV0LZ/TLAWhkU/O+L9NLvC5i0XzY4KAUrkP0f64uvm8NyO1gN0qa67LDXzrwH2J2AhS5l/359js/ehg9U9654FsgQG2iOU0LD1Qm2e4Xv/rGXGbI+QSFQu+//E6O+KOkJfdtkMWeUiALOZjOzhPNdceRWklRw7Jc7alP8mJZw22mCj+YbPbCMNt0yi02l5fznUAnvxpjw+H1SECnqKfbnsMzj527uPLt6MhU4U34BHvIAl879CCeBjbhXMmY3M0sVkoHeE2h/bzE8WG4uyQiaC0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1NHRE0rVW4zMHJaMEoydWlpLzNzM0R0QXZiaXZ6VGg2c2pjakJ3eUtQcE5l?=
 =?utf-8?B?S0VLRHIvVXpxTGxWVDdwWmMxZFdUWC96YzljMnpOdUdvL3pWSUpUUllha003?=
 =?utf-8?B?K1RFS1ZTaUR4bkhkckhIZTJrMlVhdnpqUVdhUUQ0Q1Uvck92d20wNlRjMlBI?=
 =?utf-8?B?RndsNWxSRzJwYXNiamk2a0lFMENCMnZEdWlIQmd1WVpGekhvWVlKQmhqWHZF?=
 =?utf-8?B?WHVOeTdIQVZMVUZPaFRSOUg1cjRuOXFnQWEwd05wWjZ3UUJET0pRbXl4eHZx?=
 =?utf-8?B?THc3VGJMd25pSU9NaEwvUnZ4dmhJSVRuQXFZYURzNnZUaCs0NG5XUTlRZjNP?=
 =?utf-8?B?ek1WUDZaZVpYMndVVXRvZTJidTJpYnFiOE9xVFVyZHpJVys1ZkRObmRPeS9B?=
 =?utf-8?B?QXNVUHNMYmcydk5rUUdsWVBGU2gvdHREMmFaM2hOcUFrd0NmWVlOWTVOaE8v?=
 =?utf-8?B?c3BPQWg1bWkxVHNSOTM4bmdaYmhjQ3dlWTlRaHBFeGhXVTlZMVlDQStRS1JG?=
 =?utf-8?B?N21ZVlNYL2xmcHdIZ3VPK2phS0J1U0JobkZYNVNoNm1YTy9HdWpxNnpMb2Z1?=
 =?utf-8?B?T25lNWFmT0FUYlJCaGNRZFdlT1IxOU9KM3RSTWxCUElFY21CMnFIOXZxaE9R?=
 =?utf-8?B?VHd2bzJnK3BGVHdiMEFWV0JMR2ZVNm90TFk2Wm1IZm1lN3lPT1dzQ0k1b0hW?=
 =?utf-8?B?bndGTzEycW5YWjFYakp5a3ZFb2tjREdrTm91SDNscThjNnJVZ0JWK1lPUWVB?=
 =?utf-8?B?UzFJa1lVejdCNEVQNm1vdTg0aWVoMGFPeFJ1a0xIN3V1czR2M09hZ0pXSVhL?=
 =?utf-8?B?ZEtOeUtUK3RwY1hBYUROZHdiWEVkMGxGV2FES1FuNjFhMWVxT0NFcFE1K2Zu?=
 =?utf-8?B?ZEg5VjZvZDA2cldUV3YrNkZjRWhNM2NUZWxVeXhSaGp5dWVqZUZrejNwaGhj?=
 =?utf-8?B?TTRvUXNZK3hQK0J2MEZnSUVzVFNiVkJBZlpMWVhsbXh5RFZIaTZWNHljRWR0?=
 =?utf-8?B?aHJXbXR3WXFJWWFxZnkxWlk4c0Q3bi9PRWYvMWt4dExobVFZY1gyNndwM3Q4?=
 =?utf-8?B?TzBzSEFJek9HcWlVU1A3N3pjQWVDQ0lsUjh3ZmFJNnRJUmZma1FkMlhRMWlo?=
 =?utf-8?B?SnNlcEJWZjFFR2ZqN1Y1NUtYODJUUzF3eExCTGt3dU9CN0lQalcvS25uMTBm?=
 =?utf-8?B?YlVWTHBuTktaNkRtay85MjBoVVRreFZJbDNnRjQvU2VocXFTTWRZVnh5YmtL?=
 =?utf-8?B?eklVSnYzZVpvZ0RuY0RSUlE3am0vYlZkeS92YXJkUUtRNS9DdndMVU11S2kw?=
 =?utf-8?B?eUJrNHBKVGVFdHVPNDN4MC95NjZRSjNjeVFobHMvMUdOejlReHFCUjlJd1l5?=
 =?utf-8?B?cHc4NTFWcUp4eHdKMkRWWStDVU05eS9QL21NQmZSSGhsTHU5M1RVZFJnMU5G?=
 =?utf-8?B?VXE2NlVSaHN0VklwZHV4eExHTk9keE9nUml5bXVvaXFCREE0MmxGWFVXQkFK?=
 =?utf-8?B?OHV0ZmxXYzB3OEo3M1REem9Oa2E2OXJIb2lXc0lLYnNYWlVlV2hzMGpMaXpx?=
 =?utf-8?B?UzRRVGI1blhLWEdoZTNhUmx4RElRa2doOHpabnRmMW1xMW9XL3pVK2JOa2N2?=
 =?utf-8?B?Y3FPWVZWRTBDV1FOQXh0aWc1ekxxclVSejZyR0xwRml0SlpZaTU5OVF5UUEw?=
 =?utf-8?B?SUpVUHowaTdlN0E5aTJMd01xZDhIVkFlcmZTWDNrazk4bkxBOGpGVWxsbWNS?=
 =?utf-8?B?bVpzV1Zwa0EycndqMlJ0VUZhVUROUVJ6cmo2WFpoUHlraDVESzNnUlppdTVM?=
 =?utf-8?B?V2ZaVmg2SUM2VUZ5WHFlRHZDait0eEpVSG1IeW1sa3ZkMXJxL3h0Z0ZFYzcr?=
 =?utf-8?B?Y3EwMnVsMkJYd1RFTTBRQUFJNDBBSG5neCtyb3Z6V2Z2WkkveVBlaE04RjZU?=
 =?utf-8?B?UkJoaUY2R0JsbENKeENLbjZTbDQ5MU9mb052UGxnTXllalJGNGkrdW04OW04?=
 =?utf-8?B?S04ybHNqOWFjSXlPdFdSVnlyUEpHUDh0VVduSENaNkNVdVJIajBmdjlVSlJF?=
 =?utf-8?B?QVFwOEsvbnhzRXI4a1NZb0tHSmZhU0RZVjBoWVlMRWoxeU9DOS85NHRJaGR0?=
 =?utf-8?B?eGNKb0NqaXA2Vk9QaHVBSzRnZlM4UktENjljdnNVMFljWkVOamcxbXIrZ0pM?=
 =?utf-8?B?U1dCSy8wVkM4Y1htdzZZRWMvM1JHWkZGR0ZCNzc2SDVFdmpCS3FKRFh2RHNE?=
 =?utf-8?B?NmkzYkw4enJmTFVnb014bXEvcXJGYmhDZjNBM2V6cU4rMmpsUEVPOHFGSzNS?=
 =?utf-8?B?T2g2Q2RFcW9YZ2JqOVZxYUdRRGtlNHBRMzA3TFJhamZteXg4U1k5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E91AFB8340925488AE6FCB4CA379451@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd0429f-b1ea-4956-e481-08df4b477623
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:57:20.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUhJGKxF1TxVjBIUZkK9Se3maksolbkTVqb5dGPo+OP34cfRuIOVILI7YNubAvlHDLUvFI1rUl3Jw0cNbM7jRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

T24gMTEvMjQvMjYgNTo0NSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgUldC
UyB2YWx1ZSBmb3IgV1JJVEUgWkVST0VTLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBU
aHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
