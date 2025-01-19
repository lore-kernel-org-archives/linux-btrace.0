Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022100.outbound.protection.outlook.com [40.107.193.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875681925B8
	for <linux-btrace@vger.kernel.org>; Sun, 19 Jan 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737316848; cv=fail; b=jVIFnmw/hggKVewGwvH4VDNF9ZK2yThP+5npVlquRe1gzu3OFGocG0hvWScE4XQtnLHYrBnrH5g1R2YrHjj01FVhH/qaWof99Bl0jB9ki7+ZnOdXGwvS+6WcQx5SmwTZKRh5AlwwzaaTpzlQuEh8q4p1TSR5C69ihQRjcWaqd50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737316848; c=relaxed/simple;
	bh=w8zJARQ/EDbLFMOVpAksfgCY6Ohka81iwM1lsvtq+54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RokD3wf369U6zCo48Z3Me30yxfXpYEUJ43BkFVPMSy0GvLwl/JM+WRN5tNl0ANldoiS33hFuGKP87A/2RD3ih2MEBH3y+MYyyVzNrQ4boAnj026DKi987zBnSN2a34igI3veYYhOzzHNTpgjyI3KT8Yu9D4jL7dcFzp4Zu1BRAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com; spf=pass smtp.mailfrom=raithlin.com; dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b=pJEOcwSF; arc=fail smtp.client-ip=40.107.193.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raithlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="pJEOcwSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9a8EAAcHs1Us6BhwAukT6r/HOyMOmwoc64riYdikIYLtCB1kIIMPAssUkdqs53HyC6oQibZQRP3CUWf/2XhJRSacrjchwHGC4nS/CzODLPiV8mbKs2QiUw59kLvoVI5jQrUUaLsgCalnWCUsHLVrd9XBV2wPQJ8B8JGh8kcms1uVRmrH8qIOqgi96M7lN/HIj1i3sdtL6cZXopyJ59eHi6zUyaqzGbpM/2BZqJQT3ugvmkcXoWcZKSdVRynpHSVA+A0ovjhjT4fhqWeHoAnA3WEloBsLNUD2jMJXSUfjNnonMcCuczehE8JLSsW5PxNDJbsvOJH75zLf274YnhTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udqkvc8NX5f5el6Fsy20PXTJmhDnGWGAWxt7iSrETnw=;
 b=uxqISBi92M63oidIQYOd/Kx98jSzSmOPZ/iXukGR5II2uPwUb/4J0E4ggwwK4v0nDfdOVU61ZSOJYOGa9VyR0nTQxo1qD16pE9SeOuns7rYT+FhuAHUbAaWysH4hEvSRPdwm5NlFoPBCSWfE7lkKQbQyvJXnV7eHKmJGGKrk+4jym52AUryu5YvhkgBk8p6GSrB7+ftFkwpmAJ1G+YsCNxX4Ns7YlLq3CuLdPSVRw1VibzVap9HcI9pDmlzIivfjllbqtwUUhwR2DrwbuAeIwVk3VCdvIi69A6Oi1vUVvwRNTieZ3T2YynDF2X5nECNrxpjH7OGhJ/96mPPARqO10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udqkvc8NX5f5el6Fsy20PXTJmhDnGWGAWxt7iSrETnw=;
 b=pJEOcwSFz3wz29TNyt0neINBE69WCqc/afO8Am3G9NtOIXDANaGuyXmbSoUxnJQSYSFi1PUBIeKejNpoiypPBBHqF8x8Pg+1qkzVVwtXBVrcXuH/0tyBr0k3K2Tu9YG6rTmeEtudjf4xjQaMjy8UINjDFcP27n4OXLZqkLcedls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YQXPR01MB5280.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sun, 19 Jan
 2025 20:00:44 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e7b4:a800:3c23:2814]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e7b4:a800:3c23:2814%7]) with mapi id 15.20.8356.020; Sun, 19 Jan 2025
 20:00:44 +0000
Date: Sun, 19 Jan 2025 13:00:41 -0700
From: Stephen Bates <sbates@raithlin.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-btrace@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v1 0/1] Add an option to stop blktrace based on events
 recorded
