Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820E43DEDA;
	Fri,  2 Oct 2026 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927630; cv=fail; b=jmwaYrtmNdWbVwuUws6qgzd+oLwhUPRCGYC7/fphjZ/PVLSEvDAHdS5gXeTlGdkIXyawK3DfsaFgb7x0K/6HwI/ZEGkD4lhUlujmC0cDfI99IvS9sOrw/A6ZobiVdrkFfvfVVI5IBxeM4Ak+YZeJCybnxai2nxBJL8q26ztvh9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927630; c=relaxed/simple;
	bh=oTP7cn/28mgf2WDuDOIyX7lv9N1oAuHWi1V7eHOkID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqabqmMJpoxyJGR+BkclD8BSPP4CyPgtIOADSc43/oCJdoS161oguTFfyffKoYVFarWGjoutuSyS5haPEkH+M248HkOghXsqwhIL+7e/f8ceOdttl2Rp/fuTTtG6trynzkTCqvGgtrhDq8ALdT108FyPqilsKZBIerJvH8sEsdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nlGwCQPy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Kq5C7LYm; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nlGwCQPy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kq5C7LYm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790927629; x=1822463629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oTP7cn/28mgf2WDuDOIyX7lv9N1oAuHWi1V7eHOkID4=;
  b=nlGwCQPyP/NbDbdS022jSGIZVx7ddX7RwxA5so0oSniVeqKiDz3HEIBD
   G4lBJEQb8bPjAbm7Xb34l4ntKZ4sArBHlgz9D7dvxsbMWX78mp0D3i8qg
   VhzRpcKz1p+U1P1Gk9qkZVe79OEd4yKRY+FgXUALG/mg7O8gJf5Q/y7P/
   y9W1WIbtZp1rGmqgWSLirlv6AL9lvEde/EPHY0T9TG4352FpxL3oLE1mf
   WVDhfEksMG9HFr8WnXf12rlQtNhkTgEVX6olUC0MjkAhiBsvxzFGvKMgK
   l477tEInmb9S1qy8Ue05eafPCx5rqx5YTpUE5E9Fhdxge01B8Hroej2n9
   w==;
X-CSE-ConnectionGUID: mfq6iaDmTTWbO7xN4DaLMw==
X-CSE-MsgGUID: kYWWCAlSQN+LjrzHfOh7XA==
X-IronPort-AV: E=Sophos;i="6.27,136,1786982400"; 
   d="scan'208";a="157115511"
