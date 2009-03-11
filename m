From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Wed, 11 Mar 2009 11:59:21 +0000
Subject: Re: blktrace / relay: bad trace
Message-Id: <1236772761.23294.5.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <1236270223.10040.61.camel@kitka.ibm.com>
In-Reply-To: <1236270223.10040.61.camel@kitka.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-btrace@vger.kernel.org

Hi Alan,
I get bad data from relay in user space. I don't see a crash similar to
the one you have posted. My issue appears to be older anyway.
The last kernel I have tried out is 2.6.29-rc7.

Martin

On Tue, 2009-03-10 at 13:19 -0400, Alan D. Brunelle wrote:
> Hi Martin -
>=20
> What version of the kernel are you running on? I'm experiencing some bad
> stuff the last couple of days, and it's in the blktrace/relay arena:
> http://lkml.org/lkml/2009/3/10/331 - this is with 2.6.29-rc[67]...
>=20
> For some reason the first e-mail isn't showing up correctly on LKML (I
> got it via e-mail OK), anyways, that stack looked like:
>=20
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:3002!
> invalid opcode: 0000 [#1] SMP
> last sysfs file: /sys/devices/system/cpu/cpu15/cache/index2/shared_cpu_map
> CPU 6
> Modules linked in: xfs exportfs fuse ext2 loop dm_mod sd_mod crc_t10dif
> bnx2 ipmi_si sg qla2xxx shpchp scsi_transport_fc sr_mod rtc_cmos button
> container ipmi_msghandler hpilo hpwdt rtc_core pci_hotplug pcspkr
> rtc_lib cdrom scsi_tgt serio_raw usbhid hid ehci_hcd uhci_hcd ohci_hcd
> usbcore edd ext3 mbcache jbd fan ide_pci_generic amd74xx ide_core
> pata_amd thermal processor thermal_sys hwmon cciss ata_generic libata
> scsi_mod
> Pid: 11346, comm: blktrace Tainted: G    B      2.6.29-rc7 #3 ProLiant
> DL585 G5
> RIP: 0010:[<ffffffff802c5099>]  [<ffffffff802c5099>]
> cache_alloc_refill+0x107/0x229
> RSP: 0018:ffff88081384d9e8  EFLAGS: 00010046
> RAX: 0000000000000070 RBX: ffff88187fc01340 RCX: 0000000000000015
> RDX: ffff88187c032000 RSI: ffff88187c682000 RDI: ffff88187fc01350
> RBP: ffff88081384da28 R08: ffff88187fc01360 R09: 00000000000000d2
> R10: ffff8817f4b9eabf R11: 000000000000000a R12: ffff88187c762c00
> R13: 0000000000000027 R14: ffff88087fc00040 R15: 00000000000492d0
> FS:  00007f3b2d6806f0(0000) GS:ffff88187c7671c0(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00007f3b2d022f30 CR3: 000000183c883000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process blktrace (pid: 11346, threadinfo ffff88081384c000, task
> ffff88082e5ae140)
> Stack:
>  ffff88081384da78 ffffffff802b7061 000000021384da18 0000000000000002
>  ffff88087fc00040 00000000000080d0 0000000000000292 ffff88181f992ec0
>  ffff88081384da68 ffffffff802c4cb1 0000000077c6c910 ffff88187a89fc80
> Call Trace:
>  [<ffffffff802b7061>] ? alloc_vmap_area+0x1fe/0x211
>  [<ffffffff802c4cb1>] kmem_cache_alloc_node+0x9a/0xe6
>  [<ffffffff80289a49>] ? relay_open_buf+0x9f/0x23c
>  [<ffffffff802c56a2>] __kmalloc_node+0x43/0x45
>  [<ffffffff802b79af>] __vmalloc_area_node+0x76/0x14b
>  [<ffffffff80289a49>] ? relay_open_buf+0x9f/0x23c
>  [<ffffffff802b7b00>] __vmalloc_node+0x7c/0x8c
>  [<ffffffff80289a49>] ? relay_open_buf+0x9f/0x23c
>  [<ffffffff802b7c34>] vmalloc+0x1f/0x21
>  [<ffffffff80289a49>] relay_open_buf+0x9f/0x23c
>  [<ffffffff8028a4b3>] relay_open+0x144/0x218
>  [<ffffffff8036a643>] do_blk_trace_setup+0x1a4/0x59b
>  [<ffffffff8036aa7e>] blk_trace_setup+0x44/0x75
>  [<ffffffff8036ad56>] blk_trace_ioctl+0x9a/0xcf
>  [<ffffffff802d4685>] ? path_put+0x2c/0x30
>  [<ffffffff80361dd8>] blkdev_ioctl+0x803/0x853
>  [<ffffffff802d615b>] ? putname+0x30/0x39
>  [<ffffffff802d80be>] ? user_path_at+0x5d/0x8c
>  [<ffffffff802e2e67>] ? mntput_no_expire+0x31/0x18f
>  [<ffffffff802d4685>] ? path_put+0x2c/0x30
>  [<ffffffff802f10f3>] block_ioctl+0x38/0x3c
>  [<ffffffff802d9690>] vfs_ioctl+0x2a/0x78
>  [<ffffffff802d9b24>] do_vfs_ioctl+0x446/0x482
>  [<ffffffff8024ff46>] ? do_sigaction+0x166/0x187
>  [<ffffffff802d9bb5>] sys_ioctl+0x55/0x77
>  [<ffffffff8020c42a>] system_call_fastpath+0x16/0x1b
> Code: 00 00 00 48 8b 33 48 39 de 75 14 48 8b 73 20 c7 43 60 01 00 00 00
> 4c 39 c6 0f 84 a6 00 00 00 8b 46 20 41 3b 86 18 10 00 00 72 33 <0f> 0b
> eb fe ff c0 41 8b 0c 24 41 8b 96 0c 10 00 00 89 46 20 8b
> RIP  [<ffffffff802c5099>] cache_alloc_refill+0x107/0x229
>  RSP <ffff88081384d9e8>
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> hpwdt: An NMI occurred, but unable to determine source.
> Initializing cgroup subsys cpuset
> Initializing cgroup subsys cpu
> Linux version 2.6.29-rc7 (root@seatpost) (gcc version 4.3.2
> [gcc-4_3-branch revision 141291] (SUSE Linux) ) #3 SMP Tue Mar 10
> 10:15:07 EDT 2009
> Command line: root=3D/dev/cciss/c0d2p3 text resume=3D/dev/cciss/c0d2p2
> vga=3D0x317 console=3DttyS1,115200N8 elevator=DEadline sysrq=3D1 reset_de=
vices
> irqpoll maxcpus=3D1  memmap=3Dexactmap memmapd0K@0K memmap=130412K@17024K
> elfcorehdr=147436K memmap2K#2095416K
> KERNEL supported cpus:
>   Intel GenuineIntel
>   AMD AuthenticAMD
>   Centaur CentaurHauls
>=20
> Alan

