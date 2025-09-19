Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A83043B3;
	Fri, 19 Sep 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269428; cv=fail; b=Us9CC7jxKrdUPARpozIE4/739vW+pSXsLc5UKAeSjAVx4tTI1l1uc+nd48aOy5786Ujz2WQ8UmTsxKA7iWuLz9L9dHPDLggkxW5uNSzc+DjjKe905SQaQl8fu4gqix3Vlr9haOi10y2AkZ9NfiGRuCnkcV2H4er5/+gdbQ7OXmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269428; c=relaxed/simple;
	bh=M8T4iTF5PLHl0yURrsgHAlt/9x4RHesX2OJ3TH4wD7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTVEWT12Zwi2pRpcdDaPd7hqKAmUV5MUQh3GKUDXyyRoK1+Z/Qrah+MSZewHVz4aTG1TDO3fmu2cYG3QyMvNEi3P17/9D6WM9O7T221xaFOrNrayB8nXxU+IJyChsj4njUWgJhIRrHZSkk267NbdSSfctm6//Z+hPF06gDP6mdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bWNOdYax; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eFMJom73; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bWNOdYax";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eFMJom73"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758269426; x=1789805426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M8T4iTF5PLHl0yURrsgHAlt/9x4RHesX2OJ3TH4wD7U=;
  b=bWNOdYax3ieDnosNNaFQHoOiWGlq1nYt0LLHzR0KThEfyTFRhs6Q426x
   xMS1e+TjzrMK4TBlXMorqYYic7s4c5AjmC81MINGsqEjL6KKnkmJHC9P3
   z+5+l1duM5REGNTlP23QjeeaPROu8qynh/oda+PLscKWiAPQA4MkzWfbx
   ZSHDdrlgUuKoBCB37KXO8YnZplRaVK7wWM3y8e+R5iHC2sUXE4CzXvWga
   UlVNICoJULm8jk10SUqTKLFdH4/9JhXcAD8QEHa+1yKGXike5zVaBGBM/
   vkEOb9ZB4G0cRAN+0XYAYu5Sq7Heclv63FWK1wIoWpTAXz3LRNqfDrI7e
   A==;
X-CSE-ConnectionGUID: sWg9QGy+QOmGRRPP3BWg4g==
X-CSE-MsgGUID: CAOkScwiRrqW7l95UYQlRA==
X-IronPort-AV: E=Sophos;i="6.18,277,1751212800"; 
   d="scan'208";a="124385723"
