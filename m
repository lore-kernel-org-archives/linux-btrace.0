Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527985;
	b=JPhtE+DT500Tv9md0EJjmR/d8g5C2AJa9KLAyMMNqyAevlGRO87IRMMi9+1k4b1IG/8d
	 WZ3Gb3WFVDRQF8vslBi6NgUP2zUoMu8XixiGBvnJtOhH7dkBpsLqzgzAGoeWqcSNzGiEV
	 fekCKKudEolUbCTb8odsUt+XSnAEsGfT5EZXgJFIy32ps34Q9hkMsLOa5P4IwWSvS1bLa
	 bnxpaiWVZQ2taX0FX8eu4Qy+u1CZGsYtaz2pNPkMgSJ/oDJe/zt6vd+a0+9L/tWbpVtae
	 QZA6yUHLsYpB+TXaD1st/F6cLMfry0PdndobsIMfKd9kNvS+tRMm43uUdJQQXieS8zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527985;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=X1qK5IaPlBZnBn/lnuyDjs07hz+M1XXQ67AX/mzIWKY=;
	b=yjx3NO4MSgSZaMAuid+TgNNTJvtlQzpvOhrM3mj9f9OrS90DE1A1VpAEafaQ5FgyIJKe
	 yMbgQ314WrA9o5WqnrNCZBOLjO6m7c1/ffIxB4XRrYcPYMl/7Yu15IIeHiNrPt0BbCK6d
	 NvWUuJ/MSSM0jL9bq64ump4twPfWJQ5+tu9k9nrVEACqFcWVPsjIGB8jNoTK/M7mWYwv4
	 OjFFqaPonC1ZeuEp/QmwROgBfbG2AMGT3jEi36DVNqCqaUV/b0nTXkuBhILrTBkDdNCjB
	 pB0hedu1ZezgnAxWl3Y/i80cAr7qTDWnELSWVVJmr9Gej4eCUr4h4zDiWoPgEQs+cng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=jXMmhk39;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=NeeNepY1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D1606A32A;
	Tue, 24 Nov 2026 13:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4D1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=jXMmhk39;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=NeeNepY1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527984; x=1827063984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1Jt3G227Wb8ZArFe8uCdEaHbOaKeZQs/QwZhbBROoPs=;
  b=jXMmhk39Zc7s5Df3BU0IEwAqpWaWQjt83PTfnC+uWR+dVRlxtk/0wA6L
   AtQwEktRGdwr1MM1FZZvHobJGLkE1Die6Jp07uMTS0x5tJgixDHfmBOOJ
   ypCIlpbR1OaZqucTDlroS+weoeIwhHMZsVS3/RC2yK0J5asLJqU6DpaBA
   fZscnIh6jlfDdrw7PUVG7evb/pCh24km97bTG0xR9bNlFpoQfw9MhQpMq
   mHViM5JEkUap8UKbSGYYy+oY1tRbpvX/s94Xw1GrvzvKQ7GQH9tHLwoCG
   /YmZpvMEVTgdyNtJrpZyt60Xw6eBwfV68jUg7xnt1n1yiOn3Y+I8mHFLv
   A==;
