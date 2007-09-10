From: Jens Axboe <jens.axboe@oracle.com>
Date: Mon, 10 Sep 2007 16:39:24 +0000
Subject: Re: [BTT PATCH] Major revamping (ver 2.0)
Message-Id: <20070910163924.GL6892@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <46E33802.9040209@hp.com>
In-Reply-To: <46E33802.9040209@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sat, Sep 08 2007, Alan D. Brunelle wrote:
> After a lot of fighting with maintaining a tree-styled design (each trace 
> having it's own node), it was just getting too cumbersome to work in all 
> circumstances. Taking a clue from blkparse itself, I decided to just keep 
> track of IOs at queue time, and updating fields based upon later traces.
>
> The attached (large) patch works much faster, handles larger test cases 
> with less failures, and is managing some pretty large jobs I'm working on 
> (large Oracle-based DB analysis - 32-way box w/ lots of storage).
>
> I've also added a Q2Q seek distance feature - it's come in handy when 
> comparing results of IO scheduler choice: We can see what the incoming IO 
> seek distances are (at queue time), and then see how the scheduler itself 
> manages things (via merges & sorting) by looking at D2D seek distances 
> generated.
>
> As noted in the subject, I arbitrarily bumped this to version 2.00 as the 
> innards are so different. The documentation (btt/doc/btt.tex) has been 
> updated to reflect some minor output changes. I also fixed a bug dealing 
> with process name notification: there was a problem that if a new PID came 
> up with a name that was previously seen, btt wouldn't keep track of it 
> right. [When running with Oracle, a lot of processes have the same name but 
> different PIDs of course.]

Applied (the 2nd full variant).

-- 
Jens Axboe

