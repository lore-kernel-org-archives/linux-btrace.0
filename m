From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Fri, 27 Apr 2018 19:40:53 +0000
Subject: Re: [PATCH 18/31] blktrace: doc: alternatives to blktrace traditional tooling
Message-Id: <20180427194053.GA17295@kernel.org>
List-Id: <linux-btrace.vger.kernel.org>
References: <20180427130738.102806-19-maier@linux.ibm.com>
In-Reply-To: <20180427130738.102806-19-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Em Fri, Apr 27, 2018 at 03:07:25PM +0200, Steffen Maier escreveu:
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>

Interesting, I'd suggest adding 'perf trace' to that mix, that is a strace like
perf tool that can mix and match syscalls formatted strace-like + other events,
such as tracepoints, with the record perf.data, process it later, or do it
live, like strace, but with a vastly lower overhead and not just for a workload
started from it or a pid, but supporting the other targets perf supports:
system wide, CPU wide, cgroups, etc.

For instance, to see the block lifetime of a workload that
calls fsync, intermixed to the strace like output of the 'read' and 'write'
syscalls:

[root@jouet bpf]# perf trace -e read,write,block:* dd if=/etc/passwd of=bla conv=fsync
     0.054 ( 0.004 ms): dd/24556 read(fd: 3, buf: 0x7fff83d09318, count: 832                           ) = 832
     0.521 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.524 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.528 (         ): block:block_touch_buffer:253,2 sector92603 size@96
     0.534 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.550 ( 0.007 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.559 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.562 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.574 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.578 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.559 ( 0.023 ms): dd/24556  ... [continued]: write()) = 512
     0.584 ( 0.003 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.589 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.592 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.594 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.589 ( 0.007 ms): dd/24556  ... [continued]: write()) = 512
     0.598 ( 0.002 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.603 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.606 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.608 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.603 ( 0.008 ms): dd/24556  ... [continued]: write()) = 512
     0.613 ( 0.002 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.617 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.621 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.623 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.617 ( 0.009 ms): dd/24556  ... [continued]: write()) = 512
     0.629 ( 0.003 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.634 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.637 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.639 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.634 ( 0.008 ms): dd/24556  ... [continued]: write()) = 512
     0.644 ( 0.002 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.649 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.652 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.654 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.649 ( 0.008 ms): dd/24556  ... [continued]: write()) = 512
     0.659 ( 0.003 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 512
     0.664 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 512      ) ...
     0.667 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.669 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.664 ( 0.007 ms): dd/24556  ... [continued]: write()) = 512
     0.674 ( 0.002 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 298
     0.679 ( 0.005 ms): dd/24556 read(buf: 0x55c3ca055000, count: 512                                  ) = 0
     0.686 (         ): dd/24556 write(fd: 1</home/acme/bpf/bla>, buf: 0x55c3ca057000, count: 298      ) ...
     0.689 (         ): block:block_dirty_buffer:253,2 sector446744073709486080 size@96
     0.691 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.686 ( 0.008 ms): dd/24556  ... [continued]: write()) = 298
     0.716 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.719 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.729 (         ): block:block_touch_buffer:253,2 sector84 size@96
     0.735 (         ): block:block_bio_queue:253,2 WS 63627608 + 8 [dd]
     0.740 (         ): block:block_bio_remap:8,0 WS 79620440 + 8 <- (253,2) 63627608
     0.743 (         ): block:block_bio_remap:8,0 WS 196985176 + 8 <- (8,6) 79620440
     0.746 (         ): block:block_bio_queue:8,0 WS 196985176 + 8 [dd]
     0.756 (         ): block:block_getrq:8,0 WS 196985176 + 8 [dd]
     0.759 (         ): block:block_plug:[dd]
     0.764 (         ): block:block_rq_insert:8,0 WS 4096 () 196985176 + 8 [dd]
     0.768 (         ): block:block_unplug:[dd] 1
     0.771 (         ): block:block_rq_issue:8,0 WS 4096 () 196985176 + 8 [dd]
     8.864 ( 0.006 ms): dd/24556 read(buf: 0x55c3ca057910, count: 4096                                 ) = 2997
     8.891 ( 0.003 ms): dd/24556 read(buf: 0x55c3ca057910, count: 4096                                 ) = 0
7+1 records in
7+1 records out
3882 bytes (3.9 kB, 3.8 KiB) copied, 0.00845109 s, 459 kB/s
     8.985 ( 0.008 ms): dd/24556 write(fd: 2</dev/pts/10>, buf: 0x7fff83d07760, count: 31              ) = 31
     9.013 ( 0.005 ms): dd/24556 write(fd: 2</dev/pts/10>, buf: 0x7fff83d06f90, count: 59              ) = 59
     9.021 ( 0.004 ms): dd/24556 write(fd: 2</dev/pts/10>, buf: 0x7f032f1946e3, count: 1               ) = 1
[root@jouet bpf]#

If one wants instead to concentrate on the callchains leading to the block_rq_issue:

[root@jouet bpf]# perf trace --no-syscalls -e block:*rq_issue/call-graph=dwarf,max-stack/ dd if=/etc/passwd of=bla conv=fsync
7+1 records in
7+1 records out
3882 bytes (3.9 kB, 3.8 KiB) copied, 0.010108 s, 384 kB/s
no symbols found in /usr/bin/dd, maybe install a debug package?
     0.000 block:block_rq_issue:8,0 WS 4096 () 197218728 + 8 [dd]
                                       blk_peek_request ([kernel.kallsyms])
                                       fsync (/usr/lib64/libc-2.26.so)
                                       [0xffffaa100818045d] (/usr/bin/dd)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       [0xffffaa1008180d99] (/usr/bin/dd)
[root@jouet bpf]# 

installing the debuginfo for the coreutils package, where dd lives, would give more info, etc.

Since this is an ext4 filesystem, lets add its *write* routines to the mix:

[root@jouet bpf]# perf trace --no-syscalls -e ext4:*write*/call-graph=dwarf/,block:*rq_issue/call-graph=dwarf/ dd if=/etc/passwd of=bla conv=fsync |& tail -18
     0.215 ext4:ext4_da_write_pages:dev 253,2 ino 8437 first_page 1 nr_to_write 9223372036854775806 sync_mode 1
                                       ext4_writepages ([kernel.kallsyms])
                                       fsync (/usr/lib64/libc-2.26.so)
                                       [0xffffa9f16310445d] (/usr/bin/dd)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       [0xffffa9f163104d99] (/usr/bin/dd)
     0.231 block:block_rq_issue:8,0 WS 4096 () 197703696 + 8 [dd]
                                       blk_peek_request ([kernel.kallsyms])
                                       fsync (/usr/lib64/libc-2.26.so)
                                       [0xffffa9f16310445d] (/usr/bin/dd)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       [0xffffa9f163104d99] (/usr/bin/dd)
     0.249 ext4:ext4_writepages_result:dev 253,2 ino 8437 ret 0 pages_written 1 pages_skipped 0 sync_mode 1 writeback_index 1
                                       ext4_writepages ([kernel.kallsyms])
                                       fsync (/usr/lib64/libc-2.26.so)
                                       [0xffffa9f16310445d] (/usr/bin/dd)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       [0xffffa9f163104d99] (/usr/bin/dd)
[root@jouet bpf]#

And if we replace that --no-syscalls with *sync, we'd get as the last line this:

     0.752 ( 7.651 ms): dd/24974  ... [continued]: fsync()) = 0

:-)

- Arnaldo
