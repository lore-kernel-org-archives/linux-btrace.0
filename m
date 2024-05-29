Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED641509B4
	for <linux-btrace@vger.kernel.org>; Wed, 29 May 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005490; cv=none; b=WI6QAb3oYj1SfU6aO3Q+vzeuLE0q8HWWFxUzFkuDUsjn8RS+KNfVewM7lwkg9RxbJryUVWTBeI+XWI8YgW6d9XWTNwX1RVZW2l5Pgc0I+F7D14ulKUD+Mb0+mPTVOYqgmnYeKmtmk52jyMqgbhdlF5WdE2v+sJ2WcFQh6hrXl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005490; c=relaxed/simple;
	bh=LVzQL5C/6K1aqqIx3nJwJ0KdPBu1P1ULgahmuN5MmrM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Kspkm/Bl1VFJw694+KhJO6cDz0SQq2jcY0JAuzqFgodpDvXQx8Y2pqX11ZvH6FgP/ocwsVCslUunvV+tSCgQ6FplbATQjUM+DtQzumQ8L9XhuHaLEGuF593MeXzARK+Q84i5/R6gMwnC5i0usDaNya2OuIMYElokgQMNr9a26n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqAYf9CY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqAYf9CY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717005488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhJUaCeUirYASfRPpgIpKu976D5Tpqqu144siyKS1Xw=;
	b=FqAYf9CYwd7rDf99NFR6sniiCwIARQ2wZXTgJSe5ZBThHTJIIGFfaZ+688bR40+Lj7BlCx
	fEvhSAQgmgRraV/nrGwoi9/UjGqv8p3g/EtVabThAKR1K3HsLCq8/3YtdRMggroI6QkaJ3
	pH+qorrvm/l2o8iXg9IIXjKiK3hjZCU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-Wqw0Erl5ML2fX4lke97ToA-1; Wed,
 29 May 2024 13:55:22 -0400
X-MC-Unique: Wqw0Erl5ML2fX4lke97ToA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A135429AA384;
	Wed, 29 May 2024 17:55:22 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65542105480A;
	Wed, 29 May 2024 17:55:22 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>
Subject: Re: blktrace hangs with "-o -" if BLKTRACESETUP fails
References: <8a2252b0-2205-4e10-bc61-2aeb5faee81b@sandeen.net>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 29 May 2024 13:55:21 -0400
In-Reply-To: <8a2252b0-2205-4e10-bc61-2aeb5faee81b@sandeen.net> (Eric
	Sandeen's message of "Wed, 29 May 2024 12:00:24 -0500")
Message-ID: <x49h6eg5wqe.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Eric Sandeen <sandeen@sandeen.net> writes:

> I tried to sort through this, but got a bit lost. Possible solution at the
> end of the email.
>
> tl;dr: 
>
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
> when setup_buts() fails in run_tracers(), but I'm not sure if that's the
> right approach. Thoughts?

I think that looks ok.  I think we probably should also set 'done = 1' if
setup_tracer_devpaths() fails as well.

-Jeff

>
> Thanks,
> -Eric
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
> 						
> 				

