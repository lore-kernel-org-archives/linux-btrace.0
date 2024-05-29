Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1715A863
	for <linux-btrace@vger.kernel.org>; Wed, 29 May 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002360; cv=none; b=Gu4ZeZN856pVMo7Hwqj1Qa/ZfWSE2IFlnxIWFQe28wzFknGXsFig44a7UXk1e8nck0ZYEvYDjIQg0VKYwMeL6FIT0yZR3Mgdjs6tMYvACyCRL3qcH7NeeH4PH2L9dVTUFd0Svxq3SuWKuBAnf1LlGwhuMkxoCE2LriwcZihWsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002360; c=relaxed/simple;
	bh=6lpRXsejrAUhW0Zs7UMbjh+kuFMsvYgG4rZdzZemv3A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mKYEB4+dFstmTgJjMNS1OyKXBr5WQGpx4+JoHQ0qCwoSEOAk4eLF0S8kIxCwuOMQGFUa5G6hO93n8QgaJMKzD1nhjt/HAA1EDvX+gr3uRTemfSbuL6vLaH/Q9uTNx8zunpjnZReMkDszYjyzd4SqfoXNot4unmHYQnqLe7vAHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=xbXPAipp; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="xbXPAipp"
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id D343811656
	for <linux-btrace@vger.kernel.org>; Wed, 29 May 2024 12:00:24 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net D343811656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1717002024;
	bh=jHa3ZcHS0sgj3FKt+dO8/DpYHTFUSTupGG66uafbFM0=;
	h=Date:To:From:Subject:From;
	b=xbXPAippNXE2knWu4KQBGUvwWfFBcrmaKp21EtMJavUASUzTBzquACGnEs6nGiJ0C
	 /fQcLtPCE3UcTvBKp2XfyS9YnkYLEu0M2Qp8FkwHnhRav1wKFcUHliRMKdAI0iSy5v
	 ToDI/o1ayN2t9/OU+euiCqdS3UnYo+NY+CeXDkID32vqq+9hEy+CRrFB8o/XawPVTk
	 NfNoFUhv4p7Vr+DdJ/za/XyEWOWcC5F2GSpE/egGBGz4BXtleXvRclL2DipZDsZ4pD
	 pysiznh6K5mKtOCociPHx+C6n3uvLATzNU2YnIFkVFLD4OCD/AkG9YZrOre6aMqAGS
	 4gr109T8NpSSw==
Message-ID: <8a2252b0-2205-4e10-bc61-2aeb5faee81b@sandeen.net>
Date: Wed, 29 May 2024 12:00:24 -0500
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
Subject: blktrace hangs with "-o -" if BLKTRACESETUP fails
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I tried to sort through this, but got a bit lost. Possible solution at the
end of the email.

tl;dr: 

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
when setup_buts() fails in run_tracers(), but I'm not sure if that's the
right approach. Thoughts?

Thanks,
-Eric

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
						
				
