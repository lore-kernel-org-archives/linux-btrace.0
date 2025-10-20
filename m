Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6625485F;
	Mon, 20 Oct 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957856; cv=fail; b=Qu2nQz9Imy5kn2P+BUf/OpXGBmWYfSIkczp7Ty5zZefHD6E/F57q9jsUEm3hLPpR7O9VjLtkxg5PsXPh4au/O4C4vT0uhmGSBInYuUV+P/waKTdK49PQQ95THXO9RntFHhoLTkYm9oTkWKP1zv6Yp+W9AVqzquhLI5zK+TD7XdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957856; c=relaxed/simple;
	bh=qtAMQJ0xGZV8qzDLHp4mDWBS1jeVgyj/zLY2UceWaIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rt70HAV077+EZxFJwzu3hvCLX0p/VqRo7KfaBAf+pNRMAzYM2kOlQcT/VEy7xRwkxD7QpsOW5H+MfxdRH2fRFDpPm3fVqonJkunwuowo5AAsX/yn861v51E/tE1t3amd41dhjZYJ3DP96b4xlz4XuhxF2oWQbtArkX9nuYUtrko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nZVPbbvq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qIaa8PmT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nZVPbbvq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qIaa8PmT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760957855; x=1792493855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qtAMQJ0xGZV8qzDLHp4mDWBS1jeVgyj/zLY2UceWaIk=;
  b=nZVPbbvqK2mmwJvxEm+rGJ2EDsjc36yuCADR8C5P1BVh44dl5NMC8AW1
   EYPecWc0oPWSy/nkmz+yWZhcVwDhZ7OlPYxO1yE8toQCz1S7PcblZ+MaT
   COMJHNppGsZaS732wY/tl8aeOd+EifQNtRWL4Yrz7r0kFv4/bCH3TzFrO
   3vcSWpGtZvKNd21b5cTlNaGDFCo9vonZ/O0E8rbdFfu6Qe5yNLsZtfOGw
   sNGMBWadI823xkAw3wV0dDEWbWtDL6T3e4DAsCXtvoO2kLE3EytoSiJbT
   EkqfxCCuYz0k2LTcqCRxTwgxzL1S/OC4D2EofyVM7fq8RQIoiBwNh+mSS
   A==;
X-CSE-ConnectionGUID: y96oGQnCSKu/hvswI/WDjA==
X-CSE-MsgGUID: d7UqyoDMR5mCisBc6pkhCg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133564973"
Received: from mail-westus3azon11012052.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.52])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 18:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eggda5nlTCeyjCUXk1oH1r6xGLISlLW10WeQXTLo+KrrBAxJUOoU58VCCqndmDY6p+MDHCc5H3sm6m7E18sXka5GRF6ZEFv6VIxMTz1W+KGheg0XfAM193iIdgBEReXcRnB/rVEdsBXI7XsyJKSDrvfk4/qFkjfykJr7/qv2gEcprkwy/JbnRSrG5wTk9/wLmh9wzmwnoZAGbzYHp+euTo221466TA3f4kGCWWECulsjMSZJApw0n1Tgn+IZFyKI18b01Ynw9r3sauRDw7Fg06tiDQjIitag+gJ9/KnCQQCtGH378/GqkqQResgsfOpWwAhe5VsPJhp2o36SnZoU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtAMQJ0xGZV8qzDLHp4mDWBS1jeVgyj/zLY2UceWaIk=;
 b=sUHzhnZITY4jtkiQ/iHANZkVwN+jQEaQYZs5XaIvuu5oGS9j8BDwMEE2sUD10vcILVP5eYbdm06Ccvq7oBWTEWlro1tHRDne0twTFR4rUSNcrlTwQ4ibxyHrd2Um56qKbBaIHpDHk8vXeT0aAbnkojNTCyFIFxeEzcp5dih34Eav9Sf3AGHMd6bNZaAOsW2SBQIEYqmgoDSc2QcGt8935XqFXI8LOWE2WdxMBvaaZJc1OkAo/ml7GHBvjw53R6hwGYjOLNSMoKgLaEgT1aYA2k52WYPyG1ro9pxu5CuyRpJOjX/T6O+ROgk0ydsidiTHhT9Xbh0/UYRgfs8m5STpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtAMQJ0xGZV8qzDLHp4mDWBS1jeVgyj/zLY2UceWaIk=;
 b=qIaa8PmT3TvaaNhi/2fwMFFO7SBV/fkeA/gBwNWSX78ArTw0fMCl8fZ9ks37jX/rTt0QPEj8iW4hTjC1v7uoIneiv8OWakhewJxXEVmKYX+M0MxvoVVMpwuPkMA4ly3AsORCLcit/d/1bmQSzUB/lMFcxxb4T2mS4YcJZY7SDTs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Mon, 20 Oct
 2025 10:57:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 10:57:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"hare@suse.de" <hare@suse.de>, "john.g.garry@oracle.com"
	<john.g.garry@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-btrace@vger.kernel.org"
	<linux-btrace@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 13/16] blktrace: add block trace commands for zone
 operations
