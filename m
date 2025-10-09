Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5828642B;
	Thu,  9 Oct 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003832; cv=fail; b=MLD+9abq6atqLAsZPKe/GPdBOiklQ2Fr58UBDVskf5YgWS21v946sboRYlVLXllibnuRdNw1yslyUrWzx6OIgMLbE+5IsY1eYp10Kz295m64QjBeyZoauFCCaGn2Gb8BCPdFpO9Dr3aMd4cOyV0ohr9Dzs//os601O7bDR11xQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003832; c=relaxed/simple;
	bh=R75YqlVEpiqnQoxL7QHuz9taL65oKwca736tDoZcCgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOq8M/5kvbCVvXi2hld0FmNtotFJYYRX+mgdqkOo3WDDTs4F8dSxymeHSwzlEjJv3nijlnDyw6jNZGWghZSnZS/hrc22c42Pt3i738W+iDOv3qNEV3ic13KoNg0tW+G/8f+R59xjZnSG5VXcVFb5wJOkFC0OyA8Vn6aulIw0o4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oOwTAISq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CQ148++B; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oOwTAISq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CQ148++B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760003831; x=1791539831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R75YqlVEpiqnQoxL7QHuz9taL65oKwca736tDoZcCgk=;
  b=oOwTAISqJEBbkNXIQHK8G8st3nD5WbUFnuayXonftgyTbFyuD22Vf2QC
   Nc0mufz2EXYT0tcT8vvtf1R59n/Qhr+yQ5o9A/sNooG9zAUUmixo+TqpH
   M3xLFeidU/lKkBOao4RuUdGLeIVVa4lU/ZE2eX9zs+9r7oljRYMPdF1yz
   CNznC4SGzVWsh0KSlDj/9B2M6h13hhUtxJ5Nr7IDJVMN0n2+ZfT/WTlLn
   /DJFU1h3aJ5ofHMdVCBZDniHadbdTyHrErdTXMT99vgAfmk7PnBOdKqNl
   Y8mydBLdvb8IlIguBdCbBpdYEtbeqDPb4gnyhEPgE5FaIXiBCd81NA2b4
   A==;
X-CSE-ConnectionGUID: l+OuwzCDTlCI2+yykX+gDg==
X-CSE-MsgGUID: JKSBY8RnRkm49SexvDtnPg==
X-IronPort-AV: E=Sophos;i="6.19,215,1754928000"; 
   d="scan'208";a="129918450"
Received: from mail-westcentralusazon11010033.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.33])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2025 17:57:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRjMep7eADt5PKj1ntTU6LMn1gxgoj7vTtMTyqeKf05aG/JpiZa6teEfw9Ft/ZGHr6luXHUSZWa3Fyrq7M+5E2wfy6KLDu9rmCSmviB1ww1QomnSNpwOWjLYJSTXa5a40/WpxBFM1yW5xlJLlmDf7/7gjR5PawTt0YLc4yyaxfxBmBMKR4kxnRqJw2rQrHdbUfmHHz2PILLPqVy5WSB56MY1OdwF5wtuenbWAZxXbuv+VsMcQfCk8pol3taT616qsixq8BMTLF+Hie9t17Y0h/m/jcy/IhTv7DkTi8DoV9VO5XhceXlHHplKuYbmmIXQ3CaGvlcXxVsrU+XcSxg0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R75YqlVEpiqnQoxL7QHuz9taL65oKwca736tDoZcCgk=;
 b=pW4yR5BllS6S6X0+ImHMEzhghvDARO/DKO6ACUzKsgwUHysaHEXn/WcoFjXDCaeTt4RPJQ5cmtxiPXZMUVTmow8s0lrNge9e1N8NoNbcu7sViRTT8m0nJR17W/2jkyTNBU0uVelGozt13i9ucpekV5sdp03eEqi8JQVIHAfdqCS4d7geYIeA5D08t4/utenXr+kZj+DspMXQgeAb5LAo7BAecDaZxgKrBcriuoFT4NRGGl6naMKIq8MlyNfn6NOoICIb8TaKtKp4wrce+v8iAquCqBBMHxpj7CxW47pcMlduQQ+sCf/g4ma8inAKM4De6eMSX6Q9+M6W7t/okHOlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R75YqlVEpiqnQoxL7QHuz9taL65oKwca736tDoZcCgk=;
 b=CQ148++BHjU3MSoTL/pGI492e8XQl1EXY4E1oR4/UE/60tNW9PStoB9fveKPKBLBJuEr7CJmFWZlle4pJT2NZula2Fozys/tyVePSTKk2M5dVnXtfE81rA64uuOAj5ojWrYp/59Z3GGR0k06eoB8OusUtwRI71kTKmEQMWlfSNc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6498.namprd04.prod.outlook.com (2603:10b6:208:1c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:57:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 09:57:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 13/15] blktrace: trace zone management operations
