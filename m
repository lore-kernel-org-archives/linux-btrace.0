Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021085.outbound.protection.outlook.com [40.107.192.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509C1C8FBD
	for <linux-btrace@vger.kernel.org>; Thu, 21 Nov 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226477; cv=fail; b=W8cLLcOoYKsfNK9vAKcIDZehFuVhSLsnLPYicJiyDoOwrYpQkPwaeclXCUGo3JvfC0H3XlqG9c5WN3gJO6Vj53bq+ygwkEX3ctEhRJQWpOHlftltexZpp8Gqfj++vLvMHLId5abpwquHnc1n+cBclFs3HTijAUGXlZPWnBVh2Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226477; c=relaxed/simple;
	bh=zIeYbKCwSrpxOpgpUCOG5xv04gnoTA6Xbc98WGx5Evc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=U8ctiD+XM1IQJZtwXpACca05M66YjEiUagldTJWg0fwcPJx7W/cmSAG0wIw6Vmw5Rvz1tutiZkFXw4/CMXML1ekQNF/T8pdyxFz6gyh6xWXqJdAON4Y7ut6OORbdojaLMQLelsf2o9YACxJOEZdQrvDBrBCZMcmjZikr10jqBoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com; spf=pass smtp.mailfrom=raithlin.com; dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b=qM8DExBY; arc=fail smtp.client-ip=40.107.192.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raithlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="qM8DExBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da9M9x0E/GO/MLgkCqGXRtRsejgRPGNxO2rJyZCmVvUTQDyst23tVd6XN88nb0BuUWDMiZBTkfinfawkJCo3ixiDhQ/CYNYbxEqVj/naCHSHFKz1ThMmUkjCZfqLg2viTVyBAXlu7DcOO2uFSel+K7PH98p0zLDgYFwbHzgG3gv0Qd033w+a8QsjfDevTNtCu6wNzgSSpvoybGOBohvbQqddS5PTmiuqwJMptfF7rQDXk8w9y3WUQ2r2jVvwy0PgGGyBXqSWmXz+H2LKAA1/ZPxPW3rnNVyJNkEh9nXymViKrOm8DBY9pIpEthu6nl3SZJSHyFnOKleLgYF9m5YuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+mYIGCQGnxelWFs4E2JKIDg3ucvWRUKGGeU+tCSceA=;
 b=BdDgW87Zm5YFU8SOdWVwlYgCVKNvcTF8XyQ1JNjq/mDSjCsfrYllIXbPv0R3YvMUH8nA/JzQvC5m4vobS5vZ2hQtpCbuaj7aZXIi5HrRNVmay1bUQuuC5UnuPyh98mE+TpzWAXQS3LCrXWN+8GrPZLP7EVnjeyoZQEPfUSmnsS+mjTO31XJot52N9NbxZl+v+MARuxbIo4EK05e0SwIZN879v3XnQxcmdZ7wuPPBD/62BOWLRb6qltj8Ap4Fs9+Lz4+Exevl+96GPJ/7sgY0p9ZBHi7xw1VeHXH6zXhadXO6zpODBwPK4yy0vJIfN/Po6dmb8qHDZQsNQdFsSGNK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+mYIGCQGnxelWFs4E2JKIDg3ucvWRUKGGeU+tCSceA=;
 b=qM8DExBYn6rGye809OGUVuW9QXOFYBxm5hkhZqFdyqG98yB2k91a5RkWG95Z0cf5lnIJdqjHjCEGd6MCLV/2iVki2Pl33BCt1zL1SogoRziNyeYz9eVNxJpFBTVlSq0IdR6ZDt1lm57j7/1VYnRNvt8NBwhxZC01Px36smrb8ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YT2PR01MB11292.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 22:01:13 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 22:01:13 +0000
Date: Thu, 21 Nov 2024 15:01:11 -0700
From: Stephen Bates <sbates@raithlin.com>
To: linux-btrace@vger.kernel.org
Cc: axboe@kernel.dk
Subject: [PATCH v1 1/1] blktrace/events: Add an option to stop blktrace upon
 a number of events
Message-ID: <Zz-tpw-CsW2CHLzP@snoc-pinewood>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YT2PR01MB11292:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad91a4f-7a59-49bc-99c1-08dd0a7803dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHRuWW8yS3ROeExBNVBmVy9pOTNPZ1pkdTV0VC8vRFN5Y01SbVBpZC9IWWFS?=
 =?utf-8?B?eVViQXZ6RXlaQXNoVXNhemdGOGtlY2V6bGpadEFVQm9meVpXekZEdTNEbEZE?=
 =?utf-8?B?U2FGcktVNjkxaEZ5aVhhaDJZN04rWE5sbHd2TjJGRWRzckt0b3EvRmZFQW5z?=
 =?utf-8?B?TURsNjEyRk1meDNlTjBscFhOT2xaVEZVMk5hUFVuSGRHdmhjTjhpUnBVbncx?=
 =?utf-8?B?N1BRVGV5RkpjUGE1YTlGdFR2TE0rdExoa3kxUzI5eC9TWFQ0MDY5SFd6OVBV?=
 =?utf-8?B?dzQyc1A5ZkJMZHZFUUREeWkraFp5OWliZ0pldjhVdXl5c2tvTzd0MTR3b2NK?=
 =?utf-8?B?STY0djBXL05oNmhnMFI2Q2VMY21PazlEU3RYcG4rYWM1MHViaElUd2tNQW9C?=
 =?utf-8?B?Y29CM3o5d09JYVlWOVNENUhzbUU1emZYUzVhMDVjM09GUldYWk5KWWE3U0Fn?=
 =?utf-8?B?eGpSdVFQUDMvMXlIOUVYREFUMnpmMkVLZE1KbjR2QmtYcnEwTXlxM09hWktm?=
 =?utf-8?B?QkdaMVpYSVBHQUt2WTROQjdWbHhuQld5U2VqU2FtY2JRVmoxcE9FSkZsampo?=
 =?utf-8?B?SjFvSWp4LytpZ0dEZWNMK3ZNNFpINHZYc3ZIWGE5Nyt6elFCSDhIU1BaV3hH?=
 =?utf-8?B?TVYwU0ZSdTFjd2tyZjU5Smc3Nmk1T1FRUVVpMWozUnY3N2N1cFdOb0x1Ri9j?=
 =?utf-8?B?SnRmWE8ydWpUcmlvNXgwZ1hvQVo3dFBpRExzMDZQM1VLSk1RclNTQ2VmVml5?=
 =?utf-8?B?Umk0Mm1rK1dPSjdiYnlNaXprTmZFQ2w0QTI0bUxWRDZKVkpOY3A0OEtoSjRl?=
 =?utf-8?B?YnBHTEdFTnIySDB1dnE2NW40RWlOTjVtOFBPZzlzblJkSm91YlVhaUNkRmsy?=
 =?utf-8?B?SS9mdURGb3l2Q3FPdlNldklDKzBlNlE5Mi9lQ0NGZ1JYN2VoZW1iRjBHWTgx?=
 =?utf-8?B?ZTk2QWtWaHcxY2JqNUxNWWZOUjZ2L1I0ZnpKNU9SN0FnUW1jMzdWQnphQkNv?=
 =?utf-8?B?bmRxME93TkFjYytxVUh4YVNVc3NrNWg3SkQyYmFaRTRseGo2bjJtMUJIYVFR?=
 =?utf-8?B?a3ZwV1ZXYnVoMUViaXh4ZUZ0alo2WTRRWlRFbTMybU1rU0VQbHh3T0t2cEpI?=
 =?utf-8?B?amtIYzBuSFNPUzhEMmpNWFAvZnNxZFJFK2tFdCtoekNNYmNHM3JRMFpvSU82?=
 =?utf-8?B?anVRb2lnNjN4aHFkdHlnZTZYNDdOcXRnYVRodmdIV3dFWWRjdFRrZEh4RUdu?=
 =?utf-8?B?ZW5McGh6QzI0Wmp0WEdLeEhxSDFjQ3dLRUFPTC82MXdiV083YlVYYnpjWUlI?=
 =?utf-8?B?M3NubGVNVnNNVytpeTdQZkQ4eHcyTDZtMW1ZdktBVHcwT3NNMWtsMUx6Rkla?=
 =?utf-8?B?c0dIQTdhb1ZFKzFFaTNaWXhIS1ZDeDg0MHJOMlZVbHlxb1JJL08ySHcySlBz?=
 =?utf-8?B?bEc4MXVYVURkdnVnMUJrcEQrOHp4SWF1NkNnS08wRGRSeHZQR1dDVjFIeWJO?=
 =?utf-8?B?bGJWTVFjVHlvN1hTWnpaNWdqdFdTSmdOUFlsMjZFV3V4OFAyTHFUMEtoNTlX?=
 =?utf-8?B?Y2ZQVkE5NVhOSG4xNGlRQ3V5anJrbkIvSmpoU05yRTdHZFRLS3FtYU9XRWNY?=
 =?utf-8?B?MGU3R0c2cTJJWUttSjkva2dGeXJMWlBIZ2ZueWlWdTNHZGxoOHhqczh3OXVG?=
 =?utf-8?B?ZldhaUZqN1FkaHhEZWxzR1RqTU55SVBDM3pjaXlCTjZtMmQwQS9FVzBNVGFl?=
 =?utf-8?Q?2YdW+n/DI/DJamCNBujBTSYcp1MtXpMQCaE/MPY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpvdUNTSGp4cEUrVXBnY3FLVGROQjR6R1BKcndoOXdzdnlnMkRudHJWalY4?=
 =?utf-8?B?Yjh3bVhQaC9tNWtWVC9SVy9WeXpPdjR3UFRoaWh2dXR4ZWp5UFNoRCtiRkVV?=
 =?utf-8?B?OE9OTVZxQ2NhdFBnT201NUwyZDJBUFBTVE9EdWRGVHVlTTUxNGVPaVJIdFcr?=
 =?utf-8?B?clRlaXdvejNRVkNiQXd0b3VGNnNUVjFPWHBRVkY1NGN6aDJGK2tLdjJkUTFs?=
 =?utf-8?B?cS96L0IvQlVxWDlKOG1nTXB4NGNVdll0MlpFQ1NHSnhEWlBFSGtRVisySTdQ?=
 =?utf-8?B?d0R0VTFkU0Vzb3NvNVQ5UmhzUnlQUGZ0MzlHa2p4ZUdkejlPb3hmaVNGdnNp?=
 =?utf-8?B?WlBhVStHSU1VSnRmYkRUQUkzRkZzd3FqTlVCQmwxR2FKcXBwOEhBclhwSTBN?=
 =?utf-8?B?K2dZMjZhamRrdUFVVmxJTnBKTytjc1BEMks2Q3p6NUdEb0o0ajRBNjdPNzJL?=
 =?utf-8?B?bWdhMnd6cGdqOE41WEF0ZmM2RlU4ZWgyd3p5dFl5cFM0a3FMdzAxbGc2b2hy?=
 =?utf-8?B?c002WEN1NytDdzFzd0tPdHAwK3h1UXoxbmlsenlCSFM5Zm44QkM5MXBFOXBo?=
 =?utf-8?B?bmhEOEVvL1lKS1VpbkRmTGtieG9qc0xNWHAzQmVVdWo1bXhhQzY3RlB1OHpM?=
 =?utf-8?B?MWpKZUNDb2VxRGpHVm9TTjgyLzF4VGdIcWVFOXFaRmFXOTZTSWZwQlB3ZDdI?=
 =?utf-8?B?TG9zbURWVHF0dm9xSnc0b3hDSnJVOG4rcWZOUzNEN0hCZDhqMlN5ZFBlV0Z2?=
 =?utf-8?B?VTV5TnhrdExXcXpCSmxQRXp3bFR3dmdRbzhYUlBMc2UxTU5JUEZNaTZXNFBx?=
 =?utf-8?B?OFREbk1sbWwvOXZkR05qZHNtekRhTEpyT3NFa3crTUNQUXhnL3FXaU9iVEdP?=
 =?utf-8?B?dlBneW1MbkZaZDl1aW5EMU5CRGpuMXdwOTd3WWVFcXVhUkxmY1N5OTZnczRC?=
 =?utf-8?B?ZDBEMnpvVm1uYnIvMlRtRnI4VlYwR01mcWJrMDZaTzBZQzVnLzk2aGptYVRS?=
 =?utf-8?B?ajN5aU1BNlVOVWFnQXhVeUt5RkJvYVJYTnovekwvb2VyWVVwN29LTnRDNFlo?=
 =?utf-8?B?UVhCRzhyeFZQdW1FNzJBaDR0N25hK21KYVdPRnpSTUFrZTNWWVR4U21VZUVP?=
 =?utf-8?B?MWtCRlREQXd3R0FiK2Rtb2RuN204bkc5RzUwSGFtL0NLSHdxSHRlVXlDQ2VE?=
 =?utf-8?B?SGdRd1RBMHVrYkVqZFoxVjlrNkk1UStNZWJQZ25wQXRLSFR6aFpZSUVJQWNs?=
 =?utf-8?B?N2MwcFpEaVRtaGllVWtWcGppL01TbzJHN0JmQ0ZQUWV5aWtNWUxJKzd1NnhR?=
 =?utf-8?B?dmtldFBWMHlYZ3prbytpNnVqdFRNN3FOcGtMM1d4TnZiRHFDSmY4SWFWc0Zt?=
 =?utf-8?B?Y0loSHlLcGUxQUxYRkppQ1RzWjJzck9BSkZRUnRqTXI3TFVxR0pZUVlPK0RL?=
 =?utf-8?B?Mmx0d3Fuc0E4U3hJVTVZMktjSzJDSEtTU1FEa0dKVmsrVldpN0J6YXo5VGpT?=
 =?utf-8?B?WkpsaWdwTUNFY05CTGtEVURzRGpZVXAwMFQ2Vmsrd3YxVFJqeThUVzJQbis1?=
 =?utf-8?B?bHZNVlYrS3NlOUVkWXFLWTRrdUdsN3V6TlhteGRBNG1qeU1xY0NmWkNTSmh0?=
 =?utf-8?B?dW0yRlhuR09FRnpEcUlucnJlSWpEOEUxSG9QNEcvRzRXZFFWbG9HU2F6WEV1?=
 =?utf-8?B?elZscTU5cCtxdjdqcUlyS2JJUy83WVBWNmUzb0djVXkyS2RsZkJoTHdmZGJo?=
 =?utf-8?B?YzBPVjdIdDB1TjA5R0VDWDhsOXh1dVdrenBkVGdyekRIc1FXL28yMUtueStu?=
 =?utf-8?B?eW9NSVh2Tjh2TkFqcGtNbkRlMHh4V3dxOXhRNm84SXBYUkprb2l3OGxJYjI4?=
 =?utf-8?B?OUhlb3Zlb0V1OEtUUWxFSWVzejlLS2VidVBnMDhFU05MMnVmWW96WVhVL0pn?=
 =?utf-8?B?Y2dYazBUVmpCaDVSUU1CUHZmd0pIRTNkNUF6LyswY0VyVjBQRi8zeG9IU1dq?=
 =?utf-8?B?dnFHdmhLTzRaM0JKVVNRR2JYMFc0SCs0eGhZTmZjNm5mWG56NEhUV0ZSTHlJ?=
 =?utf-8?B?ejhmU0twS3E5VHpsUE40d05yaUhXTllXRUFMOXRlNHI1MGdyVnBwaGw3a211?=
 =?utf-8?B?NjArdDNJSWVRNGxRUzlZU1dYZzF3Z3hVMGVXNUlzUnBNUU82S2Z0NTUrRi9I?=
 =?utf-8?Q?VujZB/SrviyW7lWibfEVDvNJMLXy+uR66OxR28/VpDji?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad91a4f-7a59-49bc-99c1-08dd0a7803dd
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:01:13.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCvoXCGacIPTmHFV/ZMcMcsfeWdCsqhVonwo8AiDLX24RYr9Np2XrdINv9h9Q/ukRROthfRGt1LdXpUdSNJp0A==
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

