Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020122.outbound.protection.outlook.com [52.101.191.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A11BD031
	for <linux-btrace@vger.kernel.org>; Thu, 21 Nov 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226465; cv=fail; b=Vi7PydYkJl3TcLOF64kbNo+FSKKDid5hcwfaPzgs7bu0ON6zzP+9QHj9QhdjkbpwQeowTUtJ1pgUTZgwK1v5b9VpjiuOwCnXKp4sxhjQSNOUG7eSuHAELOYRCrGP3ICNyiVmHl7acN9eCk80KHV5FS7+8hEytlcWuOjAXciDJyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226465; c=relaxed/simple;
	bh=fEKi5paxJ0TvevwamSZE6kQRBVSfV43TProFRV0LjzI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hUTYV9rlYTglXfDzwgG5fuHPLo4zAs9DM5O65xtex6DkOhtt+3i6TIbcO41xzn4vnDDcZdzTvbcPiKjCNpnxm7nsYlyTyvAArgyZ+ZNJiCxVM+6/qyTBMwFyCiyhkDYLbK94BdyCfv9O6nut4aFYwlklI7CqAJowACrNZ1P0+YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com; spf=pass smtp.mailfrom=raithlin.com; dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b=FzagVKXo; arc=fail smtp.client-ip=52.101.191.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raithlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="FzagVKXo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5fSDjcqGdkSEWmucsSF7W8xW4cyorP/wUWzO9+5xc0rT5BVJDtL3fnmxLGFwb/TZstxnHwx5cQwWE+l2PFJSIe+kkgoEzHfR2Kpih8Sh3fAbwBITeQYyA0B8eGJ8mfjWKk/8G3yWSic4S12PKaX/ffKMGivCbSpvV2g3AvbDDMsonIyh8HOlp7sxhXHAxNETCMShurQLydn/TS+AF6qfA5Z6gF7HaVpmvEpYOjIhQNE2fsmXK7XSjULKs+4/MWqOweX0XsF/vhxyR6DP00lsECUGlVIwrcbWmsHJFwEjSTYTooThu2uP3i82fwwz/CXhziSDgC35Nwcbw+SBRfAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzPYQ0ceobadsaQOf5+UCiEQFHW+6XafPYhLpE2vl58=;
 b=opsp+U5XTKMvE62Ho5ndBHjcDAPv2MBF6NEbnc3pPgSaLiPE2v4NW9C1li31X3vkANRymJ3DS6zDMX1Bt6/sSucAtcFhsWpdMS3r7FEnzBG/mtCVV4gsDmbL2UGPZc9m07h1VbxgeumVPjO2tYhvngb3Ezc0cBG4ulK9FAurbMh9lVO26PpsPsU+ppo5ueZXjGAO+z0BtbpEMlA91H+WmoChNtjH1RwLP8q+SPOTldSYsI5LInm/JUp+d/i3VFL1a/NpnizWiFX7jimOZc0BhcJQmc4+YHFNVWSiqlKXEjP9vJXd2Q5Cacwoz3mPaoDDoBPQ1DSx/0vlhhmylxuZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzPYQ0ceobadsaQOf5+UCiEQFHW+6XafPYhLpE2vl58=;
 b=FzagVKXo9b1bOnTFoY3GonYDBgJQIbC9O4tNMstC95IGPWvU0K8ZLMtzxjlRDm+sAsp1kUsWMvcfwbk4qzL885Qlj1dES3S2aPR/EUaAjOTBuyVGb6Do0meIij3DpYsuIkkDxTBXl71gwmdG0VFiFcuJw9m1JxqQecittCCL6XM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YT2PR01MB11292.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 22:01:00 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 22:00:59 +0000
Date: Thu, 21 Nov 2024 15:00:57 -0700
From: Stephen Bates <sbates@raithlin.com>
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk
Subject: [PATCH v1 0/1] Add an option to stop blktrace based on events
 recorded
Message-ID: <Zz-tmR3IyJFdSR8Y@snoc-pinewood>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:303:dc::29) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YT2PR01MB11292:EE_
X-MS-Office365-Filtering-Correlation-Id: dd43ca21-0dc9-43e5-de54-08dd0a77fbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTltNTRhL3NXNHZPVkp1OWkvb3VNYVVvNllCcTQrRzgySWIxcHBnS1RGekVj?=
 =?utf-8?B?enFSQS9yd3NuRkVnWjJvOUNhcU9uelJLZFRTNW9IT1I1NXJpZjVmbHNaMFRB?=
 =?utf-8?B?eTd2ekZTcnVMeDI3ZnhyYzczVW5nNEw1ajlYQzd5YmxldlJpMUlXRlJIRzFK?=
 =?utf-8?B?ZHpGM0E4UFgwNVNLa1JtbUVXUmxIaFJ5Mk9zalB4WUN5Z1Zldnp5S2hRODNB?=
 =?utf-8?B?MnR4Zzc2eFdIREV6T21NeENEZ0pCaWd0Y2pBWGZFU3Jib2hLeEpxVStieFR2?=
 =?utf-8?B?RkxETjB5ZUZtenZ5akhmOWE4NmVYSVB6MERtN1hlREZpdDExYTVIa3Q0Yzlu?=
 =?utf-8?B?eGFmellBUnI1anNPUVM4cmttWGtEQlVGMHdPbmlrR0ZOVWVSL21NZ0VEV1pt?=
 =?utf-8?B?b0ZUajRjSzhOZ1JrVllBckxyVzVtUlRiWStSQ2ZlaTlTSGF1NW5KYlAyeGh0?=
 =?utf-8?B?M3h6YzErSkx1c0Rucm9TUms2RHdlWWE2eDhlWUZNZWxtYlJKYXZUYUQ3K2k0?=
 =?utf-8?B?N2lyZHU0Rm96U1pWNVJQY0U5bkdvcXQ5dDBqUHJ2TXg5MFd5NEdRZ0lGUTdL?=
 =?utf-8?B?YzE4QmJKSnl2VldUdUpkUGZHOGpWbEVZazZ3ZWwrV3lLdmtjMGJlOC9hTi9N?=
 =?utf-8?B?WDV5YTNiUlF4Y2hJRHN2MXg3NWV5eVBTemxWK0dmM3BqOTRsZUxDSmhIZzly?=
 =?utf-8?B?M3pGTTR0UmlST3UvRmhQaUdGS3Fwc1JGZmxGd0RteUhWWldOc1Y0VVdGbGV4?=
 =?utf-8?B?QTRidE05VmVQT3YxRjlEZ05LMVhpNCt2R1E3MGRHM0w0MjRFK3Q3ZmhHWEYv?=
 =?utf-8?B?RzNHMlF4RE1CYzVYTFZuM0IzM25sZTJyc0VOU3FGbG8rK01ESk5tcHhrTWph?=
 =?utf-8?B?YmdTNVNjWUwvSFNLOXZQSUJ5UTRicHB4ekFqallCbk1aNU5BalEyb1ZNUEYv?=
 =?utf-8?B?UFY1N2drajYwRWlzTFdMRzNRZktRSjZmU1FyU3lQWWVvUXYrZUxkYUtBdlhE?=
 =?utf-8?B?QTAxakJKdjVud256TUdRZ200WVozeG4zQU5OYnhpY2l3WWFaM3cwMEZlZ2xE?=
 =?utf-8?B?bkg2VXFYa0ZVRGUyWVhmY0ZxZHlvdWRJSkZzUWliRCt3cUZtc2xIZU4yNnZa?=
 =?utf-8?B?eDVvR3ZxWTBSWU5XQlMvZFRCVzhhZ2VETkxZQjd0UG5IaDZtWDRJckRVdVV4?=
 =?utf-8?B?RktwVW9sMlJTTHRxV0F5L25rQUh6V3lFRENRQXl1ZC9JaVB4QnNIVW1iUm4r?=
 =?utf-8?B?c0FTam40aGRiazZLc2FBZTdScFkvT1MvNFhFaHA3QTJHdnYyN1RiVzd2aHJu?=
 =?utf-8?B?RUJKSndUL3NKV3o3NURJekdBcUZmMnd4T2FKaUVJY01LYXQ2UTZrWHZydUtm?=
 =?utf-8?B?eVE5RTBUdUlFVmppd2JyVmkrZG5iaW1RQ0ZpYkNOc1BuMXJyQTI4V2FucDBT?=
 =?utf-8?B?emdWbjFMZ3NWQmI5RUtpc0N0M0JGRzhEVWVwMVpwZ3ZzZHIvS0o2amt6dkwy?=
 =?utf-8?B?Zm8yUm13V24vZDNFdHVUdFY3WGFocGtJQy9XM3Z6KytIQUFoc3BQVDZIRHMr?=
 =?utf-8?B?OGVxNHdnSHhWbnVjZitjaTQ2anpXM0s5NHYreldadmo3WWdRMERxb3phTUIw?=
 =?utf-8?B?NzhFRWFzdmhNMEliOGU0VFIwR0dNTVFWNlBDSWtONDhDSitGdVR1R1FLNUw0?=
 =?utf-8?B?N2xkTUNEQzNHOHNEUjVDaUl6NUpKOEdRTGEyQlZ4QjBMV0ZZcUk3NTRubFFo?=
 =?utf-8?Q?s0fRE3IUK4T3/fyE1adBlMuldUSW2F5CQIdpouJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnZhLzFXTVJ4Zld4TXFWR2tsREU0VDJWbGZCNWk3RDFjN005YktBbmxYbWtY?=
 =?utf-8?B?emFoeEJqenpxemR2VjJXaGF5ZkpxT00wakVVSy92aWVvRnFLbVdhWGN3UFRV?=
 =?utf-8?B?RG9DQWdXOU02Zy9Ob2ZQVjZ1RE95Rkt1VVZvN2dZaXR4V0paYUk1Nmprck1a?=
 =?utf-8?B?ZVdJUXBMY2tETTVXZEVVZWtLV0FLeWJLS3I5QlVCSFNTM0E1eDJJL3JtelJR?=
 =?utf-8?B?aHdjWEZHU2pSekZDV0RSTUZTZktEWmJLSy9pWE1KZnpFZ1JKcG9GZU9jYnJ4?=
 =?utf-8?B?d1c5MnFWeE5ZU2ZHdVBJRStaOWxLd2JCcVRTWC9SRzAxYlBQTGpxUXdTdWk0?=
 =?utf-8?B?UXRtbW1OMHl1by9YaGg4cEFUNDJXWjI1VkVuUkhlY2tDZmh0Vkw3RXI1ZWVj?=
 =?utf-8?B?MFVodWVoZUZsMFJLN2luZlRuVmdGTUtUS1R2bFg2UFFTQkxMR1BhMmxmMHM4?=
 =?utf-8?B?Kzk5Y05CVDZLSWZiZU9acW9IVkxTa05GTVVHT0tteTA2SThjbXJJNjFybFdW?=
 =?utf-8?B?aS9oTDdXc24vdjk0dE5kVGVmY2s3aUdJbG9MY2t1NGkwSjdFMUYwbDhBNm1V?=
 =?utf-8?B?M0RzbEdTWGNiMEFCVnpCR3pxOWU4SCtpa2lQNUtZQ0FMZU5BUm5PalUrUjMz?=
 =?utf-8?B?QUdsQmpzTkVtV3R4YjRkODlqL3ZLaThTcjN1TDhZT0RseEQ3VGlpMTJxNXZN?=
 =?utf-8?B?VFZ2YVRYREZpcDNZWnBHWXJpVTI1d0lzNXIvbS93K3dFd3J4cmVZK21OUk5m?=
 =?utf-8?B?WlB2RmlOb2dpeENpZTI0WEJmZVNQbE5VY21mbUhXYmNNMENUVCtsNU04enps?=
 =?utf-8?B?V0JIcGtldlFDVW9MY2xkemZsVTYvQWJibW9pTkJOb3M5SjI5dTRkSGdQcXcz?=
 =?utf-8?B?WWpEcHhYMGNhMWZvcERiVGc0ZU9COWtyZTc5bGd3NnkxZmZ6ZVBtSDFXNEUz?=
 =?utf-8?B?Z010M3Z5Z2RlNkI5SDlhdzUrUkdpN3Yyb1c3ODMvR09odjdLQnNvYWJzd3Zi?=
 =?utf-8?B?NHd0QzhRQzE2SHlDQ1Bzb3FMVHhjYUJpRnowMVR3SEdNcEdJdDV4R2NjMWJ5?=
 =?utf-8?B?dXVaUnp0WXh3N0o5Vm9RdEpRN3RxQzl5Y1pTQy9XYmNDQjBxdHY3TWJyYzBx?=
 =?utf-8?B?TGlCWGRWcXlFN3JJMnVhTW4rTnRVWXh3QVcxaHVRYTlraHdiQk9JVUcxc1Zw?=
 =?utf-8?B?QlgxaFBuVVJNZjBDWDRGMEJJMk9Od1ZPQlN6Y2U4aVJwWkc4NXhvTEJDUll2?=
 =?utf-8?B?ZVVnbUxxanlIWWhRbmt6d1BSUzE0OFpEaWU0bjFhQk16aE9tVUpqaUU3c3Zq?=
 =?utf-8?B?NHlRV0JpbjY4Q0N1QWNzczVBZHo2TUdUY1FUemFmL1N1U0x4cE9haTQ1dk4v?=
 =?utf-8?B?Q2ZaL2lBZ0o2TkdIWjFnUjJGQzRoSnR0S2tFUzdqaHpudVhVVHo4aURpbWtM?=
 =?utf-8?B?Zk9xSlpnQkQreVI0c09oTVRvaUtza2p5ZG8xZEFtUXYzLytCWUQ3emp1cStO?=
 =?utf-8?B?bE9NNElicFlLNHVzMW1FVktWbEF0aDByVWg4Vml5RFNIMW9QZjN3VzNWbUpR?=
 =?utf-8?B?ODdvV3ZWY296WWJoSzBRMi96Z053ejNoM3NYbFBhaUFjTE5WRjEweE9lTlpn?=
 =?utf-8?B?d1I2SDVlTTR4VXQ5Rjc1MVl4dnVZK0UzWmJKaWdZeFB2bUhHYi9oenJoV2Vp?=
 =?utf-8?B?ODRqK2w3ejU4YTlIR2t3bUYrZVo0dGxuamtIYmRTTS84ek5OQld0dnBMazZN?=
 =?utf-8?B?Y2JhNVYzU2twQ3lnWTFHU012Q1NkMjliVlBJY3VEai9oaU9pRDJBeTcvTU5W?=
 =?utf-8?B?bm1mM0pLRlJjaExOaGVhdzVQMGlvS0drMEJ2aWVFWnFtWHZRSUR3amVzalp1?=
 =?utf-8?B?WnZxK3MrZXd0S2tBa1pkMzdUWnNZcUxCVFJScnVNVVpEN3hNdnJEeVBQMC81?=
 =?utf-8?B?TjE0b3BRekxlaHcvTmlSYTVXMDF5aVVHNkZzMXZHdUUvVUZ1emRNR0NZWmxH?=
 =?utf-8?B?ZGYzU3dsZ3NZa3M5NThBQXRXVUpsSkI3VUY2ZWVhaXQ2YWY3ODBGOWcrQ2Zv?=
 =?utf-8?B?RzU3d3VpTnlXWmk0cW5HYUh0b3FuQkhidS8zTXFURnpyNDZ6bE0rN3l6TmtF?=
 =?utf-8?B?VVFGek5QcmF4eDlFYXdaVmtLaTdZZDljUC9QWFI0U2dvMEZTeUF0WkFBZEZV?=
 =?utf-8?Q?YiM62Z1++4/ktLHkCj6nRljP0mXCUCKM8BT7QhflHaS0?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd43ca21-0dc9-43e5-de54-08dd0a77fbaa
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:00:59.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwLalCRJknAQq9vxO5/QXXZ8+CCxQGk1fhT6Q9qGojPvlkuCf7raG03g1nHEbyGp9xQzpo/OB51mQLSG19iZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11292

Hi

I am exploring the idea of tying blktrace to a prometheus exporter to
gather more precise block layer activity across a fleet of servers. As
part of that I thought it might be useful to be able to run blktrace
until a user-specified number of events are recorded.

So the following patch adds a new option to do that. I also updated
the relevant documentation.

I'd appreciate feedback or comments on this!

Cheers

Stephen

Stephen Bates (1):
  blktrace/events: Add an option to stop blktrace upon a number of
    events

 README           |  3 ++-
 blktrace.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 doc/blktrace.8   | 15 +++++++++++++--
 doc/blktrace.tex |  7 ++++++-
 4 files changed, 69 insertions(+), 5 deletions(-)

-- 
2.43.0

