Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58D1957FE
	for <linux-btrace@vger.kernel.org>; Thu,  6 Jun 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673536; cv=none; b=ti3vVORAjSZZA6/Ck5TeTYix+9QUtUFCVZxFDNuvG9FYqb4CCARVrRMbFxhpZ3LkfUGTBwtWXuzU8V9bX+QDYSXh1ssUtD56qCWjQodQwWXCMx5akzLV3RZICHoZeSR6Z4f7PX46baXOkToafpTQc1+2j71R4UDS5VzgDA5s0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673536; c=relaxed/simple;
	bh=lMKtx60saIUScgrDa3jf12YcqBab7rbbdemee+PhLLs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hKLDODKtWUBVznJ2yUh86qpZh+L5eGLP5E9sW4Zev50eCjgC5K8W9XjA4F8KeoFYwb0WXTop/kfi1GB8kVO6cmdmFbeOmxbxXN1dg/zRn3MD7RE158ALLjYj9Bq1GvocS71qbJwb2jRNp4Vu79/pTr5vgwjoRKv60Vg0TgV0lfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FT9dta2J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT9dta2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717673533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zGekQtfhhGXP3lZglF3cD9NwSOD8mr+PNPUlUtfpz4=;
	b=FT9dta2JoqL58y8KTvKm2bEKiM+Yeg3GzJ0r8yNPy5HzkuDth/Z3yf+WN+NACYhoyKBEEb
	LWJgP57Y0up2qaBLZT+FcTZZiqI73ECPREtBvf/IVWjrI3vi5r6qPJ+aQ8OZaLbvnWYm1M
	VHallvs6+1suwywf3h6MZJbPCOWKLsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-SAnl4yldN5WNW9VHOp6DqA-1; Thu, 06 Jun 2024 07:32:12 -0400
X-MC-Unique: SAnl4yldN5WNW9VHOp6DqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA204800074;
	Thu,  6 Jun 2024 11:32:11 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.8.173])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62BC5492BF2;
	Thu,  6 Jun 2024 11:32:11 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
  axboe@kernel.dk
Subject: Re: [PATCH] fix hang when BLKTRACESETUP fails and "-o -" is used
References: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 06 Jun 2024 07:32:10 -0400
In-Reply-To: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com> (Eric Sandeen's
	message of "Wed, 5 Jun 2024 23:07:27 -0500")
Message-ID: <x49sexqz4qt.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi, Eric,

This looks like a repost?  I mentioned that we should also set done = 1
for a failed setup_tracer_devpaths() call, and I was hoping you'd
include that in a new version (or at least comment on whether you
thought it was a good idea).  Sorry if that wasn't clear!

The change here looks good to me.

-Jeff

Eric Sandeen <sandeen@redhat.com> writes:

> # blktrace -o - /dev/sda /dev/sdb /dev/sdc
>
> has to be SIGKILLed if BLKTRACESETUP fails for any or all of the devices
> listed. (I simulated this by just catching one of the devices in
> setup_buts(), skipping the ioctl, and doing ret++).
>
> This seems to be because with "-o -" on the command line, use_tracer_devpaths()
> sees piped_output set, so we call process_trace_bufs which ends up waiting on
> (!done) and "done" is never set. i.e.
>
> atexit(exit_tracing)
> 	wait_tracers
> 		if (use_tracer_devpaths()) // true because "-o -"
> 			process_trace_bufs
> 				while (wait_empty_entries())
> 					wait_empty_entries
> 						while (!done ... )
> 							<loop forever>
>
> I think this can be avoided by just setting "done = 1" before returning
> when setup_buts() fails in run_tracers().
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>
> diff --git a/blktrace.c b/blktrace.c
> index 3444fbb..038b2cb 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -2684,8 +2684,10 @@ static int run_tracers(void)
>  	if (net_mode == Net_client)
>  		printf("blktrace: connecting to %s\n", hostname);
>  
> -	if (setup_buts())
> +	if (setup_buts()) {
> +		done = 1;
>  		return 1;
> +	}
>  
>  	if (use_tracer_devpaths()) {
>  		if (setup_tracer_devpaths())

