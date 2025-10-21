Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB852749D9;
	Tue, 21 Oct 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013551; cv=fail; b=GQLnb7qOuyh/TJTZKXVHpC0ZhNMp0nnTZEjaU0hZHsKIQVdAvtILa+CVqFRiAlSgtKW+k04Qy0Fd0qGfFvYgjeBANGL3n2iZnHh5jbbfF9WUYeXpXk3oVghhLIvFTQDGp3VlC3znM/WkEulZ5FsPU+gXgT6DuUXexOl3sCZAKiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013551; c=relaxed/simple;
	bh=PNQosfg66CDTCV1GwjMNlwNmhXnDKduDSIHD/iD1f+g=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=iEAywpO66f5ZNYPHbnoEBRUADfIm2Zj7c/YOXqR+L8OZp/TDYVk/B+6ErAhvJu3nR8iVE3M+c3MKQFGOSt5khcS0mLa1eq9yPVIvYLvjP1CMoKZ7SSbw763rlpl/o1lRl6Pnpr4sOxtGImyevVq0Mqwe9vbR8fWOpWZldDK4RkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0qHDmDN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RuOSgn9n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0qHDmDN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RuOSgn9n"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJuwBc005991;
	Tue, 21 Oct 2025 02:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nOspzE3TS+aNOCKvOy
	kSfkX+l+WDMOjqteIxK10hnU4=; b=Q0qHDmDNdMJIEzoJnaEOiYbIhlLYHvnUoF
	jykRnl+aTZDC940Oagm8fs8qQ/gnq2Zh3GoxoTpexjejWKTcL5emwLh/dyspEiVD
	HCNivFmxVzpRZeuQ5wekJtfLMm81iyDYXS3F6ADodlNDwRvKYNA/gb2q1fb7VNls
	NUu0YZHSdKT5tG6s4OQ/CPnxzumpnhO9EqpMKkCMYEHfEBlOIwvoRKK/O47W6HOr
	L8asem1Y4puNfNzYo1Fg7AO5LEaHLqXWWXb3krhZIyYKYWqOTg7PEhdDRzDm/Rcs
	OFuikhMG48JTeROE5SZ2dYhLCdnCOh5mofvxsCcj4BZg8l1wwEGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3eskj63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 02:25:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59L1a2Fh035131;
	Tue, 21 Oct 2025 02:25:28 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bccjwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 02:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1hCOSx2IDNSeE+yUg9saOmLzS3AlaTXfRj56dckMygcfT8K9lPMKdDKgBRGxT0LvqHQk61TKNlgk82d7lP0jjxypEE3W8UW7rV21muPlvADqznf+pxqaGYhs8KC52P1qt9RJZ3FPHtTON+QaV5dFRNiVKA4dijt5pSiqpAJDVJon0nANgPCEbMK5FWa+S1RzwYdEnIGd3A6KC2qQuHjuBS2aP4XrG9XLo8a2yPQgYpli4TSVLr4FAQyJDR7AS4vO5lRAY+qfqFX8Cyu5JcBwhHy46ZjbI81ii+YoFNm3l2DSNwl22hfUjFR66GOwD+SjJNV6sksE9t8RFqbUrRyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOspzE3TS+aNOCKvOykSfkX+l+WDMOjqteIxK10hnU4=;
 b=fE6OIjZ1IEWrqZAazBif0rm0q05mKwsHPXyU9m7jHUNqediMxD6Y19EHnO9uBsVVQNgkjFupKKW3bbqv4kl0A6B7TClAN85qUZE04VMB4gf5oW7ZsFevWiwUOKUyLKWJYc1FTfDr9gTovSsVuiyVwhZwZ3hiHtBidYMaGZTGCqKzrORJr8trRRg2GY8bGl28Drp8QjmdJvP9765FPjZhH/ppim76iRrXFIyl/Zo18nD1osEhpk/UYIwOubGieKbSZeVH4hqAzs2vZwOphfS9Sb6/CeMqa+Vk1RttFaAYyuby7nbaMr3W00uxf3u3Cz+Eb86Kw3XZ/EMp+F4NohFouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOspzE3TS+aNOCKvOykSfkX+l+WDMOjqteIxK10hnU4=;
 b=RuOSgn9n3sf3UKmw2uY3/YXtVFQQ9LLo8pt3XBSPP4fjCYBWQiG/jKjfd+sjBBlireaEr0QwsQT5agB/eGZ6jrytYnJnW4n9QAvghiN6iXZUC4hCUDeqLL76T9cZksu6PDABxjIRym/qu4V4S53f1ncacj7qjuPQGeeT+xZCT/I=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 02:25:25 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 02:25:25 +0000
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org, hare@suse.de,
        hch@lst.de, john.g.garry@oracle.com, linux-block@vger.kernel.org,
        linux-btrace@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        naohiro.aota@wdc.com, rostedt@goodmis.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v4 00/16]  block: add blktrace support for zoned block
 devies
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251020134123.119058-1-johannes.thumshirn@wdc.com> (Johannes
	Thumshirn's message of "Mon, 20 Oct 2025 15:41:07 +0200")
Organization: Oracle Corporation
Message-ID: <yq14irt6lfk.fsf@ca-mkp.ca.oracle.com>
References: <20251020134123.119058-1-johannes.thumshirn@wdc.com>
Date: Mon, 20 Oct 2025 22:25:23 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 405c47a7-bc0c-48df-d5bb-08de104917f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/AcayJaAkHHeQkdzXA0T8NZXhMGH3O0hGAVIY2B6RA5qa1l/adxWkntO9+T?=
 =?us-ascii?Q?/Wscf1mO9UuN0YC69cuQ2wu23qJIIcchSeRku4XiPZrRwZ0Z+k+oT0vFW0yj?=
 =?us-ascii?Q?YpL+fXgNjl04a2yVCbyw3ECDQj9vleP8yfG1AQLynWVxUKWC879AYfNvVbdd?=
 =?us-ascii?Q?rbhcsUC2JQ7GTNbCBpCjX+Ih1MHHLgiI2GWmK83X3Lw6zlIy9yx9wXyY9Si7?=
 =?us-ascii?Q?IeeALDcnfITNLs1rHe+y5cLKWaHSGKGIoUYH4gpSgsvWbdbhsdhd8lYCp4zD?=
 =?us-ascii?Q?/EGMCm6791sbzaYRmiwxFgAMRrNCNko6JG4WED3pDOwKzE7YPXcSwkz2KSgs?=
 =?us-ascii?Q?TOfI2wnU3LiG3GzspVHN1VeFPXGkRO0kIejdhg+4y5EoTSoXtn88Dkmhj2mD?=
 =?us-ascii?Q?d4LkxnUHv1T9Gy8ptx+Xw9Kdo0I1H1ffJqkFubnvbp0rO+yR8i0CgTzWb9Hd?=
 =?us-ascii?Q?BImd2evDTQ4mHU03ms0SZxAQUm0ONXr2ECoKZivSnpjBga7OyY4gOg4WoQvr?=
 =?us-ascii?Q?GDWF4sNbuv7vJLAEhN2tc+TH2hRCmoZINq6gfmohbRy6Bvm8gdAsYsIIGiNG?=
 =?us-ascii?Q?4I73ytwEe9Prx1ph9mXaAYnHHsj7g750KCraK9WsGhNqEzvhrqZMGk70qaPE?=
 =?us-ascii?Q?0dGSiLrYHEbOZvtJWyQtXhMX/XViSiWuG5/wsIzaVHtw/cCAux2kDr+IFFOq?=
 =?us-ascii?Q?lA92wVg2WtKck/Myk33TSjTa6+OYG6z7uYednMYiBoplg21IMm/fOgFxMp4T?=
 =?us-ascii?Q?Ev58negg+myee61xdsz7YfERt6EBLrkp8B/b0jFXJbuRJpZz7UJnlMswB4uw?=
 =?us-ascii?Q?p8hlpelzCUf8UMoA1qMSzj/aRbufJEm00lgQRk65FmCHdEY9A9GpI05z4ksT?=
 =?us-ascii?Q?K+9mzLuwEi0tIW9ZdeqJM2KgWHkgH0gMBwr2Iz1sQQB5O9hJyJGWPSaZAIoJ?=
 =?us-ascii?Q?TkvD2aysE/Qf6ho/sQfSiQxqr91dz68fxjoAbyYfCzht2zxSc9rBMS6jBESm?=
 =?us-ascii?Q?cR+oXKM/o1LNzHJLlv17FRAMbeXCltXFWAX5V23sBmBiyO4yrI8v/FD6Amae?=
 =?us-ascii?Q?GKOtOOyV7dSyvTnDSMivrILZZv/vKWYwU4U8Oq49DVRKI/Z8dLZwweX658el?=
 =?us-ascii?Q?avY65adyWbr62hySM9lxYb8dfuY7xqNLgS03ZxL1oeiCOWiQHf+CA2vo5hhb?=
 =?us-ascii?Q?BaImqjWLs7MDw3zJ4OFw9fHA8QbI+Ams/6RQXnB4su7C6ObHmfq0iuYzX9uu?=
 =?us-ascii?Q?q6pjNUFbxdjaqHtuvljGkGH2Cf3dyBwI8AcWRw+VikRqW1sfhuSHOFa7ORQe?=
 =?us-ascii?Q?4bsB2Fw2YDPJ/43Vp9r9aBE2XsljB7cbPWX/QYJCOH1PKoO7uqbapQlCu8eh?=
 =?us-ascii?Q?CE5p1a5xtBvdKH/ukIaKtf3NuSZqF0ZI61f5GUk/hMgv9awawFUx0BkfagRW?=
 =?us-ascii?Q?Lt69YatADhHgGwF4YODudH7ZF4TDqRC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+1ctDL5h/zyOUsqk5FyQBDXp1+jQO6Fp4GJ04OTlknfaMtbLic25++h4WhV?=
 =?us-ascii?Q?AmXGG8zIKZOCn9iI0xWvOmdPtoROqtJZooMqDz9WqA0CApN+WWQPj/MIFlj0?=
 =?us-ascii?Q?bSm0vvHkXQoawadACqMw+c6dxVHoi/8QgpL/otezgJQjLIk/oQqWs7DEGubS?=
 =?us-ascii?Q?Q5hT5jc7jxtTwYMe8o6ngxnsHx1uYzeVuYTORPo1XAW3oufUtoefEvFLMxHt?=
 =?us-ascii?Q?J2Ra+M1w4wlkcAGqolkdhT+wPR6UGaDcuAVRv2e1T31lBmsBxDTVh+QXI7iW?=
 =?us-ascii?Q?4xeczupq7w8IAOj2ih1JPE/ORoBXxxUCe0EUOrziimcnYSroy+KYrbiApcld?=
 =?us-ascii?Q?HMxPvIZxlWTiJ4/7o55pkdFO7NWKXUy1P74slYfAIwLQ3Z0FYZjeJR2qzymt?=
 =?us-ascii?Q?lhygvwROjXQn9vKwxQXZzEsxh2gm0f/PIvcbGnZXkQQ62UMXzWk8yxYcT20U?=
 =?us-ascii?Q?JSEXXIhgYtFq3i1Wc27XgJJC6hO0VVmskGOy89IvS6F6xmOt5rQF8098rTfr?=
 =?us-ascii?Q?kDoR+K8Z+Z0Ixh8JzTRofgKlR1xOVkXxnA4xZ/r8ZYo/R8YS2JcjFWunFlyY?=
 =?us-ascii?Q?7Jo6LsE3cydb9MYL1WRfwqY5EhsRCL+QjjOrRIHjtBC9m4OTFbyaUY5CMlQ5?=
 =?us-ascii?Q?ikmxFkbnY5kXzWQDZOlpSWyfYidKCv6zD6+1uwD6MHl8yWwKY43myeroC6aJ?=
 =?us-ascii?Q?brrFDQ5IsUG+2ac8HSXu1CX/o2PY2NV8DwAlwaiAd4eBV+29JiuGmwi9MVgD?=
 =?us-ascii?Q?F7BwcVXZOS0b+hBLqeepfEehuIl2HQI5g70XfenF3Y29IZtSgwwPtfmHQ96C?=
 =?us-ascii?Q?kX2QOLMcD0v/DmQn0zB2KNk1stkzV3M1/BxGkh4CzSS0grndcjRD3QvMaRS2?=
 =?us-ascii?Q?l3ALF/5O3de9PywMr779agX4zu2ckSlyZ2R+DjdqTpCHXf66hTKhPBXSRBqt?=
 =?us-ascii?Q?aupjcHfxCG+FHVuoNr1J17pzCw48KR5587x84ybY+Ei0BDxuuH4ydLoskfHs?=
 =?us-ascii?Q?QTpa5DYkwhffp42E3Wud0YhVx7CIt6rMC8PFTrRSHshM9J42bZtO/pYuBfbf?=
 =?us-ascii?Q?QvT8w9ExirN+ntSJk6J60GbPW6grH6mfBio03a7MT65rCT3Vlfwa8YgFVxFq?=
 =?us-ascii?Q?LYmcqYLaS6D8hy1reS+EQZCXq2D9+Lkssp6CtXKNCZA922nnMYX+6FQiCMCk?=
 =?us-ascii?Q?A00bh1PnfeJwse++1nX53pkGH4YnsWo5BmxwCl6NMrBfIcZN/E36OZQayU5i?=
 =?us-ascii?Q?orv3/uaYkacZv0EzyeBi8KIqEqsLCmZrsN+h04hhNy33xY2TClyiI/o9oXEX?=
 =?us-ascii?Q?brUSQP2DHgRBRBOQpz/UWM88LfM9IQ1HMD03AkJJ2e6WJwHrgwjEmQlLUcjT?=
 =?us-ascii?Q?o2fIk1TEYimkUSUdqjpYr+RGRri3cngXTp6aLLJIme0lZIw2VkAijLUceokx?=
 =?us-ascii?Q?j5IiiHaCUn0MzBNpJmxNw2a+RhnBblqhx9fX3jFkLsmfDa202vVYzvUy+GvH?=
 =?us-ascii?Q?U8GR/4PmKDm1sVyjReJgYp/gZjP6u/F5cI9k+6Z+fMqIewo0yAOtXUBmJnav?=
 =?us-ascii?Q?PEW0+tKTI15W//MAUnjqvpEiYpg0t3z6uYSMELTDwCKi7TZyFBrC0hxajI0W?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VB4Z0WIhyHHNJsHFXMvqCmT6VPtupdmnLjMISWuHU0dd0Qrb2RaQP5lrF+Hy0a2dYIVVNDMfe5YRkF+ixX+OrevPDywMZ5/vaqZnq894KFcjJZpwr8aZXjhBCwT7PK6OtYzhOVDTCXDYJK/9TXz+3L/ohgayZKKtV440P4mubR9lcCBCKj4OAT7lGOAzI1FNYqnZLLviAe7Kk2/Nuk1bL1WKQGMV7Ln+XEbD+ZGd/9ypE+Io21rMjccy7SYImu/IRR6PIU+9YWgqTLy/o1QSAVJVwsOnnNJKjCNJsmX8/KOKDk7S5ROqZZGwzLYtkOhDZQOmuBgDzynphUggl2lBxbT68U4aSKSbfz/mk1KqLSPZQgIr9Lkrzc5VVvpRvmajcDKkcNhsJCdzP7Pg5bDtdswkDXX43WnLcYu+vrEkRH43lVSgAhzplxvCtxx8fzUODeoG9L6duUfIeGhJ19nFPeKkIZiMTrAklxaRzpancmfXSepAZ5N/RPLoZ/XfSOfv6Imbo5Chv/02XuhVFbeepa9seHPPMakJd0BeJHugw/fujn0CEaES4kC9kmZ2MjQYLCTuz6Xhdeu+PVE4r305LH9QKMMLxvQC8EWGv1XrihQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405c47a7-bc0c-48df-d5bb-08de104917f6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 02:25:25.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1JR7uG0XSSzYQ2z1UQi2X1+ntmZsQBI0bBVlyh0izJb9EuHQ5TWJrWo7xLWoQ4zQboCgHvXW24f5GNuEbK8DTX/D+gfbhk8pFToU8wtvRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210018
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f6ef19 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5krkydZMg8Xk1VhP3OIA:9 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: 0K9ZSUVgY3Sc9wnNKya5nuqGQmDykoV4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX44Cnrc91wRix
 7OnTDMDTQdLMffyDz3wMKARahmRuxAsHxdQaJDDsO4NEfFYqP7EC1rf7j8MIwWIyQrB6L8mTXpH
 QUGeXbtQLKbrOTqFfHGL4+OHMbRhoLcYr0MUqeZZYnXSH+dCtIuufrr9WfTSrr2pTmnQs3sYbzU
 TtIqf0aYLlNqYH7/QofF4sTOtHUzXM0/EyLMQxh53LXMxUv9MoqYacfW0yDxGY9w9ghNmHImxrD
 JT6Bq2UlLpa0qTp97GKbG+ZU0N1q9Xc+OlngNxmkenA3lUSkrbXQhDJA2c0oPz7lLW9iA/YjD2A
 VfQrxVFvUfOcUrlwfBlZwVyFIypRpivIjCPy/cfyforqhM6m+moDZzrEp0/XG7xWmGcUUcFhgvX
 N0tGodK7caqkFuaz2FuRdgEuRUCKMTdH8u+RbC5PJIrvgPJZnmA=
X-Proofpoint-GUID: 0K9ZSUVgY3Sc9wnNKya5nuqGQmDykoV4


Johannes,

> This patch series extends the kernel blktrace infrastructure to
> support tracing zoned block device commands. Zoned block devices
> (e.g., ZAC/ZBC and ZNS) introduce command types such as zone open,
> close, reset, finish, and zone append. These are currently not visible
> in blktrace, making it difficult to debug and analyze I/O workloads on
> zoned devices.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