Thread-Topic: [PATCH v2 13/15] blktrace: trace zone management operations
Thread-Index: AQHcLi2QnkMZ62p08UWUCBM+3UyrlLSs7hCAgAtkuQCAAJozAIAAvMoA
Date: Thu, 9 Oct 2025 09:57:04 +0000
Message-ID: <c39bcbc7-2669-40d4-9644-6213a0653e09@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-14-johannes.thumshirn@wdc.com>
 <f5a5bc62-093b-4d4a-91ba-a7ec5718609f@kernel.org>
 <057c7e5f-6079-4451-829d-40c73c88fb60@wdc.com>
 <45f8532e-5aa2-4b32-ae53-bdf588133a3e@kernel.org>
In-Reply-To: <45f8532e-5aa2-4b32-ae53-bdf588133a3e@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6498:EE_
x-ms-office365-filtering-correlation-id: 1500a1d2-4745-4f19-49cd-08de071a33a1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TStJb25yd2FVMWRKbFJaT1lPWkd6R2h2cW9PV2FlVjlzYlNGTUdyZy9OWlRY?=
 =?utf-8?B?MVFkKzZkb0tRR0ZzQ1RyN1lkUzhpbUpmWVNZZWhyS3NaMkV4QzNJcjAyRVFH?=
 =?utf-8?B?QUF0dmN0L1VvdUlTR2oyZTF0cjFIUTJvL1M3MEhnSkZxSUFsSHROR1pPa1FQ?=
 =?utf-8?B?WXllNzhmemhtNE1mbjh6K1p2cWlvZm8yUDZFeUtlWVFhNjdNaWhZVkExMnhz?=
 =?utf-8?B?YWdEL0JnM3ViVUswWEdMK3YzQzNwdDlVMWREanArT2JtbFRNSy9IMGplS1I5?=
 =?utf-8?B?VjVwZUxMT1VZNXR3dDNhdUhESWVYWjQ2a0kvNkZ5anhrREhnZ0FrNXAxdmhU?=
 =?utf-8?B?Q1I3K0I0K3k5UU9ER2VGSERMY1o0UlNyOUVyYnRSUzU3Mk51NXdwL2ZtTlhQ?=
 =?utf-8?B?Z3RCMEs5MU1oYkVCTmlMUWhSSVVzMy9GZ2ZjczZmT2lpM0tYZnhMa21rdTNG?=
 =?utf-8?B?SU1KTEJjWlZWQkE1Q1ZIMEV6aFhOZ2JLcFI3YTNTMU85UWVQWmY2bjdVQzRH?=
 =?utf-8?B?NmtvK2hCaTBhcWN5NjFFdUxkaHl3RFZrRXpSeEJzelJBWFprOUtjOEVlNVhz?=
 =?utf-8?B?M1ZRR2FKMW1meGtUVS9waXQxZ0NmOVZ2ZmpPUysyR1prT0FxeFY2NWF1S1Mx?=
 =?utf-8?B?MmRGM2JLZmlSQ3h1b0FPVUJhRXhzT29Vb2xTMVQ2SVdZU1E1d1pNNEFwb2Ra?=
 =?utf-8?B?ZGdpeHpHTmM0MjFha1Ezb1M3NGVidHNCSGUweXR5a3NEWWo0SmViN2sxZWVL?=
 =?utf-8?B?WGZhMFZhd1MxRkhreHVhZjRsTXV3YkpCbWhnKzJPTkFVMlowRFoyeWs1SWR1?=
 =?utf-8?B?WFNXU244WVMrWUpucXVodTYzMExtMUxkZndKMEVBOTRKam4rcWk3SXc0Y1BG?=
 =?utf-8?B?RTBRQWpsc3VLUnhYSVN6eWRwSmpSRkI0KzZiT3BiVjJzcHFlMXBia0l5RjhE?=
 =?utf-8?B?SWYvMWh3dGdZaHB1OTBiQ3c2aVN2QTU1Y1hYNG1qYy9BRHI1TkdKK2hWZzNl?=
 =?utf-8?B?SU5KVERnbDBkN3EyVlYxNW13QXd2cmU5c3ZTY2ZxeXk2M1ZNT1grdUxxcnlo?=
 =?utf-8?B?VC9XdVhNYlFFNGdEUE1ERWJ0OGRVMGp1QTRRT1JGODhzYmtaMmRFY01GYkRa?=
 =?utf-8?B?V2F6RXNRc3FQK09FY1h2VnYvaG5iT0V1dU9BWVJXc2hYNTY2K1FqZlNSNHRE?=
 =?utf-8?B?NVNMWVh6RVdvZDV1NnozWGNyZlB6SThQdElqbXFjYjJhMVM3ZEZoV21TWStC?=
 =?utf-8?B?Y2pRQTJzRmlrWWtxelJCcXMybzN3ZHQzM08rWHhSYWpkSU5OSE5LdHlyWkM4?=
 =?utf-8?B?dWFCYmdKZTZFNytmcXhCcElRdm5CSGkzSHBwR0hnSTc3Y2toLzFhMmt1YVBU?=
 =?utf-8?B?c00rellwSkZRK1owNHR4VEZoZVFVWVhneVZ1L0dpeWhZNktXOU1sM3d3azVv?=
 =?utf-8?B?eFN6YzQwS0ZmVEhMRzRFWk9zQ1lxd0xKTEtoemhrZVdRZmo4ZHNjcUJyZDBL?=
 =?utf-8?B?dTQ0VDZGZFdxZXdHNkNDeFVvZjd6enU4SUVtY0NXQmxUNCtIaGIwcmx6MWNK?=
 =?utf-8?B?MTdqa0hWOFpXaDIxazM2Y0FWSy9PNVhnTjRCV1RnTnVWSHEzR0p3akNSRFlO?=
 =?utf-8?B?Mmk2RXNDVTdUOXc0cVlla0JLRlkwRzdaam9tMUVPSHNCMzZiNWhIdTJQSktD?=
 =?utf-8?B?OFh4MXZDL1d1YTJLOVMyTnBEZjk2eEpCTGJsalp5cWUzQjV2SUtHclVDU1Zj?=
 =?utf-8?B?blM1REVoVmVVck5vNGQ4Ly93RDFUMXkyWUlWeXk3cEcrbmthSTNYckh6Z3FH?=
 =?utf-8?B?cFVYUlpWb3JuZlBiSFZURTNCdkpqTzRJZ3psbGdQUmM0bDRPMEtoS3JBU2Ns?=
 =?utf-8?B?RGg3bnkwU3U4WW5NS0s5VzI4WWVueC80eXRsMHNVdVJKcDFjTjNOc2RDT3RN?=
 =?utf-8?B?MkUwZEU5TDhuYnZPQjVhdDdpazFvbmhqenZuQ0ZKVDJRa25HZEZrZUd0Y0kw?=
 =?utf-8?B?SFhZNlJwK0dxUm1GZitTZElPTzZWdFQyY20rcWRlZjZIV09RbVNDVFZJMS9k?=
 =?utf-8?Q?rIeuoP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUJLend4c2NKdE93ejhZRk9JT0cweHQ1YnhoVTU4WWRZUDFxR1hXVkM4REQ2?=
 =?utf-8?B?eWpMblFiQjN4N3V0a1ZjTEh4V3FOYkNKUmM1L0hpN0hhUVdtRDdZZ0puRU12?=
 =?utf-8?B?RHdyc1paV2piMCtjdUltaEg3elBRUGRRelhzenNxeUFXcmtLMEJrbDFyVDV6?=
 =?utf-8?B?MW5OMlpGYS9qaHZBTUtveXFROEZmdS81UndaR0N0S1lMYTllQkZFTVNRdFRH?=
 =?utf-8?B?cHNSWGRHNkZXSGc3ejRyMUdtMmNHVnJoNmpaUmhzMkFHeFNQTUI1eFNVeGNl?=
 =?utf-8?B?Z1pKTkkxV1lObHhERjFudHRadmU2Z2drVU1uWXVLaHpkUzNVaW1QTWtqb1Rk?=
 =?utf-8?B?ZjdUSmFOOVFxSXN4QklOYjlQbHR6YXF6QlhNNTZtdlpJVW5VSW52WXZmemNt?=
 =?utf-8?B?WUh1cnhkajRGUU0yV2t4c3FjVHcyQnJhelpMRk1LWnlNU1RLVnZUNHpoM3pl?=
 =?utf-8?B?eFlqemtZRVJDeTZ1NmdHb0Q0aW93Wlg3K0FxTmtKM1hKR2c3OGJ4NEJjV2cr?=
 =?utf-8?B?QUVoalZFSmRZMjB6bXRjbDhTSzMxb0xWZkpZbzJLeTluRjF1TEc3UWNlTGwr?=
 =?utf-8?B?U3VGdmNuSlRzY2xUcUNLaHBlaGNyc3NieGlkeXlmaWwrZEdiTHlFbnFpMkNr?=
 =?utf-8?B?NGZVeml2dk5yaTNwUEFCNUJ6NFdpNHpieUludWF1Rm5rNWFZL1BZSmpiR3Zh?=
 =?utf-8?B?dkVneVFPNEFCeEk5Tldyb0NzeXFJZ3ZYNGt4OXo4dTkyTThCRXJYTHpMUCtT?=
 =?utf-8?B?QlBBeks4N282QXZLQUJIYjQ5OU9uYVpBSCtPL1FDbFowMkVSVE1aVHBHMko0?=
 =?utf-8?B?NmZRRUlBZE9VNHdNQXM5VHVQNGUyRE5saFhydkJ2SXhnWGpNSGdhTGVOcUpl?=
 =?utf-8?B?akhZT3V5eGllSHgrZXVYWldqUU90WU9jbk9zSjlnN3ZIZjlEL1E0TTU4RHk0?=
 =?utf-8?B?WmdTYkdWUEJyTzVYSzJhM1JxN1NPRTlMQnVncjdZWkRzVmR3RlR3TG04ZjRN?=
 =?utf-8?B?ejlVZkROTkZzYXNBT0pzVFFaWGdIcHpkVElSYUptQ3o0QTdBNzE2U3ljbUdM?=
 =?utf-8?B?UGtmdHlEWUhFd0cyTTBQcFRkVHBoRlgreXlFd0s5R2ZNMVUzMnhhRjlTcHVE?=
 =?utf-8?B?VFJKM05CUFNmYmFMbzNMM0ErVU8vTCtQa09Dbk9oU20wY1dqeFo2NlhOa240?=
 =?utf-8?B?NmF2cUJXYkU2VVhrRmpVbVpBRGpQNnBWZ3FOTWhOY29DYXNIWWJNUmhzV0hk?=
 =?utf-8?B?NktqNi9HTUlodFl2Yy9FOVNqd01JT3FKL08zZ2hyZXZjZXJBVXNXRUxKb1pq?=
 =?utf-8?B?Ulg3c0RwZUxwUHRjeHJoUlF3d1pnVENNMEI5RnZWT3Y1RkJwc0o3UXNMVFFR?=
 =?utf-8?B?QmlWQ01RdXBqMHVBbmlCMkxzWDNOZkk0aTFyV3dCZEJlL0tJRUxac00rM2hq?=
 =?utf-8?B?RGJ1U0dWMmVHTEtDeGUyRCtOblR4eGVkbXBFdHkyanRRU05odnZzRWJYU3Vu?=
 =?utf-8?B?b2lTRjBtblYvYUZBS01iVzhQa2diY1NiRlVMS1FVM0NISlREcUxwZi9admVw?=
 =?utf-8?B?OUlmSkFtNHltcDBPc1Vaa2gwM3hMSEhOakJIS3pFdUtWdTVVek5pMHk3SHVa?=
 =?utf-8?B?Mkd5bDM0TVpuVS9QOC8xZGxEVUZhWE0rdE55LzhBeVh2Sk80bE1DUEFOWVA2?=
 =?utf-8?B?N0FZWURyYXE1b2ZFY1RXZEgzY3NBVzAyQ0hIczZ4YnVvSzdhUlg3SGloN0tS?=
 =?utf-8?B?aVBFaXkraUJDblpLYmZtbGJ5MDJkaEZucFQyMkw5ZmRuTkNGSi9xNmJEUWxQ?=
 =?utf-8?B?aS9uOVFWN3gyUGkvQkx3RHY1YW9scHJiblVaNldsR05kd1NXcUFleU0zcG9U?=
 =?utf-8?B?MnJMTnltV3lFK2NPRUxEaU9MWHg0QjlSaXc4VGZZUU9tTUVMWnNFQmJ1ZE1m?=
 =?utf-8?B?RGxSL1IrOVlBdVJHNDVyc3Vnd2tqT0VxYm1xdkNnUHZrZGo4cjJJVk13RXo2?=
 =?utf-8?B?cFc3ZUVyd3VDcEhsd1U1TXVIL091dm11TmZnQld3dTlVcHB6TTZmcEhlTGNC?=
 =?utf-8?B?K1pDRngyT1k0RDZlUUgvb0dYNjl4d3NNUGZtZDh2VFBiODU1Wi9vdGx1MHVl?=
 =?utf-8?B?dnFzUS9QRFJnK2NyK2lPeXk3K1E5Nmw0L1hxaUlJdnU4K053SWxsSmo5VU1u?=
 =?utf-8?B?TDlDUEpjSWdjTHhQV0FzZEM4bC96Q1BLYTVka3p2eHY0MHpFaG5CQnplVUp0?=
 =?utf-8?B?WlZ5Y2s4aWZ3aXAybjA5NC9IM1ZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41505E260D0ED946A80B9B87D5163D2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bABO3elBUW04q9pUYJ9FVtZ1OfGJQC2fCvZZVcySou7K/rXLcI0jJDfe5pydWn8isQ2QVpVjgHrI2+pfSSFOEWlKCsRDjP22GyObxJoXEur+ZMB6UPoU5yx6Jf06Kc6Mqq/qd+9Rkk/w5FFU8HY7I6s2kdJsGOvzNKrb0mVieC1p3lYYzofc18QMM/N7wX6Rol46l7gNoPzDw4eOKyM8EQapE7eV3fqYCz5dY3cEbnhrPZSiThqPpsxru1FO0DSw89+WkHk/23gVazTW0GhuSARtEg6KrixggU1UiYDRUQRe/t04UM3tx7X+2lXkG3ETMo0CfOFkc/jm5AmI9QhuD2XrpSoIX5dHa/pkX/rD3f9QeSd5KoZc5SzVq8YNgFirnMmhCg+VrAqnD33vtFKNhSnhVUSJFZUQfZCU8iqzy8QNTNg6YY6XMFMRNXJHAcJLpS/d8deZrjqaSKm5Qr14JIB9BCycPGM5ckZTkRJbw0/AijkaYVNM4h0NLv25mb1d3PS2XJ3vDwLY1yZTFFKn/gNxjmedWVLNoJZuC92qrgW5H1U2VvTk598idIyqZuDyhep/Sw2nysd4UmPsXGRozSvI1Ns+5ysItdrq4IpW1ngpA56PGV9q8W1L2QaFzqYH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1500a1d2-4745-4f19-49cd-08de071a33a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 09:57:04.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7pWItzpFcdMNkcY+FyCdJVOF/xWo4rNW6Fe/NUc762E7d+zKCV8c7mIS8HTFxU4BX9GJK6pJHl6TSuqgzNm9dbZ/n+e9wBcSt+dpek80kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6498

T24gMTAvOS8yNSAxMjo0MSBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoYXQgZG9lcyBz
ZWVtIE9LIHRvIG1lLiBNYXliZSB0cnkgYW5kIHNlZSBob3cgaXQgbG9va3MgPw0KPiBUaG91Z2gg
dGhlIHJlcXVlc3QgYWxsb2MsIGluc2VydCwgZGlzcGF0Y2ggYW5kIGNvbXBsZXRpb24gZm9yIHRo
aXMgQklPIHdpbGwNCj4gc3RpbGwgYmUgdHJhY2VkLCByaWdodCA/IElmIHRoZXNlIGV2ZW50cyBz
aG93IGNvcnJlY3RseSB0aGF0IHRoaXMgaXMgYSB6b25lDQo+IG1hbmFnZW1lbnQgY29tbWFuZCAo
YW5kIHdoaWNoIG9uZSBpdCBpcyksIHRoZW4gd2Ugc2hvdWxkIG5vdCBuZWVkIHRoZSBhYm92ZS4N
Cg0KWWVzIEkgL3RoaW5rLyB0aGlzIGlzIGVub3VnaC4NCg0K
