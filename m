From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 18 Dec 2022 18:56:54 +0000
Subject: Re: Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad address
Message-Id: <80891a87-0629-0438-60e9-959ca4871208@kernel.dk>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

On 12/18/22 11:59=E2=80=AFAM, Stephen Bates wrote:
> Hi All
>=20
> I am trying to get iowatcher up and running on a VM and I seem to be
> hitting an issue reading the debugfs trace files. When I run on the VM
> I continually get messages of the form. This is not specific to
> iowatcher in that if I run blktrace directly I get something similar:
>=20
> $ blktrace -b 8192 -a queue -a complete -a issue -a notify -o ./trace -D =
. -d /dev/nvme0n1
> <snip>
> setup_mmap: mmap: Invalid argument
> Thread 0 failed read of /sys/kernel/debug/block/nvme0n1/trace0: 14/Bad ad=
dress

It's clearly mmap failing. Are you using non-4k pages? Would be useful
to strace that so we can get some hints on why you're getting EINVAL
on the mmap, not enough info in here to render an opinion on why that
would fail on your kernel.

--=20
Jens Axboe

