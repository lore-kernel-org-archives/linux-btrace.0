From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 19 May 2016 21:57:34 +0000
Subject: Re: [PATCH] blktrace: remove -k from manpage synopsis
Message-Id: <573E36CE.2020003@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <49be338d-da1d-eac9-e6db-357032f3a0d4@redhat.com>
In-Reply-To: <49be338d-da1d-eac9-e6db-357032f3a0d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 05/18/2016 10:15 AM, Eric Sandeen wrote:
> An earlier commit:
>
>    fb7f8667 blktrace: disable kill option - take 2
>
> removed the "-k" option documentation, but left
> it in the synopsis.
>
> This is a bit unusual and unhelpful and probably
> unintended; remove it from the synopsis as well.

Applied, thanks Eric.

-- 
Jens Axboe

