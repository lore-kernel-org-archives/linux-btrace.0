Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527990;
	b=T+AT4bGQv3+M1xS8Z+avoY+rSft/zW+sMO7g4aVR+h5GKF1fci/fDk4vmMytmtIkdK3M
	 VXx+jwsY6ORVwqXVt2+vfR2gwEYDhonyga284BHYHB+p3hD2JYiD4Fw+scAmNUNk/IE0Q
	 rWkV0Lqxf4Fw2TfRL2TV2zgJDCHthpHxplKmuhpzMNvIrjnfL/luk6SPPnjIKYMYXCoKt
	 Jwbg+MjOWm5pH02wEwTKGusJ1EPhYWwoLbGh4/5ttmr/Rb5DnNnwKOUuYpijcLfB3hYXR
	 uRo5FlRaQ/QDVaS0SGHm7I8uM4ut+W6xvw/y/oFf9sZi3q3VN14CIkGFsOMnj7lD1BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527990;
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
	bh=fvoQw3chxhIFfusLCnJshBKDdHzjKJeV6OS8+YxVHWM=;
	b=UsEyw2bzdhBLLvua6wqcmGpYeXxM+1TIdw3BCkz0M7hv5EJZ/YF+VR70TZ50cd+JCRB7
	 R8vnLWCM/UxBInhnHQM63DMnhPvPf0w3WYxyBV2lpUM/y9Xnk5YcmK5qHDMIfWjIgAzOZ
	 SOUXg8z22h61MOTiSopIT3rjwkAyRpMbLTk1PgAPbhluR40O2xJ7mvaupD0CWc14fg+pn
	 XaSC8z4VvAouiHaEcx/OJDVOnFAaKJjGiPQ/rer4k0Uoej1foYmpcZSbvSqSRxcdDunY+
	 r0JsnP3AnrupEXiKiabeXFMM15oFRtlofefPwdK8ida0rHEYGIRNTxI92e/P/FHYCNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=OD00LRll;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tirqx6om;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B0606A322;
	Tue, 24 Nov 2026 13:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC2B0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=OD00LRll;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tirqx6om
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527989; x=1827063989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5S49Muzqt4bhifjeV1IjTYjct1veI7QKPhyM2TVSV1U=;
  b=OD00LRlltcCnm9Ian1NR9QrKn1jVZ/Ko0RI6i+guJqhjMJBXOSuYjNph
   v8he7vXs6d5i8xqYWHBm8JwkoqNFX5YE8jiVMiORloEToN/3+J2J4l7ac
   zFpmV+DRGE6IccqVsy1zAVjyyXRA+NbnqLq54aBzY04ZM9x9BpToW8pWs
   V/avNZRHiLYs3SxTv5ZKsY21H68WI8QLSd240J/Lj3Oi5M02an+Pd8QqP
   tUo1xibEQPdFaddsYO0rD9D093q12OdNh3NFyCJJHrW7/2ZfC+ey/v54/
   PIKGorjeqOosGT8GVdR4oTDYPrCcYGbiEvff4VkDEWmluEn0N7eTGjpFz
   w==;
