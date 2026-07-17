Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF731B838;
	Fri, 17 Jul 2026 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268287; cv=fail; b=BQiRbSO080F5dou+rXrGwLi3A5S5hWPtkjsuFc7V7SqZzZTtlhbOpeJ8idF/rK0ZNzm2Tp5vUnvUu3z+giphZhnXSCWdO1PqVP/KWmjO3YAW8IOo8tEqzQ4fHTz6uN4Y2iOLT81z6wbQhrVHb7O6xvc0P4CMiGMNGfBBd2/31k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268287; c=relaxed/simple;
	bh=TkzlSoI9YH/Gnzns/J6kUSZUKDLHuqE0QAhHVRGGn5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KlNEJYOmBxwaMJkU24Jat96OQpCUKDQehtKuCN/YcLry8C8wFOvogPwsAh2eEtrBnHbwEVdWeKyThfeiv8gIA9V0mlIiNWggs4MR+jDVQrjpf5b67xGVfydWmxamNDop+I4y2jx75tAcHKz3jCqEZ/R+nAwFn+gTtFDv7SvFXyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kuSeZI5M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j7cgZVaO; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kuSeZI5M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j7cgZVaO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784268288; x=1815804288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TkzlSoI9YH/Gnzns/J6kUSZUKDLHuqE0QAhHVRGGn5Y=;
  b=kuSeZI5McVAtaposJpX9TeCE3PxcDojGVh6q02hXdEyrIL6Zk2L28wml
   zICiWjCxHjiYpRbfm5UonsPP8Ye0pGhjBYOfJRg5kutwh1xoP0ylDJbJT
   BwSJeo8lj18ujUlFGUo4lEtRWLE+8+YMZWXopBFQoC1j+gr6KDJEAurvj
   fZmgeSH67vmRXWqoL6W5hUJmrzmTdvAq5wEsru3RXTpK0LA8XVX+yxbfF
   1930SmWIbt32+8YZVqn1azRp1C8ttrPcR2XbXfyqsqZEIBRcKtSBewXTI
   Jb2MgaUvU52OH96w5jaNrUc+qBvg1saT9iDSP78mazTkS4BCXPAA2C+TK
   A==;
X-CSE-ConnectionGUID: 0Ebku9mCSFC0UnYiEo+GWg==
X-CSE-MsgGUID: R3Pqy26tRuO2ehQgNh1h1Q==
X-IronPort-AV: E=Sophos;i="6.25,168,1779120000"; 
   d="scan'208";a="151209255"
Received: from mail-eastus2azon11011044.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.44])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2026 14:04:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah85EGOzR1s/K+4JoUkZca55e5cTFJEm57Aj5py5IBvNGWKfEie+SMJD43bZaKsyxKwt5Iz3DldDZ5eQUfubmsbKfVvnLakaPD33N2N1104R8c6Ry1l9lPbYoNO6vwM4zwqICO379DVFmMvXXu2cCh5SnRn5TeKQaPuRWQvR8Vr3wB2fmgJ+rtivMNH3NhK7pd0vbk72tcKSgVhj6sE9qyetFqeusGbDGTztsIFh/LX7M7PUN+YKpeekviIts5cMoUt+qF1LFIWmhG5F8V6NqNrrUBoCqsD7H+glDICbFWfUj6DG+ZUliaJX/XqXuDrNwkZxejzv2lBbFrxqEqg++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai4uyRpOb68BkxOoTOb43dLu2IhTL7tMY2+7+QVsGks=;
 b=eVz9WHXFJF0p0/Cb76D0dgQnP9y0CQemQDVLmRcdyzSkATGGuHKTDRNexXPYmKUVmYSDBiE0xDcUANzMjS6QEv1KxQ9PV1dl4omBb77pi/XDgd901JrCWxFwSqvDct/EZeGWM56I25rXb9yfKqUfLXJGubuXnflg0j0M4ublDGO0Rdknuol9PVYp6wqq20DqC4vBwxfdihYFuVesn+0cypZUMq3ffalsIfmfMOis24xwTnUgGkCp/Fjg0mlN52CHa8fXL1LTGUR0tri7se+JgVDimE2aVzHj9hYeuOF7ziiW2xgSC9wb/n0kgS3xntc1jjpgBAQ2QarnIcf8QRE5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai4uyRpOb68BkxOoTOb43dLu2IhTL7tMY2+7+QVsGks=;
 b=j7cgZVaOCvUM1OBVI4kDZsCJZ8jtNV9quiQrTpLICDtmNfy8DrC60Gi8jPHqDOHL6ifU2ZVARnw4817bsstSNX54LFlf6LuW59PH1Zc45rs7f4fcSCKb/yQJZLurT0M5vEJsok9+TTE92fa1XpBrfFwaJMmLoJ/lspXjmYDREbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BY5PR04MB6375.namprd04.prod.outlook.com (2603:10b6:a03:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 06:04:41 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 06:04:41 +0000
Message-ID: <7a57255a-164c-4a0b-8225-31ebdcebb5d6@wdc.com>
Date: Fri, 17 Jul 2026 08:04:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] blktrace: add option to request a specific trace
 protocol version
