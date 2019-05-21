From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 21 May 2019 14:06:23 +0000
Subject: Re: [PATCH V4] blkparse: add support sort program by io event
Message-Id: <c27d8908-4dc3-0593-feae-caa41965e0f0@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190521132907.GA27742@192.168.3.9>
In-Reply-To: <20190521132907.GA27742@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 5/21/19 7:29 AM, Weiping Zhang wrote:
> Displays each program's data sorted by program name or io event, like
> Queued, Read, Write and Complete. When -S is specified the -s will be ignored.
> The capital letters Q,R,W,C stand for KB, then q/r/w/c stand for IO.
> The N is used for sorting programs by name, same to -s.
> 
> If you want to sort programs by how many data they queued, you can use:
> 
> blkparse -i sda.blktrace. -q -S Q -o sda.parse

Applied, thanks.

-- 
Jens Axboe
