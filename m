From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 30 Jan 2009 12:59:25 +0000
Subject: Re: -b vs. -n
Message-Id: <4982F9AD.3020408@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <49821F8D.4050207@hp.com>
In-Reply-To: <49821F8D.4050207@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 29 2009, Alan D. Brunelle wrote:
>> Has anybody experimented with increasing the _number_ of buffers rather
>> than the _size_ of the buffers when confronted with drops? I'm finding
>> on a large(ish) system that it is better to have lots of small buffers
>> handled by relay rather than fewer larger buffers. In my particular case:
>>
>> 16 CPUs
>> 96 devices
>> running some dd's against all the devices...
>>
>> -b 1024 or -b 2048 still results in drops
>>
>> but:
>>
>> -n 512 -b 16 allows things to run smoother.
>>
>> I _think_ this may have to do with the way relay reports POLLIN: it does
>> it only when a buffer switch happens as opposed to when there is data
>> ready. Need to look at this some more, but just wondering if others out
>> there have found similar things in their testing...
> 
> That's interesting. The reason why I exposed both parameters was mainly
> that I didn't have the equipment to do adequate testing on what would be
> the best setup for this. So perhaps we can change the README to reflect
> that it is usually better to bump the number of buffers instead of the
> size, if you run into overflow problems?
> 

It's not clear - still running tests. [I know for SMALLER numbers of
disks increasing the buffers has worked just fine.] I'm still fighting
(part time) with version 2.0 of blktrace, so _that_ may have something
to do with it! :-)

Alan
