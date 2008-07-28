From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Mon, 28 Jul 2008 00:54:05 +0000
Subject: [RFC] LTTng merge plan
Message-Id: <20080728005405.GA7941@Krystal>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080717155724.897537670@polymtl.ca> <48862A30.7050701@qumranet.com> <y0mabg991c3.fsf@ton.toronto.redhat.com> <488635A7.2030609@qumranet.com> <20080722221204.GA14661@Krystal> <488C49CC.8040800@qumranet.com>
In-Reply-To: <488C49CC.8040800@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Avi Kivity <avi@qumranet.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, "Frank Ch. Eigler" <fche@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, systemtap-ml <systemtap@sources.redhat.com>, linux-btrace@vger.kernel.org

* Avi Kivity (avi@qumranet.com) wrote:
> Mathieu Desnoyers wrote:
>
>  
>>> Yes, but the userspace side would collect the format strings as well 
>>> (just once) and could put them in the same file.  The aggregation is 
>>> portable across kernel versions.
>>>
>>>     
>>
>> Yes,
>>
>> LTTng does exactly all that.
>>
>>
>>   
>
> [snip goodies]
>
>> I'll be more than happy to answer your questions.
>>   
>
> What's the merge plan for this?
>

Hi Avi,

Thanks for asking. Given the amount of expectation from kernel
developers, distributions and users I have seen for kernel tracing at
this year's OLS, I think giving a detailed merge plan for my LTTng work
is appropriate.

Currently, it looks like :

In Ingo's trees :
- Tracepoints, scheduler tracepoints instrumentation, ftrace port to
  tracepoints
  - Should make it into 2.6.27 since ftrace needs those.
- Immediate Values (faster branch based on load immediate instruction)
  Useful for markers and tracepoints, but can also be used for any
  compiled-in code that has to be dynamically enabled.
  - Aims at 2.6.28
- Text Edit Lock : protection of kernel text modification with a mutex.
  Synchronises kprobes and immediate values.
  - Aims at 2.6.28

Short-term submission plan

In LTTng patchset
(http://ltt.polymtl.ca/lttng/patch-2.6.26-0.12.tar.bz2)

- Instrumentation
  - LTTng tracepoints
    - Used by LTTng, SystemTAP and usable specialized probes.
  - Port specific sets of tracepoints along with their current users
    - ftrace (port currently in Ingo's tree), KVM trace, blktrace.

- Data extraction
  - LTTng timestamping
     - Based on the CPU cycle counter when synchronized across CPUs.
     - Fallback on a simple cache-bouncing atomic counter if no
       synchronized fast time source is available. Basically, the idea
       is that having the correct event _order_ is more important than
       having an approximate time, because this "timestamp" is used to
       reorder events which are written in per-CPU buffers. Time updates
       can always be recorded as an event in the trace to get an idea of
       the kernel time flow.
  - LTTng trace management
    - netlink interface to start/stop tracing and set the buffer sizes.
      - Supports multiple channels (high/medium/low event rate).
        Metadata (marker types, list of interrupt handlers...) can be
        exported in low event rate channels.
      - Supports flight recorder mode (overwriting oldest buffer data),
        normal mode (writes to disk, drops events if buffer is full) or
        hybrid, or mixed, mode, where the high event rate buffers only
        are in flight recorder mode.
  - Data relay
    - Atomic buffering mechanism which does not call into kernel
      primitives except preempt disable. Only touches variables
      atomically, does not use any lock. Aims at having minimal
      intrusiveness and allowing the largest code coverage (thus not
      calling kernel code).
  - LTTng marker control
    - Currently a /proc/ltt interface with read and write operations to
      list markers and connect LTTng probe to individual markers,
      specifying in which channel to send the data (I know, should
      probably belong to /sys instead, comments welcome) It's not part
      of the core marker infrastructure because it depends both on
      markers and on the LTTng trace management. It's also responsible
      for allocating a numeric ID to a marker which is guaranteed to be
      unique as long as there is at least one active trace.


Medium-term submission plan

In LTTng patchset

- Instrumentation
  - Userspace tracing interface
    - Allow userspace to declare tracepoints and/or markers
    - Provide a data extraction interface to collect the tracing data.
      - More work needed in this area.
  - LTTng statedump
    - Exports the kernel data structures to the trace buffers at trace
      start. List interrupts, system calls, threads, memory maps, ... It
      does not use /proc because :
        1 - /proc has nasty races which makes the information "generally
        correct" but not more.
        2 - /proc exports the information in text format, which is not
        as compact as LTTng binary format.

Longer term wishlist
- GCC support for static branch patching
  - Improvement on the immediate values for dynamic code activation

A bit more information is available in the slides I just presented at
OLS at :

http://ltt.polymtl.ca/slides/desnoyers-talk-ols2008.pdf

I'll gladly answer to questions/comments.

Mathieu


-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
