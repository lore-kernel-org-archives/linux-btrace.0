Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B438D308
	for <linux-btrace@vger.kernel.org>; Wed, 24 Jan 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075296; cv=fail; b=pCm/KQYmxSTZmexBDcxwoKiurRLuANUSZemkuvT9Asp96tAPp5YiTDJOTocvWbLK8BaPhow7nq1ILOa9ZP8uF4vE6yP32Xd017Wi6obXlFf5+P5Ha9dkSqQfIQDzfBm3MtVUzcDhXvyfrSarnxPS2mI//wl4OYijcg64HUeqDc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075296; c=relaxed/simple;
	bh=1nLP8UZmE8WGFLhU78iRw/e80ODv6xsX28MxNeLWhuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mJvmFrnDVehn/mp161XeVKdBA8AgHq/61dBSLI5fRnitLIVfDzDPKIx02G2uCM0MX9zxL1TKUSP13l8OOPH7vKoCzqjDAyLCgzE/s2bjtgETzxmXbHmc3m0EjCXpGI5h60RoiqmmjE8/KGtNVAM8qsPTY8Z8MqV9hO6tEoFDIec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=if6uTVK0; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="if6uTVK0"
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O4jg0L028784;
	Wed, 24 Jan 2024 05:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=nN5/WyKCYMCS+B2vyyL+ytVB9G3Cv/hII1Zs2Wjl5pQ=;
 b=if6uTVK0YTzVEPo3emhpmss4l2VLpisMOd8ew542bfc8WuegTCi/vsZC1qOScnWHyeGw
 g+ZdjXjE2OGpCsIoL/CKjw1HtvEqr+u7RWhRuu4Dg7v9WCKGkBAc8CcTP3etbCCYa6GO
 XK1k1J8+uKGr767yGnOib6jpSu18iysq49BuGEemLZIz8OQzosX+p50eJFWlJDJ+6iF1
 9ezzxlYSACm8zxRK1xaggTtULizD9aLtI8k7/IoRuR/poQz04jGlTJUvOvhKVht9MID0
 53gElIyysijh2Aec6R1QB6rzEVDo1ZkWLaxs6MwcwNwAHHI73WtokzklK4zZTJDKPpIx jg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vr7f4c1j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 05:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3Me+XPGmmS5/hZuxi6u69MACFgXO5hRDgBv3BUQMomAXMUArh/78UKJUl7LodNdAv53NE1kEhkpU94JTxPimSBO1WmfvIszG07nDBugdAZjGOpZJ0sSELvRLLktB+3ZG0fmPAe+yeDGyA4lQTkn7khO5b/rbw1tGE7hoPWbPzf5AOKR4TSTQyn3xvjTS7Nt7GxNKSg+ClKYjA5H16f27xrOBkGiTgIHP1wOgx143sCXdLgIKx8wBmQCHwVwLpxdD9OcPR854G1cLKBRxonoXh+H7v/ea6zSlVN7eWEzjm7Kvjh4pEaV9+lzRFn1ETTfMSnDgasYe/xQDXUCb3fEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN5/WyKCYMCS+B2vyyL+ytVB9G3Cv/hII1Zs2Wjl5pQ=;
 b=kYCeTcWU+pOCSuR35xFcqgkD745UTt5x1S2aHaSahJ1zoBHix49xUKk/flAIxxMaj2FOZ1myeUsa4dBsN3HOsaRjP8zq2jcHe0gk/rx1G3Mtx79zE0BiuFzbeZrzpyavcb3t2e3DZbxVejMPT+iJbjH0lu+2gCbvEZN+N3OZTjcX//ReTGelLhSwIrG3HZXOCNNmIP2XGu8W4EctfeFQPzandmdux7wG9TD7tma48dCT64Jc1w/+FJhsIXaXBRHaOTyc6yh9TQjfGrS+MTkc63FIOJG/t94thaSQdtCY7Pn2o/pJkItw/MopbXBFllV9XKuSVpwktVO1L1WBk1PfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com (2603:1096:400:32c::12)
 by JH0PR04MB7943.apcprd04.prod.outlook.com (2603:1096:990:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 05:47:59 +0000
Received: from TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::f1fa:1a16:1fa4:f961]) by TY0PR04MB6191.apcprd04.prod.outlook.com
 ([fe80::f1fa:1a16:1fa4:f961%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 05:47:59 +0000
From: "Friendy.Su@sony.com" <Friendy.Su@sony.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-btrace@vger.kernel.org"
	<linux-btrace@vger.kernel.org>
CC: "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Friendy.Su@sony.com"
	<Friendy.Su@sony.com>,
        "Shupeng.Fan@sony.com" <Shupeng.Fan@sony.com>
Subject: RE: [PATCH v1] blktrace: output the earliest block trace log firstly
Thread-Topic: [PATCH v1] blktrace: output the earliest block trace log firstly
Thread-Index: AQHaLAWc6UUF3TeDfk2ExkO9lfocgrDouI7g
Date: Wed, 24 Jan 2024 05:47:59 +0000
Message-ID: 
 <TY0PR04MB61910D973B932BD47C82C2BEFD7B2@TY0PR04MB6191.apcprd04.prod.outlook.com>
References: 
 <TYZPR04MB79360169FE3D4147B64F75998B8FA@TYZPR04MB7936.apcprd04.prod.outlook.com>
In-Reply-To: 
 <TYZPR04MB79360169FE3D4147B64F75998B8FA@TYZPR04MB7936.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6191:EE_|JH0PR04MB7943:EE_
x-ms-office365-filtering-correlation-id: 31cbabe1-fa6b-4caf-f433-08dc1ca0056e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /m0DlLHDP+MuRwnJ20mvhhdgakTJRKxs9ZNHL29QiN0N2RAHYMgkA2M2PvEC4oMxopmTBYvVQBxY8wuJ8ozDHLNJKCWFpkxCFIrwwFW9HBY21wHDWEB7HO+AlFUXcICChutjNrTIBOnbiF2iKGfxiVaVEy0AG1+bH+RAeZMqyNT/w8IOWYq4eZXmsv5Ar17gWY4UtDADdX7MGl8AnXHl5J0gX5U3ZlUxQu+wXyqk+Qtamf5JF8k6HlOMSANFExGljTL1mHOtQZ+j5Tt38yf1X2QAT361b+bhUFmEd1VciZv2RLfWZqaIRUZjHEoiBZPnua1oItThV8ru8LDQFF54LXA4iGIz2MMlfVNseIDR+ZXC9rk61xukYh7U9EXCmCndHAzHZ96yx3hUES5iNt2TLB3m1byPZDhgkDU8qVm+zQ/tAM9j9cP8+sckpMTsT0nRk2uR5xwcj7F/fcnBw6s7UCHK0iDQYAdjIRbIAIMqOuAIDwzYtOrpyvS9xpvWV87bbr9IeVVOI2Mi7l85EBrWic/Bxm3pAns4XJZpKbHApb7NOMBgnEv+hwyMDtZRtRdx3R9iKY3Xmy9DvIDxvNOO7GfiHnEP8KWgVY5qpkYXc4luSEQJpyxCZrl+5gQXD0AO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6191.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(7696005)(52536014)(9686003)(107886003)(38100700002)(122000001)(41300700001)(26005)(8936002)(8676002)(4326008)(5660300002)(2906002)(66446008)(6506007)(54906003)(66946007)(71200400001)(53546011)(478600001)(64756008)(110136005)(76116006)(66476007)(66556008)(316002)(38070700009)(82960400001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wrh3DoKaYgMZAk0jId6XyMXeG4s4Lj6VYFh6vvOqJofrfDwf57SWXhnkeIxF?=
 =?us-ascii?Q?CxXwu0dN7jz5HEFus4zJD+lbNv4me6L1KuuRqYu3xYlan5EDtwJOz10/YsNW?=
 =?us-ascii?Q?TqCtESh6A6A82Roit2l5QylUGTCwrgIsrZdbmMnj2pR2BcqeUBuH2o4ShDuZ?=
 =?us-ascii?Q?MlrU+oft4Ll8UCre+TEfLU0z7ZFSaIToUT352ZbQ2mEbWTlPJKuOtD5UVHza?=
 =?us-ascii?Q?tX6PaMIsRd4kdHOSN+X1cIDOE2pz1w8CykehgrIie8nnghEgXN4F5nhevl4r?=
 =?us-ascii?Q?XND4rfcuPXkHePlia4suQzB0y1FtAFKxDqfhDSEtPWjHHtAqiqk7OJuLBFWG?=
 =?us-ascii?Q?FsuLxtrKW/lKKWs+d/XAPh+pCQcRYGx6D/2mkjCl3z7FTsywgouS60vywyNT?=
 =?us-ascii?Q?9cSCW375iqEDx9T5W6iIRexv61YTx3jFu3F+ZwfksrHx3aVfdPg8ogVvYVAR?=
 =?us-ascii?Q?gBqApVWzSutYXxISHYfJS8rCgEVwkWvj40K5flZd92uV/WtdcpIStUIX/w9e?=
 =?us-ascii?Q?9vLULun1Kw1k/ZB7k7plqzUmsUsxlMCQT+9yyCGJ8dzYd3qdxVMfrpAO+EKK?=
 =?us-ascii?Q?AzcVeBg2T8wikL3idC/OoVFUZnhXyhMeWuEeWrkuzvwr8spusBTuOF688qb+?=
 =?us-ascii?Q?l+MVn4IwI/vsIt6rVQdWNd1mDcNglawjtzMmdYrjd9UVwD5lsrct4AC5PXCA?=
 =?us-ascii?Q?yl0Nq3S4IxgM5qcDpxKjP59hCKFTus8WhOe5e6YHRPnelIyIhWakzaxPpfK2?=
 =?us-ascii?Q?saq6JSiWm0hjUEO/eXa18arWzmxkSwhKoYQiqOoBPoufrUq6T08pJq+TsJBR?=
 =?us-ascii?Q?yo4CBfeWUO+asqkHyrV84/3slhoPbrKDGOnBGrbjuJqNhEaVizgVt4QQEyfM?=
 =?us-ascii?Q?oBCCx35+/wmSBKd/qxBa8lI+jT4kJtzQBpIUGbT1O4xUWc92TYBWEXFezhK0?=
 =?us-ascii?Q?SaRwzUUyIAAqJ4zLg4FrNqnQDtu8dJs2LLk2IXCtwfXIZFYLCb/szOxkW2y5?=
 =?us-ascii?Q?qcIhcqiXb4XtXew1PZ3WngYWAHvNFN4AKpdZI3NRJxVxh4NfCYzlX464KaEX?=
 =?us-ascii?Q?yBsi8pNKubNPdOWx1vGad7osZE9QhvEEbnjFR3NQQzH2CbOFrutj/G61WHWY?=
 =?us-ascii?Q?jPAplw2YL2fE4TcIG8jnY6K15gk93Ns0htTyQFsRQ7hXaeoxn2iqTvr778Uo?=
 =?us-ascii?Q?ozQNR18fp4JGcWLCYAp5BSDuOTdsco14uEhN4Od+ouiTgCyBsXCHYwKnnhPr?=
 =?us-ascii?Q?FJ35K2ImSVyNQZ6ioE47MTAmJ6CAnymP2faNBXCxVI/2ZXGYyW00GdDMjKg7?=
 =?us-ascii?Q?vYsX/3FRnBJlL1xoOjDfdVfrVebMbO6MnIRV84dPe5n/lYiq4lRD5jBbBbpC?=
 =?us-ascii?Q?5Vr7+a5qzJmOwqzCacbT9yRkuJIqFLSx4QK0RVBWB+aRGSjJI39tvCqR9/7n?=
 =?us-ascii?Q?c1uiM7itpuN/OBirE7/T65eVo5s2w3ltu0V3GmwQ17zrJvfeLGC3iGfvqDEC?=
 =?us-ascii?Q?kM2n6geRSQfRyUcmFqesheJhvT8RfiZZrQqOxQS+N7kS7puTEBV224xZ5J2i?=
 =?us-ascii?Q?yPm6jWycrR+hfjOhEaGh682fGcRosdaaPpjBP0cS?=
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	u1DFlSZNW/miwU7HxJQnCOBZ3UtOYxoPThu3Q+x3dsd8xqGYTejD7sxEobHxq4k+7S0ypVMDbA16//nphFcjxfnA+Vm5RaBUhAeDsff34FBfO9najvt1qUirV9ksqKrk6kh8eCd5BezmE+uY0YljScXh8eORE5PjErfGCeeAPCP1NQXP4lzgDtHpdxc7YT16j6z/78glnm3tuBR3c8NtzMMbUV+ieyKsaW0m3HZofGSS876xSoMtximfLqKHaqLKGRyWIRMWtA+Wi51YX55FY9dRE7gGRw1aPpxHk81tP7PYOeJIMkMXx1eK3JlAXVkXcgfyPgxtbSJyNuvujvXWGdc7vj+TcOF0jwgDD8Gaj7d0mWvqck/SajNKGFfOCIY38efm1m3bpptQ4Q0ZrfjkSfi56pYZ6gi5Yagd468tB8/sBYcjL2z6sUZtFCYjTDW3VdCTUdl7jc5HXsDpI0oPGctWfuRP6+xnByoE3zF4hq/iQnGQCWQbpFX7omY4VUbw4XGX2GqL1JS/jtpCZVm4phGxqEWBUCXiyqKaZIruPhTLarXOqa9o3RQj1vL7stCRTpIlWfzSorLDx/X3jYa1KrivqKwCOj2UIdEdR6HN0AvdECpEwamg8OyRDJLotgoY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6191.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cbabe1-fa6b-4caf-f433-08dc1ca0056e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 05:47:59.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1AiOrKqlroUtaH+m8lAvQHg9H++DQXX+8+TX3aGjNy8GI/CkeSQJAvOiDSgDl1Oi8UFw8AODzhekyTMf0mUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7943
X-Proofpoint-GUID: x60iG1JmPny1IKOQ1El4XZbezXXc0sTY
X-Proofpoint-ORIG-GUID: x60iG1JmPny1IKOQ1El4XZbezXXc0sTY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: x60iG1JmPny1IKOQ1El4XZbezXXc0sTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02

Hi, Maintainer,

Is there any feedback for this patch?

-----Original Message-----
From: Fan, Shupeng (Contractors) <Shupeng.Fan@sony.com>=20
Sent: Monday, December 11, 2023 3:44 PM
To: linux-btrace@vger.kernel.org
Cc: Su, Friendy <Friendy.Su@sony.com>; Fan, Shupeng (Contractors) <Shupeng.=
Fan@sony.com>; Aoyama, Wataru (SGC) <Wataru.Aoyama@sony.com>
Subject: [PATCH v1] blktrace: output the earliest block trace log firstly

Fix the problem of huge timestamps under pipe mode.

root@target:~# blktrace -d /dev/mmcblk1 -o - | blkparse -i - -o blkparse.lo=
g
root@target:~# grep 1266874889 blkparse.log

179,96   1        1 1266874889.702689491  3871  A  WS 2080 + 1 <- (179,97) =
32
179,96   1        2 1266874889.702693491  3871  Q  WS 2080 + 1 [mkdir]
179,96   1        3 1266874889.702734116  3871  G  WS 2080 + 1 [mkdir]
179,96   1        4 1266874889.702736616  3871  P   N [mkdir]
179,96   1        5 1266874889.702742991  3871  A  WS 3872 + 1 <- (179,97) =
1824
179,96   1        6 1266874889.702743491  3871  Q  WS 3872 + 1 [mkdir]
......
179,96   1      206 1266874889.706598366   114  D  WS 5728 + 64 [kworker/1:=
1H]
179,96   1      207 1266874889.706626741    15  C  WS 2080 + 1 [0]
179,96   1      208 1266874889.707723741    15  C  WS 3872 + 1 [0]

blktrace creates each cpu specific thread to read trace log from kernel,
then pipe out to blkparse. blkparse treats the smallest timestamp in the
1st batch of logs got from pipe as the genesis_time. All other logs's
timestamp will minus genesis_time to show as relative time.

However, the genesis_time obtained from the smallest timestamp in the 1st
batch of logs may not the earliest. Assume there are 4 CPUs, blktrace
launches 4 threads, each thread read one CPU buffer from kernel to a
independent list. blktrace main thread checks each CPU's list in a loop,
once there are available logs, pipe out.

Due to the scheduling of 4 read threads and main thread, there are 2 risks
that blkparse can not obtain the earliest timestamp as genesis_time.

1. the earliest log kernel filled CPU buffer may not earliest read by
   blktrace.

E.g.
1st: kernel CPU#1 buffer is filled -> log_1 (log_1 is earliest)
2nd: kernel CPU#0 buffer is filled -> log_0
3rd: blktrace CPU#0 thread is scheduled, log_0 is read
4th: blktrace main thread is scheduled, log_0 is read and piped out
5th: blkparse read log_0 from pipe, treat:
     log_0->timestamp =3D genesis_time,
     then dump out log_0 to stdout
6th: blktrace CPU#1 thread is scheduled, log_1 is read
7th: blktrace main thread is scheduled, log_1 is read and piped out
8th: blkparse read log_1 from pipe, calculate:
     (relative timestamp =3D log_1->timestamp - genesis_time) (negative)
     dump out the negative timestamp

2. the earliest log blktrace read to list may not 1st piped out.

E.g.
1st: blktrace main thread is scheduled, read from CPU#0 buffer firstly.
2nd: at this moment, CPU#2 thread read log_2 (earliest), CPU#1 thread read
     log_1.
3rd: blktrace main thread read CPU#1 buffer. log_1 is piped out.
4th: blkparse read log_1, treat log_1->timestamp =3D genensis,
     then dump out log_1.
5th: blktrace main thread read CPU#2 buffer. log_2 is piped out.
6th: blkparse read log_2, relative timestamp becomes negative.

This patch makes when any blktrace read thread obtained the 1st valid
block trace log, all other read thread will be read kernel CPU buffer at
least once. This guarantees the trace logs in any CPU buffer be obtained,
then sorted the earliest. blktrace main thread will pipe out the earliest
trace log firstly.

Signed-off-by: shupeng-fan <Shupeng.Fan@sony.com>
Signed-off-by: friendy-su <friendy.su@sony.com>
---
 blktrace.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/blktrace.c b/blktrace.c
index 3444fbb..d530a3e 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -298,6 +298,17 @@ static LIST_HEAD(tracers);
=20
 static volatile int done;
=20
+/*
+ * guarantee the earliest block trace log piped output first.
+ * blkparse treats the smallest timestamp in 1st batch of logs as genesis.
+ */
+static pthread_mutex_t earliest_blk_trace_mutex =3D PTHREAD_MUTEX_INITIALI=
ZER;
+static pthread_key_t self_done_read;
+static volatile int done_read_cpu_num;
+static volatile int earliest_blk_trace_cpu =3D -1;
+static volatile unsigned long long earliest_blk_trace_time =3D -1ULL;
+static int earliest_blk_trace_out;
+
 /*
  * tracer threads add entries, the main thread takes them off and processe=
s
  * them. These protect the dp_entries variable.
@@ -1245,6 +1256,80 @@ static int wait_empty_entries(void)
 	return !done;
 }
=20
+/*
+ * Screen the trace log. Once any thread read a valid block trace log from
+ * kernel, starts to count thread number of read() executed, record the
+ * earliest timestamp and cpu which got it.
+ */
+static void screen_earliest_blk_trace(struct trace_buf *tbp)
+{
+	int off, t_len, *is_done;
+	struct blk_io_trace *bit;
+
+	/*
+	 * read() got a valid log
+	 */
+	if (tbp->len > 0) {
+		is_done =3D (int *)pthread_getspecific(self_done_read);
+		/*
+		 * if this thread has not read valid block trace log, check this log,
+		 * otherwise do nothing.
+		 */
+		if (*is_done =3D=3D 0) {
+			/*
+			 * track the trace log buffer until the 1st block trace log
+			 */
+			off =3D 0;
+			while (off + (int)sizeof(*bit) <=3D tbp->len) {
+				bit =3D (struct blk_io_trace *)(tbp->buf + off);
+				t_len =3D sizeof(*bit) + bit->pdu_len;
+				if (off + t_len > tbp->len)
+					break;
+				if ((bit->action & BLK_TC_ACT(BLK_TC_NOTIFY)) =3D=3D 0 ||
+					(bit->action & ~__BLK_TN_CGROUP) =3D=3D BLK_TN_MESSAGE) {
+
+					pthread_mutex_lock(&earliest_blk_trace_mutex);
+					/*
+					 * it's a block trace log. if its timestamp is smaller than
+					 * current earliest, update the earliest.
+					 */
+					if (bit->time < earliest_blk_trace_time) {
+						earliest_blk_trace_time =3D bit->time;
+						earliest_blk_trace_cpu =3D (int)bit->cpu;
+						done_read_cpu_num++;
+						*is_done =3D 1;
+					}
+					pthread_mutex_unlock(&earliest_blk_trace_mutex);
+
+					/*
+					 * in one buffer, first is always earliest,
+					 * no need check more
+					 */
+					break;
+				}
+				off +=3D t_len;
+			}
+		}
+	/*
+	 * read() did not got log or error
+	 */
+	} else {
+		pthread_mutex_lock(&earliest_blk_trace_mutex);
+		/*
+		 * if this thread is the 1st read() after block trace got by another
+		 * thread, set self thread read done and count global done_read_cpu_num.
+		 */
+		if (done_read_cpu_num !=3D 0) {
+			is_done =3D (int *)pthread_getspecific(self_done_read);
+			if (*is_done =3D=3D 0) {
+				*is_done =3D 1;
+				done_read_cpu_num++;
+			}
+		}
+		pthread_mutex_unlock(&earliest_blk_trace_mutex);
+	}
+}
+
 static int add_devpath(char *path)
 {
 	int fd;
@@ -1450,10 +1535,34 @@ static void __process_trace_bufs(void)
 				continue;
 			}
=20
-			list_replace_init(&hd->head, &list);
-			pthread_mutex_unlock(&hd->mutex);
+			/*
+			 * earliest blk trace should be output firstly. blkparse will use
+			 * the smallest timestamp in the 1st batch of trace logs as genesis.
+			 */
+			if (earliest_blk_trace_out =3D=3D 0) {
+				/*
+				 * if all cpu has done read() after a valid blk trace log got,
+				 * earliest_blk_trace_cpu is exact cpu got earliest log, start
+				 * pipe out log from this cpu.
+				 */
+				if (done_read_cpu_num =3D=3D max_cpus &&
+					earliest_blk_trace_cpu =3D=3D cpu) {
=20
-			handled +=3D handle_list(hd, &list);
+					list_replace_init(&hd->head, &list);
+					pthread_mutex_unlock(&hd->mutex);
+
+					handled +=3D handle_list(hd, &list);
+					earliest_blk_trace_out =3D 1;
+				} else {
+					pthread_mutex_unlock(&hd->mutex);
+					continue;
+				}
+			} else {
+				list_replace_init(&hd->head, &list);
+				pthread_mutex_unlock(&hd->mutex);
+
+				handled +=3D handle_list(hd, &list);
+			}
 		}
 	}
=20
@@ -1805,6 +1914,12 @@ static int handle_pfds_entries(struct tracer *tp, in=
t nevs, int force_read)
 	for (i =3D 0; i < ndevs; i++, pfd++, iop++) {
 		if (pfd->revents & POLLIN || force_read) {
 			tbp->len =3D read(iop->ifd, tbp->buf, buf_size);
+			/*
+			 * screen the earliest blk trace log
+			 * update earliest cpu, timestamp
+			 */
+			screen_earliest_blk_trace(tbp);
+
 			if (tbp->len > 0) {
 				pdc_dr_update(iop->dpp, tp->cpu, tbp->len);
 				add_trace_buf(iop->dpp, tp->cpu, &tbp);
@@ -1837,7 +1952,9 @@ static void *thread_main(void *arg)
 {
 	int ret, ndone, to_val;
 	struct tracer *tp =3D arg;
+	int is_read_done =3D 0;
=20
+	pthread_setspecific(self_done_read, &is_read_done);
 	ret =3D lock_on_cpu(tp->cpu);
 	if (ret)
 		goto err;
@@ -1927,6 +2044,7 @@ static void start_tracers(void)
 	struct list_head *p;
 	size_t alloc_size =3D CPU_ALLOC_SIZE(max_cpus);
=20
+	pthread_key_create(&self_done_read, NULL);
 	for (cpu =3D 0; cpu < max_cpus; cpu++) {
 		if (!CPU_ISSET_S(cpu, alloc_size, online_cpus)) {
 			/*
--=20
2.17.1
