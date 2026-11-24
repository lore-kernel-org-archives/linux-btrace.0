Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527982;
	b=Aop7WKlbzKdLv1qfU1AokjHTRjYLf1iddBbZK9Vqtw9gQYCexR1LYg1r3bo3Ob61XdkG
	 i3ohsV8ARchJ0hjfLgmRn4KW2VOvkZWmeMwZduPawIxOq0MqcmiV9LCIkVziFG8AE+O8S
	 WSoa1/GpoylxSjvJWuDAAltqLKUr5G31OWEsY+/jHUP/o+62KEq+9RxdKktMAHeb1JAji
	 TI5v7gDG+Qi8+lKlcVueo7utWO0wCrxiXxZxe1ndV571a1YaCHlbXi3bNP1oc9RCJwgFi
	 0TGlIcJCAqiUg1IQbgaqMwbFJ/HSMx/U8d4Zyrz1V6gab1kfu3xL4I3DRrg/hj04d5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527982;
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
	bh=4IEy6gX1E54tYKMVt+/pn6UzBMR9fYGH8lxcr/rq1mA=;
	b=iZ1FHdSt5ppy8SOO5hcF5YLOh5x1dsj7ABvXXDjnZXnpUa8WLm0awPQR3ly6P6lOM1Jl
	 4AJsGQfJcI7EkBkgiJe1OBt1lSx+GXBZXAUaP9wIcQtJQKNPpNvDyPT79X+TKFrWihZx+
	 DS6ueUkj+jNq62tmy30Hc48eFCmijHXtzYQbD4HfW1lLp3vETjv1V5jcUh9ZSZBFiZHFJ
	 DmXFlCyPNRg6aU9kHuk8fsmVbpx+qVeMCTIqPIucnKHGzV+lewfhJxzhtM0Ru+BKuS+Z8
	 uo71hrNhx45Q003oxjjwYNVXTqixNwNIaLX2cN7XCpIWn8HcwapOGmijlKFViV6Aanw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=UOVlVn2z;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=x85ciIj7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D7606A322;
	Tue, 24 Nov 2026 13:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950D7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=UOVlVn2z;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=x85ciIj7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527981; x=1827063981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EbOmsmEk52n9zEds/ePej1+56YGreHZ4zhAom65TC9E=;
  b=UOVlVn2zXmcFog3DxVS30/chrordikK1z/eb60Srl9jHNT85bmwmzgj9
   aY3v06bRXCz6GqA60/Gu38Oa3GXwnqRJMWw/M6RZb5AXqlSXvzSVImM5F
   l5KjBJPYLAipZwHt7ghSEsIsIyzoD17PcLTPsACEfjJTtpbPWJK9/PqYe
   YCY//q0YO4+/opw5siLlo4YxZ47u91IEH7PomreivHqgTO3w6JEf2XQBz
   VFOjCahUok39Eiw6fV1Nyh/nEMyVtMKTPpczZ6qfY5lXMGlrdKk/x3rri
   52fVCzkwFs6pbYw7MRM/WgZMQZYzLMNJLLB9L4ARYIzvJx0DIJkCVi/LK
   A==;
