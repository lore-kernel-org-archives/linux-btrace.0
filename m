Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE832EB86C;
	Mon, 24 Nov 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989723; cv=fail; b=R05MsNHwI/b0XJ8Wy4k9mVocLcBQET8Exc7YsvSSDvCAZsT6drht5Lqbw9L5PJqtXQ1rVSHhJ5k8AH/usX1PwUg7FudqY52S3R8v+7aNA2lfGUeSyOnYyh0LBhsG6t8n3WWow1Lyls1ajWfmZHQWdUNI/AGlkiBRyC+RGHyOrzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989723; c=relaxed/simple;
	bh=ZNVyGwbIu9qJqQv68Re0CFc7MymVMCA0qkKheU+eabY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=nzh5gFzFB75sCyEeaSidq6UJ5PqLLKNJm+Jsjb7cW4Acht5KCQtEjxrODyYIdUn7skvIA/KfQtkaUR/2nnFJj4JAqNgbwQsjoND0hV7kn6pDTs1TXdYq4DC+Z+ghE7hFe3pQhUHQoDJv7pshzPlBT1poe033AZqtqB+SGNfIPrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rfIiquJL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AVdXv1d6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfIiquJL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AVdXv1d6"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVD1x1085558;
	Mon, 24 Nov 2025 13:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0PfwB2wcnl0Vd2TF+S
	yzu8SFZXKyBAXVpRSJbmmm4Ps=; b=rfIiquJLb+reL8qkXpB4X5EEpHDbLeC5wn
	PIklJbjoiJC2Xzairz8DKx3Qn8eb5HW511CWU7tHPo630U5Qx7meXPb/JjIht3Qv
	u1va2ue7SaTEs0tkuOk7U3REeW2whAEeWxk/YaRvn6kzRQVDQFG1atXtMMOk2Fw7
	XFxqHzYWFqPmtk3v9A4xAV+mR+E+tgT7rW0IlKiTB+wRGg6L5f+3oU0H0HbPNpZB
	O9A+p4Z4QEUp2CnzEo4nIqY4/98Zj6xHdKBQbCIS6pdzgJHsAWdJcFhh/WLDk6FR
	sQyLxpXL+sJvZJHZBwzbYep6gda25ng4U+Z8PpvKI6Ycao4xW5hA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7xd1yjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 13:08:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOBatMx029886;
	Mon, 24 Nov 2025 13:08:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mbkgh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 13:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYsMOkvUUAPoJFBsSNJiQWTZDk4s/jyj7UEiMXVaZKGE7jZ1YAL5j9L6HlE7U0D3jzjol1SJ4dETCiPtfwF4fdr1+EZKxC85cfX9LaalZS7tHLx5pia1DppoHKWbKMLjKGMSqnu6Ht/FsyYFxbp6PzfhQTeRAPKkmVBTplEfeQK9WnqMqaabe0pLuMWb0i0/SxRU9cXHLq6zrCyX4MXfx15NKPAA2am5LOzQF6IYMHBitd6+4v897svQnv7Atbf+f2CqZUwKJX3jfVnKFiPykwCjP/Rw8uQt5iW/LgMcohWusQu2d24j4ICcmKRXMIHlAfyMqTd5mG4qjM1WxpOpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PfwB2wcnl0Vd2TF+Syzu8SFZXKyBAXVpRSJbmmm4Ps=;
 b=pWnOJ0E7tKMByKqglBqOF4G8xlwd9dCrKqyQb7IzXZzDtYTbKAQ8Zq8Wa+U42o78N6osQhEu+LnTcYlv9G1mBkROM2gZ3wWFigDoLrfKKGEVzoBBbyG7uu3yt5hRh0rwdv3LScqwIIv0Qe4mPJYJp+xkt6048/L62a0/YfJNiiNUyDETfG+ePq8zf71OSV2P/s1YTWCCWKRillsiQ5zX9fJXamAhIgQUvT589GlxMEVRGtnJia41faST2Aadod78/qdIWUZs0emrohffIyR59coVvC9+3QZTLibZ3uXR3fGLr2LTA9Km8nBiLu3WaIox91nsfgiTJ+sV3GIPx/vcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PfwB2wcnl0Vd2TF+Syzu8SFZXKyBAXVpRSJbmmm4Ps=;
 b=AVdXv1d6l6Nse2lzJj2fJWXJwsaE2MzqQuAxtjeLkxQiNemmV+xgar+3La75shYxa0ZfZfHwsYjPB2gltJ6KL1coVGB8NyAtPvj5eT1DPRyGGGhUwSjIDSGwi4DtAF391PXxovdZLLAlTT7OwTO/qC3RWAH0dVYNJFCKPgU9mpU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH3PPFAEC321F49.namprd10.prod.outlook.com (2603:10b6:518:1::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 13:08:30 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 13:08:29 +0000
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota
 <naohiro.aota@wdc.com>,
        Niklas Cassel <cassel@kernel.org>, linux-btrace@vger.kernel.org
Subject: Re: [RESEND PATCH blktrace v3 00/20] blktrace: Add user-space
 support for zoned command tracing
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251124073739.513212-1-johannes.thumshirn@wdc.com> (Johannes
	Thumshirn's message of "Mon, 24 Nov 2025 08:37:19 +0100")
Organization: Oracle Corporation
Message-ID: <yq15xaz4lzy.fsf@ca-mkp.ca.oracle.com>
References: <20251124073739.513212-1-johannes.thumshirn@wdc.com>
Date: Mon, 24 Nov 2025 08:08:27 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH3PPFAEC321F49:EE_
X-MS-Office365-Filtering-Correlation-Id: 667c0bf8-1435-441e-0b7d-08de2b5a8f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGc4Xfzln7tclWAQIMj5pT0nNlzvKcoYBIq0VVwnzugwoB3dbSYEgSSe3nwI?=
 =?us-ascii?Q?cWUYmCxs+kygao28qvoHJxvnMaq9wPPLuMLwLl3q8MVR7OpJsQOfMt40seB+?=
 =?us-ascii?Q?8IQ7oFjlp+eiAaybww9dVdqfKp9qRcZF1jO345b8VXxdXyjKLiN14qYYdyPz?=
 =?us-ascii?Q?hfeYVxDtQ2sWHtLbHYGFuLNSf87QsrLgUrMU4ff+YM4PRl2mbFIwfyaK0Wt/?=
 =?us-ascii?Q?NKs5PQxvKglOyrHBYRBm83ynOGN5yCR/fsKIY1GFvhLYiVmlXi0CSLrSK1ri?=
 =?us-ascii?Q?5Dmh4RyETiqDSR40GYGQilbzAO18ObeCXaLQcWx48NQXmZt5vUqEsWvljUc0?=
 =?us-ascii?Q?A4YZ8Ip/WVaEraxH6TQC56swtHN9MrIfLP9cfjK9rh026cafUVjPd4mZGMWU?=
 =?us-ascii?Q?Auc6W2VqTFKW5ktBT+4ijTb5U90n5yZF0FNXzhqRkbX2P0dieyIbyBSh1ctM?=
 =?us-ascii?Q?YFTw5SdKzPrha3v6KOlX2t4k1jQwhsEw/kqJ96pZy6ARZiqDWZom2b/Frt5l?=
 =?us-ascii?Q?qrZLpR6EChTi9/shOFwLbW9zSHuEICid/F7YqyXHSWuCsaVkSO/VyTQuWeEb?=
 =?us-ascii?Q?OHyA0rjkJuvfR2lbML+V3NgTcxTKmD8CZVuvuPapGfNQ7ImqkZ4nqJiewgWS?=
 =?us-ascii?Q?FlhZZHNmyLPNfdFT3hh7G//KSk95kXUeBxyuNG+hjg0Uo+dzJm5RcwRtSfvM?=
 =?us-ascii?Q?XVtP71VpceQOxZ58N6CiXqlompQF01zMdeNYQg0E5IYhKrxPhhxFHMoY3rOq?=
 =?us-ascii?Q?R5sMgQfUGm6jrIdUNkCO3RIxnQYrlQTvQ9rOtD+bDNXw1ImjTur4lRHzK3m2?=
 =?us-ascii?Q?UhPB7/p7BSJY/H6XvDQ1n/aPoC+6ehAL4V1TPu5llNRAfLVUQ3tdshBH5CL7?=
 =?us-ascii?Q?1zKPHNqEkCPSK8yqJZWHOtc/+LOPvNnnt4NhhQEGLrLDLUCUFDAhGd7D5jrF?=
 =?us-ascii?Q?BJElhjdSjg4DSSoaOD5KseLGyIioX24WLQEIyzGRJP5Vea4E+qxyW38a1Scb?=
 =?us-ascii?Q?OexVZUVGjBnfLqQtJXkTqZ46EP/jntHyYcE2p/qsryHTPaA54LE5knbAQXhO?=
 =?us-ascii?Q?qCxbkI4MacVNDHRVEr5pWiYJV3fy+2qGVyhmJPxm8d7IuzlucXrssHlRX/wx?=
 =?us-ascii?Q?UAbgQZPNSzRwTYzMfTwBNwr+quqS+AB/HhCQK9h36NnstVjf9n9sZwqhJK/I?=
 =?us-ascii?Q?vcpB/Ezm5Ji/Dzs4L1000TqHex8M1a7snzwZpEOweLPxi8Sny6oV0Xis2pHG?=
 =?us-ascii?Q?Lz9ffl34cSPr+tWdr62vK6GqFaSwS0t2dS/s8xhow1ccLujbF3oNtIfcDabe?=
 =?us-ascii?Q?1jRF866OPsli7zK5oJW1xbHE2CCio/48n/C9mQODBomr6VHAY2hjoopqWSWG?=
 =?us-ascii?Q?FqclyT8jVokMA+RZ1RWcUzmK+51ZY8knvcpFfS5fXVq8e/4YL3le0dd6uvsx?=
 =?us-ascii?Q?DPtiS+XJHxtb4z4DFy/Yo1pYsss3DIVh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EFZJlbes/RuLuWwfR4xF5N0uorqNGPR91gT3tqQF4LnX83MbBPdq6P4VsC2y?=
 =?us-ascii?Q?G0zJtcWANJXCik7ZJuwVWZcmWgT2Caiall6JSWj47qhoSHnyPQpDlkFA7WCr?=
 =?us-ascii?Q?yo8skL/XKyqJLJ03EVZj2MuikQO8XNZ4jwJ3Ed2Fi0dIncOWE72M70LZDMFs?=
 =?us-ascii?Q?YXhygZEnOkf3s+rSDwnSHmpV/MmnyTiqCxJYD9MZcZhq67nX1rY6u0ORceZA?=
 =?us-ascii?Q?7xvFeSbhsuYcPrpaM7X1kru2HfqqBviN95kGyaoYW2LYx+NGqbeHCK2fEs8R?=
 =?us-ascii?Q?ZpXeYgg67Wg2W0ho2PWoF9p+IjI4Hafp6QQ4qZMQcShv7BCMM5iHM5Nmw1Jt?=
 =?us-ascii?Q?BAEa0qJyZQcOnXScSs5FDJMm8JOiWEol874Fp8fFhKDfaM55ra9jxrgRbUEb?=
 =?us-ascii?Q?eATEGBZREP8smgtfvxbrmPv5eapM1/3kJANRDuGjnT0yutmAPYfqC1QzjZhZ?=
 =?us-ascii?Q?TF54HBhnFEkyHVVa1lZLRZ/rRGppuutgSqFDRXahKbAT+enYK3GJLAH41CNH?=
 =?us-ascii?Q?51LcdKQnD0ljUE000/erBLZBebvoj3TCH/Q8xJFjvYgmE3GI1kK5ynyAq0L9?=
 =?us-ascii?Q?A9ffUuGNBWy1kLQblEcrDCOHmC3zEH/WTLDXlyaZwm52UhLeTz3lJnP38jD6?=
 =?us-ascii?Q?xR3tyBU+mS/vGp3CzXT1jI3hexzaAxUZiBwsWTVRwPea/3AF6AfxMpskfQwl?=
 =?us-ascii?Q?XWnV/mfj4mvjcwA6/+TGU7ae/bee/AQ6qrjl6DoMPvllVFYEE0tmEgcX8DFW?=
 =?us-ascii?Q?GfdSl4RNg4YhU1880T/ZVV+3rj9RwA0x3WHzWaLr0ZcDJ5ASx0LIiGv7diVx?=
 =?us-ascii?Q?XB7zkgqCcR0qG/5zqKzs/xisL33/4k6gOnW1b1+GqvbUx20Y1Qln8rbmHplO?=
 =?us-ascii?Q?Yvmfkml8a6nRLnt+nM0k9W2NpPZBqCKatO005TRedzov06ciTb3eXSkVNeKE?=
 =?us-ascii?Q?GSxqIBUBdDz6r8O7frtpxnHIVBAJWPoICWxsgEdp+QuFLzKI9SA+PkKVnQ0N?=
 =?us-ascii?Q?HPl1XpTbODDwejQ5ESCbqd2m9Qj5KKnNcYv8q/IvDqUzxbsSrJwB3wTg4mdY?=
 =?us-ascii?Q?paIp1MomdmewP9jPZYlxWhT4//lW7bfbw4S89UfxwPvEK925RmdW9brT70jq?=
 =?us-ascii?Q?b8WEABYkXLQ1T74EFeHhwUEtZsPH8/YiEJjgHrfiaY8IaiR3GKvptGIRYB3p?=
 =?us-ascii?Q?6qvgiKPFkaZXD2RQ2XcYknA+xGeTTr6EmzlHGql2BmN/NBpWzlFVYREUwCk4?=
 =?us-ascii?Q?LeqfUwWd2cOqfJsL3+WNL/unCQpH7UxdkCkBDWLaigHLyJNuxqIztylDQv9L?=
 =?us-ascii?Q?nczJ7DsDGGAtfXRXJeJ4UG1nsTR2fY5AqdVqa5ts1KerlUj/4YoodczZ2n0f?=
 =?us-ascii?Q?dQWT0gyl3sKtfMZfZItkfbCRlz6GugHje/g+SJ+VsFiI+oJH4jcZx/YzKlXA?=
 =?us-ascii?Q?g2JHPs+ktWBmNDdM9ysIdu2OnsIdPNN9/WvzNpwwKVSegA2YE2PKVRr/KSHs?=
 =?us-ascii?Q?34fdaXvJIuSP9zZvINI28wRL0OT5CkOb0HES9mN6GGrlNiWsB+/xbVs2wP3R?=
 =?us-ascii?Q?+uRhCDLOfAu5DHDWwcqf2b5/FR1LFWEEFSejSkT8l6VfPldvqUoNgsdl9J+F?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ipTORp4vBEDnbGC/YQJqTO7HnlFIf7hfYiK65Qznnl9EqfgFr4Ea+0JZOMKXUo+P0kPalKfW46iDghg4hJfBaAlZS+ThBF9qZJE1ntNrznmz1HgCI0uaceRUmk5AJZWyDPAX5PTvAoEpoEOIUKqv4BXlvAh/xBrY2DplGlZpB55LXAXM8jAUeuNvyDPB9WWmt96LgcVi79205ccTJ2Via+LKy5Rk8bwfx1oIqh3PZq+q6H8rMvpIN179fx2iDfqmGVRP0+PViWv8THYxKbsSu8B/+hxd6KttFEbPBsHlwC2Z0rF0/2E5uxJNWMLNWu7eyQaIfAJQas9jDYvXHvykARsBvhQmnvqKRZ8Oi+WQXxklrj6cRYShU9So0P74XzvI9mZT5olp3RmRR6aoL/PVueKlDoMMPcuxZyS1qQRtJQ63U2RLRsABQ6HCoySbcWzI/jQtgC3Q7sJpaRBU+2bUwqOSke5epMZ8jcsna+I21T7dkzIuRwPlE+AITP/80qsvoJ95FsXRrF6PPMzTH1IC5QF3CaFF0d+VGGaeGBTlFc0grRCXh0RYFh3cbPJDNEJblIWwd81STNlyP4PBwU4ek8z2iLx3qryXFKEOIK69qw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667c0bf8-1435-441e-0b7d-08de2b5a8f92
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 13:08:29.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35+ENkh7mA/fkAhYHlQj2YeeF0bnilJZG5ypj+iTXzz1+26Yb+MnZXrJPTHFyLTrYK/ww5quaiUu5p6npK3MVwuozz298DeOwm7107V5jxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAEC321F49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDExNSBTYWx0ZWRfX0fTQflvsh9aT
 t05giLQ2jroIzCK2UZDkO/SV/DWqkljyCqIL4JAgh2NYwGSJsn+nDq5kqQB1d4hsLKzSdo/R+2s
 TRRTcZSxRLykcRzSpVdhjiIJMmWf6hj1FeC+iPgAs5d3+DOgx+z4apw+vtbW/ZWS7CKA0csPpfp
 MshMOFWSonW8G70oQawJJBCGNby9ojEqp4n0EpIhqrsDB0El+UgnP+hZyIlZUJCYAnwr0HDEYx1
 46jY8LbDigQKfxpi0MAwbZWrCpvOKtgHMA9rPo7MrlgQ1SVbvBd+qHj2Ev5pJjBxLrKU7J0d1t7
 F5u/O9FDME+f0ekPUxDJmcE6dUdCZzwKhhLUxWiZOQt8sGZ6IMNkn/bDIJppAKZXof/83gillpp
 GQ3rIGUIgKqGdKtUZ25oFRJRpxwIv1UewvFVnjWbq0X8vtD9KOk=
X-Proofpoint-ORIG-GUID: f9C8JyaaldCjWaX23Dtd0K1dgP-BDJi3
X-Proofpoint-GUID: f9C8JyaaldCjWaX23Dtd0K1dgP-BDJi3
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=692458d2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=SKH6ucs0r88tvSaumd8A:9 cc=ntf awl=host:12099


Johannes,

> This patch series extends the user-space blktrace tools to support the new
> trace events for zoned block device commands introduced in the corresponding
> kernel patch series.

Looks OK to me.

With patch 6 moved to the end:

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
