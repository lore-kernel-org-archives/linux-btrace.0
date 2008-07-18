From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Fri, 18 Jul 2008 15:15:17 +0000
Subject: Re: [Patch] blkiomon: repost with some fixes and improvements
Message-Id: <4880B385.3070101@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070109010907080509030706"
List-Id: <linux-btrace.vger.kernel.org>
References: <1216377086.8497.4.camel@kitka.ibm.com>
In-Reply-To: <1216377086.8497.4.camel@kitka.ibm.com>
To: linux-btrace@vger.kernel.org

This is a multi-part message in MIME format.
--------------070109010907080509030706
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

T=F6r=F6k Edwin wrote:
> On 2008-07-18 13:31, Martin Peschke wrote:
>> recent changes:
>> - added man page
>> - beautified human-readable output
>> - fixed an x86 compile error caused by incomplete endianess handling
>> - fixed some x86 __u64 vs. unsigned long compiler warnings
>> - fixed checking of a command line argument
>>
>>
>> blkiomon periodicaly generates per devive request size and request laten=
cy
>> statistics from blktrace data. It provides histograms as well as data th=
at
>>  =20
>=20
> Does it also measure latency caused by the request queues being full?
> (which happens around here):
> blk-core.c:get_request:
> /*
>                      * The queue is full and the allocating
>                      * process is not a "batcher", and not
>                      * exempted by the IO scheduler
>                      */
>                     goto out;
>=20
> That would be very useful to trace some high latencies I am seeing, see
> discussion here:
> http://lkml.org/lkml/2008/7/12/104
>=20
> Best regards,
> --Edwin

Hi Edwin -

If you could try this, it might provide some more data. This is very
hastily thrown together, so it may need some work. Basically: I wrote a
Python script which chains together blktrace | blkparse and takes the
output looking for sleep requests, and then a successful get request on
that same device. It then outputs min/avg/max as in:

   1 sleepers                         0.142157151
   1 sleepers                         0.174224178
   3 sleepers min=3D  0.027375521 avg=3D  0.048117339 max=3D  0.075909947
   1 sleepers                         0.132267452
   1 sleepers                         0.030572955
   2 sleepers min=3D  0.060603135 avg=3D  0.071087077 max=3D  0.081571020
   1 sleepers                         0.002082554
   1 sleepers                         0.033337675
   1 sleepers                         0.010796369

(with 1 sleeper, I leave off the min/max stuff). The values are in
seconds (so above I'm seeing 0.01 to 0.17+ seconds of sleeping...)

To run it (as root):

# ./qsg.py <device> [<device> ...]

So, for me:

# ./qsg.py /dev/sda

This will produce output only when sleeps-for-requests occur. (I think
other logic in the block I/O layer will put off other potential
requesters - I'm looking into how to measure that next.)

For now the script just assumes that the debugfs stuff is mounted at
/sys/kernel/debug...

Let me know if this needs some tweaking...

BTW: I can't seem to reproduce your problem (I do see the sleeps from my
script, but the system seems responsive otherwise). I have a 4-core
(dual-socket) Xeon box w/ 8GB RAM plus 5 SAS drives. I'm using Ubuntu
8.04 w/ an Ext3 FS for root (where I was running the test). I tried
bumping the dd' counts (large amount of RAM), but that didn't make a
difference.

I will try some more dd's just in case...

Alan

--------------070109010907080509030706
Content-Type: text/x-python;
 name="qsg.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qsg.py"

#! /usr/bin/env python
"""
qsg.py [dev...]
"""

#
#  (C) Copyright 2008 Hewlett-Packard Development Company, L.P.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

import os, sys

#
# Crazy stuff to get unbuffered output flowing through the pipeline -
# not a Python wiz, there are probably better ways...
#
def start_tracer(devs):
	(r, w) = os.pipe()
	pid = os.fork()
	if pid == 0:
		os.close(r)

		cmd = '/usr/local/bin/blktrace -o - -n 8 -b 512'
		for dev in devs: cmd = '%s -d %s' % (cmd, dev)
		cmd = cmd.split(None)

		fw = os.fdopen(w, 'w', 0)
		os.dup2(fw.fileno(), sys.stdout.fileno())

		os.execvp(cmd[0], cmd)
		sys.exit(1)
	else:
		os.close(w)
		return (pid, r)

def start_parser(devs):
	(trace_pid, tr) = start_tracer(devs)

	(r, w) = os.pipe()
	pid = os.fork()
	if pid == 0:
		os.close(r)

		fmt = '%D %a %T.%t\n'
		cmd = [ '/usr/local/bin/blkparse', '-q', '-i', '-', '-f', fmt ]
		print cmd

		os.dup2(tr, sys.stdin.fileno())
		fw = os.fdopen(w, 'w', 0)
		os.dup2(fw.fileno(), sys.stdout.fileno())

		os.execvp(cmd[0], cmd)
		sys.exit(1)
	else:
		os.close(w)
		fr = os.fdopen(r, 'r', 0)
		return (trace_pid, pid, fr)

def parse_line(line):
	fields = line.split(None)
	return fields[0], fields[1], float(fields[2])

if __name__ == '__main__':
	if len(sys.argv) < 2:
		print __doc__
		sys.exit(1)

	sleepers = {}
	devs = sys.argv[1:]

	(trace_pid, parse_pid, fi) = start_parser(devs)
	for line in fi:
		(dev, act, ts) = parse_line(line.rstrip())

		if not act in ['S', 'G']: continue
		if act == 'S':
			if not sleepers.has_key(dev):	sleepers[dev] = [ts]
			else:				sleepers[dev].append(ts)
			continue
		elif not sleepers.has_key(dev): continue

		mn = mx = None
		tot = 0.0
		nsleepers = 0
		for sleeper in sleepers[dev]:
			if ts < sleeper: continue

			nsleepers += 1
			dt = ts - sleeper
			if mn == None or dt < mn: mn = dt
			if mx == None or dt > mx: mx = dt
			tot += dt
		del sleepers[dev]

		if nsleepers == 0:
			continue

		print '%4d sleepers' % nsleepers,
		if nsleepers == 1:
			print '    %13s     %13.9f' % ('', tot)
		else:
			print 'min=%13.9f' % mn,
			print 'avg=%13.9f' % (tot / float(nsleepers)),
			print 'max=%13.9f' % mx

--------------070109010907080509030706--
