Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAA139D1E
	for <linux-btrace@vger.kernel.org>; Tue, 14 Jan 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864981; cv=none; b=qsF2m5Q/srKe1lSHW+PG9HSauqSN0LRdVMQrHBZjU6exjpmvQvxEI9EWQHkCyXt35oS+fr6IZsYxwvQ7Cg+Aaqyh+d1xEC4HgGhcLi8oOCCmA3GuyP3dekzL0Ep1O/eF92WVvQiehE4K0VCW6MRHedp4lBJyBAbvYU0MhVqKx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864981; c=relaxed/simple;
	bh=vlz3L+JcuMLQuZQsqhvKkzW9p9dmKeDXy0S1T8MmNx0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UV/t2KTM8oq0z1aTAl5pu3BjqGzczW5L8mGNVlxDhNwKpfnlLTqc4JRbEhHm1BYL4qNjGH3RsHhaakJ5Ioz7Uftl7N/ocGfx0tzUMGiIWJYSN4PI1Dtp4I/zy2z9+QBF6J9tA7i86Ca/0lm5+mPGmruR+FPRl+iPRWvwa3NuLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAp2yS+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAp2yS+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736864978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48jYWuwOpO1aPP75mT3Q1HpnSFFfX21z2lxuWydhvfw=;
	b=JAp2yS+AoGMASwo5CnOf/u464aZdAd03wzA284a73WnUX8l1c0L/ek+wqnTxqmSHLRLFkC
	BTT0uh4/Mt/sPlXM7S5/ujSZZCTMCV2j+IMEK0SWvaYv5d9XCpz28SCrBM8eL32X6QTqfE
	JzxvpPkzd9RZ/tcA1543XVwbC5J93pI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-BPaGyrVUP3WJZdFr3Rm83Q-1; Tue,
 14 Jan 2025 09:29:36 -0500
X-MC-Unique: BPaGyrVUP3WJZdFr3Rm83Q-1
X-Mimecast-MFC-AGG-ID: BPaGyrVUP3WJZdFr3Rm83Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AC80195D013;
	Tue, 14 Jan 2025 14:29:34 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.89.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A69619560AA;
	Tue, 14 Jan 2025 14:29:31 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: linux-btrace@vger.kernel.org,  axboe@kernel.dk
Subject: Re: [PATCH v1 0/1] Add an option to stop blktrace based on events
 recorded
References: <Zz-tmR3IyJFdSR8Y@snoc-pinewood>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 14 Jan 2025 09:29:30 -0500
In-Reply-To: <Zz-tmR3IyJFdSR8Y@snoc-pinewood> (Stephen Bates's message of
	"Thu, 21 Nov 2024 15:00:57 -0700")
Message-ID: <x49plkpeaet.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi, Stephen,

Stephen Bates <sbates@raithlin.com> writes:

> Hi
>
> I am exploring the idea of tying blktrace to a prometheus exporter to
> gather more precise block layer activity across a fleet of servers. As
> part of that I thought it might be useful to be able to run blktrace
> until a user-specified number of events are recorded.
>
> So the following patch adds a new option to do that. I also updated
> the relevant documentation.
>
> I'd appreciate feedback or comments on this!

Can you expand on the use case?  Why is the number of events a useful
parameter?

Thanks,
Jeff

