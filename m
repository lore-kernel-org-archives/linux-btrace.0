Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57709328B71
	for <linux-btrace@vger.kernel.org>; Fri,  2 Oct 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951143; cv=none; b=txTd6UuBrwRtjfM5eTEGQ6DElngxYl7+Vr9YG35p68488+NNe/QqPSyNTRVDgxb93ChgVrRgakaNruqea+bCj0P+bPrWf2RbkuxjCM3QKjIrbU8nQAjlTtsfSqoA5d8saJrhJq8iLiRZiJZDYl1Uh6n+LhIaQp9n15lbAeGml+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951143; c=relaxed/simple;
	bh=Ohp/QHsDmFh+DylqIS74grqU08piWPEjnIyZ5Wsszn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g0kfBPH9TJxBrPbnEulf2G0DK7KF9Rnzft0ybqwjVl7/rliiTrBtcAFuN3iV2wJeLgOxIbHlKuQ7gCuoyVEwgSh4qzl56lWtJ3bdxu5+Dn2ofCkOm/443u0x+eExgCYqsax+NvuF5RnirVFPbJpD1J9jYiuibExbMs8TWjk2/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=So3X0h6f; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="So3X0h6f"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so4867426a34.0
        for <linux-btrace@vger.kernel.org>; Fri, 02 Oct 2026 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790951140; x=1791555940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jw8IU+S0kg+UTErQSW7dh4lYfl8wngrkl9OOAXPXsT0=;
        b=So3X0h6flQfaKKSAZ/X+XEtI4W/Bz3ehOdtBYJvx5eQr86xUgYc9803M0R3ikxFRe5
         WvYtaA3tss4nK/hDbiFXlFUsRBmoQ0Jh/mMs0HdVnONUwNXUaZW2QaycVG/VqcHvJwE5
         36aYFLreyY+Ym96YlgP240b4tzpRUbXRs+MUHKqu0HfYAiXhmJf4jkzW37H81rc5Lr4N
         fFzVgGfak36lxwt9foodHTEoz4GJQTe3jLDSaxv+o/re1OC0JdLa1syeaRaK8lNVZVoL
         ZajoQjb57lNyQa1zEYyfQ834Pnr2cCTR8mNMFdfJnMehZdmagTf9F6SODHO2q5PyWCZB
         adqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951140; x=1791555940;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jw8IU+S0kg+UTErQSW7dh4lYfl8wngrkl9OOAXPXsT0=;
        b=rpJ+YW2HxC0v6Mb2mzAjrXZJRqJuFCsO6qi8JwdU3xNLb0Ce+u/HKsEDtrocaqd1gs
         fS7GqusHkdzHgRv6EjR2FmOo3LN1DJlgYsi0U8jNCK6w/0KuwiGXI7hwDSdxGQgVSxU7
         P4QT9mQcY7s0xgHI8qfXkMEn+WJjA23jQNvOjUhwfbRw0SfCbT1NqSgJ2EgbCrxZxDRS
         RATgVMHexthtSgdHuIMHiKPgkvEadpOaBPqfJ6UwlONnun1GuA6Ju4p6AXFmzNUT78h0
         x2cli3zTKx3iY2OQTmaDs8XsBTgvsRuKZ+Zmj2jEL/R6Kui/ilyz1M4bQz2qjAWoZvkR
         fIQA==
X-Forwarded-Encrypted: i=1; AKwUvBwijvLFBQ2ak0wUAztZFq5ND5SWB+ZLbCwp04WEhrIewaY8278lnhVgArtQHoD2hcgBgTiNy3V/CdeoDzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nM7w7mFTBypblHCc+iAQv/H+yH54ZfVpKLdPKaQUQZpqobqLUB
	rADRGI4n8cTlLukWVGGuBeD0rjgSzXtrdQxUxjRtmUq7xa9zCSS/0WDQ88aGOQGdbu0=
