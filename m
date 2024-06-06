Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D5194C87
	for <linux-btrace@vger.kernel.org>; Thu,  6 Jun 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679129; cv=none; b=lhKzwq+ozv076i8serlbJOdzvO89+67Qq8RXqO6ojELHumZh1RuVFnGuL6746UHb2VfW6IHXTEjUxZ21KQcofCwmlQqHF1AyJf9e8iu3GCBXv6h9K18XmuqG5WIlZQrZlr09ejlggPhMCtzZfbvU5XWmbE9+ifIZIGeUIa3NNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679129; c=relaxed/simple;
	bh=zsr0AVZrVASUct7rttDtkmCiAQzu5T3BT5T8RhxxaE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJLMexye9L1pFbhaiBG82pPEyLhi0B80SdBb8XAt7gGbs0v36h9HFeIgHhwjPCQ22UyMB5eh7pZKXmytNKFBRDjjL9xfkzxGaeXKA671sSboitb5ap6w3KPHKgjKxhfvFFwKlAG3botPA9TDQjlC/xOnYN1fg1OimBycsYy85EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=jdWGbkPA; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="jdWGbkPA"
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 12D5711656;
	Thu,  6 Jun 2024 08:05:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 12D5711656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1717679126;
	bh=6W7tUPbOvhekFokgzlHAZUuZjk1nX7wjxitqtJvAKH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jdWGbkPAmPMJ6E7DIsELF55pq4Zydo28CxIuXZyXF9qGCW5mHS4CnOoqs+3QECG5Y
	 IkRMEZCKx2NGTrHLDgpB1hXJig/SWG2Uskb4Q5w/gOZ7CstFPsaXpoJxF3rj3rObS1
	 nanZmCZPJDHaRTYljeT8+woCAPvQdZymj1cfk4A3IWy7SE8rBxSP3X6wVy2lXP0omT
	 ri8duiUdy5LqghLCOTWWhL9QWcvEcKd8WF4UFkJe7RdPo1YsAsf13LcaNVtQNFJDOF
	 eXytsqfRvwn8AfSi+WtnU3FK0pFEUDFcf5JM6PGt9ZShfy0/GkQHIVBqXMHGsru/iq
	 Qzdt1Qloah5yQ==
Message-ID: <9552c8d6-0f53-4bb8-ae0b-acf14731872b@sandeen.net>
Date: Thu, 6 Jun 2024 08:05:25 -0500
Precedence: bulk
X-Mailing-List: linux-btrace@vger.kernel.org
List-Id: <linux-btrace.vger.kernel.org>
List-Subscribe: <mailto:linux-btrace+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrace+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix hang when BLKTRACESETUP fails and "-o -" is used
To: Jeff Moyer <jmoyer@redhat.com>, Eric Sandeen <sandeen@redhat.com>
Cc: "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
 axboe@kernel.dk
References: <f3204c9d-1384-40b5-a5fb-3bb967ca2bec@redhat.com>
 <x49sexqz4qt.fsf@segfault.usersys.redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <x49sexqz4qt.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 6:32 AM, Jeff Moyer wrote:
> Hi, Eric,
> 
> This looks like a repost?  I mentioned that we should also set done = 1
> for a failed setup_tracer_devpaths() call, and I was hoping you'd
> include that in a new version (or at least comment on whether you
> thought it was a good idea).  Sorry if that wasn't clear!

The first one was a question, this one was a patch :)

I'm sorry, I have not had time to look into or test for failed
setup_tracer_devpaths() calls, and hoped to just fix the bug
I had encountered.
 
> The change here looks good to me.

Thanks,
-Eric

> -Jeff
> 
> Eric Sandeen <sandeen@redhat.com> writes:
> 
>> # blktrace -o - /dev/sda /dev/sdb /dev/sdc
>>
>> has to be SIGKILLed if BLKTRACESETUP fails for any or all of the devices
>> listed. (I simulated this by just catching one of the devices in
>> setup_buts(), skipping the ioctl, and doing ret++).
>>
>> This seems to be because with "-o -" on the command line, use_tracer_devpaths()
>> sees piped_output set, so we call process_trace_bufs which ends up waiting on
>> (!done) and "done" is never set. i.e.
>>
>> atexit(exit_tracing)
>> 	wait_tracers
>> 		if (use_tracer_devpaths()) // true because "-o -"
>> 			process_trace_bufs
>> 				while (wait_empty_entries())
>> 					wait_empty_entries
>> 						while (!done ... )
>> 							<loop forever>
>>
>> I think this can be avoided by just setting "done = 1" before returning
>> when setup_buts() fails in run_tracers().
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/blktrace.c b/blktrace.c
>> index 3444fbb..038b2cb 100644
>> --- a/blktrace.c
>> +++ b/blktrace.c
>> @@ -2684,8 +2684,10 @@ static int run_tracers(void)
>>  	if (net_mode == Net_client)
>>  		printf("blktrace: connecting to %s\n", hostname);
>>  
>> -	if (setup_buts())
>> +	if (setup_buts()) {
>> +		done = 1;
>>  		return 1;
>> +	}
>>  
>>  	if (use_tracer_devpaths()) {
>>  		if (setup_tracer_devpaths())
> 
> 

