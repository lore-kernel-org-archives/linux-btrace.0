From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 16 Jan 2020 20:34:20 +0000
Subject: Re: [PATCH] fix parallel build of btt and blkiomon
Message-Id: <6c434913-4b1e-25c7-2e4a-548092dd9425@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20200116203326.54058-1-gwendal@chromium.org>
In-Reply-To: <20200116203326.54058-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 1/16/20 1:33 PM, Gwendal Grignou wrote:
> rbtree.c is used by both binaries. It is possible that when make -C btt
> is invoked rbtree.o does not exist yet, but is already schedule by the
> compilation of blkiomon. That could result in recompiling rbtree.o again
> for btt/btt.
> In that case, at install time, make will recompile blkiomon which can
> fail in gentoo, because CC variable is not overriden by ebuild script at
> install time. (see https://bugs.gentoo.org/705594)
> 
> Add a dependency on SUBDIRS to wait for all binary in . to be compiled.
> It will guarante rbtree.o exists.

Applied, thanks.

-- 
Jens Axboe