To: Damien Le Moal <dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-4-johannes.thumshirn@wdc.com>
 <c0ee5837-35a2-427f-bebb-da142cf4cdbf@kernel.org>
Content-Language: en-GB
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <c0ee5837-35a2-427f-bebb-da142cf4cdbf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BY5PR04MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbe5bea-c1ac-4275-0e84-08dee3c94a93
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|10070799003|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jyyZPf6MABpYNqyh95N6I7gQ8+1V2iIUvH6S7ogfwRAvM1cMClp1C32UJIzGSiKLZyoAQmjvhw98ao/xtqueDyrqObifg+lQcc5oxmR51hk0YVRCbQUdT9mK0Dro8npuDJoexVhlY7q9bip7r9HW+vM/aXp/98mnprAsIl1srXeQggUmd04/yWZs/oIZZyQ3sR4oAApw6sgjlKBcXrlxa8i4bNoo1fpc75/HwitabpNNBlVcOiWtulnOmB/rWjvy1wqUU+Oz8sBMt/Y2z1mQSvei+EEu2JFZePmCnwRkv4goRnrRhS/uBd/E5asUvmQn7y223uJKrz0Yazt7VdZa7LDykAPIUOwGjaDM1XktR/ZfQNOHV4zgMRvsqSERjolwbk4wT9ec6YdUFlOU2iHxhhELOKdyWp2vF2tddyEZb091/9BDXJkkhlxuQWxjm/d1+Sxo0Y0DLTfzHncCU3PoxJZgqDRfMQdQxuNnI6JsyZAFPW0e674o/bGhjEFc3rY8S8NAfbfjoxRne0mfRNFgprVv5OLRqcnTDLF1gsTKKu+NTL6d1Ke9D1AH1t9ra4cB2x8egw6f3SOIiu2/D8audpcMyHlh7lQROuavgsPjKgbPBqI/yoqC5X47WM9WlXtIqD7rilrKjjrMdZ86WBZE7v0UFVvzpWW8LbUo8F3V+tA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(10070799003)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmIzam96QUMrL3JMQjdlbitISTdjbWQ1OWp3TGNBSktvT3ZNTkRCZGFJVnA3?=
 =?utf-8?B?Wm5CdWtiTGlkQm0zeENGalVJemFCdVFFeWswSG9UTE5QeVhKTFRNeG43ajBG?=
 =?utf-8?B?WGV0a2J4ckZyUzhqdjE1ZmhvRGxJaXZNc1pNVkFUN0ZhQS9NT09nNlZxRVo0?=
 =?utf-8?B?WU13dFJMem1ieVBRR3J3clBudU5WRDIrMjVRMFpYZFhSdm04YzBoTXdaSmVY?=
 =?utf-8?B?Z21PSXdlMVJJVWI0NGhMZ0Y1NUpXMnNXZXNIb3prME9PejQzT2tnNkJ6QTZS?=
 =?utf-8?B?LytyTGw0dWxocWFOZ3Bqb1UvTkVheTNLQS9nVEpXVG4zdGpmdEprcEg2dUxs?=
 =?utf-8?B?bmNiUGM1OTA1ZUc0a3duSHhKT3c1TVByVC9GNGo2V0pHR3VSb3JVOHc3RzFo?=
 =?utf-8?B?K3I1aFJQZ1dWVlZSNkhqdGZMMUNTWDFqYVVGcG0yU3I5UW83NllYUFRPV3VY?=
 =?utf-8?B?OTlRaDhqZjdDSnVWWENiUFJSNjRTeUd5N1FSd3JDcVdCbzFEb01yK1RMWm5s?=
 =?utf-8?B?TUJOc2lWMlp4L0ZkcVhyeHhxbDYwdFhabU5saTR3a3Vzc3lmVHRVczRCRTJh?=
 =?utf-8?B?enVYM3hFSUppdFB6eGs1d2dRRGZRZnFmRkJtYlR5WjVlT2tqSDBTN1FPcWhw?=
 =?utf-8?B?eEdFenJoUmJvYmJ3QjNuY3o5TUR1K01GUEtsakJGU3VGRVFTcEo4eTFhMVdL?=
 =?utf-8?B?SENnRWxTZFhqaUFLTGFnRHY4VlFLR01VSGlIdjZNOTJqOG5kOTJ3TTdLaUhi?=
 =?utf-8?B?bjdXT3Q4SmJTZGZwOVZJTVZ3MmNDUXBubWcrajhjOUx4RmpvTEk2UjhHNUtL?=
 =?utf-8?B?OUhMYmp4eVc2QTR1U1laQkhCRS9WYzRjN0dLakNURklueURjLzhFZW5BM2Jh?=
 =?utf-8?B?am12WDU3dWJodVBRcmZGbmFSR3FlT2E4bk1uczlHMzFOcG1UTVpxNThpWW5P?=
 =?utf-8?B?UVNId08vdE5KRWJiK2RJSE1nc2YvNVQxRlJTNmJkZHk3NTZLMWlzd0RxUTFD?=
 =?utf-8?B?NGtjS2VKYlE2NTdqUmcxMUFEYTFCcG1qVFJvNERlcmxNK29tUHNlclA1TVZ5?=
 =?utf-8?B?M0tnU0pMY2laeHdnUTFXckd2REgzN3R5dHdsaHd5VWQ4OHVteHBiYm9udHlv?=
 =?utf-8?B?RS9LbFZyR2hNQzRUaWJxN1RBQU01MGRpTVNyejQwNlpBUkQzMlI4YjlDbUUv?=
 =?utf-8?B?aFRaUkwrYnU0WmJIT2ltbDlyTDNHSmlMN1FvRWpFb2dveEpOTjVMeHd4eVZT?=
 =?utf-8?B?STVmb0JqUnpKaWk5YTg3TGtiSVpibU4vY0NwYkg1djNaMG9ZQzdXZW1hUGN3?=
 =?utf-8?B?QWZXaWZ5bmxpL3dtNmhuRzBTbTUzVjJzTXNLUCtuYzVSdXNIOVRJNzBOc3Bu?=
 =?utf-8?B?a1Z1MVZSSTRyVDhFeWZYNU14cUpzdi9CUWVPU1ZsR1F5cHRGU1Z4WFRhWVdH?=
 =?utf-8?B?b2FKaU43MVh6RjdFc1I1RGprd3FBcVhpemNHRUlka2k0KzQvY0ZFeDBDUWpX?=
 =?utf-8?B?OUgzVzRybUpkZG5HaVhHeUVySE5QZ2VXVjJQZFpUV1JOeFFQU0xWdFl2UzNB?=
 =?utf-8?B?U05CUmNxNnhNMHlrMHd1b0ZXS0pGRmtuNmpFdFhkNldDOHliU3o4ckVKcjZT?=
 =?utf-8?B?em8yQnV5eWI2Qy9TOHQyRFZVdEtEa2c3VEZrL3AxdEs4VWFxMUVObTVPUHRY?=
 =?utf-8?B?WlNJbHdZVnl4WW0xcnB5TWpXSWdqRnNNOFZKd0RZWFF2TjR2UzJKK3B0M2lN?=
 =?utf-8?B?djVnbFN0a0pxQkJGa05COWZUNmpJdS9QVk1CSU9rY29tUkpjRTc1cEJGTnFB?=
 =?utf-8?B?cEdQbzg3ZzE2eGZUemRlQi81Q1A1YUdKUHovR3RQMUlKeDlhVlE4VGkyOTVn?=
 =?utf-8?B?R0pmQVRmVlJkMUZtWWQ1K3dkaVVqaEZCMTI4UXpHdExXZFUzUmZnUUhGajgw?=
 =?utf-8?B?MUxEZFZhejZwSXI1Y3RyVHMxRlhpY0RRWS8zWnZFWkhHMHFCaU5QdVR4VUNO?=
 =?utf-8?B?TEFpNFMxN3AyUHNJRTk1cDZYMmxEMGxzeG5TaFFqOW8rK2tLalRUdHB1akNQ?=
 =?utf-8?B?NWpMTGRMU2JDQnJpZG9kYzlOY1hieGFTUkp6SzA2VDVFam5RU0JJSjdPb0Ri?=
 =?utf-8?B?SmhWTFdkK1hReEoyOTdnZTJZdnpZVXY4WjBMQ0Zyd0g3SG5PVU55V2NhT095?=
 =?utf-8?B?NTBIT3hYdDNhVTVvTWpubFdUbFdPUkxMZnNFNDEvYVAvQUtXczc5YlZvNkpD?=
 =?utf-8?B?a1MrN1ZKQVJKc1NkSGhPVTgweUo1N0pvZTFXZG5rdlF2SjJBNnR3eFl5MEtC?=
 =?utf-8?B?UUZUZTBzbUlqVGpDTmczcGNtZEtzQW5CdHpHNlZBS2NzM0kxNTRBdzJNYzkw?=
 =?utf-8?Q?w8sNfzm2gmhMz6B6HQbN7fRUQecgCWtHyOCRIHWoy/koQ?=
