From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 23 Jan 2018 22:56:29 +0000
Subject: Re: [PATCH] respect LDFLAGS when linking programs
Message-Id: <c6bc1542-93b6-526a-6782-9f5a09f4ae1c@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20180123224719.8195-1-vapier@gentoo.org>
In-Reply-To: <20180123224719.8195-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 1/23/18 3:47 PM, Mike Frysinger wrote:
> From: "Robin H. Johnson" <robbat2@gentoo.org>
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  Makefile           | 10 +++++-----
>  btreplay/Makefile  |  4 ++--
>  btt/Makefile       |  2 +-
>  iowatcher/Makefile |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Jens Axboe

