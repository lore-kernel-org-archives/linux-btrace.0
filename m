From: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 27 Mar 2007 10:58:31 +0000
Subject: Re: how to explain the current process?
Message-Id: <20070327105831.GJ3803@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <1174833941.3625.10.camel@localhost.localdomain>
In-Reply-To: <1174833941.3625.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Mar 25 2007, Ming Zhang wrote:
> Hi All
> 
> I am using blktrace to trace a untar operation on a 400GB (already 80%
> used) ext3 disk.
> 
> since journal in ext3 is at the beginning of ext3, so small LBA are
> journal operations, and large lba should be inode or file data.
> 
>   8,0    0  1081156    60.171965751  4929  P   R [kjournald] 
>   8,0    0  1081157    60.171965991  4929  I   W 26079 + 8 [kjournald]
>   8,0    0  1081158    60.171966726  4929  U   R [kjournald] 1
>   8,0    0  1081159    60.171968511  4929  D   W 26079 + 8 [kjournald]
>   8,0    0  1081160    60.172249031     0  C   W 26079 + 8 [0]
> 
> journal request
> 
>   8,0    0  1081161    60.172306613  4944  Q   W 733338903 + 8 [tar]
>   8,0    0  1081162    60.172307471  4944  G   W 733338903 + 8 [tar]
>   8,0    0  1081163    60.172308435  4944  P   R [tar] 
>   8,0    0  1081164    60.172308798  4944  I   W 733338903 + 8 [tar]
>   8,0    0  1081165    60.172311794  4944  Q   W 733338911 + 8 [tar]
>   8,0    0  1081166    60.172312274  4944  M   W 733338911 + 8 [tar]
> 
> file or inode
> 
>   8,0    0  1081167    60.172327693  4929  U   R [kjournald] 1
> 
> why here a R(read) come up? and what is the meaning of this "1" here?

It's not a read, it's an UNPLUG. And the 1 means that there was 1
request plugged when it happened.

>   8,0    0  1081168    60.172329564  4929  D   W 733338903 + 16
> [kjournald]
>   8,0    0  1081169    60.172773400     0  C   W 733338903 + 16 [0]
> 
> why it is kjounrald here to "D" this request? is this because tar
> already "finish" the request by writing to page cache and then when do
> device io, current process is happened to be kjournald? i read the code
> and it grabs current pid, so it looks so. but i still need a
> confirmation here from your guys.

Because kjournald apparently ends up doing the dispatch. The unplug will
cause dispatch of requests, and kjournald did the unplug. So it gets to
do the dispatching as well.

-- 
Jens Axboe