X-CSE-ConnectionGUID: 8XLUun5lSI+09mF2urCk6w==
X-CSE-MsgGUID: Y+HvYbmKSe6MlD7L4W5BBg==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="157409278"
Received: from mail-westus2azon11012033.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVKq2kEtDlpi4XhYlU3mCUsnxKaAV8LEoS2MrgyILmQK8tjn8jLbVvSWon3D3wLV8qa/F4MozfFIvzD4xJXNfznGYcOClA2wBMLc7rptleqZ3VIwvYp2phV07ZGUgS5IlROoPR0y3ioScWfqHg/K1t6tZHjNeD0fRWomiok0vShSb60SJP9rG74ggYW+nHx+UdOmlqRB3+yfA26EhPzlbPv6Fa/qB9QqYGxVZ1aSVrkjYHaEyEb5UTb1XyRQqROlF1zQOS6Iod0nvyvfRsnEu+m61kX3gBRnRRxvw6k3H6BQbeVVn3CyhNTrmFolPcXkRHqLCfXsCRVSMd4uMQSm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1qK5IaPlBZnBn/lnuyDjs07hz+M1XXQ67AX/mzIWKY=;
 b=AgUMpTTg5Cy1eVO74j5XQ0nSWYEf+DzjQ7uRGsrJE+yNxg0ZdHNOhO57tmRIWVoQcjV5Xn470VnHH/pUi6QCaD9mkgxTN5X2PEjdbUNM5vCKYrdc1UIJp23Aw/0supzrjugw6mX3kB8XGT3sLjGGJmMnxJat9FR5TaCtbIrrJCs/UEtJgloNLXA/WiDotZShlLuqvFPN/Y9LdVOUghtVIRtUZIacY9AOhmXfbK2Ct3lGbQ9MCkbCtJZN1DGT8vDxYu01XfIrMDk5Bk3JvRX+SxWYfjTrDqCHrPzSFnDauEReZnyk1S5XP0kWh9pEYwJYDYfYpQDH19noKEdadfDJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1qK5IaPlBZnBn/lnuyDjs07hz+M1XXQ67AX/mzIWKY=;
 b=NeeNepY1GGK06LSFQ1Wk/ntuTUqVwilJdKkjTRNqKyqa02AYaUBUlhgHs/IWpi6l9CMzgMZVs28ftrQaGz8tmdq8kzlTOvotJdj/CDzTu+6u5BSgu1YBsROzCs4IWa4hjLIVQFE37lj/O71sIvbt0OgdqLGj1HAyh9dZ2cOcvdE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BN8PR04MB6354.namprd04.prod.outlook.com (2603:10b6:408:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 13:46:22 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:22 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-btrace@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace 4/6] blktrace: mask __BLK_TA_IOPRIO when decoding actions
