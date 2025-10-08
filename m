Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916D241691;
	Wed,  8 Oct 2025 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930177; cv=fail; b=N0vuM9Xc2/xRW+NB5kTRIWA/ZwSKsLSo1dHXTEwNbi0y403YYVFKzFS5o+KRS59vbrLWo1LsCG7HCM/hD0yE6k70O6qxTIGLxIjcTWrvuYkRNIU91zMfuhd2emEtz0hioRChZqD/ZUXUG9fE4ahStv0r6QkoZMxr4xe47Az9kXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930177; c=relaxed/simple;
	bh=08IHwzQ55lNsI9Row4N5HBqgOikHq1wmU2ICXbpL5XM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fo9pXWvgLEuHY1rz34uqiD1tINYAOZXSQrP+xc0CqkEZHdIA4lehk9GmRADDeVVVlqbKXeN0hrceGpKPTrcFql5mXNOMuR+VwIpmjUo3L/zR4yUSAyTf6/YmZoFMf02aQ5XLEqus1qpV0+e6cKmIxn4b+1vHjYxhvIOgK/W+9xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=okJwdhIU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Mp8DZSb7; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="okJwdhIU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mp8DZSb7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759930175; x=1791466175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=08IHwzQ55lNsI9Row4N5HBqgOikHq1wmU2ICXbpL5XM=;
  b=okJwdhIUiH7BeXiDbpE9K5rHDCjdARUrro5+sOXzWy7oNTbWLn1rWNrl
   y/dgiO4KwUHW1KQCey/QFtTElYuZHqZwHvctqGCTZzu05OqROleismaJa
   sn4CgO2okMJdrtXM0KeA2Q1IgO6yv8tATPtHcBFF5UBCJeN4mrG2/fW89
   /a9UHZFWinl10ziGMMTWRdX7DCOozZv2v0xD6qSqAnN//keDLJ8kuLeAN
   PskLmUoHs6oAVKzSLv2/Df8kArZwcuYqOpN4XcOqb/m/IxCr1WWKH6AF/
   WfNGn9A+/8FQ06xy4eTS2LhOmpV6j4HhsWZ1xgX9J+za6pimTLL7EZiNu
   A==;
X-CSE-ConnectionGUID: T3kA/NXgQJWcQmCRpTFv9A==
X-CSE-MsgGUID: bR3Gw8RXS+GvvbcON3XudA==
X-IronPort-AV: E=Sophos;i="6.19,213,1754928000"; 
   d="scan'208";a="129846200"
