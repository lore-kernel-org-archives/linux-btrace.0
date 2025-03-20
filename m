Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6401E1A18
	for <linux-btrace@vger.kernel.org>; Thu, 20 Mar 2025 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435823; cv=none; b=Q4qcDUS8FPYyWln/tdyrPozS8/0nFoSMClM41YIfpFgCSiRUiDgYpWvDVKYSjAn+pSPwU5TSFahB9xY4wdNdLc0lHJDVtCdcruWP44dUzIdLtpJkgsR4xeXgrNPsvJpIUqCwmJiEGKy5/PORzg0LSn8OGP/nKapzChm+2u0CYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435823; c=relaxed/simple;
	bh=U1quFmViZ1zjDqXisjEHewnY2VY6BpLMayq/l4oqTHg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgKhoMm8r21yluOqXSMAY3Y/LkjShFdQn41LnloMr1y/5xp4zhlUK+xiVX2/fBd2ePAjJPvxAYnsDh5FP0fVYLKhZ6m/2Je4KMUh1Wdm6UoF7mBk5c19WE0Gn3m+G6sRJwrET1XX2mIy2nGCFiEtfvlqofN7wxY+szJF+lOhhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kYCVoKno; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kYCVoKno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742435809; bh=vjvEG18XDAIz+EDLs48ks7PMb/g2usP/52gWrQI87rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYCVoKnoRV/Vn+nqvQRuWBhkCL7WzLXsBG/ZZqwyqK3zNxoRu/Sikqg4p4xtYKl+C
	 TZ6lFGnO0nbsb88ounXQfMayolqq2gFZaUyR5GiH+fREbB9e4/NocFSRYtLpnNEn68
	 ul7T5rpeg2gwsBNae63iWWvEyOtFAF6DH1/ESYc4=
Received: from localhost.localdomain ([39.144.177.15])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id CA2B68DC; Thu, 20 Mar 2025 09:50:34 +0800
X-QQ-mid: xmsmtpt1742435434ts4qgwdfu
Message-ID: <tencent_D844947035F128017DDC0AA43ECF482BA808@qq.com>
X-QQ-XMAILINFO: MR7w4hg+gyTSk3ghCrmPx47NOWuYhKVkmjRolso5U7HIlG4Lu1cfoU/f2g/JMY
	 pjSGL3y+xfViFNtAi64/jdto91K3Fzpmnj+QiEf//C4iAW4+ZQY1/gimeH0y3HUzsLofb28W3oY9
	 fb/TQVfhD3Ftnrulm9lzpQ5RYtC0eQVzDdlTfl2hdQkxVskiq20WPr6vcvKojUK4/XfamBCQ5dnl
	 bMmPsjRXj1nddP9JEtWqrYDCKf+x/w7gJ9G77B+QHWgs13xWStJ+/keHpYgB0Ub0SrcN5UZtLJVF
	 v60rAL9FwO9tpQr78OeycbC6SUxnpSVu/pYDdFPnmhDx5xBv0Wh+uapSgPD/2lK1aHZFv0XLzgFm
	 T/nZc/n0Js8Ub9YiEprHloWN71P3Aor20mcUSMqtxrKWRAGRXl4eb7psTrsGRka0OSmvc8aAMeiV
	 XY9DZSspeNQ3+INkU8Cygz6K9xdOJj8EF94Mr18yjv2ar7hsg21YADciti6xIx4XRfsNrbdTi788
	 0sPbxKCd0lsTWxukgzW3luyp9BgUXTEKSV1IVqB1tOI0BnEKzGvQAlifQ1k6cbTSGBpLyrFFNC6n
	 tsl8j4USgu9g737gSrj2A4Jtxr8202abMnIYdowk9UHzyFqTs8uy/mcahS+UYWDsrx63+O8G95/Z
	 AmbKhRnNL1XLX4at2N0p539+Q1DwdigJz2C2/AwKsYdPKVIwGu1dHsUTKvE1pJWVssWhyvnGjAD/
	 j6rgPMJ51HMYVoMqJ90zltqOVAHZGfF2Q3nWRNuchI6L1Zejisi1iYtA74As3VPI0Kj4O7pSq123
	 ckXwkUpGzjdl+by74kFkZPmUCOJAL4JHTT1HvogYdkBRhQhwaG26rqIaOFH8dV9RJxJ26CTX8DYP
	 B2uJ9JMEQUQ19MI9CUHPlK+OgNcjAOdf1kmFI87OKuahc5W6dAUhvo+IgdcWJ3t4GvarBAoh3zf5
	 yVppwexTqYZWtiK1XYlPvhjkweIKKzWFwwwGQ/vwY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: 303146950@qq.com
To: axboe@kernel.dk
Cc: 303146950@qq.com,
	kouwenqi@kylinos.cn,
	linux-btrace@vger.kernel.org
Subject: Re: [PATCH v3] blkparse: Fix a potential coredump issue
Date: Thu, 20 Mar 2025 09:49:54 +0800
X-OQ-MSGID: <20250320014956.3311-1-303146950@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1962cea3-e413-441c-b98a-ded4a6a4fe68@kernel.dk>
References: <1962cea3-e413-441c-b98a-ded4a6a4fe68@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kou Wenqi <kouwenqi@kylinos.cn>

On 3/19/25 7:10 AM, axboe@kernel.dk wrote:
> Nit picking, but the idiomatic way would be to make it calloc(size, 1)
> not the other way around. The first one is the size, the 2nd one is the
> number of them.

Thank you for reviewing the patch!
I wanted to double-check the calloc usage
to ensure alignment with the project's conventions. 
The man page defines calloc as:
void *calloc(size_t nmemb, size_t size); 
where nmemb is the number of elements, and size is the size of each element.
In the submitted code, 
split = calloc(1, sizeof(*iot)) follows this order: nmemb=1 and size=sizeof(...). 
I also reviewed existing code in blktrace and saw consistent usage like calloc(1, size), 
which matches the man page’s parameter order.
Could you clarify if there’s a specific reason or project-specific idiom
for reversing the parameters (e.g., calloc(size, 1) instead)?
I’m happy to adjust it if there’s a stylistic preference or guideline I’ve overlooked.
Thanks again for your guidance!

-- 
Kou Wenqi

