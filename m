From: Jens Axboe <axboe@fb.com>
Date: Fri, 05 Sep 2014 19:17:04 +0000
Subject: Re: [RFC] merge seekwatcher into the blktrace repository?
Message-Id: <540A0C30.3000604@fb.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20140905184806.GA32325@infradead.org>
In-Reply-To: <20140905184806.GA32325@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/05/2014 12:48 PM, Christoph Hellwig wrote:
> Hi Chris, hi Jens,
> 
> I worked with a customer last week who had to manually install
> seekwatcher because their distro didn't provide it, and it turns
> out that the hg repository for it seems fairly dead, and recent fixes
> are instead carried in various distro packages.
> 
> Given that seekwatcher is based on blktrace, and given that other
> simple blktrace consumers are in the blktrace repository maybe it's time
> to simple add seekwatcher to the blktrace repository so that we have
> a canonical place for any sort of fixes for it?

I agree it'd be a good idea to have this packaged together, and I'd have
no problem adding seekwatcher to the blktrace repo. Chris?


-- 
Jens Axboe

