From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 02 May 2018 16:25:33 +0000
Subject: Re: A heap overflow in blktrace
Message-Id: <b127c936-69c3-b4d8-2619-998d08cb7984@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <CAOLTLfkkdbjy5Yf-LqA1DZnM8eDUQEJm5vfOcUBO3z7MA6uUjQ@mail.gmail.com>
In-Reply-To: <CAOLTLfkkdbjy5Yf-LqA1DZnM8eDUQEJm5vfOcUBO3z7MA6uUjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 5/2/18 1:55 AM, herbo zhang wrote:
> Hello,
> 
> I found a bug in blktrace/btt/devmap.c. The code is just as follows:

[snip]

Thanks for your report, I changed them to use PATH_MAX.

-- 
Jens Axboe

