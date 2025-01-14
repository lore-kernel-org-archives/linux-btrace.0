Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAC83CD2
	for <linux-btrace@vger.kernel.org>; Tue, 14 Jan 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866068; cv=none; b=E+cDYgb2lio2Sl7x2sydgvzAigMmRJQPEuYIMo5LOuzlphKuPgtmaXcwxFj5CevEUJu/Z26+3De0vatchS9m+bc4CwCFPP/AlVoW3UQhrY15q8r0hVLfYUXPhrRrpc24Y6WHqB4FJMfwsxexutmPSc8eNk1EKSuypXR/2EsUWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866068; c=relaxed/simple;
	bh=Y14C7yQMmwlYrnK+cCaL7tsBqWr4nZre7H2GCCwW+pA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V2Mt42eddwmkK4s4ePvyk1VpxMxpNQ87KIxKZEeCcDEFnHU7RpMY6A9rVc2PUzT1W5/Haz5dmh46xARum2k3WvZ/Kam5+cv04kWi6rfmbQS0/5ctHMVBjPSfeovSiogz6BFk6tM9RjG2hdQq5iWIQgFSEOFhFKjO9m4b0nutnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRULnfXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRULnfXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736866065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Drb3HtJm8Mpd/mi9+m1I3THLiHii2Yq3KdHbtCQKj+U=;
	b=KRULnfXDtFVoQBxMZDQ6J8rd4R8En0qDmHOfk7gNWvLJHahg8CcME9T3GwgCbPHMYoazT9
	Nw3saA71IvtjVaM+qRfa1hPxozzsB+oY3gcOJb5BI6+s26R8pBn4DTR5vhNdF1dZG3hI1h
	3kITLJQkg05ZSB8BZy8kVLB/Glc/rVY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-46JNgSexOSyAmFCkr59nKQ-1; Tue,
 14 Jan 2025 09:47:42 -0500
X-MC-Unique: 46JNgSexOSyAmFCkr59nKQ-1
X-Mimecast-MFC-AGG-ID: 46JNgSexOSyAmFCkr59nKQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47A8F19560B7;
	Tue, 14 Jan 2025 14:47:41 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.89.100])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE0E619560AB;
	Tue, 14 Jan 2025 14:47:39 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-btrace@vger.kernel.org,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] doc: update RWBS descriptions
References: <20241123204010.519984-1-stefanha@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 14 Jan 2025 09:47:37 -0500
In-Reply-To: <20241123204010.519984-1-stefanha@redhat.com> (Stefan Hajnoczi's
	message of "Sat, 23 Nov 2024 15:40:10 -0500")
Message-ID: <x49ldvde9km.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Barriers no longer exist but a number of other flags have been added.
> Document them.

It's possible to run the tool against older kernels, so perhaps we
should keep a note about barriers at the end of the man page.

Aside from that, this looks fine to me.

-Jeff

>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  doc/blkparse.1   | 34 +++++++++++++++++++++++++++++++---
>  doc/blktrace.tex | 20 +++++++++++++++++---
>  2 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/doc/blkparse.1 b/doc/blkparse.1
> index 4c26baf..722efff 100644
> --- a/doc/blkparse.1
> +++ b/doc/blkparse.1
> @@ -435,10 +435,38 @@ Split
>  
>  .SH "RWBS DESCRIPTION"
>  
> -This is a small string containing at least one character ('R' for read, 'W'
> -for write, or 'D' for block discard operation), and optionally either
> -a 'B' (for barrier operations) or 'S' (for synchronous operations).
> +This is a small string containing characters in the following order:
>  
> +.IP F
> +Flush
> +
> +.IP R
> +Read
> +
> +.IP W
> +Write
> +
> +.IP D
> +Discard
> +
> +.IP N
> +Other operation
> +
> +.IP F
> +Force Unit Access (FUA)
> +
> +.IP A
> +Readahead
> +
> +.IP S
> +Synchronous
> +
> +.IP M
> +Meta
> +
> +.PP
> +One of 'R', 'W', 'D', or 'N' is always present. The other characters are
> +optional. Note that 'F' has two meanings, depending on its position.
>  
>  .SH "DEFAULT OUTPUT"
>  
> diff --git a/doc/blktrace.tex b/doc/blktrace.tex
> index 836ac4a..6a33fb6 100644
> --- a/doc/blktrace.tex
> +++ b/doc/blktrace.tex
> @@ -653,9 +653,23 @@ X & Split \\ \hline
>  \end{tabular}
>  
>  \subsubsection{\label{sec:act-table}RWBS Description}
> -This is a small string containing at least one character ('R' for read,
> -'W' for write, or 'D' for block discard operation), and optionally either
> -a 'B' (for barrier operations) or 'S' (for synchronous operations).
> +This is a small string containing characters in the following order:
> +
> +\begin{tabular}{|l|l|}\hline
> +Character & Description \\ \hline\hline
> +F & Flush \\ \hline
> +R & Read \\ \hline
> +W & Write \\ \hline
> +D & Discard \\ \hline
> +N & Other operation \\ \hline
> +F & Force Unit Access (FUA) \\ \hline
> +A & Readahead \\ \hline
> +S & Synchronous \\ \hline
> +M & Meta \\ \hline
> +\end{tabular}
> +
> +One of 'R', 'W', 'D', or 'N' is always present. The other characters are
> +optional. Note that 'F' has two meanings, depending on its position.
>  
>  \subsubsection{\label{sec:default-output}Default output}