X-MS-Exchange-AntiSpam-MessageData-1: fuq/Z/Y916N2ow==
X-Exchange-RoutingPolicyChecked:
	gHeFI+CTADSdrcKzolhbFv1olZ8EYOCoVU8h/rfJXujKXbjkfm0q4sZmbXoNUJSqpl89u4jXvfmvRQZszvE+9/fxKhfZWx6WLUuE/hBuA8YOZhAKTLxMuMuwhFO5S+XHhAsS8ycVTd6Hz0IWcNVODPFr0/6sojPxxB0EHMWGpDcwOa724J1epVjdz6f/cf9MoGSNZoqNgFrIuDv71J+Y+HI36XWJD5/VbDmn89T8+V7sCYcDzMllw2MEzBj5qjvfFeY5eUo462kA9V0P+Uwe+BjzdEs/FUZ8QVT91F4YvRDYq2BDQJUXhKxX5oxRv+DLLjnw9xfCPi+nP36pN/Va7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	diVvdu2vR0Fr/dGexc8toccjfAEwrZx/XLDWEHaKBKgRoHe/zuz7i8wYOOeNaTyiUO/AKp0Z6XSBl3Cth7UurZnKX2EFmJ8TvfL9vFjBytLwwOEKTszfvHz9Rz2rmx+qMY98BLNz9DkVOca77bGxt5mYDP0PNkNBTr6aSBW1nr0IjEx9jHPEGCef/BZmCl3qGmzkYE96HbOn1k2UVFWwJtmeQ5zKv0quP8hIpRcamO+TWSdh8HREvHwXx48BDzcXZPhcJEg8mkyhLgirEtnlYUndy5Oq8eDos9Tn0eH//G6ns7F1QZg2ajlnkrrfP4rVNy2Is8rN/F0gL8UFBroUVrMJRUZB2H85VIdEHNzUWR4w16rQBopdN5C3DQKrNx494Ls1zSDZL/A+HQdGkIGRTak666IV9v4TQwKjkUDC7arh7JlFf8I2oHCdFIhzO+0SR9tYBE/cNuBn+zkvTMl9vxCwdmFFnkkbLB5d9pESg7UuecfajqBvdjxWzfmyxFNhe4Gt4JQdRZ1SKFgihTaAUnEh/MQn1ZVSuPnJoGsaFWDRk1F2RbhMvUC/HAVwaDoYbqkJ1WyAlBEWvIHtirgyMDiBV5to8qjL1oIxiBD8+Cs/BCWworkW4pgB/MocfcDg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbe5bea-c1ac-4275-0e84-08dee3c94a93
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 06:04:41.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5ZznYTX7VO+P+/+njBPdhRjwVVq9DWujMh7wUvywWXxZaWJ94xdxmIOgBMCkpCHt9HhJQrOLQsPJ98BkXHJIOHJZrmb5Mfjpu1VUy/F6NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6375

On 16.07.26 13:54, Damien Le Moal wrote:
>> +static int v1;
> bool ?
> 
> Or maybe less confusing/more scalable:
> 
> static int trace_ver = 2;
> 
> to match the default and the --trace-version option changes that to the
> specified value? That simplifies the code below too.
>>   static void clear_events(struct pollfd *pfd)
>>   {
>> @@ -2244,6 +2257,19 @@ static int handle_args(int argc, char *argv[])
>>   		case 's':
>>   			net_use_sendfile = 0;
>>   			break;
>> +		case OPT_TRACE_VERSION: {
> 		case OPT_TRACE_VERSION:
> 			trace_ver = atoi(optarg);
> 			if (trace_ver != 1 && trace_ver != 2) {
> 				show_usage(argv[0]);
> 				exit(1);
> 			}
> 			break;

Sure