X-CSE-ConnectionGUID: l7tQtB/BQTOZMNkRQJcq2Q==
X-CSE-MsgGUID: ZbaBL0zLQCeWQYIuvZJGxQ==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="157409271"
Received: from mail-westus2azon11012018.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqrJeh1up8lbRUlzBQawh0rFgHv2e7HoXmurt3FZCSegUCFriRUjR4I7QPqE310h7TSaCMFmn+w6Dra7UZRRmEGPbDUUPmOp1dNuBJBK38+0B/GGv43jXqwMziwOhxOqToDcZ4tGJEi3TAfdn82MdSrUwS5Lgo60bWJvAwyxDZa7JuVqOR0Sh7tOU0U0BxIKz625BkXRwrdT8iN7NtgiTfGs1eF+hn2jxHD143pDe9nB5VJCkQBvlv5PWzE+eliK0v60OWmxr0KfSxC32KeHdProE6DEVNDK6IhWTD1NjO2pHh5O0ghNv4ALd+r8LnmVXbIPGotF+eqj/a/RFDTbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IEy6gX1E54tYKMVt+/pn6UzBMR9fYGH8lxcr/rq1mA=;
 b=huVcGZHfyOqPql4Qm582Q4/es/2hqnwAdmlH9ELNZ3cjphc1onf+JuzB4FW83VUmz2dqR6oWOjXnEWbtCgQ/rnTlkYGmL60XccyHzQ8CxY/1Ft8htKJQB3zy69CJ2R4gkZUlVEiT+nC/10ViTsFhgE2u1VAYSmSOnMdaYJR3acVF9VhnsX52pAU7ZOKQ9unctDYHTnHn5AQ5mOJnv4Ik3Wo+RWqQt+h8zzs/jt8FsXu9IaUiaipWmBXDQ0T1sK7IfV2Dra+9KvfKwrnfMWo5UBApXDHI9QlPxMAF9fIQEs8wy8bJ7/+0nQdc6EBNh3PhB4yrTGCZrbhbLLe9WXnfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IEy6gX1E54tYKMVt+/pn6UzBMR9fYGH8lxcr/rq1mA=;
 b=x85ciIj7qrZ9p8G8Y8mQ4F9ogdNzneEiVWNCJSYd0r22IAh6JKTwG9BkX5kyCP6Y6GPSKy0bWcKAUqid8LD9m7csJw2HxZew/f6RnKCwIrpIx/965K1lNumle5ORkCWvJ0bbFAq+Wk2tZv3l1p9FqDJ2TlqvUWwtlhTO6WrB3SA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BN8PR04MB6354.namprd04.prod.outlook.com (2603:10b6:408:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 13:46:18 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:18 +0000
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
Subject: [PATCH blktrace 2/6] blktrace: add RWBS for WRITE ZEROES
Date: Tue, 24 Nov 2026 14:45:57 +0100
Message-ID: <20261124134602.153239-3-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: a16a4251-a41c-445c-d6ff-08df4a3150a7
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|23010399003|1800799024|376014|366016|261102123227099003|261021121427099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WmEq+WWI3O13fc8J7DK/zaLwggI3D9Sf+Iq8XEGnWm7jLXP8UKgrMR7w0aCJFlRWetJx+/yr02u6hlz7dTw7iYj9G6t0hVpcTWUkUU2u3HRD1A/HvBizfpWGF7ujcKhpywE2JmO0WHPaqRhtWoNeEV4U7Ozd7r4K1le7RZZv1Giw420pLrCfs1POKJrQHG412ZIscl8VJEIDs2S4E7hLfPKmRosnD514cnaslDdTVkWgkFruAOo3FKzO4vnfWBh2od8P+KveDOVy/xeZTtdk1uEB4KiiKMin5abzZxSap+bF+qHLwBweEB+ymupe5RWwAnElb9E5qcYzRolH/H3jDXXULXfFgBd2gAtFfXxOMm0M/DzqlY1jcdaVS0Zl6TtERu3pQt8aIcfHjH5hXWJweBFQqjQx6evSsoaDR5DPNrgy+UWgkjks4ezQ4adlv4Z2LSUgalbUqu4q/d9VxDaMIcW4SP5De5pBx3CNRd9882Jvc3jRLtK0q+V3oE/9tUr1Edc2bC5wWRVsTAbxw0+l9d73y14hSZiqeL/zkjNg5Jiq+X1RCsK3goe4s4rXVx7maqDx+GGJLIybS+vNL8yk9adzFAcvqjK2evbyxZ6h1R8gjC8BexFesbZc9jmFzT7lwdnRC4Nc/kpQobiA6yuqjBnWEaDXOLsRp8w+50gD2GY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261021121427099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3vq1J++H4RJT83pQ8y9QNSgDGPXvy1VeWig4UHaTSesXOkaddxEIeDiWBDG?=
 =?us-ascii?Q?6Uk/EfWPZm5CRP5AUCAmadkI/5hVT6OQBAC0b34Kaf8Zng4FYhtOz7Emr6Hk?=
 =?us-ascii?Q?56MhuXRJU1Y2kIfpWX47Hhs4VDlj6XzKjliFj3UXG1+yPE+Yr+0APDpIK4sc?=
 =?us-ascii?Q?jq5Lf0novGzxhREe0gGAmnjEKs1kEK8HaQnY4ABDaCeNBexUWW5wAjQP+2zS?=
 =?us-ascii?Q?Q7+se+adyHUoT9Aw3VB5l8dCT+uVA6jjAeBfR3aoN4Q0RGH8lCvvx+FRPUD3?=
 =?us-ascii?Q?g208+zSC/XbXWdZNTz9WE/yq0aIR9SXmKQOXaVDsiPMfA816Dj70UqgCAqea?=
 =?us-ascii?Q?ML1IxxoTiPNS/L8QHy28aHTdTOxKyJjJTbn1U141h5lTLtXAVBndztrcctWk?=
 =?us-ascii?Q?JEj6b1wHn53SfUcojZuInWrUAE0PZ0EVSpsfEsEUMDDDLDh9ycrSpWxiUR3e?=
 =?us-ascii?Q?iDmhLXzt0NvFwRI6PYl2POVO6Ud5lGJgKt2cKE1MAP2SOxDgK7j3dvCfInEj?=
 =?us-ascii?Q?l/o02e/DyB9Vv/YUL+g3CM41byVxxshlWy22QxJjqrzDkiHPePCFKb7Sewup?=
 =?us-ascii?Q?oRGqp8q1aVaviRshKkrJ7dC+cpb6e09t/dctrI50tbs5hOHwKyD6wGAwdC5L?=
 =?us-ascii?Q?kWEWXMSPd8gXvbgdeRBE8dEFu/RR1vGQCk0SpomuUCJRlcqfkgOCR9r7yBIK?=
 =?us-ascii?Q?xxFRQr5vqmlQZKDYSUDLKFHy9kwCIrwjHoYb0c/lxy3XrGq/HQoZhjRNJxzp?=
 =?us-ascii?Q?J6+bOFJKTfsQJCLbRlRGZxpZsxfMOIwF4Xj0BExlWkHWic5VKsEBH/dav7Ib?=
 =?us-ascii?Q?SL07/E95kP+d7yyTZI/sYbdLhx4k9Pbcfe52PEW4CkQcqVaH8aTHs2h3pFhA?=
 =?us-ascii?Q?OjTdFcEGLIyp0N0sJ+bB6rImZ6Qs3kBaSs+kFDLeu9ksIniWj4ZSaaDfL7iG?=
 =?us-ascii?Q?zgn1eRBNwBQcjBVJizIimVrIJCPdN6lFYRlmitpENFdGQ/9UQaxpDwoONga+?=
 =?us-ascii?Q?rDjnKMj8XwC9mfOdts7llmCwoyusugaE6J4IcQvnZWhqR6+xcmhIhQ1E45ln?=
 =?us-ascii?Q?0XkCNHrjGcMS7MgHRRySX+Vuyg8gJZT+fL74I31YRazHOWyRTtfk994Ftw4m?=
 =?us-ascii?Q?6ZqYvTk5e7EIpi2HuZ5Ef4y1UNxqzMVGA+HIMNAw1lXqlNswfeFHIQ6J6ZZU?=
 =?us-ascii?Q?7V3U5y/TN4tjIIBMBJdvtNpkwPItSZ7wJtFY7t9Ck4A9BKFY5G8GRCbfSKf5?=
 =?us-ascii?Q?rth6JG3neEvgpaOfl8QbJA3DeRRGVPFlMNjDZ5i6RrzL/NqH1BeXemjVLhGD?=
 =?us-ascii?Q?C0a6FkcrAifiRTR2NSIjv51gJkUlfGqzhbX4Ka5SVpoC3bITG7HXAzVQEv29?=
 =?us-ascii?Q?daIH130ajs+ZSjYZjdShjyeVKSYTCaNKQijNP5P5cE5jjXX9pk+btlTaMMpw?=
 =?us-ascii?Q?mOSQ8icXx5bPVNTKgyJU6d1UmWKcAL9mcdbeBtrX0qQyEjFewjLkk1JsXHHN?=
 =?us-ascii?Q?yk6BPqAN4DTvgrnE+gNyWvTQ/VPPQVd+cKPYWBNh8JpLe65Hd4dKbcz0VmX7?=
 =?us-ascii?Q?PRpyGUu1p3F1DySP6XTZwmPdxxU3gm2U0LGqfiYsZZJYesACcAv+nUFfsVCt?=
 =?us-ascii?Q?eeEWERuAK3AuVGnwkSwOsV2g1cN83/ZvorGNdDC48Q4NzGdv+LmJ/EEuMyIV?=
 =?us-ascii?Q?UZVo+FKINRtw8SiJO7ZN0nAG54haey5dFDvTrLI6joVEApmcf0GLy49nxQ6s?=
 =?us-ascii?Q?2dspNU/lcrDpR2BmeMXZp5PlDepOu8Ha9wLW3li/gb/9/DZ/swtQR55dXHnn?=
X-MS-Exchange-AntiSpam-MessageData-1: jcwO0VysIsvosHvKb9Iz6J6UFyB6plFGJvM=
X-Exchange-RoutingPolicyChecked:
	eILxDq+BCuK/0I4hf/hti7T+I51eQeUz2IlDfrPDMgd28MN9tS1Mb3ohjX8NoiOK8B3d9e+U8zBF7eTCNFJ2G11Hoa9h+2Lt0jrPrX72LpxqBQx4zlXWLhO3oFOA87ZnQMf5UkilozVJ4j/ajaEOwazeIEggjCB4DbFTNzWFhRksTuhIuW10f7PJOn+8gJyhyv8hKCMktBcZtmhNECTdz1UPAOaVCP4hB2bFa9w4PClAxPhbrc9021sAt1z+dSWvb2A/pueTbQurn8GcSF0dgkSbzEvx1TBQ2IoEOpV4Ztb/srWsskf+sDFknZcrNnwle9vq3Z04q2IXc403HROh2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cE4nt3KyXeYUv+Q/7SbambgWpFyoNgXVeDwWC16xQKKcTjqki7CDq9A1n4l0t2a9S/VHp1eXBgvtWXxAXQMt5jPe58gg2XFQ+myV5bsvI97Um4RX7olPLqaUMbvK0E0jFt1Hb9a8RPlTjBEhrb5zGmAlHoNRBqwp0qBxxvQAcCggme6igOhFiLZsek6SxS7StsT1ZYCjuBcpRFxJqzJAXU58JUQO0kaBdyT+CmNyF8kfHw8OcTkbhK9RZf9w+Dkt7OBGKhet/Nx01AOkcivIqoS8Fjx4kmqntvcT6yzurFgy51nLB7o+F5RkSelY2F3Sg3MnOibFWUfr1P77I1mrXZZX3mtt5trdwv9Q9uv766UrIRuBoMoim9JbzQhs53UMBL7lblwHmt8e7tbm0elUg7mqone46lh6RHE8mvlg5/M3qThCg/L7XoFR3bYTOEO8uM5uRhUI7XtnMadBVWwkATx/bRNWSqhbVjlIZDK03GQ16UA2C4ya+ryvuGAyHo2RXs6r0fB0oUS9o2wncwyZvAiZQ14SMBjBUDEABhr1R6YtvUHhsYkSQrng2PKqX3BYDWRrwTv9X9GJoz75G9Es0Pi+s1ZA1JJ/EbRFzX61AIEuzsuwU6Lb7pkbOWz/Acs7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16a4251-a41c-445c-d6ff-08df4a3150a7
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:17.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+5uFuybL4taoAW6grdJig+c7HgGv2iB+nRh6ZS//hP0aFVcLj7zocZyZLruOZirKZOLMQLbGcf9OqxhdAOYx6SmsrFEWdx28bklit5IOlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6354

Add RWBS value for WRITE ZEROES.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 06b055b..ef9f745 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -66,6 +66,7 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	bool zf = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_FINISH));
 	bool zo = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_OPEN));
 	bool zc = !!(t->action & BLK_TC_ACT(BLK_TC_ZONE_CLOSE));
+	bool wz = !!(t->action & BLK_TC_ACT(BLK_TC_WRITE_ZEROES));
 	int i = 0;
 
 	if (f)
@@ -92,6 +93,9 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	} else if (zc) {
 		rwbs[i++] = 'Z';
 		rwbs[i++] = 'C';
+	} else if (wz) {
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
 	} else if (w) {
 		rwbs[i++] = 'W';
 	} else if (t->bytes) {
-- 
2.56.1

