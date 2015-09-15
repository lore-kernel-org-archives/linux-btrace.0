From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 15 Sep 2015 14:44:33 +0000
Subject: Re: [PATCH] include sys/types.h for dev_t definition
Message-Id: <55F82ED1.5030807@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1442275521-130450-1-git-send-email-raj.khem@gmail.com>
In-Reply-To: <1442275521-130450-1-git-send-email-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 09/14/2015 06:05 PM, Khem Raj wrote:
> Avoids the build failures when sys/types.h does not get included
> indirectly through other headers.
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

Applied, thanks.

-- 
Jens Axboe

