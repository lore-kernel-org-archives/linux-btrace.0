From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 04 May 2018 16:10:38 +0000
Subject: Re: [PATCH 18/31] blktrace: doc: alternatives to blktrace traditional tooling
Message-Id: <c95d95c9-6518-f012-46ee-6e1a2978b0c5@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20180427130738.102806-19-maier@linux.ibm.com>
In-Reply-To: <20180427130738.102806-19-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-btrace@vger.kernel.org

On 04/27/2018 09:40 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 27, 2018 at 03:07:25PM +0200, Steffen Maier escreveu:
>> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Li Zefan <lizefan@huawei.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Christoph Hellwig <hch@lst.de>
> 
> Interesting, I'd suggest adding 'perf trace' to that mix, that is a strace like
> perf tool that can mix and match syscalls formatted strace-like + other events,

Thanks for the feedback!

Indeed, I looked at its man page but should have kept reading, because I 
stopped when I saw strace and thus missed that it can also handle other 
events.

> such as tracepoints, with the record perf.data, process it later, or do it

I tried to use "perf trace" with -i and perf.data from a previous "perf 
record" for offline analysis, but I must be doing something wrong:

# perf trace -i perf.data
<<gets me into a pager with no content>>

# perf trace -v -i perf.data --no-syscalls
Please specify something to trace.

Is it because my perf.data does not contain any raw_syscall events?

Whereas "perf script" formats the trace sequence of perf.data.

> live, like strace, but with a vastly lower overhead and not just for a workload

Cool, I have to remember this for other future analysis cases.

> started from it or a pid, but supporting the other targets perf supports:
> system wide, CPU wide, cgroups, etc.
> 
> For instance, to see the block lifetime of a workload that
> calls fsync, intermixed to the strace like output of the 'read' and 'write'
> syscalls:
> 
> [root@jouet bpf]# perf trace -e read,write,block:* dd if=/etc/passwd of=bla conv=fsync

>       0.735 (         ): block:block_bio_queue:253,2 WS 63627608 + 8 [dd]
>       0.740 (         ): block:block_bio_remap:8,0 WS 79620440 + 8 <- (253,2) 63627608
>       0.743 (         ): block:block_bio_remap:8,0 WS 196985176 + 8 <- (8,6) 79620440
>       0.746 (         ): block:block_bio_queue:8,0 WS 196985176 + 8 [dd]
>       0.756 (         ): block:block_getrq:8,0 WS 196985176 + 8 [dd]
>       0.759 (         ): block:block_plug:[dd]
>       0.764 (         ): block:block_rq_insert:8,0 WS 4096 () 196985176 + 8 [dd]
>       0.768 (         ): block:block_unplug:[dd] 1
>       0.771 (         ): block:block_rq_issue:8,0 WS 4096 () 196985176 + 8 [dd]

Using process filter, by design means that complete events would only be 
traced if they happen to occur when the same process was scheduled. 
Since they occur in IRQ context, it's often another process. For use 
cases as yours, that's likely not a problem.

For my cases, where I want to see every related block event, I usually 
use option -a for full system.

The "perf trace" v4.16 I tried, does not seem to accept event filters 
and the man page also does not mention such option. In order to separate 
system events (e.g. syslog I/O or paging) from the workload events I'm 
interested in, I would need some event filtering I guess. Unless I did 
something wrong, "perf trace" seems currently further away from how 
traditional blktrace tooling works.

This is roughly where I came from when writing up my things:

Dimensions:
* type: I/O actions, block events
* size: record to memory buffer, stream from memory buffer
* analysis: online (live trace), offline (efficiently record/stream and 
then show later)
* filters: blktrace always filters for device(s), also need for events

Due to time and space constraints, I don't cover all possible combinations.

E.g. for block events, I only cover:
* manual setup and manually reading from ftrace buffer, and
* efficient streaming of traces for offline analysis.
I.e. no "streamed" live tracing.

> If one wants instead to concentrate on the callchains leading to the block_rq_issue:
> 
> [root@jouet bpf]# perf trace --no-syscalls -e block:*rq_issue/call-graph=dwarf,max-stack/ dd if=/etc/passwd of=bla conv=fsync
> 7+1 records in
> 7+1 records out
> 3882 bytes (3.9 kB, 3.8 KiB) copied, 0.010108 s, 384 kB/s
> no symbols found in /usr/bin/dd, maybe install a debug package?
>       0.000 block:block_rq_issue:8,0 WS 4096 () 197218728 + 8 [dd]
>                                         blk_peek_request ([kernel.kallsyms])
>                                         fsync (/usr/lib64/libc-2.26.so)
>                                         [0xffffaa100818045d] (/usr/bin/dd)
>                                         __libc_start_main (/usr/lib64/libc-2.26.so)
>                                         [0xffffaa1008180d99] (/usr/bin/dd)
> [root@jouet bpf]#

I was hoping to cover all additional functionality by referring the 
reader to the respective documentation elsewhere and keep the blktrace 
docs somewhat limited in scope (also to avoid duplication):

+See the kernel ftrace documentation for more details.

[I also use filtered (kernel) stacktraces and other functionality when I 
use ftrace for analysis or understanding code.]

> installing the debuginfo for the coreutils package, where dd lives, would give more info, etc.

that is very nice

I try to come up with a short reference to "perf trace" in my text to 
provide the reader with an idea of what's possible beyond blktrace.

Do the other perf use cases in my patch make sense or did I get anything 
wrong from a review point of view?


-- 
Mit freundlichen Grüßen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

