From: Chris Mason <clm@fb.com>
Date: Fri, 05 Sep 2014 20:22:35 +0000
Subject: Re: [RFC] merge seekwatcher into the blktrace repository?
Message-Id: <540A1B8B.4020304@fb.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20140905184806.GA32325@infradead.org>
In-Reply-To: <20140905184806.GA32325@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/05/2014 03:30 PM, Eric Sandeen wrote:
> On 9/5/14, 1:48 PM, Christoph Hellwig wrote:
>> Hi Chris, hi Jens,
>>
>> I worked with a customer last week who had to manually install
>> seekwatcher because their distro didn't provide it, and it turns
>> out that the hg repository for it seems fairly dead, and recent fixes
>> are instead carried in various distro packages.
> 
> seekwatcher is dead, long live iowatcher, right?
> 

Yeah, iowatcher is the new hotness.

> 
> 
> Still, I've be happy to have any graphing functionality bundled
> with blktrace.

Jens and I have bounced this around a few times, and now that iowatcher
doesn't have any crazy dependencies, it makes sense.

-chris

