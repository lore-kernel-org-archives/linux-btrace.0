From: Stephen Bates <sbates@raithlin.com>
Date: Mon, 19 Dec 2022 05:52:55 +0000
Subject: Re: Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad address
Message-Id: <Y5/8N1lKjQyAXxCS@bunbeg>
List-Id: <linux-btrace.vger.kernel.org>
References: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
In-Reply-To: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org


> >> Would be useful  to strace that so we can get some hints on why
> >> you're getting EINVAL on the mmap, not enough info in here to render
> >> an opinion on why that would fail on your kernel.
> >>
> > 
> > $ sudo strace -f blktrace -b 8192 -a queue -a complete -a issue -a notify -o ./trace -D . -d /dev/nvme0n1
> > <snip>
> > [pid 2269231] <... ppoll resumed>)      = 1 ([{fd=8, revents=POLLIN}], left {tv_sec=0, tv_nsecB9998741})
> > [pid 2269231] ftruncate(9, 134217728)   = 0
> > [pid 2269231] mmap(NULL, 134217728, PROT_WRITE, MAP_SHARED, 9, 0) = -1 EINVAL (Invalid argument)
> > [pid 2269231] dup(2)                    = 12
> > [pid 2269231] fcntl(12, F_GETFL)        = 0x2 (flags O_RDWR)
> > [pid 2269231] newfstatat(12, "", {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x8), ...}, AT_EMPTY_PATH) = 0
> > [pid 2269231] write(12, "setup_mmap: mmap: Invalid argume"..., 35setup_mmap: mmap: Invalid argument) = 35
> > 
> > Excuse the mangling of the last line as the strace and stderr message
> > trash each other. Does this point in any particular direction?
> 
> Only guess is that whatever fs is hosting the blktrace files doesn't
> support mmap? There's no reason why that mmap should fail otherwise.
>

Oh that was the clue I needed. My VM uses UTM which leverages VirtFS [1]
for sharing of my Projects directory on my MacOS host into the
guest. I don't know exactly why but the files in this share are not
mmap'able. If I cd to a folder outside the share then blktrace works
fine.

$ mount | grep Projects
share on /home/batesste/Projects type 9p (rw,relatime,sync,dirsync,access=client,trans=virtio,_netdev)

[1]. https://docs.getutm.app/guest-support/linux/#virtfs

I will follow up with the UTM folks and see if we can get to a
specific root cause. Thanks for the prompt help!

Cheers

Stephen
