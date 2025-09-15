Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C12EA17F;
	Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923163; cv=fail; b=qJ55nWg8a5j212vKInGuM52XSkXFea7a4lKI4RxkEMCzKRPQaQD23Qap9mK7HwK5SCHYAlRgHefmBLrNOJVJvgJE9Mp/dpEcp7tZsEF5C5lisiYGwDYuvMszhliXKw9p7sG4enxsD4LJfAI8F+qOVXrPJQB17lAvL6wKga1TIPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923163; c=relaxed/simple;
	bh=lZXoFl9QvEKXURS+HB3V3yiBMVb7EokZyonxPEST5Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nM1jX+X3T3U2fxkF21iP70vOWA3Omc7AJMN2sGlO2IqhT1CSA5NH1eglaBXwYfhsAtVF3OBNG0rQMppCw45lGWA62e0RKAJI7RFshZLnzOAjCSXi0zE9suuW+U4IbvP3F1y4s/j5Kba9OtRF/ycGwqKSpxpNTb6JYh+mk4FmpPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hAXHiTNK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rc17ziWp; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hAXHiTNK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rc17ziWp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757923161; x=1789459161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lZXoFl9QvEKXURS+HB3V3yiBMVb7EokZyonxPEST5Ac=;
  b=hAXHiTNKOL/cJxMRxs3fFujjhRjbke6liB4/vjR4+NQpQD7obmlGRA+x
   mF3QHk5W0IglhrATkpG7CzBqEpvcjrc9czBRYq43Ab8eg0y8oiDF6pskL
   VLzSOXsZs10XYpjFxryjccknEUrH6jZ3az8umPaDbYhASseswI8XNvSIU
   OsJVaE5bBM4Z2oj8dYvsQPjAVRinlhOtSJVBWPOLPxJoe0Q4FZvd3bkhw
   yW6LIwxccbJNi3MMF4AibsnswvFW2+eaFGSz3daB5DVgppwqgYV3ZSvJS
   XNSOf0SeNE8r7+Vv/uyPEtBqk+PefFsKq5XTmyrrm8LjvpscrqL+LdMWU
   Q==;
X-CSE-ConnectionGUID: lizXjkMqQ4mMB3Mb9eB3Sw==
X-CSE-MsgGUID: 1ZXiwijQSSiR7mnSgEvrOQ==
X-IronPort-AV: E=Sophos;i="6.18,265,1751212800"; 
   d="scan'208";a="120197150"
Received: from mail-westus2azon11012033.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.33])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2025 15:59:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4TT8G7l6SypqTlE7gCOnJiPkREXNvRcSmihcZFxs8azpVIw2fwWErR4fiEUjMDRTq20XzNcQJaHQe8jR21nhgup0q4N6WMzSGvNhTZtYDZR+iaiu9MbQJNuwmjOrsH1YDBKHSmXAjEcUhKJorWmldakP4xnlu63c9b4Hzh7Bxs9eZIW+Ui/i0fZZ2vSZUTMjv+Dd/INY9ZA4v0AM2lnWEmio7Fb4V3Hh+d1W3dAQo09EQ/xUCD9Tzp0ZltT09YGYwwg2wqCbRbIO7rUTYWlMawcv1DE49pg22Prv9f4qVVsAAgU2GiY6gJ1NeGJDAveS2olzBK0bpotT5EZ8Pws8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZXoFl9QvEKXURS+HB3V3yiBMVb7EokZyonxPEST5Ac=;
 b=Wy/LsyUCDj84XWSUe410ydyhasrBoJqE1AaVEmbCSCZ8nCLBfHiXrnujpibYvsqA7uuYSx0g5TJXsu9QP/zKNT9KzpFfvN3JS4WzOMkzjRjOBZpJ5BTSRr4xyGxGXLmv3KlACCSArYurbFv2Rm3pTowjlnGmGBys6HAwi4d14w4e0jNKotJ569/Bo/FycULEeeFr/B24/QM6hsNcv/MboziSpISa4wWPOeqATeN4jerxqttL2b0sN5+EsubWrY4UmabX5DceNIVpJsXHhfneo/uKTjyQ0NAj+WqzdP0i7rf+YmJ88GCwMK935J0LpZTgItm4FO8UoGc8rYwqls5o8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZXoFl9QvEKXURS+HB3V3yiBMVb7EokZyonxPEST5Ac=;
 b=rc17ziWpkBkV/DLdFTWkH7GKX0W0D8uuNtLltR+mTxnGWe8RQGVF2AV95AjxurLPqw5Vbe8aGd+NJ/5QkOF3gxmS2OmbJ3cZk8KVGiqxg4vQwalGMaKCSZpqwCccLKk9dh5szOUrVOyklmj9BoLIdhzcJV0ZJs8w5rQIXIgO5GM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6608.namprd04.prod.outlook.com (2603:10b6:5:1b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 07:59:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:59:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>, Damien Le Moal
	<dlemoal@kernel.org>, hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 00/21] blktrace: Add user-space support for zoned command
 tracing
