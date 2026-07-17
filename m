Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947633A874D;
	Fri, 17 Jul 2026 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268895; cv=fail; b=eN4DfRUW23zNBVrNC/X5DJhUJteEF4oS4ortikColWXhVf3+5f9SilRbxnq5CJnbRdI19QgHAmcSMIU1I+EN5W5reqA1Zl582x8tC8dCc3Y6edU29TobfCGl7VcVcLhSC+p3WFLAJCGg9otIrlVu0ZIeQTHsucNzC92+O/mwnBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268895; c=relaxed/simple;
	bh=WTIpaBxHUMbCBsXzubrX+5fRvbD5J9VZ0PuPN4QQ+fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lq0IDa/m6jhDcPIzwgVahIGXUvFC4Isv/T2JIg+qm6kQhVoEM44y3/LLIcGFNogX1HXierOAurQsRh8HwF2Wxx3u2gF/kuUSS8chWqKuMOi08h4oGL9guckFv1IQQMThPfAb1c9xoryNOlXKk5zJx3sgCk++2yIoRhZ6WsPc34g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U2R7Yhpo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=n/3GWSw5; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U2R7Yhpo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n/3GWSw5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784268894; x=1815804894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WTIpaBxHUMbCBsXzubrX+5fRvbD5J9VZ0PuPN4QQ+fs=;
  b=U2R7YhpoUumhvXRDHAgNYtRSEfv5HG1shNWTYvsW7Mp2dTh6yqiA8vtM
   JLuztBfnDvfbVXICfPm5ETQoCPn1QlhP/mMyAFJ25N42tp/u5RPVoo2Cp
   HOYd74iTSP39mJGislQfW8hwaXzBbg7lEauxfRWHih/EPTj3oGc4mNRpU
   3lvF53thaJNks2jlpUgUSSJdSkau5OutSsCBB8iCJajxlFu8gBZ9dzuzI
   sAEmGk4t0/94U+PmeqkI8trxbT1fhLy+Y2eLqxPOmeTeslHl5OsQIb6Tu
   7MeeMNEwVIRiMA40z6X01V8yLgYdL0glgKybS9/KzeJfqlXpWr2TAweVO
   g==;
X-CSE-ConnectionGUID: vEVjOZMxT8eocbuRFLPSHQ==
X-CSE-MsgGUID: bk4VqrdCS0m5LJzOUAsXoQ==
X-IronPort-AV: E=Sophos;i="6.25,168,1779120000"; 
   d="scan'208";a="150253526"
Received: from mail-southcentralusazon11013016.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.16])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2026 14:14:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV00R4pftlFzzUlY2VSoaRGHakW7iXddZA2CQ+tclijnTm/sZss2U4mLsKXhFu6D7oZQjo7zvbNqVSamKTYp6h9++Cd1YXLKyJe2RaV28m/c67W7KLFhJfCjGijuadC/AP5lR24zrCPv69J1T7eaWJXtU3Mcg8muMeu6AaX6NxpYO7UDzd37naKBKbD/ejHdOstpYMbr5ICj9qRx23pI83CrlooH2Y/4ufpJpb1gLlA3XTsuWV57H82jVVV5txEAn/SiDNGW2bK2j95F2VhTvva8zXB2zllNnKyzrLG7nFFPmBz9Hw3YRuvhTvczvmTDh/OBY7Qe34He+z96tnNAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0I2hwLWI7xImdi01hv1jABg5X1slZ3Wg3gnBjM/aXc=;
 b=Q4gRAfr72OmcNm+EDMB9H7UurBW+ttPfC/m8kS12m+OWNjQ0ljGisGdjHmsT0yjeLp3P+jWUnUkeGy6Hhqtdtl9+CY6CHA3KCLmAbILBaCvjpr/WK+C0t9O5tTbv4oVtAQtYZ5CmPIfPQb34ZkRwwr+2TJ9G50NdUEGSBoDHUD/IveTlUXflAMdwZtsB8bBzgRs40NOn0MsMZ395XgOMxqEH+vytEJvcWWZtLabaHv3+jTutEu/VFBzu23VAE58kDQ2AyJ+tjmE7iaI8FgSqOdcRLwojIt5qbDGlaaZC8W8JNHcjlHns1kc/7aMd68OG1c3u1sAg7aosgAlSlOZ3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0I2hwLWI7xImdi01hv1jABg5X1slZ3Wg3gnBjM/aXc=;
 b=n/3GWSw5GrBQCt/iP9jbAxlSCmbK6cQ7TtxgTw3/tUwYSf8MVI8GT3bPBWzpAxkksp7VqFqJiNM4Jsih2gYEkmPCN/kjNgOEydZnsTS6kXCWaEefxLkeAA8oxaMLcp4m77KFvcQf/1CtVPs4dI1r8iWtE9sJhyB3jD6znPj1y3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by DS6PR04MB10087.namprd04.prod.outlook.com (2603:10b6:8:464::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 06:14:46 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 06:14:46 +0000
Message-ID: <658ce002-6c5c-4373-9be1-2563d070a410@wdc.com>
Date: Fri, 17 Jul 2026 08:14:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] blkparse: add option to emit a specific trace
 protocol version
