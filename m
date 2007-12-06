From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 06 Dec 2007 08:14:00 +0000
Subject: Re: [PATCH] Remove strange make dependency
Message-Id: <20071206081400.GA25209@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <47578CBC.1040904@gelato.unsw.edu.au>
In-Reply-To: <47578CBC.1040904@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Thu, Dec 06 2007, Joshua Root wrote:
> Listing "-lpthread" as a dependency in a make rule doesn't make much sense.

Indeed. Thanks, applied.

-- 
Jens Axboe

