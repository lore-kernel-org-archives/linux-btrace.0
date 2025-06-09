Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACD253B59
	for <linux-btrace@vger.kernel.org>; Mon,  9 Jun 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461277; cv=none; b=DWEmb3PK1gZJgPb/M/e1wzXcgkcxRxaN0Bavzjg2GYazhde91FbXcrLd6kx8SLUGgPrBfjgjPw1M9ngwxOjbRD+dqEMg5FPUpp/ONxXPPKwZY2YX0dk9MmBH5nvjHIQ7Pi5Oojz5t8ew4GUUNo5QHiuCldngjJzFWXXSCGskqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461277; c=relaxed/simple;
	bh=5w47D0gExdpYqAbpP/n7bg3Oqvw54nSIPJl7u7yDUfc=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=ap/OYpqBv0bQaf4OPTzlqOwnmeSbMaze5vQ3aheBhwspXe2WmTIKErM8l+62GCRMGn9cTnYP+290EBpjGHFKleSBNZte9sLPGpwX+TPM5PQiQDNc3dhor3ACSzIyDw/b1/csI/+BXt7b9x2wgmZLph8Qop0UsDGUI2bGAU7DnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rath.org; spf=pass smtp.mailfrom=rath.org; dkim=pass (2048-bit key) header.d=rath.org header.i=@rath.org header.b=Ej+bvFLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsTLKe+3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rath.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rath.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rath.org header.i=@rath.org header.b="Ej+bvFLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsTLKe+3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 849B1114027E
	for <linux-btrace@vger.kernel.org>; Mon,  9 Jun 2025 05:27:53 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-06.internal (MEProxy); Mon, 09 Jun 2025 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1749461273; x=1749547673; bh=kMILyjAixH
	G03RWQpHro6oTAJA2nH5SqdA25BNFouNA=; b=Ej+bvFLCyjpaOOuSjpTb0dKdoq
	HEzAX9pCdnHmmnOqk55oRjoWZHrw8g9cw/v+lMORqbofJjTNIlaOX/bKOcA1vsNZ
	sZqxLZ0AqbAQPzjZZPqfQfcUHP7WoaIrVdqW6WdqEqp0tElZp6Usj5FMaoIP+pmH
	8+TNuDZ+h2z11cwQquipGTRQzvIq6s2IF4ozDWVFHmH2Hqu9ZPhnzFCdBkLHGFHy
	z9BcRmiF2dauZDtX179d/WBud10Jp+6UVJjHVMCwNRJ4x83oS2NT5JCp6ZdewO6i
	nUrlj71VWAFjual5UExUMUdbUA42arg60BcMMDO8jbQR6oFcmXb9pUKHsf2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749461273; x=1749547673; bh=kMILyjAixHG03RWQpHro6oTAJA2nH5SqdA2
	5BNFouNA=; b=AsTLKe+37IbuwCt+dGKHTtbxMAXupItZ/JptxaTK96kyXlcwxJp
	0Zn89BrWYGRz2SenmElhd23a+iFDpkUZcumvDHVf7C+ANkb0djRL/TEa2p2FF4qw
	Hfbpm8MDXHTuM+Rzhl5ZpkAg9NlYr37ge4r66BmHS6nk/HGtSqWZTGN34V9ciMv9
	PNsfHZBBkh3sY0cTK5PNXHgvkArFNSA2AdOqG39WL3Z473deeHCURJlkHkdAcdSH
	R5gALHiP/kot+gDSEdFOhq+4iBpMFCPZvjuhkLeeQfDGkHHz1YMsH9j8lC1Xur3U
	kD5Lfgg+TJStnlttXAmA59aIgqpqS0R8lfg==
X-ME-Sender: <xms:GalGaOjM5ysDRZqnBhn3hXAPDGI87BvcqkmtFfJ-WpDnJ2ciPGP2Vw>
    <xme:GalGaPDKoFFUuaRIYg2xPfjrzBUSSj8N0DexzOX-L4DrzT-Bzlg4Vfe9C70WZLM_h
    Tkwx7f68DWloDqT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeludduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfpfhikhholhgruhhsucftrghthhdf
    uceonhhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrthhtvghrnheptefftd
    duudefgfefkeeiieefveegudfhjeehhfduvdfggeegtdehffeutdevvddunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhholhgruhhsse
    hrrghthhdrohhrghdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidqsghtrhgrtggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GalGaGFgamRZAocMthskCKsj7g_i_DFREmLxbuHkPwn_CBOpxjZJkg>
    <xmx:GalGaHSbMZBaaUlQn-D4PL023NTCGBC7s_SIkNOqwANLIaoHNFNEtg>
    <xmx:GalGaLws_RlRt7UwZkwqiYLnVcx_A3TvM5SGsm-urlEZYbsre4rxCQ>
    <xmx:GalGaF6QM03v_wKV-Wtdqu80knPGu5n42OHMj9Dy6cb7MRX6HO3K7A>
    <xmx:GalGaJ52Zurl1AsTYTVfIeVUSM8DzvoB0pYhuheaj5EBabeSeWGtJ8lF>
Feedback-ID: i53a843ae:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E56015C008B; Mon,  9 Jun 2025 05:27:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Jun 2025 10:27:32 +0100
From: "Nikolaus Rath" <nikolaus@rath.org>
To: linux-btrace@vger.kernel.org
Message-Id: <e87bbc4f-c82f-40b0-8b90-01cfea3a33ca@app.fastmail.com>
Subject: blkparse: identifying which request does not complete
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I am debugging an issue with a command that seems to be stuck hanging in kernel when doing a particular bit of I/O.

I've run blktrace on the devices that are being accessed, and noticed that for one of the devices the submitted and completed read requests don't agree:

# blkparse sdX.blktrace.0
[...]
Total (sdX):
 Reads Queued:       25872,   110096KiB  Writes Queued:          24,      108KiB
 Read Dispatches:    25872,   110096KiB  Write Dispatches:       24,      108KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    25871,   110092KiB  Writes Completed:       24,      108KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 IO unplugs:         25860               Timer unplugs:           0

This led me to suspect that the one outstanding request is the one that causes the command to hang. I then wanted to identify that request, so I ran:

# blkparse sdX.blktrace.0 -f "%a\t%s\t%p\t%C\t"
QRS	r	18579	zpool
GRS	r	18579	zpool
IRS	r	18579	zpool
DRS	r	426	kworker/29:1H
ARS	r	18571	zpool
QRS	r	18571	zpool
GRS	r	18571	zpool
IRS	r	18571	zpool
DRS	r	422	kworker/35:1H
[...]
And looked for a sequence number that was issued, but not completed. However, I found a large number of such sequence numbers, for example both 5530 and 8076:

PN 5530 18463 zpool
QR 5530 18463 zpool
PN 5530 19153 z_rd_int_5
QR 5530 19148 z_rd_int_0
IR 5530 18463 zpool
QR 5530 20637 z_rd_int_5
DR 8076 18463 zpool
GR 5530 18463 zpool
GR 5530 18463 zpool
PN 8076 18463 zpool
PN 8076 20595 z_rd_int_5
DR 8076 18463 zpool
DR 5530 20605 z_rd_int_1
GR 5530 18463 zpool
PN 8076 20165 z_rd_int_4
IR 8076 18463 zpool
GR 5530 18463 zpool
PN 5530 20632 z_rd_int_3

I would have expected there to be exactly one request without a "C" action (corresponding to the off-by-one difference in the total count), not many.

Did I misunderstand what I'm looking at? Or is the sequence id not the right number to identify a request?

Best,
-Nikolaus
