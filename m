Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAF2EB873;
	Fri, 19 Sep 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268412; cv=fail; b=ACXy03ViD36DbfCTox5jr3R+XW/63W30TdhjJ3MV8YUjUEbNOvq7JVJy3xj6ZAiK61UmF6SXiAA2GIzKqkdU3ksmqjBvGThAzH8++2xNKnynmjyLOkPGqgF14+A4D9T2uXuJu/SHf9E+qSjtVKahcGmeDdM6exbx2QBtq2WDTqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268412; c=relaxed/simple;
	bh=AC2i6l/J6yvo5DWjnPbiyq2QkXwnVZZ6zp1c3gbgMNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VoLF2+4SBWN1hhI+v56BixWFYIgEBsLq+U467sb53IQ34jSZcvfu0r57RgFBet2TIjCwTkUGMz4z9+5mo+LXU9eENx8G0gv2VQQTwAs+q1/jhnWLa+BzgA07PdRbXbYSPEJOVVKBUWWNWZ1gbyUhaAX+o0M6rvdOAgYh9H6mAlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GddzK42s; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GddzK42s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/yM0o5M0utPmuUTna3+U+VRet3uOlp8w3mPHu/QehggSScJRjcTVSgCccV/q+GcLdInjB3P1qfaXDwYocbNgKJA+U5vz5W9Ywi8psHTCY33XiWsw/FQ2qzC37+4EieclSWaoLQSx/Ig018UWrgeNFaBbCsc8gNNuJxm99JexqzREYeqU2cx58+LEzIg9VslRbad7qU1QGUftx+2XyDMZgrNN9C+2c8TEFpnwghmKp75HxBlDu6od4/QTaW5YKopyGM1qNiIRvzIbhN/2HMBuLLRBBHxkIU1vAXJq78skCNoI9DKk17ASPAdL+crZTBAjTJ5Q2c9Y38Z8kALvgn48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC2i6l/J6yvo5DWjnPbiyq2QkXwnVZZ6zp1c3gbgMNI=;
 b=AUbFgfeLKblRTAtXScigUN3lutIpEwNFs9Q6ShcBLOwc/2pmiJQaqZi2YTAW61nzF88rrfWh4OQMTdrAjtoCGE/ttbJIogivXwDGH4f5gPHKO694EiZv/j9nVzvifDf4jHMZNap+A2XCPShHNqv6e+54os9zgoeh542G8R1eRk6bV0fkldvk4JiJM6neUxirJkvegFhUEgYDvJWFCJsNnTXPR5HrnFPHeW0nfLFRDSh47uXAiL3InwlLUzgQLXYwR2lxRgMtVI9Qyx7h+mXowBlc3BYvKgsc6jgQbW78fyO9dpzk0B42+7jsB2zaTDqJOId2t1hwFGjCd/BTozvr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC2i6l/J6yvo5DWjnPbiyq2QkXwnVZZ6zp1c3gbgMNI=;
 b=GddzK42s2qnvaaPE/+EWIcmBHkZ6ZCMyBv6VfJnVJeUeDf19n1ryBhBsX7On3HYe6v6KW0b6twE0lVa4jXLEHbYFkNGpdEonHk8L9SAWui5PceDv2oObfQsI88jFHCfulxq6C6iI4aIE7KJ9bPAfcUm9e1OObRE0zWxPx8bMGtUZP6qqhann9jfYYE1oP/BXAlSyBvTDl/awkE1vXxXYq+6qzRG+i54HmTxY8+c8l0byMZwe06iTbAXR1lKXuRyJ4mOPcWsimit/Y3EKLUlIihoGOGdQYsNUx1kf0YkmN52YQndip5msnqtkvOtkP7SAnA8crXzWyVpd41eXCLPZZg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 07:53:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:53:25 +0000
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
Subject: Re: [PATCH 02/21] add definitions for BLKTRACESETUP2
Thread-Topic: [PATCH 02/21] add definitions for BLKTRACESETUP2
Thread-Index: AQHcIXn5z6C9X9H/406H9jQfBNmnKbSaMgCA
Date: Fri, 19 Sep 2025 07:53:25 +0000
Message-ID: <4a2b3413-abdd-4dfb-8fc4-8aff78de5c8a@nvidia.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
 <20250909110723.75676-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20250909110723.75676-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: 1f1c92a1-a7e8-4ab9-748e-08ddf7519d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTE4Y3UrMFp6WkNYSUxvVDQwSnFiOXVWcVNZUWUyeGh3KzlzU1lXMDl4dGNO?=
 =?utf-8?B?TVZZMTlhNWp0cndyOTdyN1Z0em9HSkN0aHBDYU9GVUJ4RkJRUzRiUGlubDh3?=
 =?utf-8?B?Y3lJVnpmNFBkTHMzc1BnOGdLUGNUa2tsMGRDK2xtVUtjYlhEMmRZbXM1bElq?=
 =?utf-8?B?eU9Db2JtVENQYjExTkdOVGRvdXVMc1NOUXUwSUR1cVZWT0JJbE44c1hvMlQx?=
 =?utf-8?B?SHhMaFlhZUFrdWY3R2phMjlQaEVGcWdsdU1mamFzNGdack42RHlhWXZqRTlB?=
 =?utf-8?B?bWtRYlp4bUhaRGxqb1NrZC8vU0ppWUtZRDZtaGFvUXhYUy82TmNZTVU1SXdR?=
 =?utf-8?B?VUtuZEwyVkFxMEZteG9BbWxPa043Y1dNTnJTWEF3VUJGaXd3UTBUeUdlK0Fh?=
 =?utf-8?B?b1RNK3pNanY4SS9tcERLYjhiNE1YZ2ZZb1RqbC80QTROTWk2MDRpTUQ0dlJt?=
 =?utf-8?B?ZzBpbllNWFFxbGVVY1hvRE5TZFhOYnZpR3d2ckx3clYvUVhCZEM1QVJYOTc5?=
 =?utf-8?B?NW9MdVRIWWxNZVl0MXQ4Ym43ZmFHQkhML3hlUFdMWHc5cVJUUTl3NmdWTUZB?=
 =?utf-8?B?dnFCei9ZcnZTYVdldU9CRk9Gd01LdjNNUHJKVmt3d3pUZXNjRlJWenU3Uk9m?=
 =?utf-8?B?MDQ5eXE0WXFQV09tZjFoUlozbFZ4UkdEaVhkVUN4M3R2bWExQXR5ODFUbHlV?=
 =?utf-8?B?T25SdHVVaitLUDh4NGN5V1RlTU5ySEFUTGx6dFJDeUZaMEZ3VzlwYS9ZbTRS?=
 =?utf-8?B?d3FtbmdXKy9NY2VyWExnc0c2cHdUb2dybURkcTgzcTY3aWFZdXNqaEdYd0sz?=
 =?utf-8?B?UjdickI5N3FESjU2NnpvNi9FaWtEL3RNdjYrZ2RMK1AyQnVxZVB4aWk4WW15?=
 =?utf-8?B?K1FyQ1A3aEk3ak5rUForb3hKYWJzMG56SkdLYTJHTi9oTitLcXZnUGovdzBV?=
 =?utf-8?B?Yk52TEZuQm4ya3VTZ0RWdEZNUWptWjRpZVhYaFIwV2pjUlFxb0s0dUxRcnFx?=
 =?utf-8?B?ZjNYaDg1a3RvaE92V0ZldWM5aWxqWmJUQjE2Ly8vMnRiWnF1WGgvU1VKWG9u?=
 =?utf-8?B?azVZMmsxcDRobXY4alFVUWlUWHMzZWhYRjZSR0cza2RPakJyTWxES3p1K2JO?=
 =?utf-8?B?cHQ1dktIL1I1QkpSbWJJdm1FRTZOK0NLYTNvbkdTOXJZeGEreFFUNkJFWlhT?=
 =?utf-8?B?SUJUbzlWdVU4WjkrRXBWMFVCbUVaRm8rU2N6bVh5MFZmRVpndUJMYitLeGhZ?=
 =?utf-8?B?VlFrcklTczBZRGc3OTVWQW40SHVRL2JpWGl5azlIdExyZzRPdjUzQmlIUzJh?=
 =?utf-8?B?U0dUT041MUV2M1ZJU3JZYklpd1loY0JLVCt6V2FvY3dzL3dKalJMcWpQeFpN?=
 =?utf-8?B?bjZOVmN6MHhLU3REZ3ZZMlBkdWZ0ektjV0dWbDhkTTJYOUZhc1I4NWU1KzFW?=
 =?utf-8?B?cnFVa2Njd2VyRzlWSUZjK0JNQjlZdkVDaUxTNHM4WC9mSjJvdk1IV1BvcXBI?=
 =?utf-8?B?VW1RWUlaMEJIVGQ5MndOQjZTRXpPT0kxaXI4M083OU9MRmdWRXk4ajNzZjZL?=
 =?utf-8?B?eUwza0hLd0xSVkZBMXp6aGNLcUoxRUhoalUzNjlmSkpGbVc5WURDMzVaeHRH?=
 =?utf-8?B?Qi9vTGJjbE5DOXdSZ2doRXhSb2lXTWw0WFdtS1diZ1BYUnZKcnRDUlgwZkMz?=
 =?utf-8?B?TTdJT2JzWG40T3k2UnJETlpURU84dlVSb3V1T1ArSnNrTkFPMXYzRVJJWTZi?=
 =?utf-8?B?dDU3VjcrWFFJTHd4Y3h5L3hWYnFYMVRobFVBdVVnalBmbnlmaXUvT3NCVmRs?=
 =?utf-8?B?TklDNm5jbjg2TlJLS1lUTDZrWkkxRXhOSXhsRnpKWTN6WmJJUEl1cWZlTEF0?=
 =?utf-8?B?elpnVkcyMlV6UmdDMkhsTHVQdE0wd1FCZnJFU2hxYXl1RTRtTlIreFZzZnVv?=
 =?utf-8?B?TEZUMDBPZFJpUnU3dGJFLzY0ZGVNeThzK2dWMEo5QSs0OFp3dlh1VmdhYi9o?=
 =?utf-8?B?dTRzM1JQRjh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3FwNUxLelBKak5mNld4cUY1M21Xd3BDSUtIRmhZa0grM05rZ2g2VTAyUEdX?=
 =?utf-8?B?STNaU1hTL01nNFcweG9sM2wzS2s5Y2RSWlYwR0hXbVRJS1JVV0l1UFlLMUZw?=
 =?utf-8?B?WndpUnNLWG9sQWZjeE15ZGE0ZGtxNk5xVWUrckxGOHVoVExWVlk0NWRwOU1Q?=
 =?utf-8?B?K2FzVjlnLzQxWDFQdUtUeVFHTTJOTCtLUzJWN2Z0RC9Mdm5hcmFEaGgrRTc2?=
 =?utf-8?B?VkJ6SFlXbng2cW15b3Y2OHFVcS82U1lDSEVXVDhQeVFvaW5nTlNRSnpiZ2lp?=
 =?utf-8?B?SUJkVkhyRGNYVmFFTENvWGdxT3BhOVBhbXZjM3NOMytNRzllalQ4Q1pPQ2Na?=
 =?utf-8?B?Y1c2cHBuTG5oQ29pbXE5RklEYXd2ZGc2NkoyYkNjMG5MTGVSaUkxL2hiN0FD?=
 =?utf-8?B?Z2lZWlpZUm00bFBoR3p2Q04veFNEeUxYaHpyMTd6aHJWOVk4M1hneTdkVStl?=
 =?utf-8?B?Z3pEQndRSTFXRHBiMWNWZ1RZV1A5bkJpdk1WS3pLK203R2FRMXRnZDFFWU51?=
 =?utf-8?B?aUo2SUFpczMwNWxEc3dWK1BtT3RaaFBjM3N5R1l6dlc2TkZhUHcvVVlLeEhr?=
 =?utf-8?B?blltUnZOTEJWeHNXbENkTGNxc2JjQ2c2Qy9nalRZay94U2NBbE1IVk80blp5?=
 =?utf-8?B?WnJjZUV5TjA1Zm16dlBMOXQ3SnFCTVJiWm9GZjJVMnQ4YzFRZzBHSUNtdFll?=
 =?utf-8?B?UGZNbWtBR3hSNThCYmV1Vm9idmNvZVhkS2gzeE45Q1ZJMXFqejFWTTJrSmFm?=
 =?utf-8?B?ZzhJQ3o1NlpHT201Qk43eXEzcERIQ1ZTYUZEbFFIeTRkSi84cjRQZGl0UTBv?=
 =?utf-8?B?bnB3N3ByMzY5V2pDT0NVRFN4NUZpTXltUFdJQS8xQ2VOM3BJM0Rtcm0vL1Ar?=
 =?utf-8?B?SnZ1TzA5ZE51bjBXY29Vc0tZTS92dzRqVHJrNG16WWw1cXQ1Nm8yYXBLVjVI?=
 =?utf-8?B?OFY0aXU1bU51SHdsdW5wWWVObW1WV3BOT2Y3emZLMUlubEVQcjY1d2dsalFi?=
 =?utf-8?B?bWhGOFNCQXFzQUpFVGVqRXlQQkFXMURqU3BQOWRadUtJdyttazRtTytWbmF6?=
 =?utf-8?B?Q0NPRzRiVGpnT1FZL3kycXZNcmdMM1MyQ0NvaG5LOXZIc2xOOXlGTUkzNkpx?=
 =?utf-8?B?aUZnWUlLVGF1Z3llMEdKc1lacTArYVR2WXBTSjBDNHBsM3lFckFUYS9MNEJo?=
 =?utf-8?B?d1VhNjlSbGdQTFNzWVZJRTg5b2RkY0pKV09SYVVnY2lGVjkvZXVVWmkyOWJG?=
 =?utf-8?B?SXBVT0RCZ2NXbEYweU1nQ29DUHpGQis5V2lVVU85SGdia0FEdVFkOUloSjN5?=
 =?utf-8?B?SnpkOVhra3NTK1lpYWJIMVpTdEZFL2dOOEtRNDM1STJ0SktIY01xSnM2OGlw?=
 =?utf-8?B?blRmT1pVaEprOTdKMGZQTllZSGVJajlYOHpYNzVXd0k3STIxU20rd2NUcnRR?=
 =?utf-8?B?Tmh2ZU5MVHlKd3FWWk9XZmR6U3o4WS94Uk1jM1RBTGFLOFlUOUU2TFdId1Ur?=
 =?utf-8?B?akJ4T2dSK09kVjc3WjZOUklRZEV3Qll2ODl1bmorQThrc1ZPSHNYeFFTYkZF?=
 =?utf-8?B?NDROQUxJZ1h1cDFyZHN2MVZYU1g2c2VRSjJVaUZQSzlDSWlqWnI2OFdReHEz?=
 =?utf-8?B?TlZVRVZhb0NvWjd2SFJHeWZwazNPbzViaXhpVWtTbTZqU2xldlQzYjNnYjdN?=
 =?utf-8?B?WEJJcktTUURVL2s5WlMzaDhxTS8yTTlIM0R2OGVVSXkwNm1uczF1dVF4cmhD?=
 =?utf-8?B?cmFiT3NZZXlRcGtjL0IySnEwNXFPcnU0TURGSVQ3YzBvNWxiSGk2V0EwUDNm?=
 =?utf-8?B?enByNE1MYlJQM3U5Q0tPS0hTZmhiUFhHZ1pmaXd4OUh6L0prU3Z2RkRlbzIz?=
 =?utf-8?B?WllHMWo2V3FsYWxFaTdRU1Fyc1h2WFlSdXVyVmxJOUQzMjN5djhsQkExYjV5?=
 =?utf-8?B?c1VzVWN4OEh2dlB2K0REM2RDV0hqKzZVNE5rWDJ0SHVHQlYzaEtjQ2pKUkVN?=
 =?utf-8?B?aUcrY0ZTeVhRZmpVRGVlSjJiOGFRSFpoTGJoVG9Nc2dkanArb2F5MGVuUDZI?=
 =?utf-8?B?TktUOTVzelpMZ2tWazkxKzExcDlFRHFzQVB2RXZhZnNkcjNVRHA0Qlh0My8z?=
 =?utf-8?B?RjdhaXFBVmF6L3haVUVCRThlQmFFd2VqS3lSNDRzWkZqVkczcnZYUWhLK3ZN?=
 =?utf-8?Q?i4yEZeeFNeiWHZr3/mm1jfxkFYiDT0C3AWiIG+Mc6tAA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <384C13FB31111C4F9842E3855605C106@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1c92a1-a7e8-4ab9-748e-08ddf7519d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:53:25.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MLgIr84tuotAjR4IsHwUQDVWLIQr8BLAmBlCHqII9WOOaZgKZAXt1GKP4mzVKLBsdyNBJ6ZRPuhJ6v+CDt0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