Thread-Topic: [PATCH v3 13/16] blktrace: add block trace commands for zone
 operations
Thread-Index: AQHcPcJIco283Noj4UeyAm47GGwCSbTEW+mAgAaJOwA=
Date: Mon, 20 Oct 2025 10:57:31 +0000
Message-ID: <60ab9ea0-59df-4de3-9af7-77daf51ee067@wdc.com>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com>
 <20251015105435.527088-14-johannes.thumshirn@wdc.com>
 <20251016070847.GE1417@lst.de>
In-Reply-To: <20251016070847.GE1417@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7623:EE_
x-ms-office365-filtering-correlation-id: b9baa2fc-c53c-439a-cde2-08de0fc7779f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUpzdUNSRTRYanRWVmdrMzZaeldaWjZXVXZpeGRSb1VGdjRmVHhIZVVXZjYx?=
 =?utf-8?B?QjQ1S1ZWNXNaNW1nYWJsTmdmaHF1REhTNHRtVk1hcXA0RXhCYXAxbkNua25O?=
 =?utf-8?B?bzVQQXRiMm0xeGxzNXBuTFRxeU5VS1ZjNFg1dkNqc0U3aWd4VUd0Skcxbjg5?=
 =?utf-8?B?SnJvdzQ0M2lWV1l1RmZQUkRJN3VlYzd5U2JSZnkwM3Q4WmlzclFJRW52Y1Bn?=
 =?utf-8?B?RVdZbHVnREwyeUpydjllUDJCVnB4VkxwRDdxcDJXRzNMdEtMUU1OUDlwZWhj?=
 =?utf-8?B?MndSSzJGdnZ2RWlNVXVoWXdxWGFEMWNGL2hwaW9IallPVnRsVmwzbzV1TjlI?=
 =?utf-8?B?VjFHUTl3Z3BuWCtlNnFGQWV4WXRDMzJPa0E3eTJlR3RkQ3YrdFNjdDBpSnhC?=
 =?utf-8?B?aW5OaTFxVWpzTlR5WENoR05kV2lyZE5WdlUrVlNXcmQ1N3AxMSs0M1Y4cEN2?=
 =?utf-8?B?RWFFUkdWZ0hldTBmTWo2R3pkN0psNkd2aWhadHYxQlhoN205SWIxV2hhaW1B?=
 =?utf-8?B?K21QTXhaS2lRU3EwZ1JQeExQWTYyVk0vTjZVWVprMUtUa05iZEp0VnQxcUZF?=
 =?utf-8?B?ODg3UjlvMG1sbm9Ya1l0QlVTdVBxeENPQWc0S2pqN1pHVlltN2R4MjhKMVND?=
 =?utf-8?B?MDJXVGIxcW1vQW1MdklieGFQa3N1R2dwWmgzcTdlSFhmeEY1NzJ4NHNKeDd0?=
 =?utf-8?B?TE5KRktjVTRnWDhGSVB3N1lyV2pRMjY4NDgyRXhuZkwvWEdSS2NWWFBtZ0JT?=
 =?utf-8?B?emdPYStrUU4rbTJ0NlpFUGRSenhEbmpjbGZld290UThxN2RoM0JtNm1zRjMr?=
 =?utf-8?B?Zk5naWMxRDNEQW93czdhUXpTNXZWOWJkZy9YOElhbm9wcXVLSmt2V2VqQWJr?=
 =?utf-8?B?VEV3QkRZNXg5bWhoc0ZPTUk2Qmk1N0dTcHV5a1kyRUJaOUo0NG1LbzhuY01J?=
 =?utf-8?B?VTBTc0ROTTF5QTFEbjhpQ3hTdDF3WFNmcFRJZk1PY2VxZTk1TVdDcTRIeWVX?=
 =?utf-8?B?bHZKMlhqc0wyZytOWXc4TUdrMkc3MmM3eXVoZDJQZVV4K1d0RDc1QXNVS0t4?=
 =?utf-8?B?V3lmdUVEb0hsUUtKdjBXbnhIaFhKVDlPaWZ2ZWtFdW5KcnZQMzF4ZC90SVlP?=
 =?utf-8?B?Ym1nem01dXZxbjdGT2FPYkxQSUI4R25FVzVmQW9WVUZZdzB0VEEvM2RtdzZ6?=
 =?utf-8?B?VWZKZjMyRlFQQS9BdjFrNWJxdHBlSll2dThWTEhHNXRIQjIxU21WOGdKQzVD?=
 =?utf-8?B?N0xEUWVZc3gwQ2pjbnQzdXVpT2lVTGI4MjVZYkVnd3dqWWlRZHErNHFhaXBU?=
 =?utf-8?B?MXdCNU42d1J5MWJkM21NS0FrMzVtaDljbVVRM1RuMGNnalo0Q0NTeDZxNGhD?=
 =?utf-8?B?RG1ZR3NxcjJTdERwTTdyMEpoUjNMNWJFdXA4THJyM2RmSzdDTURobzlRRlE3?=
 =?utf-8?B?SlRyV1hScXgvSStJYk4vM3ZMaTExbmhjVnM1UG5mQWU2RHhFQlNad1BBaE5a?=
 =?utf-8?B?M0VPZ0RtS3kvODd3WTdMQmhQWi9UWDZESmxKOW8zNzE4RFV6bFdyWC9zQjg5?=
 =?utf-8?B?eWZuS2RISGFydDVZTGg0WUtvQnJHK1lnYlJPbUZZa3pvV3RDOXZtWmZhVHo0?=
 =?utf-8?B?ZUdWQ1ZhZzlHK0c1blNBSm5VYUhUaTAvL29NQ0pXb2xqM1R6TmNnWmNkWm5N?=
 =?utf-8?B?bUdxd2VFMDZNd3VDdVFGMzNpZ2trMFI2dmhDY3ZSajBWa0NicjhhMWdQRUMv?=
 =?utf-8?B?UDB6TXFKMDR5eDhCWDNZTzFwMjZFdlViVHc3eEovcTNub0NXNjJaNGU4ZzBQ?=
 =?utf-8?B?RXNlNCtRQ3prZE9JczltRDc3UlQxUXRwNDRocFAwNWh6eloyNzRkeFNqNWdV?=
 =?utf-8?B?cFVGZFBudU5JWDhOTUprZzhjSVQ1TFJoQi91RExhNDhZb0xBM2l3VGVsOGRI?=
 =?utf-8?B?QjBtYVhPMjZFVHlicjlJcjFyQjNYTlZ5ZXpKczJHeWlmK29JM0JYUGxoSThX?=
 =?utf-8?B?a3pXVHJZVFd0bVV6bzA1bzVud3FmOW9MMWR2cUVVVGsra2NBRlNUemIyQkU2?=
 =?utf-8?Q?t7j9U4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTZGUEE2Vjd6VE8yUCt2czVRdWRVMkZicjJ3TmZ5YnlXM1pQNzhRVG5LZ3di?=
 =?utf-8?B?SzFxV2RraFY4cjJjai9RQ3VYTTVIRzRPa3lvbVJIWm5wUkFRT096cml2c0Nq?=
 =?utf-8?B?R0QrQkhDbmhnVGZvbXpCZ2ltZGJNVUFxVjVwK3NFV2RSN2g5ZGV6eUVucXk3?=
 =?utf-8?B?Z1R5K2lzVU1ZVUZ2dk9sbFg2emIyakVXWHlVRFo3RnA3U0NTbHY1NW1tVlFn?=
 =?utf-8?B?TVpSbkthR2R6V1BYeTRWc09PNXlab1lseXF3dlNjTVk2dTVlb0ZtQXJZVGtT?=
 =?utf-8?B?N1M0YUI1OHBIRmhlWHgycDVLMDhIdyt2eGl3NjRQeFJCdldvK0hUQ2VZbWhY?=
 =?utf-8?B?UWQ1akU3d3V3WlZwNEcyazM2MkNSWEVFNVB6S2hvUnVmRXJHQTVyRjMvNlc3?=
 =?utf-8?B?RlZOTk9XZEZTamJxUXNqSEJBbTRLWXdIeFB3ZHJjSjEyMGx6NkxBRHBub3Ns?=
 =?utf-8?B?SnRmZkZvWGlYN1R2a3hZSUp6d3pkRDBIU3pCMmdLWXpacHQ0M0lHMUZKK2M4?=
 =?utf-8?B?Z2QzaUdZV1phUzBaNThqdjFyYTBYMHQ5ZVVnK1daRGpxSjNUY3ZsN1pxWUNO?=
 =?utf-8?B?Q0hVeWdkcWhXYkFFenVTRVRFbWJuYlZldG5CVnBMMFFyc1BJSVk3RnRla3Vy?=
 =?utf-8?B?ajFBcHBBbHhoaElXWUY2WkZCVHU1NjlNNlM2L2Y1WFNhcUFTS0RBeEFxeUMv?=
 =?utf-8?B?QVphU0NRVDdXNnlKMktxR0Rub3BSSWgrSTJrTFpUR1hxMDdyNnVZNmpWczZz?=
 =?utf-8?B?Q2FrR3dJMit1UmlabURiajNkWVlVcTlJQ3FRUU5jK09rM2xtU2p1bG5zVk5l?=
 =?utf-8?B?MFlVU2t2TzhlMFJWN0k3VlpJSGhxZVlkbWpGNW10WEsrUDVSdEh0RG5QdTBx?=
 =?utf-8?B?S2JmMWk4MlRPVjRzMURNS2RPRkVBdjR1NXpiUnJvaUFuVTN4L2s3WFk0VVRl?=
 =?utf-8?B?cW9nTUpONEtmdStnVmtTTndwK3FIdGJ3WVdEM1RJL2JwMTZQUFJxZjZPcDkr?=
 =?utf-8?B?ZFIwMUdiamxRMGtsSkRTYzRRN2R5UlRFTkwzVnlWZXFhT3VlSEJ2VjF5azdS?=
 =?utf-8?B?N1Y5ekVNMDMwR1B5YlRhS25DRDdTS2hxdjNzYkFMSkdhRXQ5TW90VHY0SFRm?=
 =?utf-8?B?TldQWGxOc1ZSMlZzUytvSjJqYWJrcWlFdjNEaUE0TWtWNUlJUlV1MVd1UExS?=
 =?utf-8?B?VU1TMDNQdUFoNjJwMnA0bzVvZTFEWlpoeXlxczJrUlBqMWtMS21FVDdnMjB1?=
 =?utf-8?B?RTdFL1JLM2cwNk90U2xEWFl5MkZsbGRBd040dkp0bEtrMlkyUXB4aXIveTdT?=
 =?utf-8?B?OGE4N0xqQ2lzYTRuMGpaNEpvR1FOcDFqQm1qaHZDV0wrNE5WN0F3UXhENUdv?=
 =?utf-8?B?RXlYbUV1dkpOd1ovOFUyK0QvdUtHMjh6VWo2cDR1eGtqNE84U2RHNFV6ZlFz?=
 =?utf-8?B?RWkzeU0xd25LWUIyTFFTMjBwYXh2T3ZxSVcydDJqS3hYbVExQ2JtZEtERzlJ?=
 =?utf-8?B?RStzeHFFS2F1MnczNGtaZ1JXREVsaDVvazJCU1owb3gvKzdlWmxxY1FtUTZY?=
 =?utf-8?B?RDIrck5ZOENJdGRsd3ZHR296UXRMSkV4UTMyVHgvL092c0FQNTBLK0l6d3ZP?=
 =?utf-8?B?dVo2Sk5FcFlBSnFYd2hRZ2gvT0hIV1Y0YTNhTVlaeEQ1U3hDWHl3RFZlQ2Yr?=
 =?utf-8?B?ZEY2dFdOdEQxV1VFN2R5QzVkNFprWGhDdWwyTmp2UDJKVGlSbHBQajgvUnJT?=
 =?utf-8?B?b3g2aHVCWFRBaXJrSzlYR1ZuZ0szV1Y5OWl2cHhtZi9yL2k0T0dTQTdZWExN?=
 =?utf-8?B?Q0NqdXJuSkRCcnJxcTFCNzlYMWp3RHQ4L2I2T25jRUR3eEcwSS9YaVhSWE5G?=
 =?utf-8?B?M1l3QzUvaEYyUnZ5WVNyS1ZTd2pvSlFuWHJoWVBzQlVndVdacmt0S0FvV3R0?=
 =?utf-8?B?TlUvM1g2cWRCQ0tyVW5PcldPUXVIK2JIR2tkQjZhQi9mV0hUTy9LRTVjaVlM?=
 =?utf-8?B?SGJDOFprazBObFVYWXJNcERLU2VUOVNNRDZDU2dONnZwZ0tNRlcyTzhMcHp6?=
 =?utf-8?B?Nnl0UWovc1pBMlVERElVN25iMk1rYmJOZFdyMkNaazYxWkFuNjBCbVJOWjBP?=
 =?utf-8?B?TGpSREwvZVlDMUxVaUhCYTJPalJLdUcrNzZSVUl3bDVGVkRIM1FLZ1dLWW95?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FCA8323B610864582C369055ED8F426@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wkl+64C3ADyFwu2E720zWH1kBM3gtb8JetNxalGpg+uem9hiT35ly8HAX7oR4ttKfkPpKnPBcE8TpenVel2pxeGtvncXB+BQsHd5BZfu+Cb0Q1gGbtoTgP5S9sxvfCg5Inn5pOeiov3m37cdRneEilxevHXmO+Ye6pJcr0jSE+yowna+qJV2kUuvDcys+JPpbzbJLeEbATvtCpmOXKuy9cAX9gLuoa7AxcsH/vZ+BtgV5HS3WikGQ4XkYjDIo3IqT4M6P9j9cV6NNGar79fctk9GQgKGLX1mia16kldQc9pElp2NzkRN7bFqpXlENpXuOFkJme7heTCCDLP/wui+Yy3fxtR+a2qzvLPPPahrwhZnj9xGqK3vsrK+YuDWor0Qw/MMHr6YYAQ/a2fRay+HQi6fcPNuYuBWj2y2QV6GRB8uG6dmDn5d3jYSXOdWSAhN5UAQMFoOOB5FU12ENIR3oIjosk1mwt6D+eHYgh/e/gfe1AX5hAewQuwYstCwRUOG2j4PhiDEsnNUwlRqO2IFZGkZlqqvizKqHDof62LbOrk/NRIuJyukzqQSuB7mw/MWB0ky+mnAr3NwTry/tgNmH3ENsRn4ph11CELTMO1x/EU6hYFPz6emcwQ6kn2Y6sAr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9baa2fc-c53c-439a-cde2-08de0fc7779f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 10:57:31.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NHeXUtaX3OE3Tqa6ClcowFTi2kQqgkqcUncdm0neY1rCNp3MQ2Vc4gNWlVFjjYZspLQnDyUC7/AGsTppmWX/kgtLiUNv4niggI8ayU+Z7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623

T24gMTAvMTYvMjUgOTowOSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwg
T2N0IDE1LCAyMDI1IGF0IDEyOjU0OjMyUE0gKzAyMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90
ZToNCj4+IEFkZCBibG9jayB0cmFjZSBjb21tYW5kcyBmb3Igem9uZSBvcGVyYXRpb25zLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3RyYWNlX2FwaS5o
IHwgMTMgKysrKysrKysrKystLQ0KPj4gICBrZXJuZWwvdHJhY2UvYmxrdHJhY2UuYyAgICAgICAg
ICAgfCAyNSArKysrKysrKysrKysrKysrKysrKystLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
MzIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2xpbnV4L2Jsa3RyYWNlX2FwaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3Ry
YWNlX2FwaS5oDQo+PiBpbmRleCAzYTc3MWI5ODAyYWEuLjkyNWY3OGFmOTM5ZSAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt0cmFjZV9hcGkuaA0KPj4gKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L2Jsa3RyYWNlX2FwaS5oDQo+PiBAQCAtMjYsMTEgKzI2LDIwIEBAIGVudW0g
YmxrdHJhY2VfY2F0IHsNCj4+ICAgCUJMS19UQ19EUlZfREFUQQk9IDEgPDwgMTQsCS8qIGJpbmFy
eSBwZXItZHJpdmVyIGRhdGEgKi8NCj4+ICAgCUJMS19UQ19GVUEJPSAxIDw8IDE1LAkvKiBmdWEg
cmVxdWVzdHMgKi8NCj4+ICAgDQo+PiAtCUJMS19UQ19FTkQJPSAxIDw8IDE1LAkvKiB3ZSd2ZSBy
dW4gb3V0IG9mIGJpdHMhICovDQo+PiArCUJMS19UQ19FTkRfVjEJPSAxIDw8IDE1LAkvKiB3ZSd2
ZSBydW4gb3V0IG9mIGJpdHMhICovDQo+PiArDQo+PiArCUJMS19UQ19aT05FX0FQUEVORAk9IDF1
bGwgPDwgMTYsICAJLyogem9uZSBhcHBlbmQgKi8NCj4gU2hvdWxkIEJMS19UQ19aT05FX0FQUEVO
RCBiZSBCTEtfVENfRU5EX1YxPyAgT3IgaXMgQkxLX1RDX0VORF9WMSBnb2luZw0KPiBvdCBiZSB1
c2VkIGFzIHRoZSBjYXRjaGFsbCBmb3IgZXZlcnl0aGluZyBub3QgcmVwb3J0ZWQgaW4gdjE/DQpC
TEtfVENfRU5EX1YxIGlzIGVxdWFsIHRvIEJMS19UQ19GVUEsIGJ1dCBhdCB0aGUgbW9tZW50IHdl
J3JlIG5vdCBkb2luZyANCmFueXRoaW5nIHdpdGggaXQuIEknbGwgYWRkIGEgV0FSTl9PTigpIGlu
IGNhc2UgYnQtPnZlcnNpb24gMSBpcyANCnJlcXVlc3RlZCBhbmQgYSBhY3Rpb24gPiBCTEtfVENf
RU5EX1YxIGlzIHBhc3NlZCBpbi4NCg==