Date: Tue, 24 Nov 2026 14:45:59 +0100
Message-ID: <20261124134602.153239-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
References: <20261124134602.153239-1-johannes.thumshirn@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Post: <mailto:linux-btrace@vger.kernel.org>
List-Help: <mailto:linux-btrace+help@vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-btrace+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BN8PR04MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: e16ba196-5f5d-48b9-fced-08df4a31534b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|23010399003|1800799024|376014|366016|261022075727099003|261102123227099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	beIxuvLwcJfi7Ok7DG3Nmli7pudmP2jHtmIJGh4c5dQE+fnM8e380JeZXxNbqmrK2AVMDBS/9sTDr5p7N7GRyi2/IxwhowpNMSC78r8uYmbUaaFGedfpIqienkrQyArSL9gaanONZb/l+HrvwqVoZ5Xn7a47pJU6ksSAqZ+ShP69Gp+mM3S0jd+fa67fNzFJZD0Il3egZ5CXZX2boLQlyL/tSmv7IMHt6q147+Vg7U8nF0JLOdxV/7+EQKeurNRnYoDzVhxG5Iu1npwRnRBxejqo9Nq+bk2Y8kjeFAyySraPy0/fEo7VtxwNTVVNOq1BOySiO7Ah1I1QJJTIDbwJSctMx9qLjMGGZE8XTUHDM9cSPTiqkMMtx9ACEYlf+h3IOytOrC+4uyJdmcW7UiRa82BFAmWhM/NbyReu+nOfqHJ5eo3m/Aj3lBzNMYHJaDTuzYQ4xzaEdWwgbVPvbbs8ztsUEBfkEI9czLauKlWNrKrAoU0tJtkfvQEvzg2K7WDv+xiXEV7JSOQrkA+oCm4du+lVVC5I5zihCbGCaCxeDr08RJpHMYHlDbRPfH7kshtRG2P1Rdldq6508cBQSeIk+q8M0OWomcDGqA80cCfBqT3BdwkD/02znjM8hRNVi6fEnJzntuauD1xrDCHk7dYWVdGAQSXyjvtnOkZPGw1Adzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(23010399003)(1800799024)(376014)(366016)(261022075727099003)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBBYW5OOgqMduPv7V3vGxOFVs8/OKq9d1PQ0LZ0L22AoZfyBmeuyEIzskJ2K?=
 =?us-ascii?Q?377L479AOkiaySG0s0f0xVzxNXodPfLUNwYZ/rvvrqYS4dzpRx6/SyhWhaMQ?=
 =?us-ascii?Q?eoBWTv41dFNUvhwhTb+iClM2AgbxZxRYYL2swkDrrwOeVjyyoYi53dD0iC+s?=
 =?us-ascii?Q?p9CvutOzLK5ywPJXv8Iwoaea7auMFuw8pRxmr2BcLNZHRFZm1z5OGBRjSm9P?=
 =?us-ascii?Q?kBo0AaNi9ZAPKEDYP8TwSaMdi0S8efPFtiHHVfIgc5qPGhcM0lau1jGG0JVX?=
 =?us-ascii?Q?y/GrqBn21dgjGG+Xyd3mJN/EQ31tjReq3HogRJRV38ycfX8SD9q4HLKOFvoa?=
 =?us-ascii?Q?/kGlY673a4YRCZ7QhmBuDjs4MC8MaMh8pAiWbByLiKYy5Sh07wIkfZZONNDa?=
 =?us-ascii?Q?wROD6zObSDwW0qzHmemR6P16M7OlzwAoCkh0tEkon8fwPmfD/P8SFfhJ6oN5?=
 =?us-ascii?Q?NN5Qv1spnCwnPhKUHHgQVEmd45b6aGlQRmpNrVuYzyGddMILFVFGNdpIwhz6?=
 =?us-ascii?Q?OVRENsAcyO2ieyE/+BIoP8bxmsbK1HHzlTpWi+wt2kks8EstlDgw6LXae8X6?=
 =?us-ascii?Q?M793nZAM2qkpfuG1IQJkrA5G8SYW9MNyc8jHDNck0LQ0ROEwDiAveEwkUQTw?=
 =?us-ascii?Q?QoyJgykqGkHMxIvIl/gd1m/prCEBFNgQ0zJ8BANY40CGm0GVgGqiUAhAM8M5?=
 =?us-ascii?Q?TSFXmF9DX28h6nUC54xj6CmhCVZZD89OdrB7AJ19azNqJH1KJ0JzaocHnW01?=
 =?us-ascii?Q?Q8Hj2/27oalrgrW98F9koqS5GQY45jGACMCONr0mJbWDFGfWsK6o9/WIHSWY?=
 =?us-ascii?Q?ZK2J/b51jl7189wpj0xYuE/zF5Zi6XKFDoFUvggJsZOR/S9APfz2tBQ87bMI?=
 =?us-ascii?Q?9vM7CEWt9g3cJfv29X4FHnVuzjPpN81L8e8raDteNt6ewSPbKKMBvdbr6BP5?=
 =?us-ascii?Q?FCK1erISQdNQ6L0onvtC0rSrO2D3hLNcyG7JIPQxo+Y22eS1mC3cnzPFf5b5?=
 =?us-ascii?Q?pk2/JCAwkyip51TX9fK9HjW4AuzccI6XA3m88uo8EKexX8mZ6vyzpbvjacMg?=
 =?us-ascii?Q?Xm5A+qTeKi9OxDzYX4D5jgSdLpS59xqDRuKU/RopXlFSlSd4MOe+wV9YzNgH?=
 =?us-ascii?Q?/7C+T22ipuEGbpF8qVgMxprjrxPm8PyE52Z8CKfg9lo4vy931r+NeCH7YoEP?=
 =?us-ascii?Q?ITHLyUo7jpxaf5zxEon6ZiuX4rV3+fn4QeIiTS3OmLXYWmSRGfW8lYZsYMnK?=
 =?us-ascii?Q?WAz74Q3i2ld7pFDrXLOP5dVVGdlReRrlpNT9eXSb6zRReXgu2Y3vQoGH/ZCu?=
 =?us-ascii?Q?788r436lR+NDG3PRI3PxEW+SompZ/XJ5KS0UWH5d0G6+N3klexLZ+OvbSswY?=
 =?us-ascii?Q?lYjWhk8lq38j/jFYlMVo8Ncs/NuoUfFS2ahT/ld2lop8R+iJi/rXsL33owoA?=
 =?us-ascii?Q?7Q8KbzOK4B+/wNtXVn7pZg4GTo9uZlKDPSYdlyh1ehuD/zRrupQkgOxyniO9?=
 =?us-ascii?Q?QrvjOPE+VhJJyksoraM30Q9IYEeYb4xCVdzacyw6l4GfpY7Ori8yj2TUBKDW?=
 =?us-ascii?Q?PtN6G+zMnvLIV87elHSlPF7V3j4APywoRZj7Jn52WJA8uuSmWUATMJShmuRh?=
 =?us-ascii?Q?dhr1UT8PFQ7XZmCtidx1E9B+n/htQzU2l7p+wkcIFOOVzhVaWCQ1MMo1ARpV?=
 =?us-ascii?Q?SqAXVwi8UzL8WLK4Avt0ruZq37cqYlmSJ/Ep1yQms01s3B3Y/9KUvNRT3Veh?=
 =?us-ascii?Q?1EbFCxQaMjlx9Nxm0d4Edtbwj92zJbTQUc6AbRVtMBmAaEXKofPsYRAW8but?=
