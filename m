From: "Akers, Jason B" <jason.b.akers@intel.com>
Date: Wed, 09 Oct 2013 21:25:29 +0000
Subject: Whitespace in blktrace files causing "Bad magic" in blkparse
Message-Id: <372C7AE269BA5E4D92B1082F530ED4B868B66D68@ORSMSX110.amr.corp.intel.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,
I'm collecting some long-run traces on an ARM Android phone running kernel a 3.4.0 and the latest blktrace.

When I run blkparse on the traces I'm occasionally getting "Bad magic" errors from blkparse::ms_prime(). I modified blkparse to print out the offset within the trace file where the error was happening.

Looking at that offset with an editor I see that there is a huge run of zeros. The zeros seem to pad to the nearest 4MB boundary within the file, then additional valid trace data continues to be recorded. To make matters worse, trace records can span the zeros (so the first few bytes of the record are before the zeros and the rest of the record is after the next 4MB boundary) leading to incorrect parsing. There doesn't seem to be any pattern to where the zeros start.

For example here are the start/end offsets of strings of zeros within one of my blktrace files:
start_offs    : end_offs
0x20000        : 0x400000
0x4A0000     : 0x800000
0x10940000 : 0x10C00000

I saw the 2008 thread about "bad magic" but it seemed to be slightly different than this issue, and had no conclusion. (http://www.spinics.net/lists/linux-btrace/msg00316.html)

I'm at a loss for where to look to debug this issue. Any ideas would be helpful (blktrace userland or kernel).

Thanks,
Jason Akers
