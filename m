Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B31F868C
	for <linux-btrace@vger.kernel.org>; Tue, 21 Jan 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495956; cv=none; b=UHUZIXebJSSj1WQxxCWPJrsyOBerEQIqzlzkz6SBm9U5CgnXZhSS+/TU60Oib4wdCnnas1XtwykR3JpmiVLznXf5vGczZm1L/P8KaqkE1jthcflKddhXxz51TrZa5WlSM2bz+E3psgL9WgLBkLGxaUSqVSlMxQHLyFA2H7ibakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495956; c=relaxed/simple;
	bh=nC/rz5qlNEqJaJoWOB6niUILizEUBIFAkbeVWptvRpI=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=CL/ygVVTCHcSA8ZbLue72Y96spAGuhWctkbnOay+4HU/IBYsesLpTSawagUO9k/g0XAMA98hi7xE8lgKhJJ0xGjUwC38EQL3jRYj7s6QLMLrZTvhS+5Ux6IHgjMWkejPTuGAL2117m6BLbqFpEUoMlio0jm28rFOJnR/VpIyCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XucRk4CW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XucRk4CW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737495953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3f+coA5NoWEtCA0NXXl4cQ8i/fNkiu2i2ktDHwLz0D0=;
	b=XucRk4CWuSPqe7cp6R7DHDkzts9vomEqX3KV1ZguneWFb25RaKMkB3oHr/l3FYbgx93por
	LPGzvsBEW9Rm5I8rhgVf71eeHCGzESDuC1wRng9QSVbC66eV0MkzpCzUkfbCPZSZ/IZYjj
	JF+wpmMpUHH1CoDbywDyXnbqRGVoVa0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-IXDV195PPTOylwo7lH1lTw-1; Tue,
 21 Jan 2025 16:45:49 -0500
X-MC-Unique: IXDV195PPTOylwo7lH1lTw-1
X-Mimecast-MFC-AGG-ID: IXDV195PPTOylwo7lH1lTw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 292FB19560BB;
	Tue, 21 Jan 2025 21:45:48 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.88.205])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E5DA195608E;
	Tue, 21 Jan 2025 21:45:46 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: linux-btrace@vger.kernel.org,  axboe@kernel.dk
Subject: Re: [PATCH v1 0/1] Add an option to stop blktrace based on events
 recorded
References: <Zz-tmR3IyJFdSR8Y@snoc-pinewood>
	<x49plkpeaet.fsf@segfault.usersys.redhat.com>
	<Z41Z6VXqDfXlIO1h@snoc-beelink.cn.shawcable.net>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 21 Jan 2025 16:45:44 -0500
Message-ID: <x49sepbon7b.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stephen Bates <sbates@raithlin.com> writes:

> Hi Jeff
>
>> Can you expand on the use case?  Why is the number of events a useful
>> parameter?
>>
>> Thanks,
>> Jeff
>
> I am working on tying blktrace into a prometheus exporter so I can
> monitor block-level activity across a fleet of storage servers. I
> don't want to overload either the storage server CPUs or the exporter
> itself when the server is under high load so I want to avoid using the
> time-based argument for blktrace.
>
> If I have access to an events based option I can run this knowing that
> in high-load situations I will not be capturing many, many IO and
> perhaps slowing down the server in the process.
>
> Does that make sense?

Yes, thanks for the clarification.  Originally I thought you might be
using the number of events as a proxy for the size of data collected.
I'm still not sure how a user would reason about how many events is too
many (or enough), but that's a not a problem for blktrace to figure out.

I'll reply to the patch with my comments.

Cheers,
Jeff