Message-ID: <Z41Z6VXqDfXlIO1h@snoc-beelink.cn.shawcable.net>
References: <Zz-tmR3IyJFdSR8Y@snoc-pinewood>
 <x49plkpeaet.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <x49plkpeaet.fsf@segfault.usersys.redhat.com>
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YQXPR01MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: b29d90df-1409-4b29-fcfe-08dd38c3f58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW9Sdy9panhhR0xTNDZORE1Fd0dPWC8ra1JIODZZNURnbHdvNVprN21NYnBS?=
 =?utf-8?B?c3A0WnhEOGhHQmd5WEI2dEFZcy8vMWYyR3ZSNHBCUTlLVXN4VHhDenkyS2JV?=
 =?utf-8?B?Q2dmR2hpZ25lNkI4V0Z2dGdsZk5sZGJFVEVMTWhvWE16ejJrRm5JSkpvVEh6?=
 =?utf-8?B?T0Yyc0xBK2MrNjVybnhlYzE0NmFvSXRBU0czc3RrTVcrVENEcUFpemxpMkds?=
 =?utf-8?B?bURGVm9FeG4wQXdFb0swUFVKenRnUVhQVzVJbTJneVdYZGp6UFlIZ01mK3c4?=
 =?utf-8?B?V0FOTDNZc0l4THZKMGkzb0l4TVFEQXd6VU5NNHl3ZG5VYzBJcVkrendsR0RY?=
 =?utf-8?B?ZTI0aXdNV09XUFVvS3JObFhpZlV1STVFYnVEZ1YrbTE4dHRSdlBRckhyR00x?=
 =?utf-8?B?VzU5UTVrYVBsVkZFaFo1SjBPS01tQTZvemdPNkx3QzJJcU5tMlNGOVFzN3p5?=
 =?utf-8?B?dFZEYlNKcVlyS2l6S3hvbkRhQU85S3lhMkVOV1JQUktEMjgreUYrYmtiRisx?=
 =?utf-8?B?M3B1NkMwS1NNR2xhRDlrRzRHcWdueGpYRXRSSDFtT0hVVlorUDgwVXc3dGV6?=
 =?utf-8?B?UVJNcUZ2K2ZHU25IdksrMHlzL0N4OVc1RjVRM2QxS0taSm40bHpyaDZYNEJT?=
 =?utf-8?B?a2tjT1M3eHpHVjhBeWt3c0FkaDVWd1ZYSzR0TFFiVXJPdTg0ckdQYU01Zitx?=
 =?utf-8?B?VmJkc0FGR3NBZGtBN0FDNkxwS3lkUXg4VzA3UldLV0lJSkVxenJyelV0OG9K?=
 =?utf-8?B?SlVEa09mVVBBZ2NjMkczeE1ZQkRUaVFYUm96ZU1hNEZ4WE5mcHp3aHhRRU1a?=
 =?utf-8?B?bEtEUmlLakU5ZmdWci9oWmx4eUpQZjFNcHN5OURwelZ5OWxvR2RMaDFLV05S?=
 =?utf-8?B?OW03Zi9GazV0c1J3WGJjWVdrYTh1RUFIbVdId0t1bnUza3MyR0MxUkdoYlRj?=
 =?utf-8?B?YkFSRnZQOUhPUTFTUks4RzNqMmp3RjRUSWFraHJycTlTcWZFUzIwRUw4SWZq?=
 =?utf-8?B?Y2lIREs5dTYxWXdEaWd1Wm1wTlVPL05IMS9UbWx6dS9TaGlQaWpMbmFVVWc5?=
 =?utf-8?B?dEZKR3pGd1BoNkY0YVpYM3UvTWZuUTM4citEaDJCb0gwUmhSQ2JRaXl1ZzNi?=
 =?utf-8?B?RnFWbWpKVExQR3BTRTdTcHVuRjBDK0F0T29SY0tnaVgvdUdQTmczaGFMS1Bs?=
 =?utf-8?B?QnRqSjBlTXkrS0RkdHRnZTdBc2R2QjhicXZsbXZZeVV6WmpucHJoelZIaG13?=
 =?utf-8?B?bXJkVVpIWlYvMEZ5OG5NUjE1MHkvTXJlTG1LeUN6dDlzNXJkUjVISWZlb2hM?=
 =?utf-8?B?RGlIZDVKaHowTkVzRjBRS2g5RzcwNnpOZEE5MzRmRGc5QmlIc1ViTy9JbGFD?=
 =?utf-8?B?V0E2am1Jd3IrSkpVSG1UZ2l0eno0SmROamNtTkppUGhKTmtjanFrejhjVnhr?=
 =?utf-8?B?VDJzeG5nUzdEMDFpRk9oMEJEZVZBbUhVemhCcVN3aDE1eWVJN29UcnRSTzJG?=
 =?utf-8?B?VmxicnBiSnk4ckZoakMyQUlOcUs0RFo3UkJZSi9waDJyMEJ3WGdhYnA4MEtY?=
 =?utf-8?B?blo0K1Y3VU5xWDhCNVNROU9UQjJkenM2QjBuR2ZSQTRlbXd2aG5reUdOVkFO?=
 =?utf-8?B?L3IzTEdoSnNBNzdidENGazZHTFdmak44UFl6Y0NCWHNFb3E3bE5POVpJclVZ?=
 =?utf-8?B?b0ljSmhCV0VjWkJ3d0gvYjlLZzJnWjVuRmJFcStMM1NwT1VSR3pyUFVzNVgw?=
 =?utf-8?B?N2dnRnlKSzZoTDRQK2NscC9wMkFlRzNZT3p1eFlKMG9INTZYZEhJUmI5ZzBP?=
 =?utf-8?B?NFFxcmJrQUpFU1E5Tkg4TWdieVlyb1gzaGFBc0QxUm9BNzI0Vmd4ZGVTTmp5?=
 =?utf-8?Q?UvtUgtwypA70d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG9WbTZFZjY4N1l3dExqWjM1QStQcE81WHIvU1Bzc0NjOWR5MklhTFRUV3ll?=
 =?utf-8?B?cTc3LzRJVXlrQkpnNzBxaGUzTkMwRGJIQmd6aERFMG82d0oxRy9heU1melVU?=
 =?utf-8?B?aHRieENaY0MvWkZXQ1dNTklFRXExbGg1QkNtVFplL2tQTUFOeU1tVjNmQStI?=
 =?utf-8?B?akp6TDdjcS9yQmRDdE1hbkc5a0ZWdGVPSzlKd3JFa0hJYzFOUTV3dkJvK0Fi?=
 =?utf-8?B?Y1Q5clRuR3JqZzJNWm43Q21pNjBWa01FMmEzQXl4N0N5V045RExqYnIrekF2?=
 =?utf-8?B?UW8xcmovYWpxTkZ3V3orRGZ5dkwrbk9xaHlwdkYzZWJQcXBKV01GNUhQbVdT?=
 =?utf-8?B?ejR2VkdNOGZkS21TQno2RW1nOEptdFNSUVNFM01BS25obmNNSVVuazFpWFY3?=
 =?utf-8?B?MFczK2hUZEVvQ0tqNkdDMUYxTlJFcUZ3bmFjb2kwbWt0VFd5NUZQeE14VVB3?=
 =?utf-8?B?bGlZVUlxaXZ3RFcrZmMzRkZKR1FpRmp4V1ZZM1hLcjZFSCtHQXBWa1dEUWtW?=
 =?utf-8?B?S1M2OEJJck9uZTYzSTFIbkM0Vlp5L0ViVzV1L1E3Y2dzcmJ5TjVyUU4rK3hN?=
 =?utf-8?B?dDBVenZFWGhyc0xObGY5N2NkUmlwR0k0Mzl2YzFYRVdVcmNoRjhuT1diZnRZ?=
 =?utf-8?B?RHEvc0I1SFRqbTd4UlA5dGE1UWFHNUVuUkV4TEhqTVo5K2JFY0IrNjNDOUZV?=
 =?utf-8?B?ckZTbXZSRWxtRzJucGUzek1TNUc1ZjZkRi81Umk0cW9VZTR2cFhJN0pRUmdE?=
 =?utf-8?B?MXdmQnV2clNiUmhjMWxDVWpZKzJucVY3blA1UlBNN0dXNFlaWnZnUUNvdmhB?=
 =?utf-8?B?UGNpU3FJZ3hOMzBGOWJaNVFiZWx2eXVGa2gvblp4dUpUOVRtcGlhdGxWUytM?=
 =?utf-8?B?emFYWjh3Q1o2SEdrV1BFRHQ4bVd3ZDNueUZ3RFgyWmpycHRGV1dQWjFTTEhw?=
 =?utf-8?B?aEZvZ283TEJGSkp6UThvZEFNT1N3Y2NWcGxrZzcvMUtJVkJSNXhPMlRoK1k2?=
 =?utf-8?B?dnE3U0JEWVFwNEk3L05yVFEzNEl6OWQvL1lDTnZjWFAvTmpwMk0wS21ZRHJG?=
 =?utf-8?B?STFsNFdYdlh0T3ArTUtoeXVUZXNpbVVYU2grVEMveDNxYnhDODd3MmpKSHR3?=
 =?utf-8?B?TDc4RnU0eVRkaEczc0VYT28rdG10ZUpxbDZVN0Fxbzg4dUlxcnd3aVlDUjhi?=
 =?utf-8?B?L0N4clBUOHN0ek8xNkFQK3Q5L0lKeDg1dFlLUkIvaUExVzRRdHQybXdMWWwz?=
 =?utf-8?B?K2JlUzl1dnFJcDlGYWdKZ2FoK1d2ai9pUU52WDFHQ1VmbS9BUDJBWXBnUSs2?=
 =?utf-8?B?RGUrY2FjWjBDcUVUa2NaK0Nqc3luOS9jVVhvMGY2Yk9VNmRxdVV5TUpLaUto?=
 =?utf-8?B?VkUrUUplT01IZzArMTc1bE1zY2VnYkg3VG5WSkxxZy9jemZKOFp1ZDFBOTZu?=
 =?utf-8?B?eXlTaC9vcG9Mb1kzZFp2czY3eTQvcGt2YkRYWEpXQVR1RHE4dktFSUR3c3V1?=
 =?utf-8?B?YWpoaHYzN0RpUnF1Y3g1czdJaHFQdWs1VWY0THRjcGxqZFhYNkY5NUxPbktF?=
 =?utf-8?B?ME93TW9xK2g1Q0lNa3Z0NEsyVi8xOVdHSXp6N2VCcVRUTHRFeEY4T2doVG1W?=
 =?utf-8?B?dGs1SXY5bDNHT3hESW1sY3ZHK2srMUVKd0lZVnNoZUtMbG0xSnJIZU0wU2tm?=
 =?utf-8?B?VElzd04ySWUvYmkxVFp5Z2xHY2NrV2cwZVBVeTVIc0JvM1I5bUkwcm5LREpC?=
 =?utf-8?B?QXlEYU1KanFhTmI5RzZGaEFFRVBZeTVveThmamlGNnZVTmxxdDhMSVUwZkJK?=
 =?utf-8?B?VExQNHRjK0xtTFNWclZmRkQ2Y0gxNUR2K2hVdVdsWWg3TXA2cFlBMXI2bFpp?=
 =?utf-8?B?bXFuZndpYzZFN3FRTnlhaDVzd1FiYk1aakVnbC9OLzRtWmhBbzhFQTdpa3hy?=
 =?utf-8?B?YWVkeHlnK3Nsakw3WTRSUlBtdnRQTE8rSmFGcVZkc3dQcU00dk5GT2tPZU54?=
 =?utf-8?B?LzBXV1VlclpXNEI4OHB1bjViaURtZ0UvdFQ4YzdNdkY1Q201NmR5TkFadkxu?=
 =?utf-8?B?dEZFYm9VSENDNS9VbmtWeHlHcjhyMXdaQXlEK1RtWkdMVlgyMk5ZTFE3Mjdm?=
 =?utf-8?B?bnp1STl1Y1pwam82ZEZ5Wmw2S1QvZzE4djFEQnkrYkpVY2kvMUM3NXFERG1q?=
 =?utf-8?Q?NJv6omuIpo7n5eXKu4GmfHQ=3D?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29d90df-1409-4b29-fcfe-08dd38c3f58c
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 20:00:44.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhNbzotfYaIzUMMEcvbhNYRiY/YzsCBvwbmoXde6bcflMFiQHvaL+7T1zqcvbrIilCOq9RwglRPJw7eQRy6djw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5280

