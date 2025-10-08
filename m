Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811B190685;
	Wed,  8 Oct 2025 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904179; cv=fail; b=hGkaedc6J5Lt9wrtq0ffkMK9Hdaj8BMU1F7aVUJUcvX4ZVHf2A2o/Hu+9KaQ2hqR88o6wWTgFSnzM7xiOuODfGco1Lh92lHqGMAZAD3XUQvl0jc5ghZ/7NNxNUy9Be7Wz7RqlW+xjd6ThMcuuGKyAzm0Hnjbh9UDWFtNhGsVrVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904179; c=relaxed/simple;
	bh=0NPR2sHcwcNSlORNKn8xK9jPyJmSKZR16vR69Gy09dE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovTWl2FC+wXlEMlo9gN/6w3ZARZaSIRlJeZQT5CoTcZnPCoj4ZWOTGckNoV+FEJTm4YcDb82CivjtaKVx1BfrfnzKqY8lLWdubvI7gAV/P6mmFTCyuoYpUcG2c80dxADxi9buDvOWD2MtsCcc4yhf7j7++HdDR8aR1ecT2+te+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PGXLPP3g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YEOeyu7I; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PGXLPP3g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YEOeyu7I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759904177; x=1791440177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0NPR2sHcwcNSlORNKn8xK9jPyJmSKZR16vR69Gy09dE=;
  b=PGXLPP3gk32Wqj8pH++2LHgEwhirTy2L1DSoCw0pWzFYJmGBshdcpF2g
   sY9Ss680GJNfYppVF8IfL2Q6ZsPFAcAH1vSl/CTt68rX3TGcY+YhcrBLx
   j14Iei50M0uoMUCovZfcNvY5TURRPg2u6C+KZAiixji1726APBrO56TD1
   Vg/IDEX2I77d9YUnmv1pRt/RWZff82IwNQvD+bjs6YRIYcgHBROLqUYzZ
   hXAavOFeiGkIedgCr46pIgsZdMo1iEvDLpy1n4V8GDepbPM3+gqxI9r0S
   oHrIQVEHAv2GOtFYUNQVMucezeurfQugTwcA4TpLvKF6/TZeOlghSR18/
   Q==;
X-CSE-ConnectionGUID: v6yQtxr8SACEsuTT9gJh9Q==
X-CSE-MsgGUID: ggapN03WQ46mQ8Qyex+xOw==
X-IronPort-AV: E=Sophos;i="6.18,323,1751212800"; 
   d="scan'208";a="129826310"
