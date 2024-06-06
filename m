Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA212114
	for <linux-btrace@vger.kernel.org>; Thu,  6 Jun 2024 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717646860; cv=none; b=ufN0tdT9yu4xBZtw4j9QfDM7VZ6Z1u3/WEASkKcB/oR7ntOhjoLoVlWhtk83xPyThow/C/SLK+ByIdhu2trAUQHLlkCpZIOXWALWVP0tFpvqpUGHVM6wILtE971CP8uHNkOaFrlXRZMdjkgbIRrHmVG0SaGtYXLHjtNhBe40cnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717646860; c=relaxed/simple;
	bh=QpQpffiORs+rRMCPrpEyDhSrHbKUYJuS+Erj8apJISg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tnrZUrcheHsy3775QtIeAYbDXfjR+D/rsEa+HzwvcOrLeK1vtjnqjsrhk+7gq0VK1d5aRRXR7g5o+LJ1ZkRlNIbYsWpiU5+2v2XBkB8/j3r/CajTDZgM/wDm4BagEwZEpTLaHiqkHVj4jfdHXVdO9SJRYZnvUIXzmCDi/xKBW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJlfDN/Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJlfDN/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717646857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y9XBh9NKd0sQ5d+EgG8VZj1RpK8cG2IYiIwuud08jsw=;
	b=EJlfDN/ZhSNXJBl2lsqF5zRA294vEvFUKrCP+7Jlcg/GU/MpmTPRTunf8duoIGftlXTDx0
	MfGbC+dM6m3X7ou7TiHtuAbUf34WJ3osqJBLT4uHNTqkimQwU7Y5vI/x3mvZP+TdRHrsB+
	WzmofyOOaUigEIaUWhZEQoHu3ALaTeo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-JzO_1jBJNdK56qlxWkkyHA-1; Thu, 06 Jun 2024 00:07:30 -0400
X-MC-Unique: JzO_1jBJNdK56qlxWkkyHA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e261e3e1beso59118639f.3
        for <linux-btrace@vger.kernel.org>; Wed, 05 Jun 2024 21:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717646849; x=1718251649;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9XBh9NKd0sQ5d+EgG8VZj1RpK8cG2IYiIwuud08jsw=;
        b=tJW8sHpnRkcJmc+vH32GWqdEHjPdwJ+qYRjb/H+lH2PaJeFB+rHQTMMUAMgFBdqxrQ
         n4YqSwJRBYVGcNqHyXTQ52rlZxpKsX3SKcKVLQUDF2sgfnUZl8ZP4Cr8Afzi6R6Ntn+w
         qbpAysMcHCdj9t8zpm8OBwPdjJca4qAO97IVwTuEerN9x3KG7q58Ya8IuortD5QBRvIV
         ukgzzWN8zoWoFMc0hY9gnTk5XMj52iObZj23Hwpdu+1h3R9qB/6AyNRfDXowWyIxsdnz
         xNuKfbZFKZwqKa0lYPGGF2VdikmDvQ/NBxz41ZNOPAaTKGoAWuwlNhOgkKCwKwySk6Dz
         NChw==
X-Gm-Message-State: AOJu0YxyN+IMzbUkViINwuACk+LFDJsbLOR2Xkl8V1kZlL4LQuXncrdM
	+grNAJXly0OmGBYjZhz9zyhjeNIxq1bh4dJfinssmXMt/0vh8ksnFh2tnk0NRwyP1YJeDEAJnqh
	0qeOsHmNtPBGeyGEIJUUaQ2e4Db80+yQggyjkMfGMwhoq8C4srNHwJ4n/GTRTFljCNEzafi+4/4
	lmvCyZu40K5LIBv5GuZ+cAQIjFFcNih0Qt7DVbjx4c4JhF
X-Received: by 2002:a05:6602:13d0:b0:7e1:7b87:add3 with SMTP id ca18e2360f4ac-7eb3c00c65fmr514380339f.0.1717646849413;
        Wed, 05 Jun 2024 21:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC2LXhATDmZXd4b/rbAzEdnwnwRQ9nLxH4VVax9fPEGAjqFhTJe7KtrhPjcCRGLXFrzmkbnQ==
X-Received: by 2002:a05:6602:13d0:b0:7e1:7b87:add3 with SMTP id ca18e2360f4ac-7eb3c00c65fmr514378239f.0.1717646848875;
        Wed, 05 Jun 2024 21:07:28 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a23808c2sm121734173.113.2024.06.05.21.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 21:07:28 -0700 (PDT)
Message-ID: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com>
Date: Wed, 5 Jun 2024 23:07:27 -0500
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
Cc: axboe@kernel.dk
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fix hang when BLKTRACESETUP fails and "-o -" is used
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

# blktrace -o - /dev/sda /dev/sdb /dev/sdc

has to be SIGKILLed if BLKTRACESETUP fails for any or all of the devices
listed. (I simulated this by just catching one of the devices in
setup_buts(), skipping the ioctl, and doing ret++).

This seems to be because with "-o -" on the command line, use_tracer_devpaths()
sees piped_output set, so we call process_trace_bufs which ends up waiting on
(!done) and "done" is never set. i.e.

atexit(exit_tracing)
	wait_tracers
		if (use_tracer_devpaths()) // true because "-o -"
			process_trace_bufs
				while (wait_empty_entries())
					wait_empty_entries
						while (!done ... )
							<loop forever>

I think this can be avoided by just setting "done = 1" before returning
when setup_buts() fails in run_tracers().

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/blktrace.c b/blktrace.c
index 3444fbb..038b2cb 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -2684,8 +2684,10 @@ static int run_tracers(void)
 	if (net_mode == Net_client)
 		printf("blktrace: connecting to %s\n", hostname);
 
-	if (setup_buts())
+	if (setup_buts()) {
+		done = 1;
 		return 1;
+	}
 
 	if (use_tracer_devpaths()) {
 		if (setup_tracer_devpaths())