X-CSE-ConnectionGUID: HSBWTtLoQEKCyvp4ij4xFg==
X-CSE-MsgGUID: llkJPhirQTe5IlT4+LdcdQ==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161650783"
Received: from mail-eastus2azon11010043.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.43])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:46:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+T71sDdKA5V7t1BxwbfTNNumhP0bA4LfgaKajulz4xhjp6x1o1KpGoqU1t+HPNCahVLcbiqPxPrfN8FvYvkUpUGJrUpl8HOyYmwIzNYA0NlNrBMPaH01FzWZg0Kw+kOOI2zk22U7s64UfcvvfjrgnBlrh/OqQX7Fmz9efupePo8nJbZklxiERdJhEGPiTVPsy8j8eF44wlBGSncz4il6+lJ2RgHsL10T2J/hNS9Q0NZiHOpQHk+bmKl762jzm5yUF3RjR065/LPHx/zVwmNXEAK3oKoxHxBm+01z8gonKLEk39GbiYe9pCjJ/ULYrRkRziyFzmSmLVzISB3c3EKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvoQw3chxhIFfusLCnJshBKDdHzjKJeV6OS8+YxVHWM=;
 b=KAE7oYhrFrY2wgw0/QQz1hxZZbhuBoeWM/MDKC9apSU5tIEEnNS0HZ0YqkWuRxm1KasVLNY92NTFw+YCrXjm1vXbrVovciGqotbL+azHOSB/Fi5OgeR+JaSgRquJqJ2D0pz46X9/Y4j6HZDHYser4L8JSBD7AUiodRCj0xr6ngrNyaG31orf/+6RuQMUzFfy7sLeMjF+knlrsvOzq4R7KVOiq8kV4Wt3vK1Gd/IYJGvVUgFYzYmvXvMLfoRELlWQE597H21hmSnpvoO/IrritRj5yZkAy6tde0ccIX1HwBiTrVzFmsTPPyyinvK12xNcSYZDzjI+QdVhXto34vGmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvoQw3chxhIFfusLCnJshBKDdHzjKJeV6OS8+YxVHWM=;
 b=tirqx6om7fqOMjIoorSpjxo9702m37YeUuipZZk8LERgsM0GcsVYflHpFuLH/CXaT4YgOkjlLYeYcV0MeIkd0rm9nT4zhau0knsIZD7K4arHt5z13esRACwdMOcoTaMsLXCN0I0bjvq6uj93IlRUUSSVL+gC5wQvzRLzPn69Szk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:46:26 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:46:26 +0000
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
Subject: [PATCH blktrace 6/6] blkparse: print I/O priorities
Date: Tue, 24 Nov 2026 14:46:01 +0100
Message-ID: <20261124134602.153239-7-johannes.thumshirn@wdc.com>
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BL4PR04MB993740:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa56fd6-9c95-4f5e-361b-08df4a3155fd
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261009223027099003|261022075727099003|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gAAtq3JZFQM2eNzqXmhKGHopT9XeqGlIEWC14wDFLprS/EkbSnq+s1xij2n5RgK2ruQYUf+NtOwke5HtNWkApHIdB0PO2wxkwTJggroAVCbhkphAmdSM6yusz1aFgaACqDJE1ruI/bnBXStU4B037T5/yPdagsb1h/Z3ICQNVt66tMDB2ZLPmC8hcU5a+2yROySX2vISVG/gQ9zIkulJ6RGHW58MevbtP2FvJj2U3J8Nb19ZJyxcehIEITLhdrge1zSMkTiclJ14AujBDaEMaDfbq+nnkzY2g0zs/y388d7fegLsIJqyNck7qNJ8Misxw7hosb2xQED5jPRbMDHQ7KDO1JrIE4pHuVZKutikqe9aUm1/EJ46Ne58XyYDIL4zdSzxJWf7GgaoVTVWMZLGTSGE7C1dhHvnrgR7bIre5soCEIp3wnBl45Uo3pKEoMSLFi6DCaqP/lmCE4mVpO0oB1piitnbkFfZespbDkGAK109/1xuiPcKCF6JpciXZWL1v1joy9Qzgs72jbSq6XA+kPoA57E66NmIGFg5GBuO9zXX5mM/8D+fSEPt21myRk+NjQRCuyCbNAgzy8i0xqfrp/POfpYErZurnCdvFdpMMDfZrGWdcdcOv2+F5QUmQFi3YTZA2tTP8hs37QaReFRHc+uSRA3zYzb2vuTLJIeUbqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(261022075727099003)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwaCJ7egYn5gF909Vm6SCGn49AXtXXy4lsxT8KIK5Otw7ncyAHeyVwv73/YK?=
 =?us-ascii?Q?OU90YftVpX+ZOfbdYM6TAVipXDe/CDw/ijy7cO+W86gw3sB3uIlKXFqO1XD7?=
 =?us-ascii?Q?rA10aHgasaH0r5yqy8EVG7XDNQs37q/rXXNnQ9n8A6qIfkK6kA8aErA5sx07?=
 =?us-ascii?Q?i63Xcg2HWGIfjBxJqgt/G8CfYEI6UUwTtZEzAc+v9FKZACsLoSPfYbfMXvQe?=
 =?us-ascii?Q?VFFvVgXe3KCQfTCTfNJUcyvDKznAfxg9c9hybbeQnYLn/Y/dUbqJ0816TD/N?=
 =?us-ascii?Q?huC3lLrKK58jpvrseYlrHdseOFNxZYe1mEnpeurtT4Haawt8jfmWarOC0xga?=
 =?us-ascii?Q?j6NudFB1o73GkLLphJzCiy1u50Xr/Daq6nG5JyvgPm/H7TgMldRlWTy42EB6?=
 =?us-ascii?Q?SGXI5I/C9/1+HEUc0AHBj9Sv7mHtFzxvJOHL7hVPv4zEfOo4YuY+Oe4MR+/l?=
 =?us-ascii?Q?k9R+b+dIK20GQBFI527ty0KhPN/iHLyKq9LjoCgeVood1G9dE7G/Ij9rpUS4?=
 =?us-ascii?Q?7t89fMHl+UgJh/5Vo2vph8r1pobwDJBP1vPVzmyBc5qEhJit/w6aKNTIUL4u?=
 =?us-ascii?Q?MGlbDKkh3NESpY4LAKef59ZktG0glQPfHpjYCZ3eXWPH11Q4fb0Ha1uiSucF?=
 =?us-ascii?Q?nYl4sfEoNtJH7RiE+C2o2BUA3kE7gba/gWnFYCw8cueCnC8Ka63edfZQfdE2?=
 =?us-ascii?Q?3HJS4+G41KIcc/IVy5Y1zWYHgzIG+fD/0BzZ7oAU+8CpU3bQeNaUJSzCPj+K?=
 =?us-ascii?Q?BxH4t3nU3f4wCTuTMJri5sdqGl6x1jAwkhwcVJbZmxue1RtkfEne7zk2N9s/?=
 =?us-ascii?Q?xxpEnzWWL+FLOqj1Pc7XEIxRVrqG0wvkLGIYKsHTLnEbSKzKH95yTCbI8Cj0?=
 =?us-ascii?Q?gldNkG2xZcvV/21lSdeqHfOh5qDp9hLp3f/J8yYauKwa7F7eBQSnhL88wrHl?=
 =?us-ascii?Q?fVfvf9sI5POk4+W7tjAif4sgRDPpLumghU7Nv350CyxnaZwizyh+fJWazOrV?=
 =?us-ascii?Q?1lox2zn9iODtxr9d6N+znNoVv5ApKaWixlJVH+HdTOcYbuYQSYPB/gdjL7uA?=
 =?us-ascii?Q?ux9GKO+xPQkmQQ3ye++qu8dghJyVUeN8UNttvBrAQtE6PJXNG/X43S0GlJ52?=
 =?us-ascii?Q?bTMl80dQyWj4RvQgB2qojcyaSc1aJuEsVpPNVvQYlAM4ARUUTXHeMmx8RCYM?=
 =?us-ascii?Q?E5XE7Uw8ilt+hm4/vEbzwnGS4LUO9KD/ClaZtD99Eeujf07FaF6KHoFmdfIm?=
 =?us-ascii?Q?LQTXEuT3p5Dv0zoLXRzoZ9Yt1g3CF0e8BaJd35Mnqv1Ebf9AHxAkxXI+x2mE?=
 =?us-ascii?Q?ve2hQGRlnmDMcX2Nmm/41PqdpRbABX+0wFP/qxtwxW/LIoewOda3+S/QusGi?=
 =?us-ascii?Q?wPuZRWxfKA92SFdc52mBBZSxSpXy6MQXONNxnKYxblZbRjoz/xzIkksO+zlc?=
 =?us-ascii?Q?9Q6Uncs7oEFsq9xtBA3OIH8ktnMz51rXYbSxw5Drm6I9/052NyigPHyEv/iX?=
 =?us-ascii?Q?cEHOQzJsD5nOR1HbY1XQb3ukdatN0e+GsCyL/j/1aYGT07SjQuJCF3enJDoI?=
 =?us-ascii?Q?UIsWktS2YS4tYXAV0SgBgytIMoIEk0QG+sg8BzK1SdS8qujBkl5OtKYrNUhi?=
 =?us-ascii?Q?WjWSHZZ8xdHGTJnNo4YEPyK41LW0e33cRBswIG8YXDr5K51VawQHLlkaLwiL?=
 =?us-ascii?Q?O2a2+8SIqeoZffXoY1WTj1weRjuhhJ988W5FcsgZ3Wr5ThajwJIHv+BvGXdG?=
 =?us-ascii?Q?31zU7Ob8O91d8GNMbfWa/vB6dCyJYbLlUrGTNRjtuwMZCqrfBtlDSRMXi2TD?=
