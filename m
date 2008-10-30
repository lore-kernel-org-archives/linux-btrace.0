From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 30 Oct 2008 13:59:43 +0000
Subject: Re: blktrace and dm devices?
Message-Id: <20081030135943.GU31673@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1225374971.4431.5.camel@kitka.ibm.com>
In-Reply-To: <1225374971.4431.5.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Oct 30 2008, Martin Peschke wrote:
> Hi,
> 
> I have noticed that I get C traces but no D traces for device mapper
> devices. Is blktrace supposed to handle dm devices as well?

The dispatch event is associated with request dispatching, which dm/md
does not do. You should get redirect events, telling you when the IO is
being redirected to the bottom device. Or split events.

-- 
Jens Axboe

