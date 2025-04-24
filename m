Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838F198A11
	for <linux-btrace@vger.kernel.org>; Thu, 24 Apr 2025 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474987; cv=none; b=gJzUOQe9UTUpdAtUxSaFLKDUb7F0DD7mPi5mF8h4RWsfJr7TmUugbZBX4QtxKe/13ZbUnXQd51z+cyvFzlSvddBvNXDkYizfufHVmAdP3r3MKAQaCdw6bP0iBPL/XrTfaJkpB9H7JJGSr1i7mUkpr7N71E0BpzUALLWYOC1vFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474987; c=relaxed/simple;
	bh=zsLo1eg4Lb7LA/ysZ5Gb0iVg6R+FCfoc89sJ62pcbvo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=WpCnLfDXamzrMQgOnhE7WJafWIBwpTy8UTU15gsmdJ82wlrOscpnmlYGNY72Ydtlos1Nv8SD8nyytouT9ZDMhXf0tNbMKZJ8MtoZKe5DvkyHpybaAuvPFiD1MoT8LBf6OoD+YaHv+TaIB/ZzGOB1fVZzClIANJi/KdxBfzkvp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2e3bf9c20d211f0a216b1d71e6e1362-20250424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fc98ded3-e8c4-42fa-8b5d-8ca947406323,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:6493067,CLOUDID:ddcc14afdcb2cc0ec43913fa1c90f317,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b2e3bf9c20d211f0a216b1d71e6e1362-20250424
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1775503968; Thu, 24 Apr 2025 14:09:36 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 4C3A7B804EBA;
	Thu, 24 Apr 2025 14:09:36 +0800 (CST)
X-ns-mid: postfix-6809D5A0-23445726
Received: from [172.30.70.131] (unknown [172.30.70.131])
	by node2.com.cn (NSMail) with ESMTPA id 2E827B80758A;
	Thu, 24 Apr 2025 06:09:35 +0000 (UTC)
Message-ID: <3c968e8e-6b6c-4dff-8313-5b6c73bd478c@kylinos.cn>
Date: Thu, 24 Apr 2025 14:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fanhui Meng <mengfanhui@kylinos.cn>
Subject: Re: [PATCH] btt: use millisecond output latency time
To: Jens Axboe <axboe@kernel.dk>, linux-btrace@vger.kernel.org
References: <20250423082729.520799-1-mengfanhui@kylinos.cn>
 <686a96ef-4fa8-4a0e-af9f-f33bff60071b@kernel.dk>
Content-Language: en-US
In-Reply-To: <686a96ef-4fa8-4a0e-af9f-f33bff60071b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/4/24 04:14, Jens Axboe wrote:
> On 4/23/25 2:27 AM, Fanhui Meng wrote:
>> Output latency time in milliseconds to increase readability.
>> as the normal time for IO requests is usually a few milliseconds.
>>
>> q2c.dat test output result:
>> 1.725317 0.292148
>> 1.725275 0.337183
>> 1.725326 0.288462
>> 1.725334 0.282350
>> 1.725342 0.276609
>> 2.039203 0.217158
>> 2.039463 0.123061
>> 2.039715 0.173856
>> 2.040144 0.184456
> 
> This will potentially break tooling. Maybe add a switch to change
> it to msec instead?
> 

Good suggestion, the switch has been added in new patch v2. Please review it. Thank you!