Received: from mail-southcentralusazon11011004.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.4])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 21:29:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9WjVuiXAWnd/D/YLSKITXozl65htaS+d2RdPx6wB/zUQO9royVXqVg1VZ77CB3H3fMBTTEO7pRMEF6k7h0Nl1WfGWZv174Qv6WlXKAvsaV/y3Qot4qEkGDP/pP+XXkR1tD7YIvCLxOKAd19WlduMC8HAV05fX1R+tY5aQtvUSZghMwVIaaPFr8U7NliBmd4GnGVMSW8VBmoxdUFPB+rqCi+Wf8/2i7nik4gJHHO6/RBguUFMdtmokzuaOfOgub1k5omxL36uWefKVmCDWv0NKUAgLxAojDBgrzNZItEK6FeFIUE0gSVYEXo/60Okg94pysTZdlFtVnRAa5onapOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08IHwzQ55lNsI9Row4N5HBqgOikHq1wmU2ICXbpL5XM=;
 b=ID8t40nUJvQgZtru9+5zLciuGyubzQeojhCpiAUtwfh13u49cfQp3+t7FxpQgr5ZrwZOw0Tk7o760yuxJ4lTsAEJkRpdiIax+m/bXsJKVcKBv3m4ZpFEwC1AP9gY/p2Z2ytFILWTwjhomlVJzuJNCAJeQkS8ZjkYwt+hJmFUdYDKn8xXvG68fUJG22Nu+11PZlT1gJ0KN9NJnzfyz9EbCAQhXXdmdiMWWoLJOnL1akt1Kz/Xp5nfHS2zfzTenI+dDoEL6upON0O1vCQdXyXUHceHtcWHleqWqe//nG0szjwvd0cyLlZZfaK8c7YTdEZhifWOcvAfKkcK1gGOp7cC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08IHwzQ55lNsI9Row4N5HBqgOikHq1wmU2ICXbpL5XM=;
 b=Mp8DZSb7SppLvA6lyIrMB86wnY35s6eztTP0O+dwWcAgUueQ26tgxxEJJlbdmod8Z6bJ1fzqTtFwbo5bZ/PA4+S2zY6xCHNL8TPYGq4yjrkpM51/205fr7q0iK5ncC4WKintp5zhCId6Q1Im1aoJNnwiJuKKVReGEba6OkhejhE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6653.namprd04.prod.outlook.com (2603:10b6:208:1f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 13:29:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 13:29:29 +0000
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
Thread-Index: AQHcLi2QnkMZ62p08UWUCBM+3UyrlLSs7hCAgAtkuQA=
Date: Wed, 8 Oct 2025 13:29:29 +0000
Message-ID: <057c7e5f-6079-4451-829d-40c73c88fb60@wdc.com>
References: <20250925150231.67342-1-johannes.thumshirn@wdc.com>
 <20250925150231.67342-14-johannes.thumshirn@wdc.com>
 <f5a5bc62-093b-4d4a-91ba-a7ec5718609f@kernel.org>
In-Reply-To: <f5a5bc62-093b-4d4a-91ba-a7ec5718609f@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6653:EE_
x-ms-office365-filtering-correlation-id: 1fc3a993-a899-448c-f9a3-08de066eb55d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0FRekl4NEhLeEtTbWtXSmRpZUZySTlMaHNpWWtETlhYNGNUaVZDZU53eEFV?=
 =?utf-8?B?WWJqanU3TDZYRWQ3K3o1bllIL2dFNUxibkFlbG5Vb3E0V2I1VlVZeEl0em9O?=
 =?utf-8?B?bys4Um5aYkp4TkhQRDR6MGo2c1hibGNUTnk1ZWJvK0NhYllwak5uRGZTWHda?=
 =?utf-8?B?ajJzRmJscGMzdTYyVkQ5TTJoU2dVclZsQktRRXVGNkdROFFFKzIwSmRFa2Y3?=
 =?utf-8?B?KzVlTmRId3NzczZPV09xY1pySDVjOUQxLzNTdThqNHhuNlJ6K0t0dkloVXFI?=
 =?utf-8?B?T3hkeEh3K2VoemI1Z3NrK1ZWUWExOW9Ld2FNVElVenhPUUV2TllQY1BTdlQv?=
 =?utf-8?B?SHFSYnIrOWdYaTJoeHhpaWhWR1VZTThuTXd3cUExN1BOYko0UWhwaTJpa05r?=
 =?utf-8?B?NzFzZFhjT1dwd3JCaWNURWZjR0Z2NVJYVFFyY0FDck5BWElpaWFkZGw3WTRY?=
 =?utf-8?B?b1hKaXFkYzV4ZW8zSDdaK2gyN2h3SHNuV244MGVqTkwyUjJlWjU1MjFabVJo?=
 =?utf-8?B?R1pzMFp2bEo3U1dLaE12dWVXYjVteEk3YjdVSzlRNDdLZUJYd2pzMDRzUllM?=
 =?utf-8?B?UW9scU5oSys1TTE5Skp0cGhnYldrZUt2TnM0ODRsL2wrWlhicnE4cGl2UTNi?=
 =?utf-8?B?UlNKSlY0cEFIeWNKQXFnVDRxallaL0ExejR5cjhnQXd5eU8vY09nVnZXTi9K?=
 =?utf-8?B?WE5Eenp1QXdUU1lDMzRGbGdvbHlSRmx6T2MrVjAwR284T0FCMmFkN051cnc2?=
 =?utf-8?B?UytlQjZZRTQ1SmY3VEdCWHA5QVF5d2Y2SExxTDlEZ3M0SXQ5WHNzQnBHOEdl?=
 =?utf-8?B?TE9xblFqOUxOblVTVEk1bzdiaXh5Y0xWMllEbEg3UUhQb1FWTDZ0RFlkRXdC?=
 =?utf-8?B?cU1wWDdWUWsxQjc2ak5zWXY0cmJaT1MrZ3lGTXFUYk02ZHFVcHRmTHJhVm55?=
 =?utf-8?B?c2hIRVlSeFQ0MGRSU0QwQjB4MVI5dkxOZE5INjl0b0N1bHBQSU10dDJZZzFp?=
 =?utf-8?B?M1RYK2Q1K2JXTUlkYURGZXhESkZvVE8xRTdHeHoyd0FyMVh1NFE2T01GcEdm?=
 =?utf-8?B?UUhQTGEyVFVFeEc2dHhsbGRSVUJadVV5aGM1ZmY4eklKSmNLMVUwZEcvR1dU?=
 =?utf-8?B?Y0tPWEI3WDhSSktoSXVYM3hVVCtMalVuSXRhUjNkNnU4aWJBZXpXcFg0VXpi?=
 =?utf-8?B?N282eElaQ0ttbFBwQmhSM1BzUHVSWWVJMzAyclR3MS9sU2dlcmY4VW1JUU13?=
 =?utf-8?B?RlgzOHdoWlFYM1haRFZxbE1xNlBSWm9lZTRzUWdUeXdKMWRHTmkyVk1XdjNH?=
 =?utf-8?B?dGJUVHAxOVVmNHFXZWpEL2taa1BiNnlEck9TdjJTWi9FUUEweWxXUU1JZWQ2?=
 =?utf-8?B?d1U2dk5OL3cxa1hlcjVOL1lhREdaaVhBSEpNL2xoTG9BOUplaU45K1FXY2hC?=
 =?utf-8?B?akU2QWtPSnhzbzZGbW52YVVhV1BDRUNWMS82L3YrcGloam5oajRDZHFqdi9t?=
 =?utf-8?B?ZkI0TE1pWmVUcDBrWDZjQXBQWTR0YmZ2UnZab1kxOVVZMFc0NHZPU1hpR0JE?=
 =?utf-8?B?MWYyZityVzVUc0FJcFEwVWFLNXIzYWdPSXF2d1RlZVhUSlBleVJpWURSdHVN?=
 =?utf-8?B?WC9ud09oVzZKRTN6ZWVFTGhza2Z1a3dLT08wZm5nZVI1RjVvaEE0YVJCbTZE?=
 =?utf-8?B?blRrMFRGaXM0cmxiYTVZa01hM2JxMWx4ZzBMUGFCNmZjaHZRR3B3RzE0SjlQ?=
 =?utf-8?B?N0VsY2ZPbzN1bFdDRS9vdjNuM0hYdnNNTDBPM1ZxOEZIaUIzaTMvRkRGV240?=
 =?utf-8?B?enZCQTgzK0Z6bWxDY1VGOE1tSWFCLzVwTFR5VmlIdzR0RUljRndVSXFHUFZ1?=
 =?utf-8?B?dmdrOTUyMmRySjZiWjM2cnhLWWxMUDc2aUNoRzlLck5mOU5jRGpVbFJnZkF0?=
 =?utf-8?B?ZVcxMStld3huU1ozWWh1NGFxNkdDZVM3UnV0RWVGeXNsenI0V2NSRjU5MVo0?=
 =?utf-8?B?d0RlZVBOUG9rZi8vRUJvbXBnOStvdzliczVxQVVsMVIzS3RaN09GcEUrRlZJ?=
 =?utf-8?Q?aKXnou?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnF4b2ovejY0UmFzdVEvc0NPMkpON0d6ZlhkejJHZ1d2ZDJhdTJvNk9EVTBp?=
 =?utf-8?B?YkpmQWF5eGpkNjVGMk51YTRrS01Za0s4aU4ra3BIZVhXVzJwYWN1ajAya3Bt?=
 =?utf-8?B?cTlJMXlXVExCWmdGaGNSZUZ2UGNrRUQ5Q0luY3dWQSszSkFNbU9hSVZFWUNH?=
 =?utf-8?B?YzQvWkZVN2Z6N2tXRi9LZmFMSnEyc1BwSlJGS2pjYUtvVVYvYkVYNWUyZ09D?=
 =?utf-8?B?Qlg3L012VE5jWnM0bGZ2RUxpNkc3Y0tRU1oxeFNNMWUyQ3k4bTJPSDBRKzZ5?=
 =?utf-8?B?SWJjdTlSV1l0YnJvd1BoQWR2MG8wNzZ5bjVPbmo4WVBxdnZ6QUE2RUM1Zmxo?=
 =?utf-8?B?emZqZ21YM0dlNll3U2kyY1ZNY0NhSUMvdk03TEN1RXYyNEVVbCtKbXJ4ZzNL?=
 =?utf-8?B?UGticEtrNjI5N1pIMjRKZ2NOWkpaTTE5UFM3TW1mQThvMlBIY0F0cnRLNmxN?=
 =?utf-8?B?UnFBTlphZUNiZW00STVvM1ljbEtTVzBuaVB4QmI3L216UUt1ejFzQ2Fybk43?=
 =?utf-8?B?SHZIWnFMRHpKTXRnd25WZzBGZ0hlZDFEYkNSRkwxM1VTUHhWbk5DbVhNUCtn?=
 =?utf-8?B?V0hMZVJ0MHdBeEMxM2NSYWl1eDdybmc3WTNJRDN5MGVWVlk0MXdpMkwwYXI4?=
 =?utf-8?B?dm5Cam83bi9IVUdWaVFDbWxUbENMU0hwZlNsai96RmZCMTBWZmlJazAzK3JI?=
 =?utf-8?B?emQ1aEZXMUNBajdWcU50YnhPY1ZBUXNzbGtNREVlK0dxRG5hVXpRV0hyakt0?=
 =?utf-8?B?WjY1N3IzQ3J4a0hoSXg1V0pKZHpSaHlvM3QyUFJsN05NQ1FHc0JXZHZuY2xt?=
 =?utf-8?B?NGUwSnBlTnQzdkZUOFM5NGlRZHh5dXZSbXJUNHNHNFAvRmFDMXhuSnNoRFpX?=
 =?utf-8?B?YXFFNWY4U1cveHRNMmFIbXBpQ1d5MEpzYy80TEhBZnp2WlJBb2Q1UTl5cWRJ?=
 =?utf-8?B?cmtjVDBwMkJQZm1acUxGVStUSnNtbzRGdDhqangrNk1laTZndm9PajdLdmdV?=
 =?utf-8?B?ZXJqanpRY2txNWllb0JKN2tSY01hQVJrNzE2N1cyc2toWDUwbStrQ2VaTHNw?=
 =?utf-8?B?bStSQ05rbVRqenhvcm5rcGcxOFJCc29PM0NRajNZTU1FU3JDZnVjcmxJdnZl?=
 =?utf-8?B?dDlweHNSdHdJRVBvUVlBcFhlVFdRZ3NKcEk1TG9xaEVyTEp2bGRacVlVbk9x?=
 =?utf-8?B?VDE5cG5INlZsaW4wM2U3UkdwN0dZRmdGR3l0dzlSV2Zzc3J4MHErMW9CYTRW?=
 =?utf-8?B?czB1Tm9MdmNnTG5IaWRzRGF5RjRrSjBidk9yUXFpUlF2cEJ6WGxWdHpXQkhK?=
 =?utf-8?B?aWlxT1FkNWJuZE1MOFFjNU1CVHkxTkFva0JSb1FFcGZDbGszRXh0bXByY2J3?=
 =?utf-8?B?ZmNwQld1cEJiejE5NndMNytnUFc3bVUxUWFSeTJPQ3ZkQWRiRGQrdk9ybDdw?=
 =?utf-8?B?MG82Z0lYNDg3MldhY2lzVEVzUWZ5cmpSOW1SWGNQenBrbXZWQVRrVFMwRjhL?=
 =?utf-8?B?c3FXRE12OWgzOVRhUkVzVlJ0TXRpMFdBaGNEdm42cTBpQU5NZmVOcDE0YXhI?=
 =?utf-8?B?R0FkWGFLUUZBbHJpSXBVdVphNjc5bUpHQUdMaTZ6dHM1eXN1Sjg2dEVrTXpv?=
 =?utf-8?B?YjJUbkFTMTJSUE4wNVA1UHZaa1lTeW1icXM0RVN4VFNRY244WHc2S1RDWktZ?=
 =?utf-8?B?L2tuYlI5RVpFRVVRK2p3enY1RTA2aFE1UWZjejlxUDE4NWY3TjNpZFArcEp6?=
 =?utf-8?B?QXpzUCt5S002UDVITUcwNDZNd1FtRFYyeVZxMFZmd1JDbEg3ZERDckVxQ2VO?=
 =?utf-8?B?aVJ1MDdUTFJrU1dMSEhzeUtlSzRCUGVIb1U3RHUyV3ZvQnRES2krRmFYSWVw?=
 =?utf-8?B?dVllQnhuNkxtNFg5aGxwbXJReHFhREcySmpNN1VLQ1ZzdVkrblYxSmdvUWRY?=
 =?utf-8?B?dVlMUU1zVGk0MU5KTXRxUTVkM1F5ak9SMWdDc0FlcGEyRWd0eVo4R3E5ZlYv?=
 =?utf-8?B?SmJ2ZUVXTllBcUdxc1dMclhkMVYrS01UcWdNNDNiUElMc3FhTkdFMS9iOE1w?=
 =?utf-8?B?TWFPdmMxS096Ykx2blZqTjFRa1JFSXhUKzZvbThzcUdmdE1XSTVuWjNVdTRJ?=
 =?utf-8?B?eTFQc2FtRTNMeFlzT1ZVa3BxdkdCZ1dWeC9CK3ZudndQUTdmMzRCK0dJa0Qr?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63B715C210948648A6314C0EB3E62956@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pFCSCf/ghHwg0yxRz55U5RSJejlosMY+jGk8VOqA4XmFx4U5y5pev05ttAP2rfYrq7+c3LTWmOdoIh+sXWy2bu0u3Su9kyfoiNhRHHAL4iG1sJ+c1/z2bHGa+Sd5RoKzDCuSDF6ONn/tOaCTNqiI0seJn3wMFUSPgrHC7eH6ACdokMDZLCbESywqVyreQHm/xxNfi+uMv/RPhoMlySl+WwRxGzbH8YYURRCc5JHTSCMuoV5dqWiiHb8X92rYYxNT5xd8CsWtK3fWs4AfoEWx9TtkB9Z4OVt7rmm7ePcf5OIDlGF+4r67yF93s8w1B93QFl6egzf8z28uHGJW5/9u/hVqm8K4Ujh5pBD/CsH9FDBkZuSVurkRSsbgZMGh4WnM0X0oSUxYzjk554iLbeaMFneduh01m/M08Ls36zvvUCZWxF4naSmcuXHDifQtS2L2Jro0oEl0YZvxBzSf5YEfdwAVoZb6t8pjR6iHoCddKYCu+TyZjD+PI3LRkufUt2Z76USRyHP8ZsNn+8/rf5XkjqosfxyjJQTqtDyr6ZY9eNBzmFnmagwsV4BSUpbmsaah5amxlYUWHM1dKAd6cxa2zzjuwCGqrfWSpkZ8bIhSbRmWyUhSwSwKJLprCPJaOvRK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc3a993-a899-448c-f9a3-08de066eb55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 13:29:29.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQp9tLc9okMZQ5PTMzs+ltEKNMcTJkjuU5fsp1vyWAXbdshdsiDuZ9HF8Oa23oZPwN6NchJ+jkD37zwjEQ60yvczavfyB39DZL4ChvQkdbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6653

T24gMTAvMS8yNSA5OjMwIEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gT24gOS8yNi8yNSAw
MDowMiwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gVHJhY2Ugem9uZSBtYW5hZ2VtZW50
IG9wZXJhdGlvbnMgb24gYmxvY2sgZGV2aWNlcy4NCj4+DQo+PiBBcyB0cmFjaW5nIG9mIHpvbmVk
IGJsb2NrIGNvbW1hbmRzIG5lZWRzIHRoZSB1cHBlciAzMmJpdCBvZiB0aGUgd2lkZW5lZA0KPj4g
NjRiaXQgYWN0aW9uLCBvbmx5IGFkZCB0cmFjZXMgdG8gYmxrdHJhY2UgaWYgdXNlci1zcGFjZSBo
YXMgcmVxdWVzdGVkDQo+PiB2ZXJzaW9uIDIgb2YgdGhlIGJsa3RyYWNlIHByb3RvY29sLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwu
b3JnPg0KPg0KPiBOb3RlOiBBcmUgdGhlIHpvbmUgbWFuYWdlbWVudCBjb21tYW5kIGNvbXBsZXRp
b24gdHJhY2VkID8gSSBkbyBub3Qgc2VlIGEgcGF0Y2gNCj4gZm9yIHRoYXQuLi4NCj4NCj4NCg0K
SSBmaW5hbGx5IGhhZCBhIGNoYW5jZSB0byBsb29rIGludG8gem9uZSBtYW5hZ2VtZW50IGNvbW1h
bmQgdHJhY2luZyANCmFnYWluLCBidXQgdGhlIHByb2JsZW0gaGVyZSBpcyB3ZSdyZSBoYXZpbmcg
dGhpcyBwYXR0ZXJuOg0KDQppbnQgYmxrZGV2X3pvbmVfbWdtdChzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICpiZGV2LCBlbnVtIHJlcV9vcCBvcCwNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNlY3Rvcl90IHNlY3Rvciwgc2VjdG9yX3QgbnJfc2VjdG9ycykNCnsNCg0KIMKgIMKgIMKgIMKg
IC8qIFsuLi5dICovDQoNCiDCoCDCoCDCoCDCoCB0cmFjZV9ibGtkZXZfem9uZV9tZ210KGJpbywg
bnJfc2VjdG9ycyk7DQogwqAgwqAgwqAgwqAgcmV0ID0gc3VibWl0X2Jpb193YWl0KGJpbyk7DQog
wqAgwqAgwqAgwqAgYmlvX3B1dChiaW8pOw0KDQogwqAgwqAgwqAgwqAgcmV0dXJuIHJldDsNCg0K
fQ0KDQoNCkknbSBub3Qgc3VyZSBpZiBpdCBtYWtlcyBzZW5zZSB0byBkbyBjb21wbGV0aW9uIHRy
YWNpbmcgaGVyZS4gQXQgbGVhc3QgDQp3ZSBjYW5ub3QgZG8gaXQgaW4gdGhlIGVuZGlvIGhhbmRs
ZXIgYXMgdXN1YWwuDQoNCk9uZSB0aGluZyB0byBnZXQgdGhlIGVycm9yIGFuZCB0aGUgZHVyYXRp
b24gd291bGQgYmUgdGhlIGZvbGxvd2luZzoNCg0KaW50IGJsa2Rldl96b25lX21nbXQoc3RydWN0
IGJsb2NrX2RldmljZSAqYmRldiwgZW51bSByZXFfb3Agb3AsDQogwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzZWN0b3JfdCBzZWN0b3IsIHNlY3Rvcl90IG5yX3NlY3RvcnMpDQp7DQoN
CiDCoCDCoCDCoCDCoCAvKiBbLi4uXSAqLw0KDQogwqAgwqAgwqAgwqAgdHJhY2VfYmxrZGV2X3pv
bmVfbWdtdChiaW8sIG5yX3NlY3RvcnMpOw0KIMKgIMKgIMKgIMKgIHJldCA9IHN1Ym1pdF9iaW9f
d2FpdChiaW8pOw0KDQorwqAgwqAgwqB0cmFjZV9ibGtkZXZfem9uZV9tZ210X2NvbXBsZXRpb24o
YmlvLCBucl9zZWN0b3JzLCBiaW8tPmJpX2Vycm9yKTsNCiDCoCDCoCDCoCDCoCBiaW9fcHV0KGJp
byk7DQoNCiDCoCDCoCDCoCDCoCByZXR1cm4gcmV0Ow0KDQp9DQoNCg0KDQoNCg==
