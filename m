Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95531246BB4;
	Tue,  7 Oct 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842485; cv=fail; b=Hw3uBrJlX+gMM1EPcGNFcuFwOoJWcbvre0p/25CZbc7sFYqvFFQouUkTqmzyBdD8VkxKI/kdNyRz82NhoNXkLqFxRn8vUvQUWXeWIBVxik0MSsbLCkFMbb7hUhbc/5/NWww8F2F2Gsv0DsZ0sxFUnxSSI+qkGPWh6br/EdeIRtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842485; c=relaxed/simple;
	bh=37hkkIlrwWGyELWJLKZ2HKmxVRTW5XEvhmC7ZHZ9QmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKK4R5X7yQ9fsSen97Q+51YC7xWfJAmxWCRW9FIJN/9KCvX5vBvSk+BuUZNtOrPzjDOx7QE7W62YFyO2MTYhIlAwAlSsgy4NpZVcaULIO2jpyyl1KsJ0NmMCdjE4epdqH6WSFep2lLexVsd8wI1DivzL6VhhuOdiAj/zUswy1qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Mzdv+U32; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OOe9qmuq; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mzdv+U32";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OOe9qmuq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759842483; x=1791378483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=37hkkIlrwWGyELWJLKZ2HKmxVRTW5XEvhmC7ZHZ9QmM=;
  b=Mzdv+U32FHc9ygEerAIYUO53koPM+OVNNwqzpAJysgLoX4kBUIt3Zv9g
   CIoHmWUhFmRsSwE89VUsCWx4dLVlG8dzY2V47nYVz9RuvdamRwniV8w7U
   ZzZaTkLQf1bRgyhjlHoFsGHKxGc0ZZ996zHl/EjkkabCPhFpsLnkrCll5
   VIltERXrX2TFXTnrTfk+2qqM5+5qsJ9OHB2dAkE+cbgO+lDNkDBKirVAg
   OR9nkW/1H1eJYldOj0ag0i4kwUawbthxAG2MqKxaodLO/UkhggOA2WFCO
   A1QIAR5CGTYC2xV5Df2Gb6YLjyrruh7K6m5TCrho9hUjHCrGO3Up4ONEQ
   g==;
