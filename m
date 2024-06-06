Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEA195F14
	for <linux-btrace@vger.kernel.org>; Thu,  6 Jun 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679498; cv=none; b=BrBEEpFIFEWgbygGI5JJIAPAKOLw+xewvBZqsY2ZxITIaI1phYaLvp8qPzNCK/E6ApO9kanA4vqoZDGQeGsELqEN42Ax2jod1bstXovgiPjwjloC1kIU9xrCV/TImQk4J8mHLErU4QU+8RfGCJ6Ko/8fc0DFOj8VSvPSzIwYU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679498; c=relaxed/simple;
	bh=NV6wQfzvI0RNvQk25k3Wy1h/t6e6JecvXjvumqYbA80=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N9YZ2dqbJa0wxn0XjESKm2Oq2Y0uyb+JT4R64f9OR1FriY29uIj962y9aQwG6tNviMqJJ/IxHeo3id1X3BrgqT7s4TYfYM5FN0RWsnT1LtEio7PtKsjzmkg5uY2bbC+Fl00nZUXCkz12lOnCVjs+MvM5ipNkp8LxVWp9o0udKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkjybRck; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkjybRck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717679496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FIlnRqHdqymf5AO22/J2D2m2LLPHm0R37IBwTV8YcpQ=;
	b=IkjybRckYZYCpbzjUHOhhkWlrWUtx4p57CH/rI1OK49QXAVlQg1GPWebCwjd/GrouMGzG6
	y24Ct13/oFWMcyS+aGs8pdqeCvvEhS5Yi6czm+Sqcr654CVDT2nJNV7zM/uzWhW7xhbwgh
	ot8f4GJz9Y0u6JKEHipKOrTZjgpyZls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-KBrj1mVwPnqtCrsq3QbHxA-1; Thu,
 06 Jun 2024 09:11:32 -0400
X-MC-Unique: KBrj1mVwPnqtCrsq3QbHxA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 139F01944D20;
	Thu,  6 Jun 2024 13:11:30 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.8.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A19A195423C;
	Thu,  6 Jun 2024 13:11:28 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>,  "linux-btrace@vger.kernel.org"
 <linux-btrace@vger.kernel.org>,  axboe@kernel.dk
Subject: Re: [PATCH] fix hang when BLKTRACESETUP fails and "-o -" is used
References: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com>
	<x49sexqz4qt.fsf@segfault.usersys.redhat.com>
	<9552c8d6-0f53-4bb8-ae0b-acf14731872b@sandeen.net>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 06 Jun 2024 09:11:26 -0400
In-Reply-To: <9552c8d6-0f53-4bb8-ae0b-acf14731872b@sandeen.net> (Eric
	Sandeen's message of "Thu, 6 Jun 2024 08:05:25 -0500")
Message-ID: <x49o78ez05d.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Eric Sandeen <sandeen@sandeen.net> writes:

> On 6/6/24 6:32 AM, Jeff Moyer wrote:
>> Hi, Eric,
>> 
>> This looks like a repost?  I mentioned that we should also set done = 1
>> for a failed setup_tracer_devpaths() call, and I was hoping you'd
>> include that in a new version (or at least comment on whether you
>> thought it was a good idea).  Sorry if that wasn't clear!
>
> The first one was a question, this one was a patch :)

Ah, ok.  :)

> I'm sorry, I have not had time to look into or test for failed
> setup_tracer_devpaths() calls, and hoped to just fix the bug
> I had encountered.

That's fair.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thanks!

>  
>> The change here looks good to me.
>
> Thanks,
> -Eric
>
>> -Jeff
>> 
>> Eric Sandeen <sandeen@redhat.com> writes:
>> 
>>> # blktrace -o - /dev/sda /dev/sdb /dev/sdc
>>>
>>> has to be SIGKILLed if BLKTRACESETUP fails for any or all of the devices
>>> listed. (I simulated this by just catching one of the devices in
>>> setup_buts(), skipping the ioctl, and doing ret++).
>>>
>>> This seems to be because with "-o -" on the command line, use_tracer_devpaths()
>>> sees piped_output set, so we call process_trace_bufs which ends up waiting on
>>> (!done) and "done" is never set. i.e.
>>>
>>> atexit(exit_tracing)
>>> 	wait_tracers
>>> 		if (use_tracer_devpaths()) // true because "-o -"
>>> 			process_trace_bufs
>>> 				while (wait_empty_entries())
>>> 					wait_empty_entries
>>> 						while (!done ... )
>>> 							<loop forever>
>>>
>>> I think this can be avoided by just setting "done = 1" before returning
>>> when setup_buts() fails in run_tracers().
>>>
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>> ---
>>>
>>> diff --git a/blktrace.c b/blktrace.c
>>> index 3444fbb..038b2cb 100644
>>> --- a/blktrace.c
>>> +++ b/blktrace.c
>>> @@ -2684,8 +2684,10 @@ static int run_tracers(void)
>>>  	if (net_mode == Net_client)
>>>  		printf("blktrace: connecting to %s\n", hostname);
>>>  
>>> -	if (setup_buts())
>>> +	if (setup_buts()) {
>>> +		done = 1;
>>>  		return 1;
>>> +	}
>>>  
>>>  	if (use_tracer_devpaths()) {
>>>  		if (setup_tracer_devpaths())
>> 
>> 