X-MS-Exchange-AntiSpam-MessageData-1: SaxDzj2fyb6r5kmpQ7ZQqjZS1VDocaDK0xk=
X-Exchange-RoutingPolicyChecked:
	CpzzLSnICZvedTuX/CxoQ2HJVj7DAvF0SbjLcEUtQDyKI0+qLOLvasONinQbxyjzpJsCUeQRRlWD9SOcDDjr4nE2AfQkL2+5zOTaV0lICZ+e3j1QtIeZcNpB86Id9GpeL4E68Hu8dKSLx1A1kTSo02u5GjFb9ft3ZzNpCm7J/KFcE4gM1nZ3qFpeScVKCl5QJT6oatxJHbIPr4nG8EVk/WJ3z1usXSXoUmtQLKNdvdBsOX++3/H8U0f5dQ07jtfofcKi18QzNkAXBKHE46RuXleo5IUzS8b1sq1MlJmw5mdvnU+FCWB/fcemxnXd1MblF5aViCHDq4S+cImcjU5PEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3EIRMJRnw3IwR4e9FbfBgwjaFTzw8qC9IOAdrh2JHCNaXXgUp71K+Ijq4nMeAedxfK0g0izoblPhLZ5TGH0F6/8qm+3hBNzLm7B9hqK9wYeb1HEmKmtubxqMawvo7+XiIJfgg7SY7r94rIYp+ZwxrCNfpP63kRkpcGkELyj1IZo0kLLomzacGddZJ+/DzQCMErGDRy3kuiTpFiDupWWU3tYEdgJ25kpK14VFn4tjDL5DOSS4lMlA+6edwEsB+MRRpUIZjORO/bHkhBpYs5sT0c6K94q7sJZFBTi+fw2MUWqESmLYoSxtU4+WIHn4B0OE9LjSPhk7uNdv5a4KN6bt1DtdoAwnbwaJYAN7BDMc1DX/EvGixMaxXWS45slWQCiB0b2NYRLbC8v5R1CmYZMr42exPDn45XdelRsbWdUFgZYsG+SvR1Mv3AYz4yEpeYtiAg9hYsTjwLS1uqbRe/Ydamr2tcn37rcjvkP7SzVH/g7Yp6TAI0zL4ovcPonbTBO+hooBheJL6QBtUweE6vtMGkQfE/qaw9mxXAXu1hMBHGK6rvbuvEyAXNvaxEytDPu5CzK8sDhH5xHRrHJR+Z1w4O2wiUEtXMMXUFDClbzhiKxgsIL8Bh2AfP2Z5yDLw9/p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16ba196-5f5d-48b9-fced-08df4a31534b
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:22.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEp2V64QuaUFGtY5HOoFHzeJFRWLv3BswX/s7a2l8FetxmJjeoTM2fICJN419OnFzY1DZRygrTph5Ox9g1AdDSX+8hD3eY9Nxq6PzRcaKy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6354