X-MS-Exchange-AntiSpam-MessageData-1: R3Na8WDXpJUp4aKa5pBOAATNfMC/c5a7RJ4=
X-Exchange-RoutingPolicyChecked:
	WUiJBF1TGO2Avi69g8dr5ztxA6xkZ3rZhett28NcXAXnG7TTd1yLdz8p0yvydYcMYaglvVuioHeYcgZr9vGPTgh6QkkYF3XrynO4Uv/bILYyZdtInGJfF5USb5huPkN1ZrRrn11pPHNaNIHLaUouig3n/L8dNd7ADID4XTyQTLV6Io+1+uxvzsnADR16nWzB2svz45+BtW3Ng78UuSMv2OEvlWO5jlD/6Tg3dtiKtnIIl3/iPKNRfgCPJ0BIwMfgYBxUKVCsgzUShcd6rLFFqCT/DpRs0LKD4Cc9oD1lE5aTyvRI/sWf0zfbc0gFf4wgKOCTm9IHnhsW1s+gkJV0sQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DLVB+BHJrD6p268/jM3IgvipHh/RGi0+IBv0vuin/FkkNXhFczhBrINOF8DKPjhpviKS64qVX7sZYRlOAzEoxuFdTVKLc2dfmztBUTW7UPu07WG/C8zX2fRiCT42RRK8pQYJfJldRkbbg++a3cOhuCEi+UNpt8G/3JY4IXM6pwuKiWGQs5g2H32OmZHkCyjRA79ZLxlXwqX40HiHE12LVO3Z/IQxOMqWGCbcKoTc3YR0tGMFEDFsZMjoiiLksdl+b/Sbp7uQMsZx4ajuTEAL1rgoOqbyudgJBPhLHQ+cJVTj3/2CluLoZhMCv6Npaxs248F4xMW1jN7g1pD4aKmb3VING8ZrG6aiaDd4xQcsPQ4Ty2E8I+qEpq6qjtguv7DwVL+93dH68bM877Hj/ge9OmVJQtEu8IeZKvfoWOsK35jvH/7Dllc6zAAmTtMkWTLS8/yful+atYuBWaOk7EOjVk+1htYo2NQ1bTn7lvy80E94WpGyA+PXVaePSHX/I8qcZCZhksklWPdUC5uD9kaw0E4SER8tqehUdoqn6I3CjaAQSRtQ5krp2OnQT26Cw4fwkfdEqLgM5njPpOs5WcxzAz7yf8vpwza1egLW5nlXBebncMQqBDqKc4Fxaawv57fs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa56fd6-9c95-4f5e-361b-08df4a3155fd
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:46:26.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6adn7ZC7bHYtARcZ46tm9AEJ8fnUX/+SJItvE8F28LHF1VNE9ZML73nz+p1HFJ0PhprFPZcaWPlqa++pDfZDKApC1DkLMhnoxQVve2ff7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