To: Damien Le Moal <dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-btrace@vger.kernel.org
References: <20260716110442.1291010-1-johannes.thumshirn@wdc.com>
 <20260716110442.1291010-12-johannes.thumshirn@wdc.com>
 <5932975c-39db-44a7-8fe1-5ae6cad22946@kernel.org>
Content-Language: en-GB
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <5932975c-39db-44a7-8fe1-5ae6cad22946@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|DS6PR04MB10087:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c391941-6874-4ce6-67f7-08dee3cab355
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|19092799006|1800799024|6133799003|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BouLwkn01hHgy6QMpSDu0JlEo4GFdLn04OCqsAdMVRMcH9+9Pz3ZNUVNJbN+V17DHvrD04JWcKkaBvvic9Kx/tcuAcacchnvqeQOsD7gjA1C8LM7mlPGQfUQbXcjo7wn3X3lDXQ7KbTCsg96A1dbhL37wVBoV0kJNOg+USdYuMFKfmsAyNoRZHVnn1KxLBKf8sPO+1aCznAO8pPwBDOyYzM/uDx48I+7MF6Avehoq9d5Xtg6Ua9KZ78wBL/XsdnGUqKycIzwAlmt+XS9hQpXu3INysnzvr/uHBhfWNiOlyWnGIIrAbP82wJlrwwdaFor28XYcwOLgYWPD8vtyEMnSaxxtSj6tkePk1ASKDmFgZZhQdFGQSmzykwIFjmtPKPJBTyYEcQSTi4L7jNieFUZM8T6zggqarq6ATS8OFmDSnaCfTPIynWDM7mqXkm1IGhygfPjUDvp4j1QeKTCFELiSKTsB/JB8DEBa8VSDp7077Hov0Y1ffUOTSj/7WktGyH42l81ZKPmIA6qaEppr7eJzSZVZn6etf5rfqlBvBUWlYm2OG/pFZSxpkc1eeEDzjpHmb1otDTjg8Jz7vf4cXr4Wqx9YHtNvmvpAeEbNV/q7TzDOUgTERT1a3s2iWPxRyOQs9+cSu6Nr9D9TdEQeok7qyFcoa+K1ejPT1SucLhUErE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(19092799006)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTFDck5iVXpIcE5vWkR2emNjajEzNmpIUUYwMksxV2FPNUFzcU81Rk9PN1Av?=
 =?utf-8?B?b1BHQVFuMGl0eHRDVVdVWDNVdWlrOU9STnJROXg0aFBJd2NuNytwTUV5S2M1?=
 =?utf-8?B?bWNQOXVNS2QwcmpHUUJWSWRaSFRHaFY1YmVIaytZR2daVHhzQno5dWd1TFNa?=
 =?utf-8?B?Wnc5bXFiQ2JKNjMvOXAzYm1aMXZxK0I4RnNlL1RRSUJlcnRKRWZIU0NKS3Zr?=
 =?utf-8?B?TWJ1VEdYUkp1RDcwZU5qTXlHUjFENDV2bGdyLzI1YWZDUjVIbjhxT29TaUJB?=
 =?utf-8?B?QitLU3BoRGhPY3JtSGliL1NRU3Vsdk5OTnkzV3lUMXhWTE1GVllPS3Z6d29V?=
 =?utf-8?B?bXZKcUlVNVBsOFVSeTIrT0hEVG1tTDZIZ0JwdHB1SUd6VUFvdDVXcURCMEpD?=
 =?utf-8?B?VWhITlJSQWVBUnJ4MDltWkczUkQ3NTZ6dDIwUndVQWpjUWw0b1NHY3c1NklW?=
 =?utf-8?B?OEFZZUJlejlsVk5QWlRHVWttdDltcm5lUTJZYkUvMTJ4azlnR1VrTEl2YXB0?=
 =?utf-8?B?UzMza2NpMS9ldDF5a2ZNRjdrVVE0QXZBZ2VTbGg5YWdJN0xjSlhuMWx2ODht?=
 =?utf-8?B?SmpNVzVheUw5K3BLcXJYdzMxMVNvQ3NVOVNLUks1ZXpFbitNU2tWVVJONkJt?=
 =?utf-8?B?KzlTWU5GYjJSZThFY1Vlc3lnTjBKL2lyaGxJYXZnbHFCMlpjbHZIbUsxMy9o?=
 =?utf-8?B?cDR1aUhScmZzMjFvSDBPb1FtT2Z6WTl0cDdnUjQzcjdmNm5BNXdSSGZJQTlH?=
 =?utf-8?B?bDBlbDZBQTN2dnd3YnBzd09rNFI4aGR2VDd5UDZiV1pWT3hFWjBMVTQ3bGNB?=
 =?utf-8?B?UW5yOGppT2lrWUJJTXZ3cnVNUTM5YTBvSTlpN1dHMUxud2JuZjFyWUQrM3Ax?=
 =?utf-8?B?WC9wek9HQ0ZDQ3VXWHI5c0VQY2tHSWl1MmR1THorK25vZXZMdXhWaDBWbktz?=
 =?utf-8?B?V01WL1pYNGEvb084eDZEWkNnZmJOYWZnSHhWaytxK2Zjd05SUlhReHZnajN1?=
 =?utf-8?B?bEFFUWIvbTJ2VFRhL1UzenNhV29WUjZvdEVHZ1lGdDJJUE5FcHpaV3k5OEpt?=
 =?utf-8?B?dlkwa2xtendzNldkTThnN1daMFZOMTl5Tk9NNytoK2U5alNYZlV2K2l5ME9T?=
 =?utf-8?B?Tm1ZRzJCMis4b3VoWFpGRTdxbG5DY2s1SzREeHE3THBnczJ5SnAzbWhycEVm?=
 =?utf-8?B?bTZyQTh3RGlqZXhFRDN1TnA1dmJUbk1OYWtUS0ZaTWViNWNFanpOMW1LK3Jy?=
 =?utf-8?B?U0k2b1ZDeDhYdTAyQWs1YndFTStTNWtYZGZwSk5CTUYyNllRNHJOY0JQOURR?=
 =?utf-8?B?QTByeWFPYWNtKzkyNzUyNkRKZmt5ZCtXYVBvdkp6RzRnUzBOZ2ZnL243cDB3?=
 =?utf-8?B?UzJHY1RlSkh4VEpNRVdadVl3VjQxd0hMZ0tLdzhDNVQ5WWJacUgxa3gvRTBT?=
 =?utf-8?B?TzdyUDNjQlJIcnFra0Z0NjBNOEo2M1VSQVpvUlF1QkphYUMxWHFtT3pFbHRG?=
 =?utf-8?B?MlFxUHRDTDVDQ1Y0UGtONzZXcXY0STV5WUdkZU5hNXY4Q3ZrZnpta0NpUjk5?=
 =?utf-8?B?Q3d5bDBOclR5YVFsYlFCZzhMRTNVNmNkdi9lWG1xSEhqTlhNNS9oTnJDTmJH?=
 =?utf-8?B?dnJBeWNQTGsrZkFGL1hIQVRBWTBBSExFRlUvaXN0RWxDbzFHTWZvREEyY1dN?=
 =?utf-8?B?VlRUVGc2R2dZWFRsaUtBYTFiWTY5TWVpMXdLSC9idlBMdjZyMkFkblBDUzZo?=
 =?utf-8?B?dkdzenlhaEk1em1WRlFxRVZHR20wb3Nkb0w2Slp2OHljUVI1aDNxemFUMkg1?=
 =?utf-8?B?YUhtcGNMOEwrcTl2YmtBNENYdGxINW5YWHZycCtkalVSUlFXcjhXbGhnWVM4?=
 =?utf-8?B?Yzlpb1RXTGNhWjhTQWsyRWdGYndtSjZYaVJabS9ZYXdSZzVicE1DQm1kK01S?=
 =?utf-8?B?MmhpN1ZhQkhncU1DdzJMaHFHclpseWkzNE0wOGZyMDdyQ0t2L1JIemtNZkt4?=
 =?utf-8?B?eldrRUJ5SkVDem9mM2c1cVJFL2ExeWJjTnc4MWt4b0VwU250djBQbXNjaTJW?=
 =?utf-8?B?UmgwaXNiOWs3TkpwNkd1MGZlVkhPWWVrZTVhT09HblhUdkZnTkpKVkd1V09u?=
 =?utf-8?B?S2lJTWhRcXAySTQyK092eFNzSUhhcCtkKzJXRmFsTDhDTjFZVlgyVE5FVWM3?=
 =?utf-8?B?SUhGbHM2OEY4TXd2T3d3dWFMMzhpRm45dXhIZzFyb01tclNaOXhua3lRVGJW?=
 =?utf-8?B?MnNWTE9VNXFwSTl6UnEwZzA5UnFSODUzTUhlNGl5aFdjVnpRV21kSnFTRjBH?=
 =?utf-8?B?d1lKdjB1c0JvUnMzVml4d2g2Q3ZXTTVoU1AvcGlJU3UvZWVyRTg2ZnlZZEFq?=
 =?utf-8?Q?zhbMQg8lBMg6sjvygpwARAGkdazDz+AXh1D9Q2gNP5bjL?=