Hi Jeff

> Can you expand on the use case?  Why is the number of events a useful
> parameter?
>
> Thanks,
> Jeff

I am working on tying blktrace into a prometheus exporter so I can
monitor block-level activity across a fleet of storage servers. I
don't want to overload either the storage server CPUs or the exporter
itself when the server is under high load so I want to avoid using the
time-based argument for blktrace.

If I have access to an events based option I can run this knowing that
in high-load situations I will not be capturing many, many IO and
perhaps slowing down the server in the process.

Does that make sense?

Cheers

Stephen

The 01/14/2025 09:29, Jeff Moyer wrote:
> Hi, Stephen,
> 
> Stephen Bates <sbates@raithlin.com> writes:
> 
> > Hi
> >
> > I am exploring the idea of tying blktrace to a prometheus exporter to
> > gather more precise block layer activity across a fleet of servers. As
> > part of that I thought it might be useful to be able to run blktrace
> > until a user-specified number of events are recorded.
> >
> > So the following patch adds a new option to do that. I also updated
> > the relevant documentation.
> >
> > I'd appreciate feedback or comments on this!
> 
> Can you expand on the use case?  Why is the number of events a useful
> parameter?
> 
> Thanks,
> Jeff
> 

-- 

Cheers

Stephen Bates, PhD.
