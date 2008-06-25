From: Tom Zanussi <tzanussi@gmail.com>
Date: Wed, 25 Jun 2008 06:17:56 +0000
Subject: [RFC] Useful Tracing Tools library (utt)
Message-Id: <1214374677.7741.52.camel@charm-linux>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I'm happy to make available the first cut of a tracing library based on
the blktrace userspace code that allows any tracing application to take
advantage of the powerful tracing capabilities blktrace users have known
for years.  AFAIK, blktrace is the only tracing system that supports
efficient per-cpu tracing to disk as well as over the network, and also
supports a very useful 'live tracing mode', among other things.  Now,
any tracing application can have the same capabilities, by making use of
this library.

Basically what I did for this was to take everything in blktrace that I
thought could be applicable to generic tracing/display, moved it into a
separate directory, and modified it to make it usable as a generic
tracing API.

The utt code can be found here:

http://sourceforge.net/projects/utt/

I also created a simple website for it:

http://utt.sourceforge.net/


The tarball contains utt, blktrace-on-utt and a fairly realistic example
of using the utt API to create another standalone tracer that uses utt
to trace a few VFS 'events'.  The example is used as the basis for a
tutorial which tries to explain how things work and how to write a
tracing application based on utt:

http://utt.sourceforge.net/tutorial.html

One of the main reasons I chose VFS for the example is that I had also
planned on using it to demonstrate what I think could be the 'killer'
feature of having multiple tracers use the common blktrace
infrastructure - seamlessly combining any number of standalone tracers
into a single 'system-wide' tracer; each tracer can be used to do it's
own specialized tracing, but can also be combined with other tracers to
provide something that ends up being greater than the sum of its parts.
Adding a simple plugin API along with some other small changes would
probably be enough, but I haven't thought it out yet.

Anyway, this is just a first cut - the API and the code may be
reasonable or it may be crap; the only thing I can say is that it works,
at least for these two apps (blktrace and the vfs example), so any input
about any of it would be helpful.

Thanks,

Tom

PS I'll be offline for a couple of weeks - I'll have to respond to any
replies after that...









