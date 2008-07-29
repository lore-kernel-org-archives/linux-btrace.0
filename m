From: "Frank Ch. Eigler" <fche@redhat.com>
Date: Tue, 29 Jul 2008 16:18:36 +0000
Subject: Re: [RFC] LTTng merge plan
Message-Id: <20080729161836.GA10751@redhat.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20080717155724.897537670@polymtl.ca> <48862A30.7050701@qumranet.com> <y0mabg991c3.fsf@ton.toronto.redhat.com> <488635A7.2030609@qumranet.com> <20080722221204.GA14661@Krystal> <488C49CC.8040800@qumranet.com> <20080728005405.GA7941@Krystal>
In-Reply-To: <20080728005405.GA7941@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Avi Kivity <avi@qumranet.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, systemtap-ml <systemtap@sources.redhat.com>, linux-btrace@vger.kernel.org

Hi, Mathieu -

> [...]
> Currently, [my merge plan] looks like :
> 
> In Ingo's trees :
> - Tracepoints, scheduler tracepoints instrumentation, ftrace port to
>   tracepoints
>   - Should make it into 2.6.27 since ftrace needs those.
> [...]

This is the tracepoints infrastructure, and ...

> Short-term submission plan
> 
> In LTTng patchset
> (http://ltt.polymtl.ca/lttng/patch-2.6.26-0.12.tar.bz2)
> 
> - Instrumentation
>   - LTTng tracepoints
>     - Used by LTTng, SystemTAP and usable specialized probes.
> [...]

... this is the "meat", which includes both the tracepoints
and the the tracepoint-to-marker conversion modules, such as those in
"lttng-instrumentation-*-tracepoint-probes.patch", right?

- FChE