X-Gm-Gg: AYBFou3pwHxEbaHKAidfkbGLEGpkSjmdv0ltRaUTJKV8bT9G5jGvRD51fnuMziGKZMX
	ImLlZyn6ZRrDDvhMjcxX9NbqT7qG0zimPPNGHcP55TzOOfqjkCRChX9R1axEge6ckqhU0Upyipc
	z052p28M3yMoCnCTsNzVOdbQ2cL4qFstTJGGz5UBKXEsQphOvhgJwBAyFQyyW76R6oDvQQWE5Bo
	KlASSUePfI6GsusW5T3xy/pPK6re3G0Batkomj5aAqXUxgmQMxdAzHeU3uiwj3sJQoQzMi9v49K
	KumrX4SM1Gpmhsl7KiWWG9X2s9bzssaofv+pwbz97mnzPwD/GchcNt/tOmhCzBgveO3wwaHed7q
	2mn74PFlAdUDlYY0jrTr2vE2Xfm12uaf7oQFwCWlGSl6NzG1Ek00tEMTYqJCOtunBV1ABMgukD1
	iswQLAzzVeBk+gRl8gFL9PLxuleIYjyyUBrQrZowJQ23opflP6mEXmToz92jaVKqEXuvJa0XUEL
	YlkxcFkaqQ5d+DNSE+0YTYfkZZaEBYkPYN+QD9JNW4fyHmMwGPRhQo=
X-Received: by 2002:a05:6830:270e:b0:815:cdb4:4a7 with SMTP id 46e09a7af769-82281b72cdbmr2695305a34.3.1790951140228;
        Fri, 02 Oct 2026 07:25:40 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-822792a1b6bsm2970566a34.5.2026.10.02.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:25:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 linux-btrace@vger.kernel.org
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 00/11] blktrace: parse blk_io_trace2 in btt and
 iowatcher
Message-Id: <179095113917.28522.1401186462565976436.b4-ty@b4>
Date: Fri, 02 Oct 2026 08:25:39 -0600
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 13:14:06 +0200, Johannes Thumshirn wrote:
> We had an internal report that the new blktrace format does not work
> with the btt tool.
> 
> This is because I simply forgot to update these tools. Do so now and
> sorry for all the inconvenience it might have brought.
> 
> Johannes Thumshirn (11):
>   btt: use blk_io_trace2 internally
>   btt: natively parse blk_io_trace2
>   blktrace: add option to request a specific trace protocol version
>   blkrawverify: use blk_io_trace2 internally
>   blkrawverify: natively parse blk_io_trace2
>   blkiomon: use blk_io_trace2 internally
>   blkiomon: natively parse blk_io_trace2
>   iowatcher: use blk_io_trace2 internally
>   iowatcher: natively parse blk_io_trace2
>   btreplay: support blk_io_trace2 in btrecord
>   blkparse: add option to emit a specific trace protocol version
> 
> [...]

Applied, thanks!

[01/11] btt: use blk_io_trace2 internally
        commit: 99d239becf12afe328a262ed9473a255a9d517f9
[02/11] btt: natively parse blk_io_trace2
        commit: 30ee0821473d64959a134cfb857248f8e4b8a131
[03/11] blktrace: add option to request a specific trace protocol version
        commit: 950f297e790fac0b85737ed5fba03fcc55df5a91
[04/11] blkrawverify: use blk_io_trace2 internally
        commit: 5d12335aece2c8a207438b1d27071854fd1f5c88
[05/11] blkrawverify: natively parse blk_io_trace2
        commit: 05d921fab95b43c2f3e2f9c4a020d3a72d2c9ca5
[06/11] blkiomon: use blk_io_trace2 internally
        commit: c5d11505bba6f000176485d1d694f7d668618e7e
[07/11] blkiomon: natively parse blk_io_trace2
        commit: 838bc02d9cff5f85ca8453980a7f610799a3c22d
[08/11] iowatcher: use blk_io_trace2 internally
        commit: 65378ab2fe0f3e0130562fad72789c94288c961b
[09/11] iowatcher: natively parse blk_io_trace2
        commit: 4cd8158ed9a8495fc8b5151f3288ed690d36acf5
[10/11] btreplay: support blk_io_trace2 in btrecord
        commit: f7c1738a9a2463d01ec2072a70f0d444228f9144
[11/11] blkparse: add option to emit a specific trace protocol version
        commit: bf32369c515f09aae6cdcc5d9a40fdc3597693d1

Best regards,
-- 
Jens Axboe