Thread-Topic: [PATCH 00/21] blktrace: Add user-space support for zoned command
 tracing
Thread-Index: AQHcIXn0qs8inh1ZqE6CIqOKF3B+QrSSbhWAgAF8NIA=
Date: Mon, 15 Sep 2025 07:59:11 +0000
Message-ID: <fd3562c2-559c-49c7-8ef3-6e053cd6a41e@wdc.com>
References: <20250909110723.75676-1-johannes.thumshirn@wdc.com>
 <20250914181823.a17382ac3a039dc4a8257578@kernel.org>
In-Reply-To: <20250914181823.a17382ac3a039dc4a8257578@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6608:EE_
x-ms-office365-filtering-correlation-id: 13c009a0-d556-4d90-0138-08ddf42dc1bc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnNLSWZiMlhHTUYyOERwWG01V2Z2OTg2dHM3TWpHTlMzeHZ3QnNMdVhvZDE4?=
 =?utf-8?B?MERpdXhBemk5Tmk0LzhnWkxzRjJxbUtVT2F4dmx3eCt4TG9FZmVUUE5YV2VZ?=
 =?utf-8?B?VEJ4WkUyekFsVnoyODg3MHZ2ck0vcm9TcmFvVWQrT0VxZmNsbHduMExnTGM2?=
 =?utf-8?B?Szl3VTRaZlJRM3puelFFSDR2UnpUaGtGRHpFaEIyOS9NNm53cnI2d3RwR1NC?=
 =?utf-8?B?bGNwRnQvUUxjQ1dKa2tKMUxLR3AvNFpVeUk2QVBXYkJTNTNtV3dIMkViQzUr?=
 =?utf-8?B?V2ZsUGtleC9uRVFBUmM2dXM0dUlYUU5RUmg4YWZXSVlJdWFGRFR1WGpZdk03?=
 =?utf-8?B?N3M5MS9VcEpUNjUyUjBFT0xzdlhhU1cybGJ6U2dSOHlYZzlZRjBST01jaWJ0?=
 =?utf-8?B?VHo4aktEOFpIK1ZXVHZ2WFRCbXFUQkhDRzFEQTZtQjhWanBNWVc2Y2dEOTJB?=
 =?utf-8?B?bWY5S3dHTldDQlRJSzEzczZlUzd4dGNkTmlXQUxjL2dnNCtoYks5WWRoUi9N?=
 =?utf-8?B?Ymx0c2FUZ3VObkxjbHIzcCtueWpWQ1Vhajc2MTI1ZEpDR3ptTFlieXBWY3R0?=
 =?utf-8?B?N3Zyb0NRRzFrRnluUFNESnpzamoweURLSHdWYXphNHl4R24wSSswaGNZcE8x?=
 =?utf-8?B?YTdkZFR0RXltSm1zWTNnNXBMdmhxY215ckdzS040N0VSTWFOR1FpOVROWFBF?=
 =?utf-8?B?UDJ3ODhRWGJRK1FmaGkrM2Zua3ZPUVJ3T1V6c0RkLzFPa1FycnRpMmR5REhC?=
 =?utf-8?B?ZlZDWG44NURPTkU1Mkw5ZHZHeFg0eWlEUnBZWVRJcmQwVW1hOG5hQmFhU09L?=
 =?utf-8?B?bFVwWElJY1I0bk43NU5ORTAwamYzYXNaQzZVQ01Ud01hNkM2SUN4YXg3Y21k?=
 =?utf-8?B?RDY5aks3VFZpMERpbVUzSUpXdXJWdFBod3ZCTC9OUElBRHVPN2VYSEZPR2Vq?=
 =?utf-8?B?LzROdUdLcHFrT3dXRzFwWmpVeUcvSkJnNDR0MU5OR2ZVZmxKSVNKS2xtbUlp?=
 =?utf-8?B?SnU2bjU4TUhQUFlhdXBmanFBY3RWK1B6ODBXNWxJdkpaaERWWndjemxacDVD?=
 =?utf-8?B?cVNkd1ZKc3FSTVVuOWcva2M2U2dpck9BMS80blptOFFDeUFxWVAvMzNYYm1S?=
 =?utf-8?B?V2VrL29QZ0ZISjBHU2hlaTB0TGcrKzQ4TlFqNlBDUjhEZnJXWSsvek9tQjZi?=
 =?utf-8?B?UDlWbzl4a2tXaUVkc3U5VFRia1NHeGdNODhJclU2a2tOTW5jcHNocjNnUW5I?=
 =?utf-8?B?bThvY1dkTDNIMTRWbEdzbThBZk9QT3Z3WUpLRC9MMGlPQXNJOWVLY3k1Y2pr?=
 =?utf-8?B?NllETTl6dGV5TjB3UFhITmZ3Z1ZmbG9jTzhMZ29jWThNMHdIQUZDSjlBUXpC?=
 =?utf-8?B?OFpNVmxYSDc1Q0FyL09WOEdmMTlTVVVBRURNY1paeUFlcXpsUkZsQnkrMUhV?=
 =?utf-8?B?Z3c0Nk9mWjVrZVlTSkZ2ZVhHa3BJTENpS3RJRndjRDJ5eGp6aE1oWm5TdElO?=
 =?utf-8?B?K2lrNUdlN2tXR3lvY2ZZWFd6ekRIYXpVbFdNYVRUelJUYzhYKzk2YTN4MVFz?=
 =?utf-8?B?REJYa25FRUFIYTdJK0FtcHBzQkNaaytwMXhmTWZld01odmQwNWEzNVBrZmw2?=
 =?utf-8?B?NUZEclBpTDcvZU5DaWxLOE9LVW9pcDlOcjJLd1lqYXhvRXRWL0VmM0MwSUhO?=
 =?utf-8?B?WVpjbXpkWGtkYkd4d1Qva2tmUVZpcDFJblhETm5jMjVlcmM1NHFtMTZzUjJm?=
 =?utf-8?B?Smo3OG5YVE5rTW9FcFk5RlFMTXlkZHVMU1h6UGFBdnU0WmtIKzEwVjdHWEhy?=
 =?utf-8?B?a1pjWXNla3JGUjhPZzhBWFFTcUlmcFRiTU12ZkRFOVJNcnpyRFN6ZDROYWZt?=
 =?utf-8?B?UVlsT1NWS3M4SE12N0N5M0k2dExkRWM1MEFjeEg4UDZsZzVGcXIrR2dVc1ds?=
 =?utf-8?Q?DV4TsPhtsiw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWtXZnVRMllxcjIvaVg0YVdnaXRlUkw0SUNVTkdjekRkbzUwWW1HV2R2bjFv?=
 =?utf-8?B?RmRqUjNYdDUyMXI0aEhSNHg0VW5yNmpESEF2Q0ozSTdtMDJoYzYwRjlMWTYw?=
 =?utf-8?B?YTlkcWF4a3RsNmFablZXd3R4ZElPUWJVWktBbUpWMHZHTWlpRG05aU5HQnFT?=
 =?utf-8?B?am92Wk03N1VBZHROekdJSldDQXNiM2Y4R3ZreXdHSkRDZGRXZHQzQ0QrRjBH?=
 =?utf-8?B?dnR1WXkwamFpczJoUi85bk5hT3p3Szg4dWk2QnhUM2R6T2hrN2E4UzRUU1Fx?=
 =?utf-8?B?VXhiRkY3OEV0Vy9RVjIxOXY4N3FJblR3MTVjbXpMSUJ3WU1wZy8zVVR6ZElu?=
 =?utf-8?B?b3RyRnl5MG5ZZkpzSFhpcVNDc3RuMGFybDRDb1lTYWdkeFZESkNvR3haY2R1?=
 =?utf-8?B?em8xdVcvMU4zRXc1WkNnVVlaVXlieXlGcXdSakJVbnUwenFUd2szMnZZQUt0?=
 =?utf-8?B?WkJ5dFhXOEhlSVhLamE1WlYvVGRoOU52bVFWeUlNZkprMVY0eU0wY1JuR2Jq?=
 =?utf-8?B?UmNjVVZWT0xjcXRKb05QQlBtL0N3YTQ3eThGSmF2NTFpMFRxc0tyUVVkbVd2?=
 =?utf-8?B?R2pWUHhvbWlDOFRDYUxpdDdpbFlTT3Y2YldVYm1nY0d2M29XS2RMWnZnbTBj?=
 =?utf-8?B?SHVmaDdtaUhMVjVYM2gvUmxFWVRkOEVwR1VlL2VHQUNrU0dlRkZvbWtHWURj?=
 =?utf-8?B?OGFwTXZxRXRaZ2tub2VNNnloRXNybVZWNFBNSVJrb3UwcUNmZTFzcVRRQXp0?=
 =?utf-8?B?WWh5MzNkUWxzUG16R0d6c055bTk4Z3IwMTBsWnEwQm5aOTl6ZFM4RVRNbzhX?=
 =?utf-8?B?VzhrSnRway9VcFpobDJaTmxJd1ZQSU1QY2RxWnhKTU8wRGZTZnNqb0h4cVZq?=
 =?utf-8?B?NVh0T1hZbmlCbUV2SXQ1SCt6LzluM2s4SGlMNCszbTBVM0kzWHA1enkxdkxp?=
 =?utf-8?B?R1lQbUdibEg4TElVWDlTS2tHT0NQMG1aMkU1U05PVXNadDJCR1lISmQ1Mnh0?=
 =?utf-8?B?b0RhVHB1WEMrQm5NYmdlSVREYXVIWlIrNFBYNmZ6V0pxY0x5aGdlRWE4N2s4?=
 =?utf-8?B?bDVFTDJMRlMxVmswNnlsUnJrc1d6SUhMQ3lTbVRzK254MDZJb0tHNGo5cGlh?=
 =?utf-8?B?YVFXYkJ5YnJTOHdiWFRqYWIvOTlOZGdwaFFxL01EdkZKSlRFM21uZ1lUNjVq?=
 =?utf-8?B?bi9YMW8xaGJZdkRTNmxkUzZwSGdwdCtoTmJ5WkdOQzdoOFdjM3F2ZCtiK1VZ?=
 =?utf-8?B?Si9XRFBmSFhmc05iekRhNmxUTzBhZGdJNExtR2NoNk5DM1ArdnV3Q1ZSZ3pH?=
 =?utf-8?B?NHl3amRaZ3JLZmgwNmdia2ZtSU9PeUxMeVRTTkJNZCtkcGJ0SlB0UWkxSDdn?=
 =?utf-8?B?VlVpMU1nNGdRdkNoUG9hLyt1emMrQUkvamFhbm94NnYvQmwyTXd4cjVTNEhJ?=
 =?utf-8?B?aHE5eExvbXZ0SFNSWUxraFpvcFF0eEMyMEtTbDU1L05LQ080V0lMSEJNK21R?=
 =?utf-8?B?TkxFOE5DV1VyNlI1RU1LVlRiUG9neVpPZm5wa1IyMitWcnhwZTNiYnBad21s?=
 =?utf-8?B?K3VKNy9OeUQ0TUxaUTRDbW1ubGRrajJRbGxqOGRpSDh0M2tFNlZWZVlRRnlX?=
 =?utf-8?B?UHU4QzdRWUVjTzhUZGp2ZkV4TUJHU09rWkMyQjQrNU5YM2NNSUw0VGprVWFi?=
 =?utf-8?B?TjdxTHVjSzhuNmpzS2UxeXVIT2NTQ21SejRGUjJHQlRTaFM0azdBKzMzcXZH?=
 =?utf-8?B?ZTM0STF1TmVmOGNKMXppRWF4MkRndGtkOTFjeGtVR0ZxaDFVYW5lNm5YRkRk?=
 =?utf-8?B?U3FmTFg2T2o2aGJpTnArYzVTOUU1NzhiVDJobUpOZzFWdUxKOGdKQXRTL3Vh?=
 =?utf-8?B?Ly9LU0dpM2E4TkVzVGNsVkFaV1R3Vm4rejAxRWphM3lyKzhNNWxNMEpMYTNT?=
 =?utf-8?B?MkpXUHhvUmJKNTMrRWhIWk1FQkRKQUtmbC9EZkt2WHlrR1UvQlNhREV4bW1N?=
 =?utf-8?B?Y3hTaDJ1aVg4emhzZ2pKdWc5L0YvOEVCL3ZENnFCTGxiNmNFSlZPQ0FlMC9N?=
 =?utf-8?B?L25pbmFBQVpGUC9oSEJPK1Q0ME5zdjVDbGZid2NXN2w4TU4xWi9LUmt1bUtp?=
 =?utf-8?B?MHk2ME9jc0NQc2x4dFFJVmpuMDBieVZpM0VkcEpEN2pVbnhZZE43ek1ERldF?=
 =?utf-8?B?WHdSelJmWXNxeS96UW56dXhlajViMlMzblJaNXZtMVdleHZQYW9FMUFzNTBC?=
 =?utf-8?B?WVJlbktHM09zaU91SVJZdE1ZMENBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1920FAE65101B4F949706B60E52BF06@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V/ci8Ocj8K3P26O1N0CELz1bmY1tG9qp4vzToCwiLocpLQlb4vU/4IgXCzGG340K5mawEitjoaNpHX+BzOHyAdcwdGdngWBOEEuWMUNxsdlB8OAHEZw/ej6vyYSciV4mZ8nQ7jM7BW2KyJZT2fq3FMX5edRFsysot6ru1/CtJfVh96rKMMjcizfSynJRAd8wrfY0a2KmZxatOxIvZaa16R1GfXkPa/795KB8HZVsFz8WIO9UXl2T6KfDHAC8+AZczksWbRiRRuttTK2n4Col6BLQhvaAnIEl1ka09eA2jIYIoaKTxhv0iMa8zwLuOSlUneY2XftqdqCJxZBxIqqShOmu8s1OVE21wDEI0x5ELythNXliOvKq05UPqWovRcCWr9kYQW5mqGjo465qV8Aqya3efWgiSpIqbaqUq03U87qi0bdO64sKWI0Qf2XAiaEsc0oDDTlZO3kbwyn8ZSCRrXMSb9+uObmxZTEgH/124e2+7bT92ts2OykEyWjwaxlYzMaodzYAkYHFbB0WTdUwDMKDLQeSB1Ss8W1ezFcd9wzInvqyvswr0QjcDOE6J4CKYZ/rOqJIbDnrSNaTkNv+QMIdAAGBktHNdZpvfV5k0FcPPhoYdmIKAii6rZK81ApV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c009a0-d556-4d90-0138-08ddf42dc1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 07:59:11.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY8yIQQhfoK/1q3o9R4Men0dbkUPoioeO/DdJTZGa2Fe/nTLgTOOzfoIYfhDSuJHnz0O9/nZ9dGhuH5ziSC8QRUfsQ7pwKdX2t1IHVynOdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6608