Received: from mail-westusazon11010000.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.0])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2025 16:10:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=revDyMfbhSxzMZVWIWaOCSVnbRza7Dl5ihitA8dUbDdhOhmjlJLx41hpI6hj17R4hfs0oghb0YVaHm9LjcNw75IS86B8m84TzsFVvnXj1w/N2g5PqQAFjqE2mm+9yPLPoaAniMFMMPFelCv3f3hnShOSKOXepVF6/ta9ZH1j5y0N1nWj1VxMeD5PMVv3Gft/Myv+A24jY0qqbXarW+4zEHVsDhMw3XAX/yjkyS/AadG0vZ0pvY6c+l93WrGg8XIaPQUEx4lviPC31JKCHoOG/9djUOeemUrWWaTBNqLW0XA2UepfL4iI6apUwTWVbNeaixDpHyFD4jfbC9OVwphW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8T4iTF5PLHl0yURrsgHAlt/9x4RHesX2OJ3TH4wD7U=;
 b=GuY8+7CFCJkhya4zh4v2A47SmRk8pQF7OBGQzwZ8vwL3Eqsj3DIP2n5JDSz5CFjb4QpKajJH+jfwutcaSxpf9NPF9vncSx+nhaXMaG7xu/cXGcsrje2bO22crJR9vsmAXXW8j8NwVAplbGpSV8+kCl/QaP8qMSxUE+XXcOLFb2x8o2SXo2aSsaHNZMk6q9biU31NeNMXg2cHYfG++uYBKxrl/z/drZNCXB9RIlc808aTLGkGlOjaPSxom+5GjDJPwRvn2J4r7VFXZm/f7WDzCEsCfA+Gk0i4qMq2VsjKh/MTUyHUGgjps9mLF1x5t89ZiBVBTwdFwLblBHtOoarq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8T4iTF5PLHl0yURrsgHAlt/9x4RHesX2OJ3TH4wD7U=;
 b=eFMJom73wjL9ILGd4AFUYj+7kN6PO2dyuCNAVjWhT/SrMX3kSDjMH72T5M5b9Hfy7rfaPXV8R1S6TWsGbq/+hUltGVZJ8BsrmR9HzgxkXhLVUsR2NWk988u2oLgbQLx9KDYbaWs4Dni7DbRtYybgeLct5mzg1LKIdvcmBvSkIc4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7618.namprd04.prod.outlook.com (2603:10b6:303:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 08:10:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:10:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>, Damien Le Moal
	<dlemoal@kernel.org>, hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Subject: Re: [PATCH 02/21] add definitions for BLKTRACESETUP2
Thread-Topic: [PATCH 02/21] add definitions for BLKTRACESETUP2
Thread-Index: AQHcIXn4n3nIA+bn4EammyI9ERTVZbSaMgCAgAAEtoA=
Date: Fri, 19 Sep 2025 08:10:17 +0000
Message-ID: <79911e5b-0abc-4cd5-b890-15008bbc7f84@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
 <20250909110723.75676-3-johannes.thumshirn@wdc.com>
 <4a2b3413-abdd-4dfb-8fc4-8aff78de5c8a@nvidia.com>
In-Reply-To: <4a2b3413-abdd-4dfb-8fc4-8aff78de5c8a@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7618:EE_
x-ms-office365-filtering-correlation-id: f8278d0a-eea0-4368-80e2-08ddf753f854
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?REhpdGNQaEZRUnltNjE4Q0plRVVHdjBydGN2SkhXalZ5clVtdlFGSlp3U3Bw?=
 =?utf-8?B?ZGZzaVFzcng4a2dmdnBuejZSeDNEeVhZK3liNmdqclVsV24reXVmZEtadkRQ?=
 =?utf-8?B?c09YOXB4K2NFKzU0UVhFR082VDdBbldJMU9iUnp4MGxrNTJ4THJDMFRDdS9n?=
 =?utf-8?B?Z1o1U1FKamo0eDVwMVJrckZHT2hOeUJUZnhmb29nZlJuN0dBL3dzUDA4T0Er?=
 =?utf-8?B?cFJIV3BHaVY0c0ZrSXJYeFpDcm5RRTI2MklERXZOWFlWZVR6ZTRlMjNtZlk0?=
 =?utf-8?B?ZWNzQmhpdHZVUWpwT09nUU4yc2pDM0RId3IrVEdza0w3WVlVSkxLYi9adWlN?=
 =?utf-8?B?Q2hjMXpXSlRmUUpKMkpranlpV1BGQ3FTdVczMHpmNlEwdWJWbnlPMHo0ZGNK?=
 =?utf-8?B?bmc0NE5yeVpnaTdyd2hhRmttV21tT0YwMklLTFhtRnllT0tJL0Vmb3RJMnB0?=
 =?utf-8?B?L1IxK09MZjVXYWxXT3Fnbm9RaGxhV1BsU1g1OUJ0MWUwK1A5a0dGcGVUK0Q4?=
 =?utf-8?B?V2kxREhqUUFuRlg4cGpubmN4S1BTSDIwMjlIaHpBY29nMXZrOW4rR25RNlV0?=
 =?utf-8?B?cE5oNEg3QU5acnUxMmVsM1NNUE8rOUtudUNkeFllUWNNRGNlNjcyMHdxT0hE?=
 =?utf-8?B?UlQvbGxKOHhqQ0QvTFZMWUhsTVRya0RvUk5KWGRra2xFSDcwSkRRaVZZQkdS?=
 =?utf-8?B?bUJjNHhSSDg4N05zQVBaL3pLNEZCWGVWejF0TlUwOE12WExXT00weG9SOG1H?=
 =?utf-8?B?V2dyaGtHV2xheGdDbjBDM3Z5OHAvRGRRUmI4WHFnL0ZKUGZGeVNKNzkyTy8y?=
 =?utf-8?B?eTNVK0tSVm9DQ1IwM0FFa3doWFdqVzE4c2JhdDV2UXRwZm8rM2dsSzM5eElx?=
 =?utf-8?B?RlhuNjl2RjZBSHk2RkFwb05mNGNkYXFjZjdQQ0puOE9BZXZwRTdoSk5jYTRC?=
 =?utf-8?B?aHVWYWtXVjdPWjY2ekNNekIxR0V6UXl2S0xRd0lqcFJNbUdadWFrUnVpeGZu?=
 =?utf-8?B?dmZhTHBMOURsY2NPbVB3UDFjSXhCajZKZ25VMDBRd0NtS21VaE1JbFloVDZM?=
 =?utf-8?B?cmpES0lqRVBnaXJSaXBrRWg0YWlVNS9qbC9Bb2YvNlVkQmZ5STl4UnIwSmsr?=
 =?utf-8?B?NmQwdnJhUGZDamxWQU40aFBaaHkySWY0MTErMHZjRUNiNFIvcGNQcnpmTmE2?=
 =?utf-8?B?VldBVzF1bjU3MjNNSUp4OUtTd281UzNXQkxtTkFoNENTa3ZpcmhDMUpHODgr?=
 =?utf-8?B?UXFGdjdhOVczdHFVWjd4TnAzTGFnQ3BVN0hOMjRkQnRzTG5SSWd2U0ppTkYz?=
 =?utf-8?B?T3ErcUVPZXRwR0JyeHNOVjZ4T01nanJseDhxcTZLdVFrQW4xcGtjWlE5eEV1?=
 =?utf-8?B?Nm9SMkQ0Qk1QdXJybEFFVHYrdjJ2WGc2d0RkVThPWUFiTlhEWU1oaDNaa1la?=
 =?utf-8?B?Y2FNUi9DbkpZbklBV09oczdtRHhta2N1NXVTQlU5cVRFa0tqbTNwbFE2Y0NT?=
 =?utf-8?B?Vjl6ZEgyNEVjT2VwMjVLVW1wSFhBRWttR3BFNFMrTFNWU0JiM3JoR0JzU1d2?=
 =?utf-8?B?QU9pMHpjRUFoY09KcGoya2RJRVFlUjBManQyTUt6ZXdiT1phWUEyR3VSa01o?=
 =?utf-8?B?b2ZRMXVFNDNBMzl2QTR3anR1OWtFY3U3S1ZmMnBtR0E3Vi92L09HdEk4TDdy?=
 =?utf-8?B?NmliZnMxakd2c291NEgvZHlKSm9Db3BXQXh1eXNmV25KcHVQTzgrRU44SCtS?=
 =?utf-8?B?Y29mdTlwU2g2M1NWaTNWekc4ZGpWVk43NlBCdG1DT0E1VURBTWNTM1RFRHNJ?=
 =?utf-8?B?T1R5RU0vTE5MWTVTV3l2LzhGcVR0TTE4enpMK0EzNEZmeUxvOTlLRmVWNDFq?=
 =?utf-8?B?NW9iVi9pTGovYVlGSG40b09LTWxka0g1cGYwa3M2TkwyZEdKcGV4Q0tycHRW?=
 =?utf-8?B?QXZyYkIydnZibWZJU1FqZW5DMnJBVC9QOTlESTd0ZHkxb1AwcWd6YWlwUEJo?=
 =?utf-8?B?RTYyMUM4QUtRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0E0QlFYM3JPdEg0SUkyS0MzbUhNbWxzYzNuejZpdE0wdUtSd2p4YWI0Zm1I?=
 =?utf-8?B?TFdQMVdOSjdCcXkvc2RqNlNSUStyRG1rVDcxZWlYQVFPSzBMTHprN1l3Q0pj?=
 =?utf-8?B?eE5KTjlhQ0RmcFNURVlDZkRZUm9lcWNqdzViSTBCbDBWYW9vMnhpMzdGOGVL?=
 =?utf-8?B?U2hrdVpvMzVkOU04dVlvdCt5SHV4L1FOLzhUM2p1cXVGZGlMQXVBd3ZNR0ho?=
 =?utf-8?B?RTN6d0ZXeWwxWnpBdjZmNjZmVGlJWkNpWjZtdTczcG1OdEpTLzdFbGpFbjRC?=
 =?utf-8?B?ZDRtQUhtR2Rsb1lFRGRDY1RZaitkMTFGclFJUGxxTm5OdXJicjhoTFYrSHRa?=
 =?utf-8?B?bGUxZldNSG5KdHplWkVSeG1ONk5LM1BoK0gvR3AxbXpldnBhSEtpbEg4KzNV?=
 =?utf-8?B?VnAxVGtTaU15WTdzVGZNeGR2dFhWWXh0WnlFT3l6ZU9NVUhSdzVqZjZQMjV2?=
 =?utf-8?B?S1B2SEptN0pHOTVFMVhtdGtTc3ZveG5IcmJWeUhPSGhHY1FUS3YyU3BwNVV4?=
 =?utf-8?B?VjlCMGM1d08yZmFqZnpXaEl1dWROdzBITTdBWDN2VE1MN2RKckNaRUM1OXBt?=
 =?utf-8?B?Yk9nS3JFSzlzbU9xU3NES2dVQWU5L3QxMmIxWVJVR2dTMm1RUG1GSFV6ODdl?=
 =?utf-8?B?ZFkxMDB1MmszK21WWFZlNU5EblZUcHl4NDVuc3N0M1RZQnhGNWMxcmVEQ1l0?=
 =?utf-8?B?RHpUcUxQTUVRaGEvOCs4WFpwcm9TanhaMXRVSWx0YUpWU0J2cjExbmhqeU9l?=
 =?utf-8?B?dFU1eGxLQjNkL1N6MnVZdElPQTNrT3lCZTg5VjRxR0VYd0tFMFlUbk1GdDdr?=
 =?utf-8?B?Tk9la0x6WHFLZUJZdVBXTUJxWEM5TUk3Z3hYa01EdXh4R1FEMHVBNE5raUNm?=
 =?utf-8?B?NXZvbVZBYi8vK3JnTEZDcHl1TkxMdVVreGVPaDc5cjNuMk51RkttMHJ6TXVK?=
 =?utf-8?B?QnJBYVZBS0VjMXErSGRJSFdYL3V5OXNxZHkzMm8xanVmUkZaSVNSVml0NHpK?=
 =?utf-8?B?MUIzaXBPNGJZRlpSRkNiaHFBeXlnV0Y5cHVqeGJmdVgyckxCVjg0TExncjY1?=
 =?utf-8?B?Z3AxVlB5VStBTFhIVVhNbDdIV1J4Z1FmcVVWQ2JWSll4Y1c2R0NWejdqTk9u?=
 =?utf-8?B?SURlZjdFVVlYYVlBNk1iU0ZjOVByOHM3dVpiNzZTTmxDMVZwUXVacHpuUDRt?=
 =?utf-8?B?Tk10Nk0yUDl0azBZR1lHUHpJU3J6T2ZycXZYcXBEQkN0ZElVTEtycFBUS1JF?=
 =?utf-8?B?MTBHOVNhbzhKT0dBSGhpMXk2cCtLRW5OUzB4MFp4d1pRSHlkU2N5Y21oVkJZ?=
 =?utf-8?B?UjIzLzBiVWNtZXJRckRXRFRFSnBJVnJHbHhOWEhaYkl1WCtxUW5kMzRPeWJJ?=
 =?utf-8?B?bytnOUhoV3R6T2dSbzNxQ2ZFWDUxd2tYRXBMbDMyZmFNK1VwODRIQ01aRkJo?=
 =?utf-8?B?dENSd1UwRzFkbFNjUnJmWWR2N2twRFNCTGNUWFN4YURlWjZFWUtCemJ1V1hM?=
 =?utf-8?B?YllBdFE4RjB0QkhrQ3VGc29iTzRxdGl0clR4d2RnSkhwdStjb3lHckRaSmY4?=
 =?utf-8?B?ZFgySFFTQm5aWWxHazBrcHNvZUtrUUk1aUg3OVk1bkJ6enF0a3I1NUxhUjdX?=
 =?utf-8?B?cVJTc2tCMCtiamQwbkt5a094M3RPQmQ4UWFzNGhqYnpRa0hVdGdvdlBXdWM1?=
 =?utf-8?B?QnRNNDdVamNHeEZnaXl1T3dGUUNrZGg5QUlKOUdpL2NvMnprdTRCMUZIeE5E?=
 =?utf-8?B?dVVnRGNWNDcwLzAzaEpBQXlnbFZLRlNRZjdWN05OK1dxWHhXd0FqWGR3K1k3?=
 =?utf-8?B?WnlycmJDNTVpL1d1TGNLc0c0SVBCTmZwS2JGVXlhdXJtL1Y1N2Rzb0lEV1lx?=
 =?utf-8?B?cUNvYjgrWXZ5NElNY1lPM2xDTEY5QU9OSEhnRVZucDNtRWtyWWlDYWhqT0xU?=
 =?utf-8?B?S2d4elRabnRhbFVuMUptVVFaTWxDU0tlS3RybDdmenpQVVBtK05XMGJ0anZ2?=
 =?utf-8?B?cmk1TUdBR1Q4V0VGTFJHRWNWZWY5UGVUdW1jVmI0Vk5KSXNtNHlUc3ZnM1NH?=
 =?utf-8?B?UHVvTEtETHlCUUdMTGRzWEQwbjVqYmR5TVZENzNPbU1TYzlRZkpuNHZTNm5L?=
 =?utf-8?B?Tm04eFFwdUozK3U3OTVKQ1Awdk9XdGQ1VnVYODRDdmd3M3BqT1BwM3R4QXlH?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF3749D8FC458441AAA246DD5BEBBA5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kIQGW5PJXL9AvvnI3m9jchR4F9FydxPyjJaAwco6v1a83OdmFQiO0wm0mnBCw2PUf1WEpu5vBh3TqF5oDiNMxKinBUoLx/B/bmUYteft02Bz1X/JHSg/ohKEI5FZCGCb0fVU8uXuyONrLguFsGbeYpEmioeEwEcuDovn2fu2HQTvlNaUsXi4BZcPlEenvVed/YB31IeUKangTm53VeWSGZZ7Rfj5g6dPauK1dw+dGEBtGuIJQoxfrwPxlnlpmSISeFYwGz1/EldR13dLFw3JoqWVCJ5T1l+c+d5Tf9HVWBqNYVd6VfAWqrnZW7OaB21umPc4KW3MkPITEM6Jpyt2Sck+xP/XaJXEKWV48EqbWez4K1YIFb9kQlJoLUkmdcatUCD4YYN24LqJ1z+M6Zam+rMfBvsFUmMEa10o/yJcCX3EaKZA8g3Y9sILemE8IoEm8//XCT6yMLyXeXZ9nPBmsP/BUsl3H0ndlsI9Fyg3/fkGclnaYrYsYZfvWqaG6hwFD30UU/RItveBOBmPFtT9gkGgG6nnHHimSQqig+RIP33kOLAR//HqVw96aNN1YoStEOs/Y1w4mBiBIh9YvHYyREjTUeJ6nOCefNhNMEsB3SKJ1wi4kNQ+K7pDYoKB8Ltd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8278d0a-eea0-4368-80e2-08ddf753f854
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:10:17.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sz7cVSb8S4Bpli3/vDNq+JNp7Z2n+QaWUKlKmbXTY5R/Cp4H6jTl9iUphccBcazC4tLP8SAUVjvcxDJhKx5GFMGbMj1y0Oic87niVIIVh3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7618

T24gOS8xOS8yNSA5OjUzIEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDkvOS8y
NSAwNDowNywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gU2lnbmVkLW9mZi1ieTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4g
ICAgYmxrdHJhY2VfYXBpLmggfCAxNSArKysrKysrKysrKysrKysNCj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsa3RyYWNlX2FwaS5o
IGIvYmxrdHJhY2VfYXBpLmgNCj4+IGluZGV4IDE3MmI0YzIuLjlmNDM1YTUgMTAwNjQ0DQo+PiAt
LS0gYS9ibGt0cmFjZV9hcGkuaA0KPj4gKysrIGIvYmxrdHJhY2VfYXBpLmgNCj4+IEBAIC0xMzks
OSArMTM5LDI0IEBAIHN0cnVjdCBibGtfdXNlcl90cmFjZV9zZXR1cCB7DQo+PiAgICAJX191MzIg
cGlkOw0KPj4gICAgfTsNCj4+ICAgIA0KPj4gKy8qDQo+PiArICogVXNlciBzZXR1cCBzdHJ1Y3R1
cmUgcGFzc2VkIHdpdGggQkxLVFJBQ0VTRVRVUDINCj4+ICsgKi8NCj4+ICtzdHJ1Y3QgYmxrX3Vz
ZXJfdHJhY2Vfc2V0dXAyIHsNCj4+ICsJY2hhciBuYW1lWzMyXTsJCQkvKiBvdXRwdXQgKi8NCj4+
ICsJX191NjQgYWN0X21hc2s7CQkJLyogaW5wdXQgKi8NCj4+ICsJX191MzIgYnVmX3NpemU7CQkJ
LyogaW5wdXQgKi8NCj4+ICsJX191MzIgYnVmX25yOwkJCS8qIGlucHV0ICovDQo+PiArCV9fdTY0
IHN0YXJ0X2xiYTsNCj4+ICsJX191NjQgZW5kX2xiYTsNCj4+ICsJX191MzIgcGlkOw0KPj4gKwlf
X3UzMiByZXNlcnZlZDsJCQkvKiBmb3IgZnV0dXRlIHVzZSAqLw0KPj4gK307DQo+PiArDQo+PiAg
ICAjZGVmaW5lIEJMS1RSQUNFU0VUVVAgX0lPV1IoMHgxMiwxMTUsc3RydWN0IGJsa191c2VyX3Ry
YWNlX3NldHVwKQ0KPj4gICAgI2RlZmluZSBCTEtUUkFDRVNUQVJUIF9JTygweDEyLDExNikNCj4+
ICAgICNkZWZpbmUgQkxLVFJBQ0VTVE9QIF9JTygweDEyLDExNykNCj4+ICAgICNkZWZpbmUgQkxL
VFJBQ0VURUFSRE9XTiBfSU8oMHgxMiwxMTgpDQo+PiArI2RlZmluZSBCTEtUUkFDRVNFVFVQMiBf
SU9XUigweDEyLCAxNDIsIHN0cnVjdCBibGtfdXNlcl90cmFjZV9zZXR1cDIpDQo+PiAgICANCj4+
ICAgICNlbmRpZg0KPiBUaGlzIGRlZmluaXRlbHkgbmVlZHMgYSBjb21taXQgbG9nIGV4cGxhaW5p
bmcgd2h5IHlvdSBuZWVkIHNldHVwMiBzdHJ1Y3QgYW5kDQo+IHdoYXQga2luZCBvZiBwcm9ibGVt
IGl0IGlzIHNvbHZpbmcuDQoNCldob29wc2llLCB5b3UncmUgMTAwJSByaWdodCENCg==
