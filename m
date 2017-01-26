From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 26 Jan 2017 17:06:23 +0000
Subject: Re: [PATCH 1/3] blktrace: Add support for sparse CPU numbers
Message-Id: <6a98d7ac-9e81-f9d9-a97e-6b018ee182b4@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <20170126102355.19802-1-jack@suse.cz>
In-Reply-To: <20170126102355.19802-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On 01/26/2017 03:23 AM, Jan Kara wrote:
> On some machines CPU numbers do not form a contiguous interval. In such
> cases blktrace will fail to start threads for missing CPUs and exit
> effectively rendering itself unusable.
> 
> Add support into blktrace to handle systems with sparse CPU numbers.

Applied 1-3, thanks Jan.

-- 
Jens Axboe

