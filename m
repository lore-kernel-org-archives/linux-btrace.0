From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 18 Dec 2022 19:27:43 +0000
Subject: Re: Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad address
Message-Id: <9ba030c8-51bc-0cb6-66e6-e34191254c05@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
References: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
In-Reply-To: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

On 12/18/22 12:20 PM, Stephen Bates wrote:
> The 12/18/2022 12:04, Jens Axboe wrote:
>> On 12/18/22 11:59 AM, Stephen Bates wrote:
>>> Hi All
>>>
>>> I am trying to get iowatcher up and running on a VM and I seem to be
>>> hitting an issue reading the debugfs trace files. When I run on the VM
>>> I continually get messages of the form. This is not specific to
>>> iowatcher in that if I run blktrace directly I get something similar:
>>>
>>> $ blktrace -b 8192 -a queue -a complete -a issue -a notify -o ./trace -D . -d /dev/nvme0n1
>>> <snip>
>>> setup_mmap: mmap: Invalid argument
>>> Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad address
>>
>> It's clearly mmap failing. Are you using non-4k pages?
> 
> Thanks for the quick repsonse Jens! Ah yes. This VM is on my M2 Macbook Air.

I added linux-btrace back, jfyi.

> $ lscpu
> Architecture:          aarch64
> 
> But the page size appears to be 4KB?
> 
> $ sudo getconf PAGE_SIZE
> 4096

It can run both, only ask because I run mine with 16k pages (as it's much
faster).

>> Would be useful  to strace that so we can get some hints on why
>> you're getting EINVAL on the mmap, not enough info in here to render
>> an opinion on why that would fail on your kernel.
>>
> 
> $ sudo strace -f blktrace -b 8192 -a queue -a complete -a issue -a notify -o ./trace -D . -d /dev/nvme0n1
> <snip>
> [pid 2269231] <... ppoll resumed>)      = 1 ([{fd=8, revents=POLLIN}], left {tv_sec=0, tv_nsecB9998741})
> [pid 2269231] ftruncate(9, 134217728)   = 0
> [pid 2269231] mmap(NULL, 134217728, PROT_WRITE, MAP_SHARED, 9, 0) = -1 EINVAL (Invalid argument)
> [pid 2269231] dup(2)                    = 12
> [pid 2269231] fcntl(12, F_GETFL)        = 0x2 (flags O_RDWR)
> [pid 2269231] newfstatat(12, "", {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x8), ...}, AT_EMPTY_PATH) = 0
> [pid 2269231] write(12, "setup_mmap: mmap: Invalid argume"..., 35setup_mmap: mmap: Invalid argument) = 35
> 
> Excuse the mangling of the last line as the strace and stderr message
> trash each other. Does this point in any particular direction?

Only guess is that whatever fs is hosting the blktrace files doesn't
support mmap? There's no reason why that mmap should fail otherwise.

-- 
Jens Axboe

