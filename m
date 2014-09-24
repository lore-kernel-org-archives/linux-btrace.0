From: Chris Mason <clm@fb.com>
Date: Wed, 24 Sep 2014 19:42:22 +0000
Subject: [GIT PULL] merge iowatcher under blktrace repo
Message-Id: <54231E9E.5000004@fb.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi everyone,

iowatcher is a program I use to generate graphs and animations from
blktrace results.  It can also generate basic bandwidth numbers from fio
runs.

You can see basic usage instructions and a few examples here:

http://masoncoding.com/iowatcher/

The general idea is that iowatcher is a lot like seekwatcher was, but
instead of using python and matplotlib, I generate svg files directly
from C.  This means it has no dependencies and is much faster.  I've
been maintaining it in a separate repo, but it's small enough to toss
into blktrace.

I rewrote the iowatcher repo to place it under blktrace, and it's
available for pulling here:

git://git.kernel.org/pub/scm/linux/kernel/git/mason/blktrace.git master

You can see from the stats below that I've had some help on iowatcher.
Many thanks to Andrew Price for working on packages, documentation, fixes
and usability.  Jan Kara also spent a bunch of time porting his
per-process IO graphing over from seekwatcher.

Chris Mason (34) commits (+6228/-669):
    iowatcher: Fix path name handling when the trace files are in the current directory (+1/-1)
    iowatcher: Switch to ffmpeg for movie encoding.  Chrome and vlc like these better. (+2/-3)
    iowatcher: Make sure we add the xtick labels if we're only plotting IO (+1/-0)
    iowatcher: Fix the line graphs for values near the edges of the graph (+11/-2)
    iowatcher: Add a new movie mode that maps the IOs onto a platter. (+226/-31)
    iowatcher: Add -K command line option to keep the movie svg files (+11/-1)
    iowatcher: Only hash IOs if there are completion or issue events (+37/-27)
    iowatcher: Don't print a legend on the tput graphs during movies (+13/-8)
    iowatcher: Add -c to split the graphs up into multiple columns (+142/-88)
    iowatcher: Check for null mpstat structs while generating plots (+13/-6)
    iowatcher: Fix formatting errors in the iowatcher.1 man page. (+15/-14)
    iowatcher: Fix mpstat handling when the number of CPUs is not (+31/-3)
    iowatcher: Handle traces to more than once device at a time (+340/-72)
    iowatcher: Properly initialize trace.name in find_trace_file (+1/-1)
    iowatcher: Update the COPYING file to the correct address (+19/-21)
    iowatcher: Add support for fio bandwith logs (-F logfile) (+418/-6)
    iowatcher: Fix some rounding errors around the max offset (+4/-5)
    iowatcher: Start support for multiple colums of plots (+215/-145)
    iowatcher: Fix divide by zero while calculating averages (+6/-3)
    iowatcher: Fix io line graphs at the edge of the X axis (+1/-1)
    iowatcher: add iowatcher to the main blktrace Makefile (+4/-1)
    iowatcher: Update the README and the --help output (+36/-9)
    iowatcher: Add initial support for flash tracing (+180/-42)
    iowatcher: Update the README for a few new options (+8/-1)
    iowatcher: Fix spindle rotation in the movie mode (+2/-2)
    iowatcher: Update the FSF address in all files (+13/-13)
    iowatcher: Add mpstat graphing support (+311/-32)
    iowatcher: Fix mpstat file permissions (+1/-1)
    iowatcher: Add back missing plot title (+1/-1)
    iowatcher: Add mpstat.[ch] into git (+303/-0)
    iowatcher: Fix --help definition (+1/-1)
    iowatcher: Add movie support (+504/-126)
    iowatcher: Fine tune the ticks (+2/-2)
    iowatcher: Initial revision (+3355/-0)

Jan Kara (17) commits (+980/-426):
    iowatcher: Define mask of trace action and use it instead of opencoding the constant (+8/-6)
    iowatcher: Add option to set action which should be displayed in the IO graph (+32/-1)
    iowatcher: Add support for limitting IO graph offset from below (+59/-41)
    iowatcher: Do not add events out of time range to the plot (+3/-1)
    iowatcher: Add possibility to limit seconds from below (+67/-47)
    iowatcher: Add options to limit time and sector range (+104/-1)
    iowatcher: Remove duplicate defines from blkparse.c (+0/-7)
    iowatcher: Ignore trace records beyond max_seconds (+6/-12)
    iowatcher: Fix crash due to missing queue action (+8/-5)
    iowatcher: Fix filtering of outliers from below (+2/-1)
    iowatcher: Skip events beyond max_seconds (+11/-15)
    iowatcher: Rename seconds to max_seconds (+63/-63)
    iowatcher: Fix typo in option description (+1/-1)
    iowatcher: Per process IO graphs (+508/-176)
    iowatcher: Make seconds unsigned (+53/-39)
    iowatcher: Improve xticks logic (+50/-10)
    iowatcher: Handle REQUEUE events (+5/-0)

Andrew Price (16) commits (+645/-563):
    iowatcher: Fix processing of trace filenames containing spaces (+25/-3)
    iowatcher: Clean up some unused functions, make others static (+4/-71)
    iowatcher: Rework --prog to make arg processing safer (+47/-48)
    iowatcher: Update usage info and improve man page (+86/-50)
    iowatcher: Merge trace dumping functions into one (+50/-71)
    iowatcher: Convert start_blktrace to run_program (+55/-76)
    iowatcher: Separate program running from waiting (+34/-18)
    iowatcher: Simplify temp movie directory creation (+6/-16)
    iowatcher: Fix up some strcpy and strcat usage (+27/-41)
    iowatcher: Convert start_mpstat to run_program (+52/-99)
    iowatcher: Fix up directory trace processing (+119/-60)
    iowatcher: Check program exit code properly (+15/-4)
    iowatcher: Correct a couple of calloc calls (+2/-2)
    iowatcher: Add bounds checking in find_step (+5/-3)
    iowatcher: Fix a label overflow in plot_io (+2/-1)
    iowatcher: Add a man page for iowatcher (+116/-0)

Nikita Danilov (1) commits (+9/-2):
    iowatcher: iowatcher: specify ffmpeg codec

Liu Bo (1) commits (+48/-12):
    iowatcher: add blktrace destination options

Eric Sandeen (1) commits (+29/-7):
    iowatcher: iowatcher: support png2theora for videos

Yuanhan Liu (1) commits (+11/-9):
    iowatcher: Fix buffer overwrite issue

Total: (71) commits

 Makefile              |    5 +-
 iowatcher/COPYING     |  339 ++++++++++
 iowatcher/Makefile    |   37 ++
 iowatcher/README      |   97 +++
 iowatcher/blkparse.c  | 1196 +++++++++++++++++++++++++++++++++
 iowatcher/blkparse.h  |  138 ++++
 iowatcher/fio.c       |  217 ++++++
 iowatcher/fio.h       |   26 +
 iowatcher/iowatcher.1 |  162 +++++
 iowatcher/list.h      |  449 +++++++++++++
 iowatcher/main.c      | 1740 +++++++++++++++++++++++++++++++++++++++++++++++++
 iowatcher/mpstat.c    |  315 +++++++++
 iowatcher/mpstat.h    |   28 +
 iowatcher/plot.c      | 1119 +++++++++++++++++++++++++++++++
 iowatcher/plot.h      |  179 +++++
 iowatcher/tracers.c   |  189 ++++++
 iowatcher/tracers.h   |   28 +
 17 files changed, 6263 insertions(+), 1 deletion(-)
