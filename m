Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE213FEE
	for <linux-btrace@vger.kernel.org>; Thu, 30 Jan 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256114; cv=none; b=blLvXQX9p40bqpodOBG9wIPus6rt+ejUdL9XP8Jw2hb3yy1pdGc776t/b0BJvZfwK9ktQT90qhjvTdNQElwCJPfGrqQ+/YNzUUV0YqKiyoHVXLoyh/lNOqgjT8EbVw2AoqjLkLL5OhXQdodA8vaP0i0T838YCHYfiuU8mMphrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256114; c=relaxed/simple;
	bh=eTfWa9w0D7djCJJ9TzLnmvOddgvry73O80U6D+KVNII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qs/zMBk4kyM4y+iao/vyUgOm00br9QoxQCq2p62cUjnVNWp8eW4MVSOpAydYp1V7Wl3PQZfc9Nq+55g1PRZgii2WKlaHxVN3cKRjKKGzzlc3znDcBn/VUyo/iBExXkzWiKIQANFm/5emTUPRWCs87qEax03B9KvK8ArrhBKz3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HF54LXTZ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HF54LXTZ"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso71233739f.3
        for <linux-btrace@vger.kernel.org>; Thu, 30 Jan 2025 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738256110; x=1738860910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNI8G6mwomswWemQnq6UEEiyNpSOqOF240vbmuS0GzY=;
        b=HF54LXTZEGO1lxaDhAtljSFm8cKLWMW2pXFOFsZ/rNEMj+NtnkRJt1h9vOivVx/Ph6
         MEG+sGxECpCw0XQLqcQQIu/6MtkefLUPB3wZLr8eysCpsauHnKf9Q5nbwEK/SzvEMRBd
         LvbXvOeKGHPW28X7D8I9VQ/SEEJx5705SP802OPHmqLGdF3FVuyxa9/tdUc5f6as2Tf/
         OQDdRxbib/OgSe3XI8oksDbPlSMtPYihTmIU1PtwLkpzAuqeDnQ+Wmjxd4x/l7E4peaL
         qWzL0SvkFRT8kKrCvh26sMdjWbOkiHFzEx7+4m5g3FfWOuhc/N4v1uvWPJPUWz7ek66F
         9Sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738256110; x=1738860910;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNI8G6mwomswWemQnq6UEEiyNpSOqOF240vbmuS0GzY=;
        b=paT/ryvUFcIL5mU8qbd1tqe4l38QwcKI71O1E5GyqZUjuL4ozVL+Un/gIMvTlJ1nyB
         DBZWaPKM17MicrCIPvaDZBlkrYp1dGykTHxV9ibKMDRyRkWJySbOYsTvcLbyzwJN95E+
         SObmJGMC3aI4bAN0YE+NvM68KyFMmf9gpZ9qgBElqmT9KL2FMDpNwpO9noV0W120vBCL
         FNylGSut1AKc8eDnec86M7n6rZiUwhhk0r1Ghz9MEsWnuLQ07dGw7p1OwV6VVf3/rHs7
         2PgsMd8OgO40YCXdeTEOhr9uZtqa1jcOss7SboNBtqKyuwJ/6+woKfPm5LxWZ9M8D+sW
         Do5Q==
X-Gm-Message-State: AOJu0YxnaxJr2+ff/3UiuOhiY7PgzuPUR1Ikzqu6kfLZ+w0h7MZAzwQU
	/YJiUXsKDb7+oSPD7yBaKNXWqs7EhtSGc7a71qg6MOelAY/Yb58wfrcUn5PPdfoFG9OQO43oymc
	R
X-Gm-Gg: ASbGncubcY0o8HBXb0MDS4wI8zy2PLbqfyBo2l9jTyu6HgIGO2RzrWyJ53GTGr4p4GR
	MRjBHwwbaaPRZS4Jjm5QiTHYIdxLdvPJEV8Q4LFwYEOvvvvGyMW8FR1kWVu6eiNafbhshhfnC6p
	lG7oFg1rK8HeAjX5AuoNnlu0PcMYEyK1Lt2xvH963jKY1aV4eryV8o5BkGPvCIR122p6BFpY8TG
	I3pS/ERZ4D8hGbu23W8dn4gK6FMpjgP78H+CyV2HqwydUmDig6BKTEvNYNmKU/7YUjlAx9bdurq
	OwDPVg==
X-Google-Smtp-Source: AGHT+IHbvqRPzHvEO5PfEZCdhnEFGLfmea7/xIQv31SrPRVtraP+BgyhaBZGrb3B21Sg4K6RCd34fg==
X-Received: by 2002:a05:6602:1514:b0:84c:e8ce:b52e with SMTP id ca18e2360f4ac-85439fd6c6cmr670352339f.13.1738256110708;
        Thu, 30 Jan 2025 08:55:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a18407f9sm44614439f.42.2025.01.30.08.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:55:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrace@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
In-Reply-To: <20250128190544.113575-1-stefanha@redhat.com>
References: <20250128190544.113575-1-stefanha@redhat.com>
Subject: Re: [PATCH v2] doc: update RWBS descriptions
Message-Id: <173825610970.165401.9637974090807542624.b4-ty@kernel.dk>
Date: Thu, 30 Jan 2025 09:55:09 -0700
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 28 Jan 2025 14:05:44 -0500, Stefan Hajnoczi wrote:
> New RWBS flags have been added. Document them.
> 
> 

Applied, thanks!

[1/1] doc: update RWBS descriptions
      commit: 16b952f4ea2db052f7cc613474d15a76c91c93d2

Best regards,
-- 
Jens Axboe