Received: from mail-westcentralusazon11010049.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.49])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 14:16:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paS5zi3eM0UBXb3DrXfv4EnxJMFa30ofRfiWgz5vN7YXHatvVV+4zldbAk1hlsb/KYaCHNnnVU8N9Un/tiYrzwzD5FDxZdt5UNoTpGqlPjQTq7z5eyYPkae2UACnsETI6/c7GhhvjAz5FJJhVAC5N2opFFzzumC8KdtvZhqXVfEc7i6Bhq/IzTJ1ZEUycdNPVry/8jgpBlNMdV5jqCn305VcxpZ8njU88P5WHnDmLDt0P2fr8YtVBry0hGaC8eUyar4Yq6tXxmHjl4PndjO85X+ojp8nQcFyBc0GPEmC7IuROpJV/FQpeLZttInQt0DCJx6uWcijr+5mz0N2kW3OWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NPR2sHcwcNSlORNKn8xK9jPyJmSKZR16vR69Gy09dE=;
 b=jy8jtqCcTzGfeHJaLaQ36Ea6bLHsl35M5UHSl9lX7DMOsu5X3JBEJQmUTG3R1iR0iOT7uJGqvP1+Mm/X2dWqteKdjPTyrLPhUPi6ZfLd+UcJZUpTsBB6nKKmbDvptX5ieGIXy1aNn17aObsOVoYS1do6i4Eno451r9a7Xd81IHI2vtvFNK5Fhu+owuOQJYk/AinzHA5iFjW/RLY7q+RB3g8uMIBfsj48Hv9dFWCHlzS9vgLE+drt18ObJbxX6sqV0HyQnaImLeU5UI5LunHChgdi6E41VHjvk3/KeXDOc3rqUz/+f7gn0r1NYrg98DVqOSbnVHgviigDnVhmOBEnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NPR2sHcwcNSlORNKn8xK9jPyJmSKZR16vR69Gy09dE=;
 b=YEOeyu7IVJWJQubRtoCd5IMXuGQQUBLlhSeW39bQ7iJljYZ8bzoY2TR8mUt8bXo03mTGDioo2hSud1KMBx78hbdaYBZGsGyXW5Kpe6C9yxVw3yi4BBstU+KuVu5plgwMJAi2OUnVRuWOwT+tKTTBvqv7jCooOCvtwXv63R5hj+Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7017.namprd04.prod.outlook.com (2603:10b6:5:24e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 06:16:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 06:16:11 +0000
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
Thread-Index: AQHcLi2P41isIe1XeUeby1yqta+5krSwE4WAgAam7oCAAR6vAIAAAJcA
Date: Wed, 8 Oct 2025 06:16:11 +0000
Message-ID: <4a5ce076-632c-4d58-bb43-c31f41ab06a5@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-12-johannes.thumshirn@wdc.com>
 <20251003073257.GE12624@lst.de>
 <4638c185-ac5c-41e3-8c79-5c995228ec0e@wdc.com>
 <20251008061403.GA13979@lst.de>
In-Reply-To: <20251008061403.GA13979@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB7017:EE_
x-ms-office365-filtering-correlation-id: fbb879e1-3d64-436a-ab52-08de06322d78
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWZFWHc2cVNoRkxUb1ZscitoKzQ1VXh0aVFHWUxGcW5sQU1SR1BISVlOZHFn?=
 =?utf-8?B?MkdmSmlvSFg3czVDRWlHNitnbFFaOGNMYVV4aVYydzl0VS95N2xzcTVVSFVS?=
 =?utf-8?B?Mkh4YXdFR2ozdlN2WTlicnBMbm02NE5lb3FickpqODJjZThmQm1veVhHNGQw?=
 =?utf-8?B?ZXVXdDArZSsyYmhIS3g2VXVLOTZ5clliUTdYaGNkQ2R0bjRONWV3SWtqREs3?=
 =?utf-8?B?eVBpNktlTFk1NU4vbEUwZTVtZTVZR0lsK2I5RVNObDBMSnBrOUIvREFGdHk1?=
 =?utf-8?B?TUExZjRoVmQzNU1FbmJpQzladmZOejBUVFE1YzByMGRseG5FdlNPZGhwaFg2?=
 =?utf-8?B?NkpQdGdGRGhuVTRSeUx3eUxMUUloN0huMVNGS09RMDc4aktHT2lmQmVzWGYx?=
 =?utf-8?B?VE4yajlUMHRFMC8ySWJRdG0yYjFWUGNHWStVcFBjajBVcGwrU0srZmJheGNB?=
 =?utf-8?B?S0xzbHZBbHBQSmxQcHp1bjFQekFmSTBoV0xJT0pVL0ludUkvemJqU2dRMlRj?=
 =?utf-8?B?bkJkaDhWZmVqL3ZubGF6N1FRMFBMUVVmK3Y3SCsvUzE0ejBoNmo3cXhSdC9B?=
 =?utf-8?B?QWRmdk9MUENuZG5HamxKL1cva25zNmExa1d1Q1R4UjhMTFJxMUdtMm9PeHI3?=
 =?utf-8?B?MWJLdktOZDA3czVYWUg3OURoSUEwZWJITGExWERXeDJnMzdtNFZCekZOUEZ6?=
 =?utf-8?B?MHZZTUZ3ZVdMcFJ3WFVmc2dXWWhBb0RKR3RUOERsZlhINDBablNmZ1d2RFcw?=
 =?utf-8?B?dFBPV1dyTVRRODFrU2g5ZmduUlc1djlUR1VJNlVGampGOHdDWnRkZnAwVXhp?=
 =?utf-8?B?ampSdU9tTWt0YkZZNkhOVUpZRGZBOEx5ZHJyUEgreU1mWHlVYnNtQ3NnbHJ3?=
 =?utf-8?B?ajU0VlYxUVJEb0dsakNIS21STTIzSWU0aFRaWisrRlIvQSt6MGcvMGp1MlIw?=
 =?utf-8?B?L0FFVmJwcFErYmtKN3ptMFVsQ1RnZ0NPc1BvaXRwdk8rZjdPb09YeFdTdGlK?=
 =?utf-8?B?RkpBd1k4SEttQm5CaUF0ZlRLZkNNY1hVZVZsOGZHQ3VvWmZOK05EZW1Pd2lj?=
 =?utf-8?B?Ums1T0RqMkxpN0xBbmV1aWlrUTZIMS9ndG1yQm4rWGhtSXBQWSthNzExby9j?=
 =?utf-8?B?QXdLeHcrOHNuL3JRY2JGZURSdXhMZXF5bGZoNU5PWURiYVRjSlQvTzl0VXhl?=
 =?utf-8?B?eW1jODZVanRNMEE3UDA4bmxZVTdYODhKV2dEWmUwQzVtcHVjZnhKWU9IZ3gy?=
 =?utf-8?B?dm9lS0lQQXNRcklsSjZZTmx6QW9WbU9NZ3NCaHJFYVVoK2JmWXpZUXhrNXU2?=
 =?utf-8?B?MFV4VXVUdVVONmM5Tm5lblFzbzBvRFFVMXZaaDExRzVkeEJmUGZkQ0N4a2hj?=
 =?utf-8?B?OGg1QW5vcU4yRXV5ZkQrZWNQU1A3VkNkeEN5WUs2WmZaMW9XTEkwc3JDc1Zq?=
 =?utf-8?B?RnBveXErYSt0N1BuME9ZVnQ1NTV3MFpUTTdFaEVQRGM2WGg4SE5tdFNMZkpx?=
 =?utf-8?B?ME9FTEVsWkJGbHlGSlMrU25PN0FMREdvc2NITXhhajRRbWR5RHA1T0kyS3ds?=
 =?utf-8?B?QzNyYmJySjE5YzFSNHd0NkNwTTdCTEtKVU1TWktxY3dWcWZCTnpXY2VnMnlv?=
 =?utf-8?B?RFR6aUY4RkdVYm1sLzRRcU1wMWhzaTh0NXZmdzhYdHBPWUZBK1gxRHVxdEx0?=
 =?utf-8?B?b3cwNXRkdXM5MWJsb2VKeWhTVjdrZlVVWG0wZVFOZy9SSkpDVGthV2xNYUor?=
 =?utf-8?B?S1NEY2JDejFwQnkvdjV4NEM1TWVuWjBmZ2k2dFVEQmtyN1pnVVRiMXpxamUy?=
 =?utf-8?B?bzh3UWZWRHNVN1FHWm5mTlNEUG81K1RZUm1LZ2RuRWFFUTBhV1d0RTE3ZDlO?=
 =?utf-8?B?SWlDaDZtSGhqaGYrbVN0S2lWNzE2aWtnMGgxaWtwQSsrb1EzQ3V3ZC9ETUFU?=
 =?utf-8?B?RnVURS9vTWo0VkJWL3BLUzVCMURLY1VjTE9BelV0cmo1Z2huT1R3ZjZNZVY4?=
 =?utf-8?B?RHdETnRJdFVXVFArb1J6NkZkcXNxOWgxODJQWnIvRVliU2g4YTIwSk9uMjdj?=
 =?utf-8?Q?Ukp1K2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnA3eTdRVXcybWJWK1FXV1cyU29sbW95TG5qR05zeVRCczBHWlZ6alV0RUFH?=
 =?utf-8?B?eFZQRkVPSVJUdmFzTlJuVnQyWkVzNXlUOXkzbm1mdDBjd0tXY3RwbHRJNEhM?=
 =?utf-8?B?bHF2Q1RZTG8zZlUvMFBobGFhOU1pVVJXK0VNbWMwYWs0VHRvMnJRL1pXcURu?=
 =?utf-8?B?YU9CVUx2WEFZRFdlZFNPSFdiOFdtWUNmSklzbnV5RTNTQ1ZrWVlaaHlIUzEv?=
 =?utf-8?B?MGdmOC82bi9GUDZCWXM1QjA0ekI1SUFBSldXb3poM2E4ZGtINlZiMlRrV0Vp?=
 =?utf-8?B?Z09nV2k3ME9JUGE1TWlWSm1qdHpianlpcDEvblFGM2hYeFp1TytEQjZzZ2tG?=
 =?utf-8?B?aUdTN1liZ2tkNTcrR0RFUTB1L3Y2RnBxL3RpcUlxUWxaaFpPRjQrVkpoTUI2?=
 =?utf-8?B?K0ZzdHg4RWhrYm5QYS9obldNdENWQTBDdEdSWS8wODZTbDNUS0ltbVFGUGk5?=
 =?utf-8?B?QnB0Y1BtYld6L2MrVEpBUm1rempKSnpoV0lhSGUrTXRHd0kvYjIvZ1RNRnJw?=
 =?utf-8?B?cE1adCtRZE5JR3R3OGNaN2pjQ3Z0Y0N4Vm9sY3RiaktUVnRJcExyakdVVzFp?=
 =?utf-8?B?ZVp1Y1hObGlvWFg0ZXFLU1hvY3hCSmd5NTUvblRJTzR4TXU5SDBDcEtOK1hJ?=
 =?utf-8?B?cU1KaHhqcmpjL1NwcDFZNlkxU1c0dkdsWDg3Wm9GSjR2S2RTdlBTdDk5OFpL?=
 =?utf-8?B?VEo0bUNQS0I2NkNPdmxSWlplVnVlaHFyb3pOWWpWNElGWGlRbjZKOTRiZWxx?=
 =?utf-8?B?dlZEekRLckZzL09abDRKVWNEQ2RmTEhEWXVsTkVCSUF0MDFzenhORTRtNXlz?=
 =?utf-8?B?Qk94WEFleEhuREtZc1hOM1VKVVJtR2ZjMjM1Sngxd29CMFR0a2V0S1gybG9l?=
 =?utf-8?B?c3NIazVEYng4OENoVlZxMWFSUFFPOW8vYlJRK0xqTEtvejI1TnFkYjN0Yyt3?=
 =?utf-8?B?SkpkOFhZQ0hqY3lCclkyYXVGQnJpeHVlbHZ5ZjVHc1RtRjkzbzVnU2c2OHJk?=
 =?utf-8?B?WUMyelM4WjdPN0FYREtOZER1NVp4TUdUbzFhZTFtWEgzQVp2NGZ4bkswYW9u?=
 =?utf-8?B?eklNTTYzS1ZEeFh1V2dyeEZQOGRQNUgzMlVPSkhMdDhkWGhlMnNvbC9rTEJs?=
 =?utf-8?B?bXFIY1BEbHFjQWRvTjZlek53cVdrejVma1haZUUydjZheWE0VlFlQWNTQmVx?=
 =?utf-8?B?OHM3b1IzekJqODBaQUFaQzZBN0VoSi9lODR4M29IeGJ3MVdHcTVxUlArZHZR?=
 =?utf-8?B?eUpUZE1DVHJ5bUJqZ3VpVWxoeFpqN2tNN3dtcGRhbVBERGpvbEZJNGlQNGQr?=
 =?utf-8?B?SlZSM1JyWlhGUVNZVlhxSWVhWHJPM2t4SWx3d1E1eWRjSit0NEgycnl0ZFdN?=
 =?utf-8?B?TEd5RnJKWHI3aTZJRG94YWlxME81czFhbG1LcjB4UUhpYVdibmcxV25EZm5i?=
 =?utf-8?B?T1BRbGhXTE5TSWFSY2JiWGc5bTNmaG9xc2ltSWs1QklNNXRiNDZ1RUZlY2pB?=
 =?utf-8?B?U2Z2cDN5MXFJKzYzd09BRDNIaW1VbDlPNUREb2xVM3JCZU9acDd0NGtkN25t?=
 =?utf-8?B?emlLTmhHS1JBVGhzdmhYZkhkWkcvdjZyN0R4T0tFclZVK2xXREwwcGxKTDNU?=
 =?utf-8?B?NzZWSnYyTUpGQ2p5RmxKcGRNS3ZJK3hKUVZreXk2MG1hbk5GY3ZZaXFoS2Ey?=
 =?utf-8?B?amJvazg0a3c4cGZlMHVMYktpRjhLOWhGSzBaZ2xvRjU3eEFVRUc1cU5hWEdR?=
 =?utf-8?B?b0VJTDBQT3h4NHFMZGdEdnhPcWVkaTFxRlJ4QVlzam9aRDhhdGpIUUVDUXBu?=
 =?utf-8?B?RDEzZUs5MFV0d21XUzA5bjc4SHJoUi9zdldrY2dCOWhPTjIrWDBCQzROcGoz?=
 =?utf-8?B?WnNzbTBhSythU3BLU2VjK1JYL0xwTUFBR24rNEcvTUsxaWc4VW85Ny9wKy9R?=
 =?utf-8?B?WGVqMkQ0Q0U5Z2dhclFEczJmbUxZOERyRE4zUEg0WVlxc01xN0tka05vVGVq?=
 =?utf-8?B?WTZjSEZkL0M1SkhiMzFLQmh3aDdqY0VBcDhjMUhmRUF6QUxtdy9HSlNnNHFu?=
 =?utf-8?B?cUtnUmNpdWZKMFoxUWs2Z2xwRGw1WUZnTlBaV0ZKd3VxanhCNjdwNjRRQzJy?=
 =?utf-8?B?KzBMbXNyeXpJSlozTHI4UDg4WCtxSE9hN1dJVU1KdXA2RmtqWVQ3REs5ekFD?=
 =?utf-8?B?UUc2eGlHVTkwSkVnRHk1dEdsRGF5KzNGaU1VQ0ZVMnZIOWJiSXlYQjhzZVE2?=
 =?utf-8?B?QzFKelljaStxMjhaUFBrTWd5OERBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79093903BA51C1448C88A5F3BC5A0A02@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fkmwyRaDNDBbtuHZXwpslZFQEE86JMFF+BcE4PhhWMBMJF354HvWErh2pUt3GSHCFSTX3l/OhcjqLfhGfgkFHERytUjeDBVHdRtcwdypxknY1XwK4RQLerJx5sKg10D8j/rq5LWcTPcKNApblK6QGqMCXf1qUA7OLv2n431+aP8E2lYAdE0gMJNwucdyW2L/P55uv+3ldb7QmPNhPABaMupYp3Pg0bHZzfz9BVMz0BcXNXZPRdPPKM3iv63w839xkDFCJRAp0/xG1D1aR0vg7LnXGkyc3Re1irrE787xZy7SIxdccGAjrvJqclFJbj45SbubmV+/216GhPnVJV7nZrfcS6WQbpLVRhTWpqVqNMPPo1D4A6ZioDqqq8dEztB5P6bZwZWZ54EfwiuLdJBupZ6dFRZSq0QuZqav5MbTj++EP1N1Hg0U866XLJlREaQ6xt/6V7riVbN1RhAs2YadEjNydjRSydFtbOgJbSLgAOykxF+YgOP5k6yEb7BLALaQfj6QHD35fwbsqa9iOzH7Kg3EuejHgcHIdf/T5BmDhOTSr7w8nsFhV/8bOObWhvM9Hm+UZliQgehhKJczdzA1CmPtKDtDBoNH5QxYyl3n9GZAUOL57/3THhXyIOqf7gnR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb879e1-3d64-436a-ab52-08de06322d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 06:16:11.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLaMU3uY6u1YWmQ1SVMNx1pbLDBUxm6HOupftFtE22grzP3ZtQGBZpM+A+KKheNBlyKdLrzTtxr62aJR6cEIEtKGTiVAaNJhr7hqjJEFFJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7017

T24gMTAvOC8yNSA4OjE0IEFNLCBoY2ggd3JvdGU6DQo+IE9uIFR1ZSwgT2N0IDA3LCAyMDI1IGF0
IDAxOjA4OjAwUE0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IFN1cmUgZm9y
IHRoZSBvbGQgY29tbWFuZHMgZXZlcnl0aGluZyBpcyBzdGlsbCBpbiB0aGUgbG93ZXIgMzJiaXRz
LCB0aGlzDQo+PiBoYXMgdGhlIG5pY2UgcHJvcGVydHkgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIGR1
cGxpY2F0ZSBhbGwgdGhlIGNvZGUgZm9yDQo+PiB2MSBhbmQgdjIuDQo+IEkgZG9uJ3QgdGhpbmsg
eW91IG5lZWQgdG8gZHVwbGljYXRlIGFueXRoaW5nLCBqdXN0IGhhdmUgYSBsaXR0bGUNCj4gZnVu
Y3Rpb24gdGhhdCBtYXBzIGZyb20gdGhlIGZyZWUtZm9ybSB2MiBjb21tYW5kcyBhbmQgZmxhZ3Mg
dG8gdGhlDQo+IHYxIGZpZWxkLiAgUHJlZmVyYWJseSBpbmNsdWRpbmcgYSBtYXBwaW5nIG9mIGFs
bCB1bnN1cHBvcnRlZCBvbmVzIHRvDQo+IGEgY2F0Y2hhbGwgdW5zdXBwb3J0ZWQgY29tbWFuZCBh
bmQgZmxhZyBlYWNoIHRvIGluZGljYXRlIHRoYXQgdGhlDQo+IHRyYWNlIGluY2x1ZGVzIHNvbWV0
aGluZyBvbmx5IHZpc2libGUgd2l0aCB2Mi4NCg0KSSBzZWUgeW91ciBwb2ludCwgbGV0IG1lIGNv
b2sgc29tZXRoaW5nLg0KDQoNCg==