Received: from mail-westus3azon11012041.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.41])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2026 15:53:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZboRaobNOwIEdC2SRDM4Iup/WaZEMtvR/KFnadSDtK2NX4U/YESFGlP+UrQE7cMqT2hq5QGXngVSeY5xZXqW7AAZqo2UFCZefYO14oH/XQmouHBrWNjE03Y+Dt3J7lMqdMoJIt6Aeu5TBoO7l6fMuZCnbokuiyaYVx8SH1OpHVaoeJfQT4jwD0I4LbLH+3Rv7VztFmrowXabSbvXGZrzXzUdqSlMbB6YSPYx8529tHBsqHAZod9v+b/3Ylyj3+TvrN0GREchlNq3kQBm/1PQZHaKrg7rE6xTC31fjAghO3TKRWQi5AjUhuI0CUhg6WewzZk0P6KZVupuqqVnwAnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxX6v4kNWwab4xEATamEmWVZx3KoSUSEWzJHDwvAzSA=;
 b=foMKNxMcz9L2HIHiqb8cyELgpCqhEqtp+16TAlnY/iM++2X5NZ3evbeVSKD8pUM13iY49sC6MY+qkjTsGUTcqCHWB7T4ftQQpgDXFtB5vxP42Ea9/NZS28gyqypmEkyXh60exWMZ34+7BDWbQi6/JKl/jzlUlffbqPe7Dqu08nawuwqkpxk+ms6NMx/vgSkEX6/ha+SUxAsAU6m0Tsxcq48FhOQkmUQQ9xNat+94lauJ1f3g4+snAxJvnD0bZZkp9w9g2jdRMuhysdezJp+++ZmaFoxe/JJs6bI5BrHkAn52TkmXyJ6F8pCxlNwjLxbXJIN4QoZRVg1xcw9/RWQWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxX6v4kNWwab4xEATamEmWVZx3KoSUSEWzJHDwvAzSA=;
 b=Kq5C7LYmYSKdxpjcjF4MzcLevaBbBcFAAPGhopstDHl0qlvxfyIlrkdC/mELyBOHtuj6dDH/woKVIZnflC2FLU7H6IifKma0qGkymaQAQcY0ugFf/sxZ77hpA7JDGbaLYUbVDUEtTFZ3jEDLV88CmsdoUpsBeMxJK6mTooFLXy0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB8309.namprd04.prod.outlook.com (2603:10b6:510:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:53:45 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 07:53:45 +0000
Date: Fri, 2 Oct 2026 09:53:34 +0200
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	linux-btrace@vger.kernel.org
Subject: Re: [PATCH v2 00/11] blktrace: parse blk_io_trace2 in btt and
 iowatcher
Message-ID: <ar9i3yI8WALfVpGj@mayhem.fritz.box>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
 <arPISNMA9LiFR8_w@mayhem.fritz.box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arPISNMA9LiFR8_w@mayhem.fritz.box>
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH0PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f099625-7555-4c6e-f4a5-08df205a48e1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|23010399003|366016|10070799003|11063799006|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TzTJCSVHNlYysFB7De6TzAQDSJOs75ZWlycViqWTvJGEvBmlFS2PNdK2g/kfJ9w8i26WHmwSR+PFHep87NQlDqsJ0elPeUYNWWRryYX0yfrEIsqBJKt4YU4MYRmqDRV+mmU4msuSGMRy6S6q2CLWwackFwQ31ixZNwVoed79f6pE7o/+54mTVBoRTt9sKEJseYAN42Zt48L18ie23hy+P4h4D8GBC6uvFN9sZhn5O5V8n3zVwNpnLu1Qdz9+ppZJYFRXbdb+skRGMPPlk0M2hVjGxH8eW3U7UQqU+NIfsW3b1D39HYLwfCxvsV6lryNvgcPG/jpsWTdnLF0c8Hy3qcYgwjlG2vUpIRQac4GJe5xLHYJORFV+hcDRdrBQzom50JpKWUhn1vToS6cJFmSgcnyGdebzXb3WgCjfF4FhbnhY1SL1HpcAj6j90miKFnC/7gqKLQXYkcBr2DnmgEA7zMVIUlmKNwtJt0uRfOgn4Adzge5RsPCkamScpjwRMG00mpBDonJP8xSQnpqmk13VbvjATqh1AC1DXSibzXqRd4CocSKyKWSjj2xZCGJ7A2F40uyTA7PpKjU6Lh/+qGNtcgT/VlxlLL64rfgCEblj4ij9QUVGksBmUTant9DKRmdm4XO++YNkTMyjiNKuiFGGINoP2eBqyfxW0DRo3mWTNAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(23010399003)(366016)(10070799003)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Olp2d5l74NNp1+XQEdbPdTsXpXYD3YpZGLwKGqLWjQbqnPB8htbO+jiZuxM?=
 =?us-ascii?Q?n24pRgKNaoNdTUDcfOAemFfduzl9dDxZAw+Dd8MkBOFX7d8Ql9naHkMaa4QZ?=
 =?us-ascii?Q?MhT19cDM5jPFE7IcZ2iiR4JzGT+j91oq2h+DoG3LbfPTTwR7oh68eEVuN4Fv?=
 =?us-ascii?Q?qpVCLWrGnxIZVnu3hsxmDxeQG9It/OA5H/VEE/gI02LRmZwbL+PWuuW3Ybdh?=
 =?us-ascii?Q?ACHKnskEhMAJvjWzrB/M4H7WPiBoeEeMj766wuvoANS/88KZsRuosjvJNakU?=
 =?us-ascii?Q?MPUf2ydbZLRAL98TuPt3z7BgrPulXyLr3JIkgFg4AynrrBC/X0SxgmF46b5M?=
 =?us-ascii?Q?q5pC7LyAn3QLaI536tIQRWPIhH9i1xMRC3Gx+F9XRRPRd12hmYRAzIqjlk6b?=
 =?us-ascii?Q?rHCrHbWBmdXkOnh4Y3LFJN5sc/MfOAsrBf4Fd3ONH/K8fqkDBfWOsrLRXZUI?=
 =?us-ascii?Q?Z9e9ANfNbyJYz/Soj7T+3vJ+gSGlsz3WDFNd52SQ+Sys9zhvC65T/J4JJTv7?=
 =?us-ascii?Q?rHeaWl6qomRqBI45utfvzgdOKve1ImyKgykcmNRrxJkUygxK9S0h0JX4/2hX?=
 =?us-ascii?Q?Dzj3a6I5KeOql3h+e4ZFbMtjOxn26uH8RABCUMz4y6QFf0sRyt2VSD2s6nGp?=
 =?us-ascii?Q?a96e18tvi6eO6phcVYq+4xVpuabjcILihHxw9B5WwkzE62D0PnTd48r6azxy?=
 =?us-ascii?Q?PdwiMdgyNiRuxP2acYqSKEpFrEJe3stVgD6p364ZoaO3KxkYQ5GnM2y+rDYw?=
 =?us-ascii?Q?YnRJ1M07gw6GwLh+MIRtqzYz5FizVRmsuYMi4TuGPRbmlCnqybxP9fDOHOb9?=
 =?us-ascii?Q?qWDSK4mkI4DSmv431/OwoKlfDrVlXmkB5fYXNz+zhC4NAvCNaFZ8uy4aOaup?=
 =?us-ascii?Q?LE8Ho/N+iByA9wqX44HHzC1qCrFHSJ50d7oW/S8WI3yNZ1siFDItw6q/5eo6?=
 =?us-ascii?Q?IoATLve4Dx471c8iVeG9n9Q6D+R42DgXTH7mXesYOpwKP/3mp0IWm9nRs/Ly?=
 =?us-ascii?Q?BP46b2tSZvESZM7s6KFuYtq9zR1x7DEh00sSb0NDcO4hRDWrd3FUH42wLBSA?=
 =?us-ascii?Q?UINFkJtka42YpIm5QRHDQoaysj6y7K9xagLzPLqzgPs8E47Ug6qTgNJHgy6s?=
 =?us-ascii?Q?j+686Xz85tb+qNvrSv3QG4jWaMj+J1tXk6K+vLlRSiZww1qIdUTz1OOYHCs2?=
 =?us-ascii?Q?fKMB5YYL711LsgJJdM+2evGvj6qakl3Y497BSP+gZZNTtHW0QE7msVfhavyW?=
 =?us-ascii?Q?cWct7GuyWtqQMLte56PecNiSK0iOOdRbzWTbIaXGbEONj1tGUx9JKsHCqSaK?=
 =?us-ascii?Q?jiQCuCx4KQ8IVKegBalU6+8iZTYefQyKcnCOhMoktIpL4Tp7zIBOJoYm+5Jm?=
 =?us-ascii?Q?eE1j/MhynCLKEkpatIHrio+FOPwVvMWR/ImU3Jdle18EA38VFHRPWQ5GkGwP?=
 =?us-ascii?Q?KdtdTF+HFGQcEr1DKX/dezlsdbgitzipeFv7dHbvODeQoowzihFdE0ZCWWDN?=
 =?us-ascii?Q?no9zAYAQVehhqPlqIOI3GGFKeJHI7C3FM6Q9kk9m8JW35xVGkoAsZO26K+KK?=
 =?us-ascii?Q?iWz9BgOxSCbIPSAjxXAymOUP6N4xTp8nKk0ctfJ/D5UzibXjYwQXE7WAHxXc?=
 =?us-ascii?Q?9NkjaWBNZ4A2DEkEeABJKbhyaXZ4QZ83IPDI7xvqG4KbiHwRjQk80t+pUvP1?=
 =?us-ascii?Q?kEO1CKD2GZ2SZod7smm5QACsuTHi4bYo5L9OyE0TDNlGNd+g65l/dzOqwrya?=
 =?us-ascii?Q?/fNgWpGTGPr/Jn0tLpxJuFBwHheHYgoFhCE6+2AlEt2WxlSSTr7yNXf4JODE?=
X-MS-Exchange-AntiSpam-MessageData-1: nke7yEFtPOFoZls7usVDEq76XiSR1coUbFo=
X-Exchange-RoutingPolicyChecked:
	1cTlE/trhle3tskGaiOKET1N6VkqrQdtRqwDx4okxUc5z2A4j62x/JeBXPvdxSww52ivgmqT0QHU3EO7rBvhPHfeifCK5URmVUCXl25LuEvuRR2WYdLBtJo0QklER3SHbPnkpAIOSexCGaG6ajlmjJxiifCV4MNpf89nrmWeLT9Lpdkv3vVcLrqvJvfSOci6Kbr0GSs1zHovDUY0EHNYXZ8QFoFifMMuhbTd7+wnHe4zosN1E68CBoQbF6vpawAL5sbn4MA0kDO+zRc/0UxPL4I+spNhT51BbLpJ6XrFV7VkXplSprEp8UnUNMFjVyw9UfIO5dy7CqDgCvulHCFWUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1EywInHg3nP5Wv/NU/9NmhbbrMpji8i6uTNmSP5ta7I2Mnjz7INGIJdN1ox7Edmcp9+sTl+VQJHr9fON5UG9uu3fSL+rQVJ9k4BBy4jO2iVK+4nHrvTAcR7CXFPPk1QO3IIUMnELinAZIBp5QRE6v2IY6Kx/YyHu+1UahZlp7snYwLefWcG769dtF+M80C+MMQGI6YDfR8H9RSQQuZvBPGLNORgbbPtAmbGtWWg+EOOHlse2u/wFw63tpqISB9ZoayOghYCUsB+FrJ5KyAX+9gGqZKDrBeqApS3Ch4puFsZKJgqZwYXnAE2FSDfrQEqiLSPaVa7bEZnaZ7Yhu/ergyQ6R5tHTCUgsA9Z82IiAyozazp9F5kiX1L/zS410dca67SdjjYPaNOOU1OwO8wwU/nsHX4Bnex4QgkQN1kjjRHpvtUyqGSr6bIDkX3N12dNzeKX3kj7pjx77x2k65cvdcwuquRdzjb3ZNjaOHKJYOiehWSFL5DbGiTVoFc0yLIW60dZgtfWxE7S8Vekfq6qEP3dEaUobx1kzqngpPUOko7hIGqfmadZQk5K2aCoREDdqIC3fS3UVc/gtWttCY3xQtdORDCrWGp8NRLsoOH0/9XHivnHHFn1IMC8LoRf782E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f099625-7555-4c6e-f4a5-08df205a48e1
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:53:45.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qRMmC1wVpq0JtzeX85Hjp0GGXTbVVYsjmmwzkfTOBjwGVEwGmNzz/6Y7+ptTwKul80NoIPbWZUyNZKAChLfhDDjSly5Jid5xGVD0tdm3GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8309

On Wed, Sep 23, 2026 at 02:38:59PM +0200, Johannes Thumshirn wrote:
> On Mon, Jul 20, 2026 at 01:14:06PM +0200, Johannes Thumshirn wrote:
> > We had an internal report that the new blktrace format does not work
> > with the btt tool.
> > 
> > This is because I simply forgot to update these tools. Do so now and
> > sorry for all the inconvenience it might have brought.
> 
> Jens, ping?
> 

Jens, is there anything else I need do to get this series merged?