X-CSE-ConnectionGUID: /RbjwgGEQKuTBlBN585X+g==
X-CSE-MsgGUID: 0ZoFjIe2TRy321tYHkuOiA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132424411"
Received: from mail-centralusazon11011053.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.53])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 21:08:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaTjxvZVlAe2qEhTy0NOjH+f4s2BMzGZOCNuDbLf1Ct80yKrQvp6NL8RIjP2AsUe99+Cqa5lzcIP5yWXkfZ1IVLj0v5Ts9ykwyh7DYv9qlqOh256HgEpzDW98/ZV0BLzJ7+pLi/JtLhm3esfVMHcIH1z01i/Zdlx3RFfzxZLJw9uFA1K32tT2kPcM+vAI+ppv1Pa3l4KkpkWMfZBZQwHgorqYcqwv91mqDwHj1FuFW7gRAIoBXzS1nA2Ucrbj794ceGUGeekjX77esMKADoEzSNq7IlU6htlxoU3CPuG8rMw/EVVQD8eXWDOFUQ9aqRTlT4EGE6f/5HgWU1cqrVh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37hkkIlrwWGyELWJLKZ2HKmxVRTW5XEvhmC7ZHZ9QmM=;
 b=yjsZy+0Se+ITokcZkHkAs4PwAdsZLHneAv491unhfrgcmDxxPSXWP2pxSflgIClpLT8O4E6iIcTOd8kwUAeCannGi4BaYuIl79O9Z9J8JpKMSSCz+slMC92+thExAyfJgZAlNWSplJyE5vY8PkWmaxIQ5x0SSU2DtLCFXU6uiSYnrrDrN82FiH7MYaSMg4FuanOv+e1+AcHDAtJGKZEWjmSZITiPlw889jyRUcp2XGQpY+6rZypKs77rNsdgrxBi+pxQ/2PH8CImKlNSuOmAkd+yWPAC0Ypn4fekny2IKtnnERb1LzKRH8AH295lgcbN5RT6w0D5HDLm/zp1cIey7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37hkkIlrwWGyELWJLKZ2HKmxVRTW5XEvhmC7ZHZ9QmM=;
 b=OOe9qmuqAwmt9/CCcB1CUYmoGrOos7IrX16tzAbOfx3MaweN3onpq+YWIqnVAC7ckSkUc9uw7qxJIXOYuAXq5K9eBN4ooXuC6RIo+/Le5a4pZqdsp+knE742rrFOnOkgUFgStdnPeIJDD6gY073ESUfwxPuckNELu686D8Y3zNU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6731.namprd04.prod.outlook.com (2603:10b6:5:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:08:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 13:08:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-btrace@vger.kernel.org"
	<linux-btrace@vger.kernel.org>, John Garry <john.g.garry@oracle.com>, Hannes
 Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Subject: Re: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
Thread-Topic: [PATCH v2 11/15] blktrace: add block trace commands for zone
 operations
Thread-Index: AQHcLi2P41isIe1XeUeby1yqta+5krSwE4WAgAam7oA=
Date: Tue, 7 Oct 2025 13:08:00 +0000
Message-ID: <4638c185-ac5c-41e3-8c79-5c995228ec0e@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-12-johannes.thumshirn@wdc.com>
 <20251003073257.GE12624@lst.de>
In-Reply-To: <20251003073257.GE12624@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6731:EE_
x-ms-office365-filtering-correlation-id: 977558e7-efab-4d9e-1e49-08de05a28a93
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTBkWVFCNXJqT0FBUXIxOE5FbXZzQ0FNeFBtYm50TUpJVlZxWW9yVEdEbTZG?=
 =?utf-8?B?enoxZWlPYTA4VDRyQ2dhSkVmdEdqb3BkOGhVU0FQcVFNSjNUaktWbFFCRmlR?=
 =?utf-8?B?cWV1bzdyekozOEd4UnltQ2tPa29VUW4yNXIxdkJWY3FMMCtWUXNqSXRreWUx?=
 =?utf-8?B?WGp4am1yeHBiV2FlRUNYaWhESGZXQmNiZURHaGRSZU1FN2U2c0lRSlBneEV5?=
 =?utf-8?B?YlEybkIyZkZZNWFwcW94UXQ4ZHV4MEYvTDFETVFEeTZ3MTJpUUFFNFJnd295?=
 =?utf-8?B?cjdkT0h6WU55azc4MEZXanJpWEU4TEJhSURJNXZYY3RjbC9PVG5nSEZkUGFu?=
 =?utf-8?B?RkFYdXQ3ZS9IYkpjb1lkcFZERDhUcHZ6bEJoU0NNMkNJNzA3VUdFZ0NLZUxC?=
 =?utf-8?B?T1gyU3BZNHAwVWtKeWdveG5kWXVHRVJZazIyeG5PZUFiOEZaeEs5Y3BXUWpn?=
 =?utf-8?B?Tys3QW1PTzVEU0ZoZmdnS01zbmJ0MFBjcE9yUzV5MkNqNkVLbjFQUmdCWmtT?=
 =?utf-8?B?c1UrSkxHcEJEZ3VMOW54eXlaMEdsMXdySmxzUVZpQ0tjb3F5cm8rT1M2RU85?=
 =?utf-8?B?VFRVbksxVFBoRFdGWEdXQzk2bzFoQXJMRTlJc3JSbjdKTmRjMGlQSGhoTGVI?=
 =?utf-8?B?VzBZUSswRTdoeWd5bitLWGJ0STUwZzdVOE9HckZkaGZPbG1sTFVMcHhWWDFr?=
 =?utf-8?B?VEtnWVRMMCtVZVh6dGFnVElQZjJiTEV4emxtQXNnZmpIaGE3ZEdnM0RjMlFt?=
 =?utf-8?B?Qjh5RkNXVjlmTUMzTUErTUtqV21LU3owbzcrMDdYMGxmbElpc2F0S3V1UlhI?=
 =?utf-8?B?RjRNS0tTYmpOeWFhZjNjMnVmZ1FmMTVFSFdvc0pKTCttLy9IVC82V0pvbFBl?=
 =?utf-8?B?Nm5kYThPWUpkWnpvMkY4M3JYaEN1eUV6SDlzWGNQc0p1Wk1QK3NOU2FtWVJs?=
 =?utf-8?B?SjN6UjFDRmlBbEZlRHZMdEFGRGZQTmFlM3Btb2NyM3YrTEZ5aC9lK25OVElE?=
 =?utf-8?B?TjE2L3NPRHlHMUdLU0Z0MkE1OHF6VU1Dd251RTJEQTkyME1MSEk4ZGFlcUVH?=
 =?utf-8?B?ZnRBMllZK1lXOTliRDZudnN5WWpUQmxGcUJGQmxmbC9yVTJsZExHSkVDaHhh?=
 =?utf-8?B?YW1UaEpHdDJOUVJaSWl4bUNPNmZCd1dwWWtldkdTMXArZ1hvU05neG8xZ1NV?=
 =?utf-8?B?SjJWMTVJWDA0REdyb3BxcmlMWnNIcWJFY01tWmtTUVlhUHM0czFlSWVOU2x5?=
 =?utf-8?B?TkhLcmxhVGp6dC9QREkxakQrUDRsdXNPaWpGVXo4TWo3eU0wNHM3WjZQYnY4?=
 =?utf-8?B?TWIzWVpKKzdzdGlQWTdpWU5kSDlUN2VTU0pWYzV6c1V0SDcxdzl5eXJ0YkM4?=
 =?utf-8?B?SGR1VElhQ2tNaGtFVllDZG9LTXZwaEVzak9jQkh6V21TcWdqczYvWENPTGVO?=
 =?utf-8?B?WERPZHdqZVNjc2d0MVNhdU12c0hCZ2tBU3QvU0FxN1FzM1l1MnoxS0lrUDRn?=
 =?utf-8?B?TGl5d2JSTm1OWnJXZ21OLytzeE4zc0t6ZEVacS9HaGRpQWdJbDAvNDcwdmlt?=
 =?utf-8?B?ejVGZ2VsamhvMkVXRDJjMXBockVqNXJ6dm1sYkJTSlFjdGUrZjVabDFwYXNz?=
 =?utf-8?B?MzdveXNqZ0wvR2dETVBpN21Sek5XNFl1emQ5cEIxWTZDK2VKMTRDVEQzUGpz?=
 =?utf-8?B?cHZsWFp5cVpyVU1ReUFycVMyYzJYbU1IOC9Nck9Gd0w3ZEVNWkI0cHB3TWJI?=
 =?utf-8?B?SDlMeW5yeEgvYUc0TUxXWjY2b21jVHJBUkp6ZzRhL0ovaWlKdXlRdC9MOEJs?=
 =?utf-8?B?Qm5LajRmMzZyMzlMY281TEhiK2RndncxaFNCaVVwSTl5dGdZMlphL1hEZkM0?=
 =?utf-8?B?dDQrY25jcjlubUdaNWJPdTdWUjRuMnMxODZabkhmQk51bFZhM1BuQ3NXSmRR?=
 =?utf-8?B?M2FQclpnOVlxSis0QTFOREJTRDNvdjU3Q1BmYzVia3BqWkpoNWhDc1RwMXRD?=
 =?utf-8?B?ZzhoclExNmppWEVaUDREUVpyMStFZmJVSXB3cEpPVTlRM3Y0V3V3bFRoZFdm?=
 =?utf-8?Q?8VD4D9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STlCcWRGWWFXQjk5bTZoQ2hiR0xHT0JlQXd5T0hLakM3b1M4MS9XKzViVzdY?=
 =?utf-8?B?K285ZDVaelRnalMvOVpDSUJRNHJkdndMUHJoUk93SEVSTFRPVDJYWHIzd1RZ?=
 =?utf-8?B?cnoveVVzeWhLUHpZckJJUXprY0pRYVFXMGVCY2RBUXk4S1N0dTEzSjhTaWdG?=
 =?utf-8?B?QmRrbHZBT3dPdUF4VXVERDdpcy9yazFMSGZLNXVJKzg3V1ZkWU5oaE1ZT2I0?=
 =?utf-8?B?T21kYjd0dm9KdkkyVlJEY0s2ODBnQ1NXcTRyeHNBUU9aN3lKcjBORDZGVE9p?=
 =?utf-8?B?VHBHU3NoSEhiK0lVVmtJMGdlVWE5WGNZZjBCUXJpUEdnOU9nUkUrTm52U2Vw?=
 =?utf-8?B?Qm5VSnNFQk40RENwY3dVR2h2UFpLTkduWFdUN3FhMnhBVWR3MG1lam5xdnJY?=
 =?utf-8?B?OEwxYTFEbjg5V001K2haRzRHbDBTUnh5RmhlWGdPS1kyOWhrT3lPZFkxRUpu?=
 =?utf-8?B?NTgzSHgyRFNtUWxZZ2NOdXE0a1FTWUlCalRqTXJwRDN6WnhCL1lCcmQrcU93?=
 =?utf-8?B?ZmloTWkzMjN4YWJEckF0TnJHcTQ1WUQwTERGeEkwdGx0c0lUMHBMWjRhYnBi?=
 =?utf-8?B?MHdRZHVBNHNtYU00T2puWU00MlEvNGhHTm5BMU9EZWppUjh1RVVQYXdqWUkz?=
 =?utf-8?B?M1BXNGJDM3BZemlDSXo3ZkpZaUo3eWt3UCtWQWsrREo2d2ZpWWFMd2c3Q3JX?=
 =?utf-8?B?WUlvaVB2Q0s4UGpWd1JicHNEcTh2Q0xZVFhEOUtnTUpVUEZtZzZ0YWRvSGZX?=
 =?utf-8?B?c1NVS3M5bXBYSUFoOVgzRk5BeE50REVlY1g1cnFBa2d3WjRLWnVoVWhVMUVL?=
 =?utf-8?B?ZjhHKzhWVVI1dXBLbVJ0akZBbFNLcHlvU3ZWU2ZBU1FhbGsyOW9WK2h3VlNh?=
 =?utf-8?B?T1hUSHBFNnNJZWpOZ0ppaFRyemlZdklXWllCVWRKTFVvRWlVVVBuZzBhV01Y?=
 =?utf-8?B?S1Z3TmRsbGg3c0VJVEFVTE9heEJrc3FQUTEvSmVLSHhSQ1c5NG9DZkd3ZUkw?=
 =?utf-8?B?YVlUTzNpbW1NZ3g0bFhyNkg0OUhLUS9sODNyMXRkbnFCbEg2bHB2eTExYXlF?=
 =?utf-8?B?M0YvTjBiMDlMYnoxb0ZxUnp1STNPdEZOejVIaGorVThaNVhsMjRtNkNSNElY?=
 =?utf-8?B?UGZRQStLM2o2Uk05M3pSaXY1azIxdG1iRTcvaXJSVFRqSkdvcjRMdkorVVhC?=
 =?utf-8?B?dXlzWWVuNndFK0h6cWlFTXIzRTl6b2gzUGI4THVxTVVpSGdvMFl5V1BMMEhY?=
 =?utf-8?B?eTdneld2WXhHaGlJTUUxZ2w5dHJPWFUyQW5ZUFZLTmk5MGM3K3NUT2hmUVFD?=
 =?utf-8?B?TEl5U25tSzRKcXdPeDNSZ2lGbllWVlFXWitkYyt2TGpRV2hXNjV0S3E2Uk9Z?=
 =?utf-8?B?R1F5cUM1aHlYODJvenpzNHBXcDZDMldjajJRbDRGTUgvMHJmU0h5THhEaHY4?=
 =?utf-8?B?d01JYWdyNWRuL21Hd2R4bHg1QTJaeFdTTHBScnZFS1o3bTlGbnBRYyt3bkts?=
 =?utf-8?B?Ryt1K2F5S1NWaXFqU2M4NldnY3dKeGtFeGx0SDU4SVBhUExpM3BhWXcyT0F5?=
 =?utf-8?B?Z3FSVWVvMnNlc040SEpiYUNRQ2x3L2x4SlRkSEdycFRyVy9wRnRZeWNnaW5D?=
 =?utf-8?B?Ni9VUE00TVp6QVllc1lDUGQ3V1pmNjBQWnJ6TmR4OGJQb01udEJBbTBkTW9r?=
 =?utf-8?B?a09sV0YveGwrTnRBTTZFNldhOFZGTmtGTTBycVo2eHRkK0hiWEtqeHpMS2lI?=
 =?utf-8?B?eWFrM2Y3VktjWW1lMFJsdE5GTTB2YVBCM291cFBGSUxIQW52bUFqMThTWHQ4?=
 =?utf-8?B?emRENzg2bXc3bnh4T1pXbVFJTTZaaGJEZVQ1ZWZtQUlLNjRxb2Fpcms1Rzdv?=
 =?utf-8?B?N2dpYmZmK2crZ2lSMnl0ZTFjZWdEeWxxRHZzYmZjK1RaS1BnZUF2NGwwMTB2?=
 =?utf-8?B?OFovZG9XWG9BWnh5Zk5FYzRlOTRpWnVObWxUdmNNUDVYSW5HTTRpZGNwOVRx?=
 =?utf-8?B?Yi9hbnlwSUNRNXVRRGl0bWEwbC91Sk1abWNFdEIxbE5hd0JDMnNyZ3IwQTNk?=
 =?utf-8?B?UFNCZ0RjUE0xWHVmSHllbW5kVGJJMUhiN0xJQVdLT3EwRjdyaE9vQUcwU2lZ?=
 =?utf-8?B?ZFZ3VmhJQmRwZGN6eFgrTHhFUWpBV3g2a21oSGJsMHV6NGRZaWVETWhnb05U?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF8683E55FED3642A33A1D384AA81ED0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Df1ALqOg7g3nD5Qak+Bcjs5LMSkFGUPfgaudYHSGWRBO6MDF2FXdecADxXvqT1OHvKPyQsEnf6LrSRVblinugi2GZuw+27liK9oVtxY73hSS7rcifXk2w0YYt8y9mlqa9oFXMSOMvfXN8JG576KYrYCh+uEaR0GFRXhpDgG43VR9hWA05HkCQEKL9MjhSQN3Fa5UFS61A71Vvbb3mSOHvgQP86FS+ODAUF+KNDzwFIYwnpUkYp9OH222+zNjeznqDY+QCePz52jbwyB6gs9MvwfqJimT3kCZe+CXiARQrcihoqOXVE7Ez9ST/6jjfQO7ynnV62u9Pp+sCb+P5JySqNUivmD4/+Y8fBOBTjLXFeF8ZHOypJyKTrGzM6lyos3NlPM07Gw6eHeifDRk9uk/3SIvF0HVwmN7pjrn7d0vvV6iCMX+MImrT2zvY2kBOIaBxMuHPq8j6YFER5kpR8X6/W7v6XZYIANPOylpYqrXxb6MaowcQTR9J9mLosLxZvdli9AzA+XnLFfAywerycNni7pNY9BFYzrLjfutLPrwgbh57rloZQ75UZf5vSRGbM1a3r0/lQ4KMvqdlJcujqqdqETGPgb1SZuJPt9dzmqnQufZo7fSnQFLGTKVgSklaZQl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977558e7-efab-4d9e-1e49-08de05a28a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 13:08:00.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtzPNduybVuy6lsiYyhfohJBstHdEU49qHXhdk/XPww545kd1hKe8zj//XBVjM6hGzIfFZ9ZjpJwhwHrT6XpH8tnlxTFEIDFqD6liJxmllo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6731

T24gMTAvMy8yNSA5OjMzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBT
ZXAgMjUsIDIwMjUgYXQgMDU6MDI6MjdQTSArMDIwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4gQWRkIGJsb2NrIHRyYWNlIGNvbW1hbmRzIGZvciB6b25lIG9wZXJhdGlvbnMuIFRoZXNl
IGFyZSBhZGRlZCBhcyBhDQo+PiBzZXBhcmF0ZSBzZXQgb2YgJ2Jsb2NrIHRyYWNlIGNvbW1hbmRz
JyBzaGlmdGVkIGJ5IDMyYml0IHNvIHRoYXQgdGhleSBkbw0KPj4gbm90IGludGVyZmVyZSB3aXRo
IHRoZSBvbGQgMTZiaXQgd2lkZSB0cmFjZSBjb21tYW5kIGZpZWxkIGluICdzdHJ1Y3QNCj4+IGJs
a19pb190cmFjZScgYWN0aW9uLg0KPiBDYW4geW91IGV4cGxhaW4gaG93IHRoZSBjb21tYW5kcyBh
cmUgaGFuZGxlZCBmb3Igb2xkL25ldyBoZXJlPw0KPg0KPiBCZWNhdXNlIEknZCBzdGlsbCBtdWNo
IHByZWZlciB0byBzb3J0IHRoaW5ncyBvdXQgc28gdGhhdCB0aGV5IG1ha2UNCj4gc2Vuc2UgZm9y
IHRoZSBuZXcgY29kZSBpZiBwb3NzaWJsZS4gIGkuZS4gaGF2ZSBhIDMyLWJpdCBjb21tYW5kDQo+
IGFuZCAzMiBiaXQgZmxhZ3MsIGFuZCB1c2Ugc2Vuc2libGUgZW5jb2RpbmcgZm9yIHRoZSBuZXcg
b25lLCBhbmQNCj4gcmVtYXAgdGhlIHN1cHBvcnRlZCBvbmNlIHRvIHRoZSBvbGQgb3JnYW5pY2Fs
bHkgZ3Jvd24gb25lLg0KDQpTdXJlIGZvciB0aGUgb2xkIGNvbW1hbmRzIGV2ZXJ5dGhpbmcgaXMg
c3RpbGwgaW4gdGhlIGxvd2VyIDMyYml0cywgdGhpcyANCmhhcyB0aGUgbmljZSBwcm9wZXJ0eSB0
aGF0IHdlIGRvbid0IG5lZWQgdG8gZHVwbGljYXRlIGFsbCB0aGUgY29kZSBmb3IgDQp2MSBhbmQg
djIuDQoNClRoZSBjb21tYW5kcyBhZGRlZCBhZnRlcndhcmRzIGFyZSBpbnRlbmRlZCB0byBiZSBp
biB0aGUgdXBwZXIgMzJiaXRzLCANCndoaWNoIGFyZSBkaXNjYXJkZWQgaWYgdGhlIHVzZXIgcmVx
dWVzdHMgdGhlIHYxIGZvcm1hdC4NCg0KQXQgbGVhc3QgdGhpcyB3YXMgdGhlIG9yaWdpbmFsIHBs
YW4uIEkgdGhpbmsgSSBiYWRseSBtZXNzZWQgdXAgdjIgYXMgdGhlIA0KbmV3IGNvbW1hbmRzIHNo
b3VsZCByZS1zdGFydCBhdCAwIGFuZCBiZSBzaGlmdGVkIHVwIGJ5IDMyYml0cy4NCg0KDQo=