T24gOS85LzI1IDA0OjA3LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IC0t
LQ0KPiAgIGJsa3RyYWNlX2FwaS5oIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Jsa3RyYWNlX2FwaS5o
IGIvYmxrdHJhY2VfYXBpLmgNCj4gaW5kZXggMTcyYjRjMi4uOWY0MzVhNSAxMDA2NDQNCj4gLS0t
IGEvYmxrdHJhY2VfYXBpLmgNCj4gKysrIGIvYmxrdHJhY2VfYXBpLmgNCj4gQEAgLTEzOSw5ICsx
MzksMjQgQEAgc3RydWN0IGJsa191c2VyX3RyYWNlX3NldHVwIHsNCj4gICAJX191MzIgcGlkOw0K
PiAgIH07DQo+ICAgDQo+ICsvKg0KPiArICogVXNlciBzZXR1cCBzdHJ1Y3R1cmUgcGFzc2VkIHdp
dGggQkxLVFJBQ0VTRVRVUDINCj4gKyAqLw0KPiArc3RydWN0IGJsa191c2VyX3RyYWNlX3NldHVw
MiB7DQo+ICsJY2hhciBuYW1lWzMyXTsJCQkvKiBvdXRwdXQgKi8NCj4gKwlfX3U2NCBhY3RfbWFz
azsJCQkvKiBpbnB1dCAqLw0KPiArCV9fdTMyIGJ1Zl9zaXplOwkJCS8qIGlucHV0ICovDQo+ICsJ
X191MzIgYnVmX25yOwkJCS8qIGlucHV0ICovDQo+ICsJX191NjQgc3RhcnRfbGJhOw0KPiArCV9f
dTY0IGVuZF9sYmE7DQo+ICsJX191MzIgcGlkOw0KPiArCV9fdTMyIHJlc2VydmVkOwkJCS8qIGZv
ciBmdXR1dGUgdXNlICovDQo+ICt9Ow0KPiArDQo+ICAgI2RlZmluZSBCTEtUUkFDRVNFVFVQIF9J
T1dSKDB4MTIsMTE1LHN0cnVjdCBibGtfdXNlcl90cmFjZV9zZXR1cCkNCj4gICAjZGVmaW5lIEJM
S1RSQUNFU1RBUlQgX0lPKDB4MTIsMTE2KQ0KPiAgICNkZWZpbmUgQkxLVFJBQ0VTVE9QIF9JTygw
eDEyLDExNykNCj4gICAjZGVmaW5lIEJMS1RSQUNFVEVBUkRPV04gX0lPKDB4MTIsMTE4KQ0KPiAr
I2RlZmluZSBCTEtUUkFDRVNFVFVQMiBfSU9XUigweDEyLCAxNDIsIHN0cnVjdCBibGtfdXNlcl90
cmFjZV9zZXR1cDIpDQo+ICAgDQo+ICAgI2VuZGlmDQoNClRoaXMgZGVmaW5pdGVseSBuZWVkcyBh
IGNvbW1pdCBsb2cgZXhwbGFpbmluZyB3aHkgeW91IG5lZWQgc2V0dXAyIHN0cnVjdCBhbmQNCndo
YXQga2luZCBvZiBwcm9ibGVtIGl0IGlzIHNvbHZpbmcuDQoNCi1jaw0KDQoNCg==
