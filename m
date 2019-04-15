From: Bryan Gurney <bgurney@redhat.com>
Date: Mon, 15 Apr 2019 15:43:33 +0000
Subject: Re: status of seekwater
Message-Id: <CAHhmqcR1ZoEmPJAsPmOGQy9ej7n4NnuvPOEu4SLyKr1vFWjOnA@mail.gmail.com>
List-Id: <linux-btrace.vger.kernel.org>
References: <20190414114600.GA12039@lst.de>
In-Reply-To: <20190414114600.GA12039@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

On Sun, Apr 14, 2019 at 3:43 PM Chris Mason <clm@fb.com> wrote:
>
> On 14 Apr 2019, at 7:46, Christoph Hellwig wrote:
>
> > Has any tried to use seekwatcher lately?  For one the report on
> > oss.oracle.com seems to be gone.  I found a git repo that seems
> > to have the latest codebase from hg and two little fixes here:
> >
> > https://github.com/trofi/seekwatcher
> >
> > But even that doesn't seem to work in modern environments.  After
> > a build with a few warnings actually trying to run it creates doesn't
> > seem to actually work well:
>
> I replaced seekwatcher with iowatcher a while ago, and convinced Jens to
> stuff it into blktrace git.  It's dramatically faster (C instead of
> python), and the command line is slightly different.  But, all the
> features should be there.
>

Hi Chris,

I use seekwatcher and iowatcher to visualize the output of very long
blktrace runs.  One of the examples that led to a patch was "xfs: skip
online discard during eofblocks trims" (unfortunately, I missed my
chance to get a "Reported-by" tag on that patch).  In that specific
case, seekwatcher was rendering the discards as writes (at least I
believe so; under seekwatcher, "green" was used for writes, correct?)

I ran another blktrace, and decided to start "iowatcher ...
--movie=rect", and I rediscovered a few "rough edges" on iowatcher:

1. I don't believe that iowatcher renders discards.  It would be nice
if it did render discards, in a way that could be distinguishable from
reads and writes, now that it is one of the "RWBS" operations in
blktrace / blkparse.

2. I'm having issues with the time scaling, where all of the data
points seem to end up at the "end" of the video.  I forgot what
combination of "--rolling" (rolling average in seconds) and/or
"--xzoom" parameters are required to re-scale the graph, but it
becomes a trial-and-error process, since the user needs to render the
video to see if any corrections need to be made.  (Thankfully,
rendering doesn't take over 12 hours for a 16 GiB trace anymore.)

Under seekwatcher, this set of parameters would work:

seekwatcher -t sdb1.blktrace.0 -o outfile.ogg --movie
--movie-lengthH0 --rolling-avg=1

3. I miss seekwatcher's "time scale" graph on the bottom, which would
display the "seconds" counter on an X axis of the "MB/s" and "seeks/s"
graphs.

If there's any way I can help, with examples to recreate, let me know.


Thanks,

Bryan