X-MS-Exchange-AntiSpam-MessageData-1: UmjeG1Ik3Qv97w==
X-Exchange-RoutingPolicyChecked:
	Ba60D/AlAu984+NWQertUWGdxu78Zc4Xoj+tSGENZjlzZONSE2tPpW4bIUZcR9JrXP3gqlJoKNiXdepLH9q+5WLE2OE4tTuEUJxIxubszuMJ02prGIoCrlHr+XujwVcHfHCtdS/l50r03lGVGvADx0bSFB0AJlJxgT1i0HwKqb5Ilivl9ywCdUHEBi2+QoFIfeCdmm0Vt03EiYswW+RrcblyK8EyC+0hxV96I6gZQw77aB+FAugsL7FiEickpsp3d8PoFSTpfajMhSr9h1ya2BG/4PfI+LikObxaNbjICCkApOa4XN7+1rsGii+KDxZudapVQ42Z6kM3bxEDjl0JQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rxYAQ8Y+pwyWc+okseWI7psttPafcP9RyLKuv+mFcEVglC2NZCNFKMEaWOgZAwQhGSuC9zPd70yUO+0Hry88/DMEm6ck28k4rjY648qK1msp0edPCmKE3E8UQfD2/HuXYWNeG/OreqSerxrGenqtSoGNReYmX6LduOXDqJiTWCyZGdbOzbPXqciMJ3AMCQ8bZ7yQvWJRiiagoQAPBeBBDj1WG88mUGPdOcEG3sNzNDoegt/bkwoFy/VyRqVH0OLaLwjEd9BlU9s8FwdZHpNXSeZowCxQoBBimORPJSc5MbxO5rU2hzczR2TVdplw/ebLPhZB2hSPTC/vl13dWmB7yIHKo+kCX4GR1uJLTpgcSrK7jJnskfpehTyZmEHteugQ8wH8PN0XggWLVqiUGRBaqCoYV/B1zhKAE+lDJzmRclXFokXmfzNaqIDg0zhOmM0L46Er+fzoPQvJsuFKZfgwYkNad/haGPC9Lo84V4FeNrF4flJF3mcFmUtq5bJieCObwZC0fqRDgrin1EGMQb1AiKO0GBjU345yXYOPvjdBaesd0QY7bRxGwJ+EwKN3JEHtHDZoRAVZFgCygnR/WXy17GYS17aqj/iV1194HOzMZSIanI3Ae92PvdfNVNq8YJNk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c391941-6874-4ce6-67f7-08dee3cab355
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 06:14:46.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ths5UDoELgUNCLx8wr5AAxZBwuJItREId74LqJjNI2sgAMRUix2bwRogRMwYctqKR4JZ1WH+rpoMLZ66d5K5iBWl4+t4hHxY2u5smdqKS2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB10087

On 16.07.26 14:13, Damien Le Moal wrote:
>> @@ -3298,6 +3337,17 @@ int main(int argc, char *argv[])
>>   		case 'M':
>>   			bin_output_msgs = 0;
>>   			break;
>> +		case OPT_TRACE_VERSION: {
> 		case OPT_TRACE_VERSION:
> 			dump_trace_version = atoi(optarg);
> 			if (dump_trace_version != 1 &&
> 			    dump_trace_version != 2) {
> 				usage(argv[0]);
> 				return 1;
> 			}
> 
> Is a lot simpler I think.

Definitively. Will do.

