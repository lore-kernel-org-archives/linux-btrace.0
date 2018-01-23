From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 23 Jan 2018 22:59:54 +0000
Subject: Re: [PATCH] fix parallel build failures
Message-Id: <ef46b8e8-a277-3121-b20a-77d374c556e9@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20180123225755.9927-1-vapier@gentoo.org>
In-Reply-To: <20180123225755.9927-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 1/23/18 3:57 PM, Mike Frysinger wrote:
> From: "Robin H. Johnson" <robbat2@gentoo.org>
> 
> When building in parallel, the btreplay/btrecord and btreplay/btreplay
> targets cause make to kick off two jobs for `make -C btreplay` and they
> sometimes end up clobbering each other.  We could fix this by making one
> a dependency of the other, but it's a bit cleaner to refactor things to
> be based on subdirs.  This way changes in subdirs also get noticed:
>   $ touch btreplay/*.[ch]
>   $ make
>   <btreplay is now correctly updated>

Applied, thanks.

-- 
Jens Axboe

