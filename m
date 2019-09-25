From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 25 Sep 2019 06:22:52 +0000
Subject: Re: [PATCH 1/3] blkparse: split off the timestamp correction code in to a separate function
Message-Id: <4dd933fe-ea16-64c9-8d8d-a8166ea68387@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190924223206.20125-1-hmihara@redhat.com>
In-Reply-To: <20190924223206.20125-1-hmihara@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 9/25/19 12:32 AM, Hiroaki Mihara wrote:
> find_genesis() function has code to correct abs_start_time, which is
> later used to calculate the absolute timestamps of each traced
> records.
> 
> Put this code in a separate function, so that it can be used later by
> the blkparse code. No functional change.

Applied this, and the other 2. Thanks.

-- 
Jens Axboe
