From: Steffen Maier <maier@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:07:07 +0000
Subject: [PATCH 00/31] blktrace: doc updates, small fixes, small features
Message-Id: <20180427130738.102806-1-maier@linux.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi Jens,

I needed to follow practical block I/O request behavior and was new to
blktrace. So I read the docs, noted down where I had questions, did
code history research, and collected my experience during practical
use. This is the result, hoping somebody else might find it useful.

Patches 1-20 are documentation updates (incl. tool usage output).

While I synchronized the man page updates mostly into blktrace.tex,
some things such as option details did not fit nicely into the latex
tables. Removing the 2 reference sections for blktrace(8) and
blkparse(1) from the tex file and instead referring to the man pages
would be an option to avoid sync issues. But then again, I guess the
tex file was the origin for the man pages in the first place.

Patches 21-23 are small bugfixes.

Patches 24-31 are small enhancements.

Steffen Maier (31):
  btt: doc: PDF output with bookmark structure and clickable cross
    references
  btt: doc: small fixes
  btrace: fix usage by adding -h (blkparse --hash-by-name)
  btrace: fix usage by adding -v (blkparse --verbose)
  btrace: man: improve by pointing to blkparse for option -r (debugfs)
  blkrawverify: man: fix input format, reports written unconditionally
  verify_blkparse: man: document prereq and behavior
  blkparse: man: fix typos and formatting, complete and update
    information
  blktrace: man: fix typos and formatting, complete and update
    information
  blktrace: doc: PDF output with bookmark structure and clickable cross
    references
  blktrace: doc: add table of contents to show document structure
  blktrace: doc: blktrace: sync fixes from man page updates
  blktrace: doc: blkparse: sync fixes from man page updates
  blktrace: doc: (un)plug event updates for on-stack plugging
  blktrace: doc: update RWBS including flush, FUA replacing barrier
  blktrace: doc: no more SCSI CDB in payload
  blktrace: doc: assorted fixes and updates
  blktrace: doc: alternatives to blktrace traditional tooling
  README: complete tool overview
  README: remove incomplete tool option descriptions
  btt: fix --do-active to not perform --q2d-latencies|-z
  blkrawverify: fix dumping of erroneous trace
  blkparse: fix allowed event type specifiers for custom output format
  verify_blkparse: inform on bad line, report line no
  btrace: bring back possibility to toggle statistics at end of trace
  blkparse: treat sector as %llu for custom format like elsewhere in
    code
  blkparse: elapsed time: change unit of custom format, no exit on none
  blkparse: add custom format for calendar date of time stamp
  blkparse: enable custom output format also for message event type
  blkparse: add custom format field specifiers for remapping event
  blkparse: new option to customize format of default output header only

 README                | 152 ++++----
 blkparse.c            |  22 +-
 blkparse_fmt.c        |  81 ++++-
 blkrawverify.c        |   6 +-
 blktrace.h            |   1 +
 btrace                |   5 +-
 btt/args.c            |   2 +-
 btt/doc/Makefile      |   2 +-
 btt/doc/btt.tex       | 183 ++++++----
 doc/Makefile          |   2 +-
 doc/blkparse.1        | 354 +++++++++++++------
 doc/blkrawverify.1    |   3 +-
 doc/blktrace.8        |  92 +++--
 doc/blktrace.tex      | 958 ++++++++++++++++++++++++++++++++++++++++++--------
 doc/btrace.8          |  16 +-
 doc/btt.1             |   2 +-
 doc/verify_blkparse.1 |  12 +
 verify_blkparse.c     |  12 +-
 18 files changed, 1430 insertions(+), 475 deletions(-)

-- 
2.14.2