T24gOS8xNC8yNSAxMToxOCBBTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gSGkgSm9oYW5u
ZXMsDQo+DQo+IE9uIFR1ZSwgIDkgU2VwIDIwMjUgMTM6MDc6MDIgKzAyMDANCj4gSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+DQo+PiBUaGlz
IHBhdGNoIHNlcmllcyBleHRlbmRzIHRoZSB1c2VyLXNwYWNlIGJsa3RyYWNlIHRvb2xzIHRvIHN1
cHBvcnQgdGhlIG5ldw0KPj4gdHJhY2UgZXZlbnRzIGZvciB6b25lZCBibG9jayBkZXZpY2UgY29t
bWFuZHMgaW50cm9kdWNlZCBpbiB0aGUgY29ycmVzcG9uZGluZw0KPj4ga2VybmVsIHBhdGNoIHNl
cmllcy4NCj4gSSBndWVzcyB0aGlzIHNlcmllcyBhcmUgcGF0Y2hlcyBhZ2FpbnN0IGZvciB1c2Vy
LXNwYWNlIGJsa3RyYWNlIHRvb2wNCj4NCj4gaHR0cHM6Ly9naXQua2VybmVsLmRrLz9wPWJsa3Ry
YWNlLmdpdA0KPg0KPiBBbmQgdGhlIHVwZGF0ZXMgZGVwZW5kcyBvbiB0aGUga2VybmVsIHNpZGUg
dXBkYXRlIG9mIHlvdXIgc2VyaWVzOw0KPg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNTA5MDkxMTA2MTEuNzU1NTktMS1qb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbS8NCj4NCj4g
UmlnaHQ/DQo+IEknbSBub3Qgc3VyZSBob3cgdGhlIGJsa3RyYWNlIHRvb2wgZGV2ZWxvcG1lbnQg
aXMgbWFuYWdlZCwgYnV0IHBsZWFzZSBtYWtlDQo+IHN1cmUgdGhpcyBzZXJpZXMgaXMgbm90IGZv
ciB0aGUga2VybmVsLiAoYWgsIGJvdGggaGFzIGJsa3RyYWNlOiB0YWcsIGhtbW0pDQoNCllvdSdy
ZSByaWdodC4gSSdsbCBhZGQgYSBzdWJqZWN0IHByZWZpeCBmb3IgdjIgc28gdGhleSBjYW4gYmUg
YmV0dGVyIA0KZGlzdGluZ3Vpc2hlZC4NCg0KVGhhbmtzLA0KIMKgwqDCoCBKb2hhbm5lcw0K
