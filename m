From: "Alan D. Brunelle" <alan.brunelle@hp.com>
Date: Mon, 29 Nov 2010 15:32:26 +0000
Subject: Re: Question about btreplay and btrecord
Message-Id: <4CF3C78A.6010701@hp.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

My apologies for my tardy response.

I haven't played w/ betreplay in quite some time - years actually. In 
any event, I seem to recall you needed to explicitly enable btreplay to 
fire off writes : btreplay --write-enable - did you have that flag?

I'll try to get some time today to resurrect it to see if it still even 
works(!) :-)

I do know that Jens Axboe's 'fio' program does replay blktrace traffic 
(see fio read_iolog for example).

Regards,
Alan