Add the %i format specifier which prints the I/O priority of an event as
"class,hint,level", in the same format as the kernel's block tracepoints,
or "-" if the event does not carry an I/O priority. Events with an I/O
priority also show it after the RWBS field in the default output, so the
default output of traces without I/O priorities does not change.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse_fmt.c | 33 +++++++++++++++++++++++++++++++++
 doc/blkparse.1 |  7 +++++++
 2 files changed, 40 insertions(+)

diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index ef9f745..67345b1 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -16,6 +16,10 @@
 
 #define HEADER		"%D %2c %8s %5T.%9t %5p %2a %3d "
 
+#define IOPRIO_CLASS(ioprio)	(((ioprio) >> 13) & 0x7)
+#define IOPRIO_HINT(ioprio)	(((ioprio) >> 3) & 0x3ff)
+#define IOPRIO_LEVEL(ioprio)	((ioprio) & 0x7)
+
 static char *override_format[256];
 
 static inline int valid_spec(int spec)
@@ -116,6 +120,29 @@ static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 	rwbs[i] = '\0';
 }
 
+static const char *ioprio_class_str(unsigned int class)
+{
+	static const char * const names[] = { "none", "rt", "be", "idle" };
+
+	if (class < sizeof(names) / sizeof(names[0]))
+		return names[class];
+	return "invalid";
+}
+
+static const char *ioprio_str(struct blk_io_trace2 *t)
+{
+	static char iopbuff[128];
+
+	if (!(t->action & __BLK_TA_IOPRIO))
+		return "-";
+
+	snprintf(iopbuff, sizeof(iopbuff), "%s,%u,%u",
+		 ioprio_class_str(IOPRIO_CLASS(t->ioprio)),
+		 IOPRIO_HINT(t->ioprio), IOPRIO_LEVEL(t->ioprio));
+
+	return iopbuff;
+}
+
 static const char *
 print_time(unsigned long long timestamp)
 {
@@ -298,6 +325,9 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	case 'z':
 		fprintf(ofp, strcat(format, "s"), print_time(t->time));
 		break;
+	case 'i':
+		fprintf(ofp, strcat(format, "s"), ioprio_str(t));
+		break;
 	default:
 		fprintf(ofp,strcat(format, "c"), field);
 		break;
@@ -373,6 +403,9 @@ static void process_default(char *act, struct per_cpu_info *pci,
 		(int) SECONDS(t->time), (unsigned long) NANO_SECONDS(t->time),
 		t->pid, act, rwbs);
 
+	if (t->action & __BLK_TA_IOPRIO)
+		fprintf(ofp, "%s ", ioprio_str(t));
+
 	name = find_process_name(t->pid);
 
 	switch (act[0]) {
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index 80e7019..b17035f 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -343,6 +343,13 @@ Error value
 Cgroup identifier of the cgroup that generated the IO. Note that this requires
 appropriate kernel support (kernel version at least 4.14).
 
+.IP \fBi\fR 4
+I/O priority as \fIclass,hint,level\fR (for example \fIbe,3,4\fR), or
+\fI-\fR if the event carries no I/O priority. The hint is the SCSI/ATA
+command duration limit (CDL) descriptor index for hints 1 to 7. This
+requires a trace recorded with \fBblktrace \-\-ioprio\fR. Such events
+also show the I/O priority after the RWBS field in the default output.
+
 .IP \fBm\fR 4
 Minor number of event's device.
 
-- 
2.56.1