__BLK_TA_IOPRIO is a flag in the action, like __BLK_TA_CGROUP, so it has
to be masked out wherever the action is decoded: in blkparse, btt,
iowatcher and btrecord. btt and btrecord did not mask __BLK_TA_CGROUP
either, so mask both there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c           | 4 ++--
 btreplay/btrecord.c  | 5 +++--
 btt/trace.c          | 6 +++++-
 iowatcher/blkparse.c | 3 ++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 88ef019..980ce42 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -1649,7 +1649,7 @@ static void dump_trace_pc(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = (t->action & 0xffff) & ~__BLK_TA_CGROUP;
+	int act = (t->action & 0xffff) & ~(__BLK_TA_CGROUP | __BLK_TA_IOPRIO);
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1698,7 +1698,7 @@ static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = (t->action & 0xffff) & ~__BLK_TA_CGROUP;
+	int act = (t->action & 0xffff) & ~(__BLK_TA_CGROUP | __BLK_TA_IOPRIO);
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
diff --git a/btreplay/btrecord.c b/btreplay/btrecord.c
index c1c9456..4a44bd3 100644
--- a/btreplay/btrecord.c
+++ b/btreplay/btrecord.c
@@ -202,8 +202,9 @@ static inline void fatal(const char *errstring, const int exitval,
  */
 static inline int match(__u64 action)
 {
-	return ((action & 0xffff) == __BLK_TA_QUEUE) &&
-				       (action & BLK_TC_ACT(BLK_TC_QUEUE));
+	__u64 act = action & 0xffff & ~(__BLK_TA_CGROUP | __BLK_TA_IOPRIO);
+
+	return act == __BLK_TA_QUEUE && (action & BLK_TC_ACT(BLK_TC_QUEUE));
 }
 
 /**
diff --git a/btt/trace.c b/btt/trace.c
index 48f4f99..1f4883a 100644
--- a/btt/trace.c
+++ b/btt/trace.c
@@ -23,6 +23,7 @@
 static void __add_trace(struct io *iop)
 {
 	time_t now = time(NULL);
+	unsigned short action;
 
 	last_t_seen = BIT_TIME(iop->t.time);
 
@@ -36,7 +37,10 @@ static void __add_trace(struct io *iop)
 		last_vtrace = now;
 	}
 
-	switch (iop->t.action & 0xffff) {
+	action = iop->t.action & 0xffff;
+	action = action & ~(__BLK_TA_CGROUP | __BLK_TA_IOPRIO);
+
+	switch (action) {
 	case __BLK_TA_QUEUE:		trace_queue(iop); break;
 	case __BLK_TA_REMAP:		trace_remap(iop); break;
 	case __BLK_TA_INSERT:		trace_insert(iop); break;
diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 92ee1cc..efe7acf 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -50,7 +50,8 @@ extern int plot_io_action;
 extern int io_per_process;
 
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
-#define BLK_TA_MASK (((1 << BLK_TC_SHIFT) - 1) & ~__BLK_TA_CGROUP)
+#define BLK_TA_MASK (((1 << BLK_TC_SHIFT) - 1) & \
+		~(__BLK_TA_CGROUP | __BLK_TA_IOPRIO))
 
 struct pending_io {
 	/* sector offset of this IO */
-- 
2.56.1

