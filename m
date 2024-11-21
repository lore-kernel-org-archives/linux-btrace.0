Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021077.outbound.protection.outlook.com [40.107.192.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BFE1A4F20
	for <linux-btrace@vger.kernel.org>; Thu, 21 Nov 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226533; cv=fail; b=Uvjt+KYrH7ObvufUfoqpDBWGemrFLd91Ez5qtNcq59nnYneKPqZJ+5kzJ67OzhAW0nsRy+ae9aO/ui+SnYWuTeeassl1DG4fqevT+NsJUKV1kQJCznIZcXBhTaQUUQ12legXC1bMNtHf4bGB+/96ciTzB+IEVly5Pr9pLVlV3Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226533; c=relaxed/simple;
	bh=zIeYbKCwSrpxOpgpUCOG5xv04gnoTA6Xbc98WGx5Evc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=m71DJhvN9AyBUtGNhJ6UmnbFOOEpm1THP3EgGEa2y3AUy/FM4uisnGt9k6SkqjOeJ9kXsfDV9adqEGT1v5/E9+0V63Hez3eOsoG8snnNK70rmMglVjcUvgZDrjtcIyZVKGrNuUFB2w4WLk5DVB8ExHi62Hypop1bCYb7zFNKkGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com; spf=pass smtp.mailfrom=raithlin.com; dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b=sTnMKp0s; arc=fail smtp.client-ip=40.107.192.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raithlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="sTnMKp0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSi3OZboyHYcJYfMX28U84gDhZIye1nkhD+Lrbljj425/r/4yeZAiUgtuHmbNUGrxc62BjiBBqmcnJDyI0fWSr2cQD5GOl0gV/E8GQew7NEtEUJUrqRxpAWDX4XVpfwsi+6tYWywWDixnPpXdTWaOhKvZ6J853GzuP5mTHkLRV6WzBVlw3ijvQ15Ozg2lZdFM2HWwzMInIJmUQQ6ugBELj8l/lnAEIPlxKnvbunz1qRiJS5iHw+OP6WpSdMQP1BUAzRezPgTxe1mluIHV6z0sLBXVq7mqqeS383QlL8reprQRkt531ZuVWKg8aqJpzt6VeQzqPj2AfcMGrf9yG+9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+mYIGCQGnxelWFs4E2JKIDg3ucvWRUKGGeU+tCSceA=;
 b=nvpQw6WxfhfVJhd5YmEzjs/56BTY2Bi5TU4+U+dtWiCiLBC1OuM8rGo07NQ5YLbxuZTpvsLN5Y6aefZuVPsF2P+SUbeXdMGCFHNce6Q6GG49r2tDZStoMN+7/bL65zV0vRsiS0zh9artxRNgWiDXwdbQlHp/LJ1PHtv6NBFC6gTgZky+R7l+6tLJ4kX+oIVRJjGPPRtOvPOWjI0osHQiZnfAzh9d5tw2ARufK8vVXoZ1nccz/RbjVavW2HEiupeozm5C6DUETwDYdITYYONur8afrwvmCtP3PlxBxf7L9BiW8Kthvx1kgIT22hQg0cvLxe0wa8sij85ht97Uh9KMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+mYIGCQGnxelWFs4E2JKIDg3ucvWRUKGGeU+tCSceA=;
 b=sTnMKp0s1xc3jHBFhsDpWEA5uYsvEnFHDwVFkWSqn494Sb3eVj9AyXXl1UHxL2n4m8DmjiphGJIhb5lU2Cl0Qt5SKiDYfHH8aONmrF4IezWAxKCSTyz6i6H/+LH79GbqyD22B6n7M0ccftmWoOVuTFahIEqPyVzkKeV/rRbSVhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YT2PR01MB11292.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 22:02:09 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 22:02:09 +0000
Date: Thu, 21 Nov 2024 15:02:07 -0700
From: Stephen Bates <sbates@raithlin.com>
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk
Subject: [PATCH v1 1/1] blktrace/events: Add an option to stop blktrace upon
 a number of events
Message-ID: <Zz-t38YcxEgOToxv@snoc-pinewood>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YT2PR01MB11292:EE_
X-MS-Office365-Filtering-Correlation-Id: 80acdb4d-4141-4b91-902b-08dd0a782557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHZxYjBEZkNlMmlXVXZaM2w2bWd1NXE5ZGlBRVBTNCsybkJyZUdoZXJmQlBJ?=
 =?utf-8?B?WFNTRXBVNld1ckVnOFV0RERqWDZYMVQyTG83dVpESFVpM1FYdENsbTNjMnc4?=
 =?utf-8?B?T1E3bzdVRWJJK053ZXBhT1NCSFZZdUhLVENBSzBXalNudEE2eGlub1c1enN6?=
 =?utf-8?B?aHJNc3hueUl3S2pCRHM5c0RUQW5lcG15VzVuUnpyaWpqM3J5TUpzRDBSdjFx?=
 =?utf-8?B?aHRKRG1GYmRaSHJwaFU1U1BlYkczYmQ5a29ucHFBUDJPa2tlMnJsT1l6bDhy?=
 =?utf-8?B?WEpmUlZHdXJZMDlUTTJ0RXRPeldQZW5PZUxkajU0NzBBYUswdXRwWjl0ekt2?=
 =?utf-8?B?UE8wTnVXejVuOVZJV2U3SUdZeHF0RWt0UUpEZVhXMDJtMTFwWXpBMlVPbVgy?=
 =?utf-8?B?ZTBJZkFIQ2RiOUlXc21NL0xka2NPMXhoeWNRWXZBVGJibmNGaDAwTFpCQnZE?=
 =?utf-8?B?M1Npemk5R2RrQk5NQitGNHV4Zlc4K1lxSkZpVHVOcEdxbzZZNitma1JGRkF0?=
 =?utf-8?B?ODNoWjdHR1ZLeWxZbzBKd3ViNEx3QjhiaVByNXFwdUQveHZmcVhab3NwKzBL?=
 =?utf-8?B?S2J0OVNyZzN0RGo2OEh5WVg4SVI0bVNPMGZXem8vV2NMaXdTRFM2WVNQUkQz?=
 =?utf-8?B?TkgxTUE5VkEwS0d3K2hlNUxIWERVTURFQUd2RWwrMWJjVktiRUpzNTZ5Z2dX?=
 =?utf-8?B?WS84UzhzUUJhbUN3LzVFd1BiMjlqSUEzZVFmcGZiZko4SXJlU1ZBbjdjWWFC?=
 =?utf-8?B?Y0ducDVaQWQ1V1BDQ0RUTDZTUmhUNjVGOFNlN3JlKzFTTU1TQnFzNVRKTVNv?=
 =?utf-8?B?eW5hUnc2bnZNRzBjd1BEckJ6NWVxTGJHaTIzRWpSVk5YL1JyQWtXaFRNYTd6?=
 =?utf-8?B?SkoyRTRyRFVXc1hSSTYrUnNaSmx6S0tHMjJaYU9QNzQxaisxM3c0d2JHUmgw?=
 =?utf-8?B?Rm9VQUdUc1JPVVNvb2FpSWxiT3ZNNUJVVnM5UlYrWVFKdW5wS2NpTU1JK25L?=
 =?utf-8?B?YUFCOE5WT3FrVXBhMllqOCtmM05KWTRTemdmWWk4cUZOZmFkYkVsMm5MZE9S?=
 =?utf-8?B?MFFiOE5RNnNhdTE0WC9xZ1ArSnN5d1I1eUxSd3JNME1oT015cWgwZW9OcWtH?=
 =?utf-8?B?Tkt3WkhkWVBiZ2hTVXpVaUowVHpMNFJFVThLR3crdk5nMmg3QTNVUVVXNTho?=
 =?utf-8?B?VkRlZGdqYWIrb01CZU1VblVQd3JObU9yanJDa3BhT29IUk1pM2s2bWFocjNa?=
 =?utf-8?B?Qnp1c1BvNG5Ndm4vLzhHVlR4anNVQjR4OHN2N2hzMGlhMWJvU3U5eWVPeTdC?=
 =?utf-8?B?cjY3QjV6TzV5U3BCbVBKMlgxYmRsTFJRbDJRNjQvMktPT1BlQ3VBcXhDb1RF?=
 =?utf-8?B?cUF4ejlZRTNOMjhpeWwydllINURWWGVSYkpXSndmbjRqeVFVRDhtYTk5NHdF?=
 =?utf-8?B?VnZvcXQxTXZtdjI5dlZyZzRCdHJqeEl3dnhOSDZvWkV1TGRranlUQnI2UHQw?=
 =?utf-8?B?Wk84L3VxOHR2SEcrcTdZbk5hSkRRaW5oV0RJZ09UMDVROE5XemU1eTNMcVFT?=
 =?utf-8?B?dWQ0Y1V2alc3ejU4VGhlVmZNMnl3VWRCVDZrdm9VRStrMThkSkhLTUlnZXJh?=
 =?utf-8?B?QnBRa01DMUNLMDlMcGVrNVQ3VWZhekNIcXV2ZEJxN1hJUDVNS1dGNkFURHlF?=
 =?utf-8?B?REUvK2xxTjdzbGY1cDhDQUhPciswcVk2TDJBQytMNXBEZXg4ZXlaOXdvbXND?=
 =?utf-8?Q?oFnHQnmlnf0+JpOrUAa3kJUqSvzH8s6TVSREZLI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFd3SXlQQWkwREhsRksydW1Yc0xBL2t2eHFycGVpR2hHeG9vNDI3TUx5UUhL?=
 =?utf-8?B?UTFDN1Rjbkgya1I3WGF3VEFZR3ZLRC9tU2RBRTRPZW9KOEZxWGpkMzE5azc5?=
 =?utf-8?B?MnpWTzVITEE0dFZXSXRMVWtGdWR0SGZwMHVEYll5WjVxd0RBbmUrWFBCelBC?=
 =?utf-8?B?dkR6QXB1TFhOWVI3K1l1cXA2djFrcUFhNktXOFhoYSs1cXcyQTQzanZSSkVG?=
 =?utf-8?B?WDZCckFJUXpwa0FMbEtYd0tYMkcvQnZheWVxempuTXhmYlBXSzAxK05qSGhv?=
 =?utf-8?B?bkRPaXVlRW14VzNXNEZwZGljaTdJb3pLU2Vzby9qMEdZcTAweis5b1dVM2E2?=
 =?utf-8?B?dGxXQjVHaU0rSFdibC96cU5RQVl4ZGxYTzc0ZG1lL1I5WHJJK0dnUVkxN051?=
 =?utf-8?B?RGVERElMMnJQbWFQd1ZDQXVQMEc2VENqMTNWajEzbXU2M2tYc1pKbDlrcDF5?=
 =?utf-8?B?VUxoTm9YSEVGZ2NxZmt0di82MVVTUGlZRm1pWnhUbUgxUWR2Y21jSjhlayt1?=
 =?utf-8?B?RXdNOFFEYVcxV2haNUxOT25pdEoyUGFoRGFsY24yNGVpVjREU3FvRXFwWDhh?=
 =?utf-8?B?ZjcrbHVwb0p2b2xyS2RkNW9qcW05VC9wMzhqTDArb1oyWkhDMi9OMGsyUksx?=
 =?utf-8?B?aHkyUDVKS0pqM1FTeGlPck1KbnR2TUdCTERtRU9NNWVpcmtuR1lGdTQ3cHF1?=
 =?utf-8?B?OTI5ZlN4OEtXdFVhaFVaMzZneEJWVHRxUng2OVZsdWFjVW5VTm41dlhOWU9S?=
 =?utf-8?B?QWgvMkdONS9LSWVlMVl5aU1iZ1NCeTlLTXlMelBISy9QTGVCaWl1MVdlOFlB?=
 =?utf-8?B?Z3VTeEZiYnVUNlpqQkhTYmxpVDlpeUtXYlIzejg3Y0NGUVQ3MFNRWXZjNzUz?=
 =?utf-8?B?TTdNRXlJUVhEN3JRajN3REhxczloRWdXcFJWdWZacVY3YkxhR1JITWhIZWtE?=
 =?utf-8?B?Y2Z1K0djTnhrcFBPRTJ6V1YvT3VFNVAwVUdWd1V4ZFFKQ1Q0ZHVKckZhcld3?=
 =?utf-8?B?MkxXUE1BUFpTN3hKUXQ3d2p1N2Rud0psQUp6N1pITSt1U3JPdlNnbG5icGxa?=
 =?utf-8?B?eFMvT0hHSmR2bDVsT1F3ODNmd3E5QkpRYlcvTjV2OVc1UTdWQnRHWGEzK3p4?=
 =?utf-8?B?YVN2a1B1QVMveUhFM2ZkNkJ0clczRmFzaDlncWE1NkZvU09UeWFIbkNYU2sy?=
 =?utf-8?B?UXBrTG9abWxlRnhuK2hxTXhOQUNlbkNESWhGa2l1SkxiZ29abmp3UTNZdk9L?=
 =?utf-8?B?bWN2cDZHb3dPOTdGUTE0WWk5dG91L0RIOW5LVHV6N1p3bXZLU1dmR0N4WnlW?=
 =?utf-8?B?akVkRTlqN1FXWUpLZFdIRjJsYm9sMVZ1Szgwd3FKV090ODNTd2paMTdkaGRo?=
 =?utf-8?B?U1NCemhpNnBGM1RlOE1IdStXeUd5SXhDNGJqSDNjM0JXQkk2R1NtbjN4SUFs?=
 =?utf-8?B?dzdCZk9DSHl4YmF1WTdaOU9VNVRhbXdyTmk1MkFKT3dHRmZEc2VJcW9jNkx5?=
 =?utf-8?B?b3lRWjl1MkZpanRqUHBNWTNUZndocm5FZzRjSTBMVm1GbFd1MGwyUmVwWU9h?=
 =?utf-8?B?ZWpZaWU0T01oemN1OUlkbU9peDNLZWRBdi9kUTY2WWFLbzh4VDFzZHRyUEZO?=
 =?utf-8?B?bjg3UXp1aVhkSWVTbVRFZVlzTWZmZ25hYldPTUt0d2JpaGF2WHpISXgwb1R5?=
 =?utf-8?B?VUo5bGgxR2kyNVVMcHBUK21LdGc4VnRUenBnUHlVSXc4dEgzQkdYQmFJSSt2?=
 =?utf-8?B?OHdEUVJBb3NnRGxWelJYcG14STZLbDdOUDI1L21PbGZScm41OUtaeDhwTGVh?=
 =?utf-8?B?NVRnbHpmYS9Qd1VKTG1WcjMrSmpaRUNBMk5kak95dFBGeGQ4M0lJWDNJNFpl?=
 =?utf-8?B?R3VNUWthclA0OStxalMyUUprZGdzcjFXRlpXRHBnVVFkeTJkb3lEcWgvd0ty?=
 =?utf-8?B?clhOTDZJaWNQa1k4Rjh6bk5hOGVmN2srNVh5VGJvaHRYWnFXcHRQU0NvSk5o?=
 =?utf-8?B?M1F1bGZLb0haUjV0R2tWa1lDc0REekZxNzNjZ29tY3FNZWdaTEVFRld2TFZH?=
 =?utf-8?B?MmFzVE5Xc1dQS1dkNmVQV0dKS1hQaVBPUkJvcjQzM1ZMZ0x0VjZKdFdRQ0Za?=
 =?utf-8?B?S2s4aWxqYnhzdzB0MWR3dmZTQXlEUTh3eUZSaGUyZzB2SlR4MmduQm1JWnlr?=
 =?utf-8?Q?EfRS07FwhEtdnPdkmjLHJ3+AS/5NN4W9M2I/nXPYqQyN?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80acdb4d-4141-4b91-902b-08dd0a782557
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:02:09.6730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYDD46AIaknwkPIVgPoALlgHvai0lx2B1mymVz41pepRBbV2uPR+unaIQwkHOslXipBI25x0V2d1jJL9LlbdMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11292

It is useful to be able to run blktrace in a way that it stops when a
certain number of events is reached. This patch adds a new -e/--events
command line argument. Note this limit is per block device and can be
used in combination with the -w/--stopwatch argument.

Documentation is updated to include the new argument.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 README           |  3 ++-
 blktrace.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 doc/blktrace.8   | 15 +++++++++++++--
 doc/blktrace.tex |  7 ++++++-
 4 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/README b/README
index d7d1fbf..7fd803b 100644
--- a/README
+++ b/README
@@ -38,7 +38,7 @@ Usage
 -----
 
 $ blktrace -d <dev> [ -r debug_path ] [ -o output ] [ -k ] [ -w time ]
-		    [ -a action ] [ -A action mask ]
+		    [ -e events] [ -a action ] [ -A action mask ]
 
 	-d Use specified device. May also be given last after options.
 	-r Path to mounted debugfs, defaults to /sys/kernel/debug.
@@ -46,6 +46,7 @@ $ blktrace -d <dev> [ -r debug_path ] [ -o output ] [ -k ] [ -w time ]
 	-D Directory to prepend to output file names.
 	-k Kill running trace.
 	-w Stop after defined time, in seconds.
+	-e Stop after defined captured trace events.
 	-a Only trace specific actions (use more -a options to add actions).
 	   Available actions are:
 
diff --git a/blktrace.c b/blktrace.c
index 038b2cb..bc3fe84 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -282,6 +282,8 @@ static int pagesize;
 static int act_mask = ~0U;
 static int kill_running_trace;
 static int stop_watch;
+static unsigned long long  events;
+static volatile int events_done;
 static int piped_output;
 
 static char *debugfs_path = "/sys/kernel/debug";
@@ -329,7 +331,7 @@ static int *cl_fds;
 static int (*handle_pfds)(struct tracer *, int, int);
 static int (*handle_list)(struct tracer_devpath_head *, struct list_head *);
 
-#define S_OPTS	"d:a:A:r:o:kw:vVb:n:D:lh:p:sI:"
+#define S_OPTS	"d:a:A:e:r:o:kw:vVb:n:D:lh:p:sI:"
 static struct option l_opts[] = {
 	{
 		.name = "dev",
@@ -355,6 +357,12 @@ static struct option l_opts[] = {
 		.flag = NULL,
 		.val = 'A'
 	},
+	{
+		.name = "events",
+		.has_arg = required_argument,
+		.flag = NULL,
+		.val = 'e'
+	},
 	{
 		.name = "relay",
 		.has_arg = required_argument,
@@ -444,6 +452,7 @@ static char usage_str[] = "\n\n" \
         "[ -o <file>          | --output=<file>]\n" \
         "[ -D <dir>           | --output-dir=<dir>\n" \
         "[ -w <time>          | --stopwatch=<time>]\n" \
+        "[ -e <events>        | --events=<number>]\n" \
         "[ -a <action field>  | --act-mask=<action field>]\n" \
         "[ -A <action mask>   | --set-mask=<action mask>]\n" \
         "[ -b <size>          | --buffer-size]\n" \
@@ -461,6 +470,7 @@ static char usage_str[] = "\n\n" \
 	"\t-o File(s) to send output to\n" \
 	"\t-D Directory to prepend to output file names\n" \
 	"\t-w Stop after defined time, in seconds\n" \
+	"\t-e Stop after defined number of trace events\n" \
 	"\t-a Only trace specified actions. See documentation\n" \
 	"\t-A Give trace mask as a single value. See documentation\n" \
 	"\t-b Sub buffer size in KiB (default 512)\n" \
@@ -1862,6 +1872,34 @@ static void *thread_main(void *arg)
 		else if (ndone < 0 && errno != EINTR)
 			fprintf(stderr, "Thread %d poll failed: %d/%s\n",
 				tp->cpu, errno, strerror(errno));
+
+		if (ndone && events) {
+			struct list_head *p;
+			unsigned long long nevents;
+
+			__list_for_each(p, &devpaths) {
+				int cpu;
+				struct pdc_stats *sp;
+				struct devpath *dpp = list_entry(p, struct devpath, head);
+				nevents = 0;
+
+				for (cpu = 0, sp = dpp->stats; cpu < dpp->ncpus; cpu++, sp++) {
+					/*
+					 * Estimate events if not known...
+					 */
+					if (sp->nevents == 0) {
+						nevents += sp->data_read /
+							sizeof(struct blk_io_trace);
+					} else
+						nevents += sp->nevents;
+
+				}
+				if (events && (nevents >= events))
+					events_done = 1;
+			}
+			if (events_done)
+				tp->is_done = 1;
+		}
 	}
 
 	/*
@@ -2155,6 +2193,15 @@ static int handle_args(int argc, char *argv[])
 			break;
 		}
 
+		case 'e':
+			events = strtoull(optarg, NULL, 10);
+			if (events == 0) {
+				fprintf(stderr,
+					"Invalid events value (%llu)\n",
+					events);
+				return 1;
+			}
+			break;
 		case 'r':
 			debugfs_path = optarg;
 			break;
diff --git a/doc/blktrace.8 b/doc/blktrace.8
index 820b03a..b32cede 100644
--- a/doc/blktrace.8
+++ b/doc/blktrace.8
@@ -6,7 +6,7 @@ blktrace \- generate traces of the i/o traffic on block devices
 
 
 .SH SYNOPSIS
-.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
+.B blktrace \-d \fIdev\fR [ \-r \fIdebugfs_path\fR ] [ \-o \fIoutput\fR ] [ \-w \fItime\fR ] [ \-e \fIevents\fR ] [ \-a \fIaction\fR ] [ \-A \fIaction_mask\fR ] [ \-v ]
 .br
 
 
@@ -69,7 +69,11 @@ The default behaviour for blktrace is to run forever until explicitly
 killed by the user (via a control-C, or sending SIGINT signal to the
 process via invocation the kill (1) utility). Also you can specify a
 run-time duration for blktrace via the \fB\-w\fR option -- then
-blktrace will run for the specified number of seconds, and then halt.
+blktrace will run for the specified number of seconds, and then
+halt. Or you can specify a number of records to capture via the
+\fB-e\fR option. Note that this will cause blktrace to stop when the
+first block device reaches this. The \fB-w\fR and \fB-e\fR options can
+be combined with the first one to be reached taking prescident.
 
 
 .SH OPTIONS
@@ -191,6 +195,13 @@ Outputs version
 Sets run time to the number of seconds specified  
 .RE
 
+\-e \fIevents\fR
+.br
+\-\-events=\fIevents\fR
+.RS
+Sets run to stop when the specifed number of events are captured for any one block device
+.RE
+
 
 .SH FILTER MASKS
 The following masks may be passed with the \fI\-a\fR command line
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 836ac4a..d78de8b 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -377,7 +377,12 @@ of the more arcane command line options:
     \item You can specify a run-time duration for blktrace via the
     \emph{-w} option -- then blktrace will run for the specified number
     of seconds, and then halt.
-  \end{enumerate}
+
+    \item You can specify a record entry duration for blktrace via the
+    \emph{-e} option -- then blktrace will run until the specified
+    number of records are captured for any of the block devices, and
+    then halt.
+\end{enumerate}
 \end{itemize}
 
 \subsection{\label{sec:blktrace-args}Command line arguments}
-- 
2.43.0

