From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Thu, 05 Mar 2009 16:23:42 +0000
Subject: blktrace / relay: bad trace
Message-Id: <1236270223.10040.61.camel@kitka.ibm.com>
List-Id: <linux-btrace.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-btrace@vger.kernel.org

Hi,

I keep running into bad traces, at least on System z.

(See http://marc.info/?l=linux-btrace&m2709472202537&w=2 for an
earlier post).

Looking at the data as read by blktrace from relay files,
I found fragments of old traces partially overlaying other traces.

In the hexdump-ed trace below, I have added "|"s as delimiters between
traces. The corrupted part of the trace - a fragment containing the
sequence number 0x4d1d3 - is in parenthesis.

12d8ca0 |6561 7407 0005 6440 0000 00fb ef9d 6496  -> sequence 0x56440
12d8cb0  0000 0000 000f 4790 0002 0000 4001 0011
12d8cc0  0000 1445 0080 0020 0000 0001 0000 0018
12d8cd0  0000 0001 0001 007d 0000 0000 0001 3e40
12d8ce0  0000 0000 001b badc|6561 7407 0005 6441  -> sequence 0x56441
12d8cf0  0000 00fb ef9d 79e3 0000 0000 000f 4790
12d8d00  0002 0000 0181 0008 0000 1445 0080 0020
12d8d10  0000 0001 0000 0000|6561 7407 0005 6442  -> sequence 0x56442
12d8d20 (0000 1444 0080 0020 0000 0001 0000 0000
12d8d30 |6561 7407 0004 d1d3 0000 00e3 4a8b 1544  -> sequence 0x4d1d3
12d8d40  0000 0000 0015 5728 0003 0000 4001 0011     old trace!!
12d8d50  0000 1447 0080 0020 0000 0001 0000 0018)
12d8d60 |6561 7407 0005 6443 0000 00fb f04d c32a  -> sequence 0x56443
12d8d70  0000 0000 000f 4928 0000 8000 4001 0011
12d8d80  0000 1445 0080 0020 0000 0001 0000 0018
12d8d90  0000 0001 0001 007f 0000 0000 0000 55d8
12d8da0  0000 0000 0008 1070|6561 7407 0005 6444  -> sequence 0x56444

The same fragment containing sequence 0x4d1d3 originally appeared in
this context:

10d8d70  0000 0000 0013 970e|6561 7407 0004 d1d2  -> sequence 0x4d1d2
10d8d80  0000 00e3 4a82 8773 0000 0000 0039 4d20
10d8d90  0001 0000 0181 0008(0000 1444 0080 0020
10d8da0  0000 0001 0000 0000|6561 7407 0004 d1d3  -> sequence 0x4d1d3
10d8db0  0000 00e3 4a8b 1544 0000 0000 0015 5728
10d8dc0  0003 0000 4001 0011 0000 1447 0080 0020
10d8dd0  0000 0001 0000 0018)0000 0001 0001 0080
10d8de0  0000 0000 0001 156c 0000 0000 001a 10c8
10d8df0 |6561 7407 0004 d1d4 0000 00e3 4a8b 239c  -> sequence 0x4d1d4
10d8e00  0000 0000 0015 5728 0003 0000 0181 0008
10d8e10  0000 1447 0080 0020 0000 0001 0000 0000

Looks like a kernel issue to me, blktrace or relay.

Is there anything I can do in order to help fixing this?
Which debug data would be needed?
Any idea on what should be done next?

Could this issue be caused by some race in __blk_add_trace()?
I don't see one, though...

Or, could it be related to relay subbuffer switching, padding etc.?

I am using a recent git-kernel and a recent blktrace (v2).

Thanks,
Martin

